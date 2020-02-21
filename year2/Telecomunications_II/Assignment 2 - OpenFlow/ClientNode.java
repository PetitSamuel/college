package cs.tcd.ie;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.DatagramPacket;

public abstract class ClientNode extends Node {
    private Input inputListener;

    ClientNode () {
        super();
        inputListener = new Input();
        this.inputListener.start();
    }

    public abstract void onReceipt(DatagramPacket packet);
    abstract void userInterface(String message);

    class Input extends Thread {

        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

        public void run() {
            while (true) {
                try {
                    String msg = in.readLine();
                    userInterface(msg);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
