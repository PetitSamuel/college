package climbingClub;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;


public class HarnessRecords {
   private ArrayList<Harness> harnessList;

    HarnessRecords(){
        this.harnessList =  new ArrayList<>();
    }
    HarnessRecords(FileReader fileReader){
        this();
        try{
            BufferedReader bufferedReader = new BufferedReader(fileReader);
            boolean endOfFile = false;
            while (!endOfFile) {
                String harnessData = bufferedReader.readLine();
                if(harnessData == null){
                    endOfFile = true;
                } else {
                    String[] properties = harnessData.split(",");
                    boolean isUsed = (Integer.parseInt(properties[5]) == 1)? true:false;
                    Harness newHarness = new Harness(properties[0], properties[1], properties[2], Integer.parseInt(properties[3]), Integer.parseInt(properties[4]), isUsed);
                    addHarness(newHarness);
                }
            }
        } catch(IOException e){
            e.printStackTrace();
        }


    }
    public boolean isEmpty(){
        return this.harnessList == null;
    }
    public void addHarness(Harness harnessToAdd){
        this.harnessList.add(harnessToAdd);
    }

    public Harness findHarness(String make, int modelNumber){
        int index = 0;
        boolean harnessFount = false;
        Harness tmpHarness = null;
        while(index < this.harnessList.size() && !harnessFount){
            if(this.harnessList.get(index).getMake().equals(make) &&  this.harnessList.get(index).getModelNumber() == modelNumber){
                tmpHarness = this.harnessList.get(index);
                harnessFount = true;
            }
            index++;
        }
        return tmpHarness;
    }

    public Harness checkHarness(String instructorName, String make, int modelNumber){
        Harness updatedHarness = findHarness(make, modelNumber);
        if(updatedHarness != null && !updatedHarness.isHarnessOnLoan()){
            updatedHarness.checkHarness(instructorName);
            return updatedHarness;
        } else {
            return null;
        }
    }

    public Harness loanHarness(String nameClubMember){
        boolean harnessFound = false;
        Harness harnessToLoan = null;
        for(int i = 0; i < this.harnessList.size() && !harnessFound; i++){
            if(this.harnessList.get(i).canHarnessBeLoaned()){
                harnessToLoan = this.harnessList.get(i);
                harnessFound = true;
                harnessToLoan.loanHarness(nameClubMember);
            }
        }
        return harnessToLoan;
    }
    public Harness returnHarness(String make, int modelNumber) {
        Harness harnessReturned = findHarness(make, modelNumber);
        if(harnessReturned != null && harnessReturned.isHarnessOnLoan()){
            harnessReturned.returnHarness();
        }
        return harnessReturned;
    }

    public Harness removeHarness(String make, int modelNumber){
        int index = 0;
        boolean harnessFound = false;
        Harness harnessRemoved = null;
        while(index < this.harnessList.size() && !harnessFound){
            if(this.harnessList.get(index).getMake().equals(make) &&  this.harnessList.get(index).getModelNumber() == modelNumber){
                harnessFound = true;
                harnessRemoved = this.harnessList.get(index);
                this.harnessList.remove(index);
            }
            index++;
        }
        return harnessRemoved;
    }
    public void printAllHarness(){
        for(int i = 0; i < this.harnessList.size(); i++){
            System.out.println(this.harnessList.get(i).toString() + ((i == this.harnessList.size() - 1)?"\n":""));
        }
    }
}
