import com.google.gson.JsonObject;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;
import java.net.SocketException;
import java.util.HashSet;
import java.util.Scanner;

public class Subscriber extends Node {
    // setting port as 0 will assign any free port
    static final int DEFAULT_SRC_PORT = 0;
    static final int DEFAULT_DST_PORT = 50001;
    static final String DEFAULT_DST_NODE = "localhost";

    // "type" of communication values
    static final int UNSUBSCRIBE = 2;
    static final int SUBSCRIBE = 1;
    static final int END_CONNECTION = 0;

    private HashSet<String> topics = new HashSet<>();
    private InetSocketAddress dstAddress;
    Subscriber(String dstHost, int dstPort, int srcPort) {
        try {
            this.dstAddress = new InetSocketAddress(dstHost, dstPort);
            this.socket = new DatagramSocket(srcPort);
            System.out.println("Currently using port " + dstAddress.getPort());
            System.out.println("Welcome !\n1 : Subscribe\n2 : Unsubscribe\n3 : Show Subscriptions\nend : End the process");
            listener.go();

            this.getUserInput.start();
        } catch (SocketException e) {
            e.printStackTrace();
        }
    }

    public synchronized void onReceipt(DatagramPacket packet) {
        byte[] data = packet.getData();
        // receive ack or send ack
        String content = new String(data, 0, packet.getLength());
        if (content.equals("ok")) System.out.println("Packet received by the broker");
        else {
            System.out.println(content);
            sendPacketFromBytes("ok".getBytes());
        }
    }

    public String getUserInput () {
        Scanner input = new Scanner(System.in);
        return input.nextLine();
    }

    // controller method, enables client to subscribe, unsubscribe & disconnect
    @Override
    public void userInterface(String message) {
        switch (message) {
            case "1":
                System.out.println("What topic would you like to subscribe to?");
                String subToTopic = getUserInput();
                subscribe(subToTopic);
                break;
            case "2":
                System.out.println("Which topic would you like to unsubscribe from?");
                String unsubTopic = getUserInput();
                    unsubscribe(unsubTopic);
                break;
            case "3":
                if (this.topics.isEmpty()) {
                    System.out.println("You are not currently subscribed to any topics");
                } else {
                    for(String topic : this.topics){
                        System.out.println(topic);
                    }
                }
                break;
            case "end" :
                endCommunication();
            default:
                System.out.println("Error: command not found.");
                break;
        }
    }

    public void unsubscribe(String topic) {
        if (!this.topics.remove(topic)) {
            System.out.println("You are not subscribed to " + topic);
        }

        sendPacketFromString(topic, UNSUBSCRIBE);
        System.out.println("Unsubscription  request for topic : " + topic + " successfully sent!");

    }

    public void subscribe(String topic) {
        if (topic == null || topic.equals("")) return;
        this.topics.add(topic);
        sendPacketFromString(topic, SUBSCRIBE);
        System.out.println("Subscription request sent for topic : " + topic);
    }

    public void endCommunication () {
        sendPacketFromString("", END_CONNECTION);
        System.out.println("Bye");
        Thread.currentThread().stop();
    }

    // gets a string & type of coomunication & sends it to the broker
    public void sendPacketFromString(String s, int type) {
        JsonObject stringAsJson = new JsonObject();
        stringAsJson.addProperty("type", type);

        // no need for additional data for end of communication request
        if (type == END_CONNECTION) {
            byte[] endOfContactInByte = stringAsJson.toString().getBytes();
            sendPacketFromBytes(endOfContactInByte);
            return;
        }

        // build JSON object with given data
        stringAsJson.addProperty("topic", s);
        byte[] stringInBytes = stringAsJson.toString().getBytes();
        byte[] buffer = new byte[stringInBytes.length];
        System.arraycopy(stringInBytes, 0, buffer, 0, stringInBytes.length);
        DatagramPacket packet = new DatagramPacket(buffer, buffer.length, this.dstAddress);
        send(packet);
    }

    // gets a datagram packet & sends it
    public void send (DatagramPacket packet) {
        try {
            this.socket.send(packet);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // used for ack & end of communication
    public void sendPacketFromBytes (byte[] buffer) {
        DatagramPacket packet = new DatagramPacket(buffer, buffer.length, dstAddress);
        try {
            socket.send(packet);
            System.out.println("Packet has been sent.");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        Thread sub = new Thread(new Subscriber(DEFAULT_DST_NODE, DEFAULT_DST_PORT, DEFAULT_SRC_PORT));
        sub.start();
    }
}