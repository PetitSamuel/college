package BankS2;

import java.util.Date;

public interface BankInterface {
	
	public long createAccountNumber();
	public BankCustomer findCustomer(long accountNumber);
	public BankCustomer findCustomer(String name, Date dateOfBirth, String address);
	public boolean debitAccount(long accountNumber, double debitAmount);
	public boolean creditAccount(long accountNumber, double debitAmount);
	public  void printBalance(long accountNumber); 
	
}
