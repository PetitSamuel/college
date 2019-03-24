import com.google.gson.JsonObject;
import java.io.IOException;
import java.net.DatagramSocket;
import java.net.DatagramPacket;
import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.Scanner;

public class Publisher extends Node {
    // setting port as 0 automatically finds an available port
    private static final int PUBLISHER_PORT = 0;
    private static final int BROKER_PORT = 50001;
    private static final String DEFAULT_DST_NODE = "localhost";

    private InetSocketAddress dstAddress;
    private String topic;

    // types of communication used by publisher
    private static final int PUBLISH = 3;
    private static final int END_CONNECTION = 0;

    private boolean waitingOnAck;
    private ArrayList<String> packetsSent = new ArrayList<>();

    Publisher(String dstHost, int dstPort, int srcPort) {

        try {
            this.topic = "";
            dstAddress = new InetSocketAddress(dstHost, dstPort);
            System.out.println("Currently using port " + dstAddress.getPort());
            socket = new DatagramSocket(srcPort);
            listener.go();
            getUserInput.start();
            this.waitingOnAck = false;
            System.out.println("Welcome! Here are the available commands you may use:\n" +
                    "1 : Publish a message for current topic\n2 : Select a topic to publish for\nend : End communication");
        } catch (java.lang.Exception e) {
            e.printStackTrace();
        }
    }

    public synchronized void onReceipt(DatagramPacket packet) {
        byte[] data = packet.getData();
        String content = new String(data, 0, packet.getLength());
        this.waitingOnAck = false;
        int index = Integer.parseInt(content);
        System.out.println("Broker expecting for packet " + index + " current index is " + (packetsSent.size() - 1));

        // implementation of go back N
        if (index != packetsSent.size()) {
            sendSpecificPacket(packetsSent.get(index));
        }
    }

    // controller method, enables publisher to perform actions
    @Override
    public void userInterface(String message) {
        switch (message){
            case "1":
                if (this.waitingOnAck) {
                    System.out.println("Waiting on Ack from Broker, can't publish right now.");
                    return;
                }
                if (this.topic.equals("")) {
                    System.out.println("You do not currently have a topic set. You will be asked to set one before you can publish a message.");
                    userInterface("2");
                }
                String publicationText;
                do {
                    System.out.println("Enter the message to publish:");
                    Scanner s = new Scanner(System.in);
                    publicationText = s.nextLine();
                } while (publicationText.equals(""));
                sendMessage(publicationText, PUBLISH);
                break;
            case "2":
                do {
                    System.out.print("Enter the topic you would like to publish for : ");
                    Scanner topicScanner = new Scanner(System.in);
                    this.topic = topicScanner.nextLine();
                } while (topic.equals(""));
                System.out.println("Successfully selected a topic : " + this.topic);
                break;
            case "end" :
                System.out.println("Goodbye.");
                sendMessage("", END_CONNECTION);
                Thread.currentThread().stop();
                break;
            default:
                System.out.println("Error : the command entered is undefined.");
                break;
        }
    }

    // send a publication to broker
    public void sendMessage (String message, int type) {
        JsonObject json = new JsonObject();
        json.addProperty("type", type);

        // end of contact does not need additional data
        if (type == END_CONNECTION) {
            byte[] endBytes = json.toString().getBytes();
            DatagramPacket endPacket = new DatagramPacket(endBytes, endBytes.length, this.dstAddress);
            send(endPacket);
            return;
        }

        // build json object with topic/message & index (for go back N) data
        json.addProperty("topic", this.topic);
        json.addProperty("message", message);
        // index of current message use for go back N
        json.addProperty("index", this.packetsSent.size());

        // send publication
        byte[] buffer = json.toString().getBytes();
        DatagramPacket packet = new DatagramPacket(buffer, buffer.length, dstAddress);
        packetsSent.add(json.toString());
        send(packet);
    }

    // used when broker requests different publication than latest,
    public void sendSpecificPacket (String message) {
        byte[] buffer = message.getBytes();
        DatagramPacket packet = new DatagramPacket(buffer, buffer.length, dstAddress);
        send(packet);
    }

    public void send(DatagramPacket packet) {
        try {
            socket.send(packet);
            this.waitingOnAck = true;
            System.out.println("Packet sent");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }



    public static void main(String[] args) {
        Thread pub = new Thread(new Publisher(DEFAULT_DST_NODE, BROKER_PORT, PUBLISHER_PORT));
        pub.start();
    }
}