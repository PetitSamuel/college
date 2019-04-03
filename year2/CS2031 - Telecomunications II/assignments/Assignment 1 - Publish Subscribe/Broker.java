import com.google.gson.*;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketAddress;
import java.util.*;

public class Broker extends Node {
    static final int DEFAULT_PORT = 50001;

    // type of communications
    static final int PUBLISH = 3;
    static final int UNSUBSCRIBE = 2;
    static final int SUBSCRIBE = 1;
    static final int END_CONNECTION = 0;

    private HashSet<SocketAddress> subscribers = new HashSet<>();
    private HashMap<SocketAddress, Integer> publishers = new HashMap<>();
    private HashMap<String, HashSet<SocketAddress>> topicsSubscription = new HashMap<>();
    private HashMap<String, ArrayList<String>> messages = new HashMap<>();

    Broker(int port) {
        try {
            System.out.println("Broker using port " + DEFAULT_PORT);
            System.out.println("Welcome ! Here are some commands you may use:\n" +
                    "1 : Clear the subscribers lists\n2 : Clear the publishers list\n3 : Clear the messages list");
            socket = new DatagramSocket(port);
            listener.go();
            getUserInput.start();
        } catch (java.lang.Exception e) {
            e.printStackTrace();
        }
    }

    // routine to handle requests to stop communication (for both subscribers & publishers)
    public void endOfCommunicationHandler(SocketAddress destination) {
        byte[] data = "end".getBytes();
        DatagramPacket packetToSend = new DatagramPacket(data, data.length, destination);
        send(packetToSend);
        System.out.println("ended communication");
        this.subscribers.remove(destination);
        this.publishers.remove(destination);
    }

    // handles new subscriptions
    public void subscriptionHandler(JsonObject json, SocketAddress address) {
        subscribers.add(address);

        String topic = json.get("topic").getAsString();
        if(!topicsSubscription.containsKey(topic)) topicsSubscription.put(topic, new HashSet<SocketAddress>());
        topicsSubscription.get(topic).add(address);
        sendAck(address);
        sendAllMessagesForTopic(address, topic);
        System.out.println("New subscriber to " + topic);
    }

    // handles requests from clients to stop receiving messages from a topic
    public void unsubscriptionHandler(JsonObject json, SocketAddress address) {
        subscribers.remove(address);

        String topic = json.get("topic").getAsString();
        if(!topicsSubscription.containsKey(topic)) return;

        topicsSubscription.get(topic).remove(address);
        System.out.println("Client unsubscribed from " + topic);
        sendAck(address);
    }

    // handles incoming messages from publishers
    public void publicationHandler(JsonObject json, SocketAddress address) {
        // add publisher to list if new publisher
        if (!publishers.containsKey(address)){
            publishers.put(address, 0);
            System.out.println("New publisher registered ! ");
        }

        // go back N implementation, request from publisher valid message
        if (publishers.get(address) != json.get("index").getAsInt()) {
            sendAck(address, publishers.get(address));
            return;
        };

        // update index of message to request from publisher (go back N)
        publishers.replace(address, publishers.get(address), publishers.get(address) + 1);

        String topic = json.get("topic").getAsString();
        String message = json.get("message").getAsString();
        if (!messages.containsKey(topic)) {
            ArrayList<String> m = new ArrayList<>();
            messages.put(topic, m);
        }
        messages.get(topic).add(message);
        sendAck(address, publishers.get(address));
        sendMessageToSubscribers(topic, message);
        System.out.println("New message for topic \"" + topic + "\" : " + message);
    }

    // sends message to subscribers of the messages topic
    public void sendMessageToSubscribers(String topic, String message) {
        String finalStringToSend = topic + " : " + message;
        byte[] stringAsByte = finalStringToSend.getBytes();
        DatagramPacket packet = new DatagramPacket(stringAsByte, stringAsByte.length);
        HashSet<SocketAddress> sockets = topicsSubscription.get(topic);

        // there are no subscribers
        if(sockets == null || sockets.size() == 0) return;
        for(SocketAddress socket : sockets) {
            // subscriber has unsubscribed, remove from list
            if (!subscribers.contains(socket)) {
                sockets.remove(socket);
            } else {
                // send message to subscriber
                packet.setSocketAddress(socket);
                send(packet);
            }
        }
        // if list of subscribers has changed, update it
        if (sockets.size() != topicsSubscription.get(topic).size()) {
            topicsSubscription.replace(topic, topicsSubscription.get(topic), sockets);
        }
    }

    // self explanatory
    public void sendAck(SocketAddress socketAddress) {
        byte[] ackAsByte = "ok".getBytes();
        DatagramPacket packet = new DatagramPacket(ackAsByte, ackAsByte.length, socketAddress);
        send(packet);
    }

    // send ack for go back N
    public void sendAck(SocketAddress socketAddress, int number) {
        String numberAsString = "" + number;
        byte[] ackAsByte = numberAsString.getBytes();
        DatagramPacket packet = new DatagramPacket(ackAsByte, ackAsByte.length, socketAddress);
        send(packet);
    }

    // used for new subscribers
    public void sendAllMessagesForTopic(SocketAddress subscriberAddress, String topic) {
        ArrayList<String> messagesForTopic = messages.get(topic);
        String finalString = "";
        if (messagesForTopic == null || messagesForTopic.size() == 0) {
            // there are no messages for this topic, send ack of subscription
            return;
        };
        // if there are messages, send those
        // build string with all messages published to that topic
        for(String message : messagesForTopic) {
            finalString += topic + " : " + message + "\n\r";
        }

        byte[] stringAsBytes = finalString.getBytes();
        DatagramPacket packet = new DatagramPacket(stringAsBytes, stringAsBytes.length, subscriberAddress);
        send(packet);
    }

    // controller for the broker, handles subscriptions, acks, unsubs, end of communication requests and publications
    public synchronized void onReceipt(DatagramPacket packet) {
        byte[] data = packet.getData();
        String content = new String(data, 0, packet.getLength());

        // Acknowledge acks
        if (content.equals("ok")) {
            // ack from subscribers
            System.out.println("ack received");
            return;
        }

        // get JSON object from string
        JsonObject j = getJsonFromString(content);

        int typeOfRequest = Integer.parseInt(j.get("type").getAsString());
        SocketAddress address = packet.getSocketAddress();

        switch (typeOfRequest) {
            case END_CONNECTION:
                endOfCommunicationHandler(address);
                break;
            case SUBSCRIBE:
                subscriptionHandler(j, address);
                break;
            case UNSUBSCRIBE:
                unsubscriptionHandler(j, address);
                break;
            case PUBLISH:
                publicationHandler(j, address);
                break;
            default:
                System.out.println("Error! code not valid");
        }
    }

    // gets a string & parses it to a JSON object
    private JsonObject getJsonFromString (String s) {
        JsonParser parser = new JsonParser();
        return (JsonObject) parser.parse(s);
    }

    // gets a datagram packet & sends it
    private void send(DatagramPacket packet) {
        try {
            this.socket.send(packet);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // extra broker features that may be used to test the program
    @Override
    public void userInterface(String message) {
        switch (message) {
            case "1":
                // clear subscribers list
                this.subscribers = new HashSet<>();
                for(Map.Entry<String, HashSet<SocketAddress>> entry : this.topicsSubscription.entrySet()) {
                    this.topicsSubscription.replace(entry.getKey(), new HashSet<SocketAddress>());
                }
                System.out.println("Reset the subscription lists successfully");
                break;
            case "2":
                // clear publishers list
                this.publishers = new HashMap<>();
                System.out.println("Cleared list of publishers successfully");
                break;
            case "3":
                this.messages = new HashMap<>();
                for(Map.Entry<SocketAddress, Integer> entry : this.publishers.entrySet()) {
                    this.publishers.replace(entry.getKey(), 0);
                }
                System.out.println("Cleared list of messages successfully");
                break;
            default:
                System.out.println("Error : Command not supported.");
        }
    }

    public synchronized void start() {
        System.out.println("Broker ready for action");
        try {
            this.wait();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        try {
            Broker broker = new Broker(DEFAULT_PORT);
            broker.start();
        } catch (java.lang.Exception e) {
            e.printStackTrace();
        }
    }
}