package cs.tcd.ie;

import java.util.Scanner;

public class FormatedInput {
    public static String getUserInput () {
        Scanner input = new Scanner(System.in);
        return input.nextLine();
    }
    public static int getValidInteger () {
        String s;
        int i;

        boolean gettingValidPort = true;
        do {
            s = getUserInput();
            try
            {
                i = Integer.parseInt(s);
                gettingValidPort = false;
            }
            catch (NumberFormatException e)
            {
                System.out.println("Please enter a valid integer.");
                i = 0;
            }

        } while (gettingValidPort);
        return i;
    }

    public static int getAvailablePort () {
        int sourcePort;
        do {
            System.out.println("Please enter an available, valid port to use");
            sourcePort = getValidInteger();
        } while (!Port.available(sourcePort));
        return sourcePort;
    }

    public static int getInUsePort () {
        int sourcePort;
        do {
            System.out.println("Please enter a port that is currently in use :");
            sourcePort = getValidInteger();
        } while (Port.available(sourcePort));
        return sourcePort;
    }
}
