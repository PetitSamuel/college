package cs.tcd.ie;

import com.google.gson.JsonObject;
import java.io.IOException;
import java.net.*;
import java.util.ArrayList;
import java.util.HashSet;

public class Controler extends Node {
    static final int DEFAULT_PORT = 50001;
    HashSet<Integer> listOfRouters;


    Controler(int port) {
        listOfRouters = new HashSet<>();
        try {
            System.out.println("Welcome !");
            socket = new DatagramSocket(port);
            listener.go();
        } catch (java.lang.Exception e) {
            e.printStackTrace();
        }
    }


    public synchronized void onReceipt(DatagramPacket packet) {
        byte[] data = packet.getData();
        String content = new String(data, 0, packet.getLength());

        if (content.equals("hello")) {
            System.out.println("New connection !");
            listOfRouters.add(packet.getPort());
            sendPacketFromString(packet.getSocketAddress(), "hello");
            return;
        } else if (content.equals("ack")) {
            System.out.println("ACK received.");
            return;
        } else {
            sendPacketFromString(packet.getSocketAddress(), "ack");
        }

        JsonObject json = Json.getJsonFromString(content);
        switch (json.get("type").getAsString()) {
            case "unknown packet path":
                System.out.println("Received forwarding request from Router");
                newPathHandler(json, packet);
                break;
            default:
                System.out.println("Received packet with unsupported action :\n" + content);
        }
    }

    public void newPathHandler (JsonObject json, DatagramPacket packet) {
        HashSet<Integer> pathHandler = new HashSet<>(this.listOfRouters);
        json.remove("type");
        json.addProperty("type", "add path");

        int prev = packet.getPort();
        pathHandler.remove(prev);

        if (pathHandler.isEmpty()) {
            json.addProperty("forwardingPort", json.get("destinationPort").getAsInt());
            System.out.println("Sent out new path to router");
            sendPacketFromJson(prev, json);
            System.out.println("Sent successfully forwarding information to Router : " + packet.getPort());
            return;
        }

        ArrayList<Integer> list = new ArrayList<>(pathHandler);
        for (int i = 0; i < list.size(); i++) {
            sendPathToRouter(prev, list.get(i), json);

            prev = list.get(i);
            if (i == list.size() - 1) {
                sendPathToRouter(prev, json.get("destinationPort").getAsInt(), json);
            }
        }
    }

    public void sendPathToRouter (int oldPort, int newPort, JsonObject json) {
        json.remove("forwardingPort");
        json.addProperty("forwardingPort", newPort);

        System.out.println("Sent out new path to router");
        sendPacketFromJson(oldPort, json);
        System.out.println("Sent successfully forwarding information to Router : " + oldPort);
    }
    public void sendPacketFromJson(int port, JsonObject json) {
        InetSocketAddress address = new InetSocketAddress("localhost", port);
        byte[] data = json.toString().getBytes();
        DatagramPacket packet = new DatagramPacket(data, data.length, address);
        try {
            this.socket.send(packet);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public void sendPacketFromString(SocketAddress address, String message) {
        byte[] data = message.getBytes();
        DatagramPacket p = new DatagramPacket(data, data.length, address);
        try {
            this.socket.send(p);
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("Sent ack.");
    }

    public synchronized void start() {
        System.out.println("Controller ready for action");
        try {
            this.wait();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
            Controler broker = new Controler(DEFAULT_PORT);
            broker.start();
    }
}