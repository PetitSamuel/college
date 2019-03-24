package cs.tcd.ie;

import com.google.gson.JsonObject;

import java.io.IOException;
import java.net.*;

import static cs.tcd.ie.FormatedInput.*;

public class Client extends ClientNode {
    static final String DEFAULT_DST_NODE = "localhost";
    private InetSocketAddress dstAddress;

    Client(String dstHost, int dstPort, int srcPort) {
        try {
            this.dstAddress = new InetSocketAddress(dstHost, dstPort);
            this.socket = new DatagramSocket(srcPort);
            listener.go();
            System.out.println("Welcome! Here is the list of actions available :\n1 : Send a message");
        } catch (SocketException e) {
            e.printStackTrace();
        }
    }

    public synchronized void onReceipt(DatagramPacket packet) {
        byte[] data = packet.getData();
        String content = new String(data, 0, packet.getLength());

        if(content.equals("ack")){
            System.out.println("ACK received");
            return;
        } else {
            // send ack
            sendAck(packet.getSocketAddress());
        }

        JsonObject json = Json.getJsonFromString(content);
        switch (json.get("type").getAsString()) {
            case "message":
                System.out.println("New Message received from : " + json.get("sourceAddress").getAsString() + " - " + json.get("sourcePort").getAsInt());
                System.out.println("Message : " + json.get("message").getAsString());
                break;
            default:
                System.out.println("Type not Supported.");
                System.out.println(content);
                break;
        }
    }

    // controller method, enables client to subscribe, unsubscribe & disconnect
    @Override
    public void userInterface(String message) {
        switch (message) {
            case "1":
                System.out.println("Please enter which port to send this message to:");
                int dstPort = getInUsePort();
                System.out.println("Please enter the message to send to port " + dstPort + " : ");
                String chat = getUserInput();
                System.out.println("Sending : " + chat + " to : " + dstPort);
                sendMessageToPort(DEFAULT_DST_NODE, dstPort, chat);
                break;
            default:
                System.out.println("Action not supported.");
                break;
        }
    }

    public void sendMessageToPort(String destAddress, int destPort, String message) {
        JsonObject json = new JsonObject();

        json.addProperty("type", "message");
        json.addProperty("sourceAddress", DEFAULT_DST_NODE);
        json.addProperty("sourcePort", this.socket.getLocalPort());
        json.addProperty("destinationAddress", destAddress);
        json.addProperty("destinationPort", destPort);
        json.addProperty("message", message);

        byte[] messageAsBytes = json.toString().getBytes();
        DatagramPacket packet = new DatagramPacket(messageAsBytes, messageAsBytes.length, this.dstAddress);
        send(packet);
    }

    public void sendAck (SocketAddress sa) {
        DatagramPacket p = new DatagramPacket("ack".getBytes(), "ack".getBytes().length, sa);
        send(p);
        System.out.println("ACK received");
    }

    // gets a datagram packet & sends it
    public void send (DatagramPacket packet) {
        try {
            this.socket.send(packet);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        System.out.println("Welcome");
        int sourcePort = getAvailablePort();
        System.out.println("Available port selected : " + sourcePort);

        System.out.println("Please enter the router port to use to send messages to.");
        int routerPort = getInUsePort();
        System.out.println("Selected port : " + routerPort + " to send messages to.");
        Thread sub = new Thread(new Client(DEFAULT_DST_NODE, routerPort, sourcePort));
        sub.start();
    }
}