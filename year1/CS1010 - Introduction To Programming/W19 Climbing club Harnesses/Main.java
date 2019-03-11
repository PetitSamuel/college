package climbingClub;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Scanner;
public class Main {


    public static final String HOME_MESSAGE =   "[1]add a record for a newly purchased harness\n" +
                                                "[2]remove a climbing harness from the club\n" +
                                                "[3]record the fact that a club instructor has checked the safety of a harness\n" +
                                                "[4]loan a harness to a club member if there is an availabe harness\n" +
                                                "[5]return a harness which is no longer in use by a club member.\n" +
                                                "[6] Print a list of all harnesses owned by the club.";

    public static void main(String[] args) {
        HarnessRecords records = null;
        try{
            FileReader fr = new FileReader("C:\\Users\\Samuel\\IdeaProjects\\Climbing club Harness\\src\\climbingClub\\harnessInfo.txt");
            records = new HarnessRecords(fr);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        boolean endOfProgram = false;


        while(!endOfProgram){
            boolean whatToDo = false;
            String input = null;
            while(!whatToDo){
                input = scanLine("Enter the number corresponding to what you would like to do.\n" + HOME_MESSAGE + "\nOr enter exit.");
                if(input.equals("exit")){
                    whatToDo = true;
                    endOfProgram = true;
                } else if(parseToInt(input) > 0 && parseToInt(input) <=6){
                    whatToDo = true;
                }   else if(parseToInt(input) < 0 || parseToInt(input) > 5){
                    System.out.println("Number is negative or too big ! Enter a number from 1 to 5.");
                }
            }
            int numberChosen = parseToInt(input);
            if(!endOfProgram){
                switch(numberChosen){
                    case 1:
                        System.out.println("Adding a record for a newly purchased harness.");
                        String newMake = getStringLine("cancel", "Enter the make");
                        if(newMake.equals("cancel")){
                            System.out.println("Addition of new Harness cancelled.");
                            break;
                        }
                        int modelNumber = parseToInt(getStringLine("cancel", "Enter the model number"));
                        if(modelNumber == 0){
                            System.out.println("Addition of new Harness cancelled.");
                            break;
                        }
                        String instructorName = getStringLine("cancel", "Enter the name of the instructor who has done the safety checks");
                        if(instructorName.equals("cancel")){
                            System.out.println("Addition of new Harness cancelled.");
                            break;
                        }
                        Harness newHarness = new Harness(newMake, modelNumber, instructorName);
                        records.addHarness(newHarness);
                        System.out.println("New harness successfully added." + newHarness.toString() + "\n");
                        break;
                    case 2:
                        System.out.println("Removing a climbing harness from the club. Here is a list of all of the club's harnesses");
                        records.printAllHarness();
                        String makeToRemove = getStringLine("cancel", "Enter the make");
                        if(makeToRemove.equals("cancel")){
                            System.out.println("Removing harness cancelled.\n");
                            break;
                        }
                        int modelNumberToRemove = parseToInt(getStringLine("cancel", "Enter the model number"));
                        if(modelNumberToRemove == 0){
                            System.out.println("Removing harness cancelled.\n");
                            break;
                        }
                        Harness removedHarness = records.removeHarness(makeToRemove, modelNumberToRemove);
                        if(removedHarness == null) System.out.println("Harness not found. List unchanged\n");
                        else {
                            System.out.println("Harness removed : " + removedHarness.toString() +"\nNew list:");
                            records.printAllHarness();
                        }
                        break;
                    case 3:
                        System.out.println("Checking the safety of a harness. Here is a list of all of the club's harnesses");
                        records.printAllHarness();
                        String makeCheck = getStringLine("cancel", "Enter the make");
                        if(makeCheck.equals("cancel")){
                            System.out.println("Checking of harness cancelled.\n");
                            break;
                        }
                        int modelNumberToCheck = parseToInt(getStringLine("cancel", "Enter the model number"));
                        if(modelNumberToCheck == 0){
                            System.out.println("Checking of harness cancelled.\n");
                            break;
                        }
                        String checkingInstructorName  = getStringLine("cancel", "Enter the name of the instructor who has done the safety checks");
                        if(checkingInstructorName.equals("cancel")){
                            System.out.println("Checking of harness cancelled.\n");
                            break;
                        }
                        Harness harnessToCheck = records.checkHarness(checkingInstructorName, makeCheck, modelNumberToCheck);
                        if(harnessToCheck != null) System.out.println("The following harness was successfully safety checked:" + harnessToCheck.toString() + "\n");
                        else System.out.println("Harness not found.\n");
                        break;
                    case 4:
                        System.out.println("Loaning a harness.");
                        String clubMemberName = getStringLine("cancel", "Enter the name of the club member");
                        if(clubMemberName.equals("cancel")){
                            System.out.println("Loaning a harness cancelled.\n");
                            break;
                        }
                        Harness loanedHarness = records.loanHarness(clubMemberName);
                        if(loanedHarness != null) System.out.println("Harness successfully loaned: " + loanedHarness.toString() + "\n");
                        else System.out.println("No harness available to loan.\n");
                        break;
                    case 5:
                        System.out.println("Returning a harness. Here is a list of all of the club's harnesses\n");
                        records.printAllHarness();
                        String returnedMake = getStringLine("cancel", "Enter the make");
                        if(returnedMake.equals("cancel")){
                            System.out.println("Addition of new Harness cancelled.\n");
                            break;
                        }
                        int returnedModelNumber = parseToInt(getStringLine("cancel", "Enter the model number"));
                        if(returnedModelNumber == 0){
                            System.out.println("Addition of new Harness cancelled.\n");
                            break;
                        }
                        Harness returnedHarness = records.returnHarness(returnedMake, returnedModelNumber);
                        if(returnedHarness != null) System.out.println("Harness successfully returned: " + returnedHarness.toString() + "\n");
                        else System.out.println("Error : Harness not found or already returned\n");
                        break;
                    case 6:
                        System.out.println("Here is a detailed list of all harness owned by the club :\n");
                        records.printAllHarness();
                        break;
                    default:
                        System.out.println("This shoudln't happen.");
                        break;
                }
            }
        }
    }
    public static String getStringLine(String endCondition, String message){
        boolean foundLine = false;
        String input = null;
        while(!foundLine){
            input = scanLine(message + ". Or enter " + endCondition);
            if(input.equals(endCondition)){
                foundLine = true;
            } else if(input != null){
                foundLine = true;
            }
        }
        return input;
    }
    public static String scanLine(String message) {
        Scanner scanner = new Scanner(System.in);
        Integer ret = null;
        String line = null;
        while (line == null) {
            System.out.println(message);
            line = scanner.nextLine();
        }
        return line;
    }
    public static int parseToInt(String line){
        int number = 0;

        if(line == null) return 0;
        try {
            number = Integer.valueOf(line);
        } catch (NumberFormatException e) {
            System.out.println("Error when parsing to an Integer, numeric value expected. Try again.");
        }
        return number;
    }
}
