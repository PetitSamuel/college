package climbingClub;

public class Harness {

    // i.e., new harnesses have never been used before. Additionally, a club climbing instructor always double checks the safety of each new harness.
    private String make, instructorNameLastChecked, nameClubMemberBorrowed;
    private int modelNumber;
    private int countUsed;
    private boolean isUsed;

    public Harness(String make, String instructorNameLastChecked, String nameClubMemberBorrowed, int modelNumber, int countUsed, boolean isUsed) {
        this.make = make;
        this.instructorNameLastChecked = instructorNameLastChecked;
        if(isUsed)this.nameClubMemberBorrowed = nameClubMemberBorrowed;
        else this.nameClubMemberBorrowed = null;
        this.modelNumber = modelNumber;
        this.countUsed = countUsed;
        this.isUsed = isUsed;
    }

    public Harness(String make, int modelNumber, String instructorNameLastChecked) {
        this.instructorNameLastChecked = instructorNameLastChecked;
        this.modelNumber = modelNumber;
        this.make = make;
        this.nameClubMemberBorrowed = null;
        this.isUsed = false;
        this.countUsed = 0;
    }
    public void checkHarness(String instructorName){
        if(!this.isUsed){
            this.instructorNameLastChecked = instructorName;
            this.countUsed = 0;
        }
    }
//(4) isHarnessOnLoan which determines whether this harness is currently loaned out to a climbing club member.
    public boolean isHarnessOnLoan(){
        return this.isUsed;
    }

    public boolean canHarnessBeLoaned() {
        return !isHarnessOnLoan();
    }
    public void loanHarness(String clubMemberName){
        if(canHarnessBeLoaned()){
            this.isUsed = true;
            this.nameClubMemberBorrowed = clubMemberName;
        }
    }
    public void returnHarness(){
        if(isHarnessOnLoan()){
            this.nameClubMemberBorrowed = null;
            this.countUsed += 1;
            this.isUsed = false;
        }
    }

    public String getMake() {
        return make;
    }

    public String getInstructorNameLastChecked() {
        return instructorNameLastChecked;
    }

    public String getNameClubMemberBorrowed() {
        return nameClubMemberBorrowed;
    }

    public int getModelNumber() {
        return modelNumber;
    }

    public int getCountUsed() {
        return countUsed;
    }

    public boolean isUsed() {
        return isUsed;
    }

    @Override
    public String toString() {
        return "Harness{" +
                "make='" + make + '\'' +
                ", instructorNameLastChecked='" + instructorNameLastChecked + '\'' +
                ", nameClubMemberBorrowed='" + nameClubMemberBorrowed + '\'' +
                ", modelNumber=" + modelNumber +
                ", countUsed=" + countUsed +
                ", isUsed=" + isUsed +
                '}';
    }
}
