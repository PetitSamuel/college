package BankS2;

import java.util.Scanner;

public class BankApplication {
    public static void main(String[]args){
        Bank bank = new Bank();
        bank.readCustomers();
        Long [] accountNumber = bank.getAllCustomerAccountNumber();
        for(int count = 0; count < accountNumber.length; count++){
            System.out.println(accountNumber[count]);
        }

        Scanner userInput = new Scanner(System.in);

    }
}
