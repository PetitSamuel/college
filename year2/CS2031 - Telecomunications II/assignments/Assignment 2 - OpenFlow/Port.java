package cs.tcd.ie;

import java.io.IOException;
import java.net.DatagramSocket;

class Port {
    public static boolean available(int port) {
        boolean result = false;
        try {
            (new DatagramSocket(port)).close();
            result = true;
        }
        catch (IOException e) {
            // return default value
        }
        return result;
    }
}
