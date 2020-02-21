package cs.tcd.ie;

import com.google.gson.JsonObject;

import java.io.IOException;
import java.net.DatagramSocket;
import java.net.DatagramPacket;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.util.HashMap;
import static cs.tcd.ie.FormatedInput.*;


public class Router extends Node {
    // setting port as 0 automatically finds an available port
    public static final int CONTROLER_PORT = 50001;
    public static final String DEFAULT_DST_NODE = "localhost";

    private InetSocketAddress dstAddress;
    private HashMap<String, Integer> forwardingTable;
    private HashMap<String, DatagramPacket> packetWaitingList;

    Router(String dstHost, int dstPort, int srcPort) {
        forwardingTable = new HashMap<>();
        packetWaitingList = new HashMap<>();
        try {
            dstAddress = new InetSocketAddress(dstHost, dstPort);
            socket = new DatagramSocket(srcPort);
            listener.go();
            System.out.println("Welcome!");
        } catch (java.lang.Exception e) {
            e.printStackTrace();
        }
    }

    public synchronized void onReceipt(DatagramPacket packet) {
        byte[] data = packet.getData();
        String content = new String(data, 0, packet.getLength());
        if (content.equals("hello")) {
            System.out.println("Connection acknowledged by Controller");
            return;
        } else if (content.equals("ack")) {
            System.out.println("ACK received");
            return;
        } else {
            sendAck(packet.getSocketAddress());
        }

        JsonObject json = Json.getJsonFromString(content);
        PacketEndpoints pt;
        switch (json.get("type").getAsString()) {
            case "message":
                pt = new PacketEndpoints(json.get("sourceAddress").getAsString(),
                        json.get("destinationAddress").getAsString(), json.get("sourcePort").getAsInt(),
                        json.get("destinationPort").getAsInt());
                if (!forwardingTable.containsKey(pt.toString())) {
                    this.packetWaitingList.put(pt.toString(), packet);
                    sendPathRequest(pt);
                } else {
                    int portToSendTo = forwardingTable.get(pt.toString());
                    forwardPacket(portToSendTo, packet);
                }
                break;
            case "add path":
                pt = new PacketEndpoints(json.get("sourceAddress").getAsString(),
                        json.get("destinationAddress").getAsString(), json.get("sourcePort").getAsInt(),
                        json.get("destinationPort").getAsInt());
                System.out.println("Forwarding Information received from Controller.");
                int forwardingPort = json.get("forwardingPort").getAsInt();
                this.forwardingTable.put(pt.toString(), forwardingPort);

                if (this.packetWaitingList.containsKey(pt.toString())) {
                    forwardPacket(forwardingPort, this.packetWaitingList.get(pt.toString()));
                }
                break;
        }
    }

    public void sendPathRequest(PacketEndpoints pt) {
        JsonObject json = new JsonObject();

        json.addProperty("type", "unknown packet path");
        json.addProperty("sourceAddress", pt.sourceAddress);
        json.addProperty("sourcePort", pt.sourcePort);
        json.addProperty("destinationAddress", pt.destinationAddress);
        json.addProperty("destinationPort", pt.destinationPort);

        byte[] toSend = json.toString().getBytes();
        DatagramPacket packet = new DatagramPacket(toSend, toSend.length, this.dstAddress);
        System.out.println("Requesting forwarding data from Controller.");
        try {
            this.socket.send(packet);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void forwardPacket (int port, DatagramPacket packet) {
        InetSocketAddress dest = new InetSocketAddress("localhost", port);
        packet.setSocketAddress(dest);
        try {
            this.socket.send(packet);
            System.out.println("Packet forwarded to port : " + port);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void sendHelloPacket() {
        DatagramPacket p = new DatagramPacket("hello".getBytes(), "hello".getBytes().length, this.dstAddress);
        try {
            this.socket.send(p);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void sendAck (SocketAddress sa) {
        DatagramPacket p = new DatagramPacket("ack".getBytes(), "ack".getBytes().length, sa);
        try {
            this.socket.send(p);
        } catch (IOException e){
            e.printStackTrace();
        }
    }

    public synchronized void start() {
        System.out.println("Sending connection message to controller");
        sendHelloPacket();
        try {
            this.wait();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        int routerPort = getAvailablePort();
        Router pub = new Router(DEFAULT_DST_NODE, CONTROLER_PORT, routerPort);
        pub.start();
    }
}