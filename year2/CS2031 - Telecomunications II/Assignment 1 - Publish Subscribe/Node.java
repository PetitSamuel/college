import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketException;
import java.util.concurrent.CountDownLatch;

public abstract class Node extends Thread{
    static final int PACKETSIZE = 65536;

    DatagramSocket socket;
    Listener listener;
    CountDownLatch latch;
    Input getUserInput = new Input();

    Node() {
        latch = new CountDownLatch(1);
        listener = new Listener();
        listener.setDaemon(true);
        listener.start();
    }


    public abstract void onReceipt(DatagramPacket packet);

    public abstract void userInterface(String message);

    /**
     * Listener thread
     * <p>
     * Listens for incoming packets on a datagram socket and informs registered receivers about incoming packets.
     */
    class Listener extends Thread {

        /*
         *  Telling the listener that the socket has been initialized
         */
        public void go() {
            latch.countDown();
        }

        /*
         * Listen for incoming packets and inform receivers
         */
        public void run() {
            try {
                latch.await();
                // Endless loop: attempt to receive packet, notify receivers, etc
                while (true) {
                    DatagramPacket packet = new DatagramPacket(new byte[PACKETSIZE], PACKETSIZE);
                    socket.receive(packet);

                    onReceipt(packet);
                }
            } catch (Exception e) {
                if (!(e instanceof SocketException)) e.printStackTrace();
            }
        }
    }

    class Input extends Thread {

        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

        public void run() {
            while (true) {
                try {
                    String msg = in.readLine();
                    userInterface(msg);
                } catch (Exception e) {
                }
            }
        }
    }
}