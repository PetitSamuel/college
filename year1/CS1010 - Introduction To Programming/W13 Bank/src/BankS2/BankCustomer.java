package BankS2;

import java.util.ArrayList;
import java.util.Date;

public class BankCustomer {
	long accountNumber;
	int sortCode;
	String customerName;
	String customerAddress;
	String customerEmail;
	Date customerDateOfBirth;
	double balance;
	ArrayList<Transactions>customerTransactions;

	public BankCustomer(){

	}
	public BankCustomer(long accountNumber, int sortCode, String customerName, String customerAddress, String customerEmail, Date customerDateOfBirth, double balance) {
		this(customerName, customerAddress, customerEmail, customerDateOfBirth, balance);
		this.accountNumber = accountNumber;
		this.sortCode = sortCode;
	}
	public BankCustomer(String customerName, String customerAddress, String customerEmail, Date customerDateOfBirth, double balance) {
		this.customerName = customerName;
		this.customerAddress = customerAddress;
		this.customerEmail = customerEmail;
		this.customerDateOfBirth = customerDateOfBirth;
		this.balance = balance;
	}

	public ArrayList<Transactions> getCustomerTransactions() {
		return customerTransactions;
	}
	public void setCustomerTransactions(ArrayList<Transactions> customerTransactions) {
		this.customerTransactions = customerTransactions;
	}
	public long getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(long accountNumber) {
		this.accountNumber = accountNumber;
	}
	public int getSortCode() {
		return sortCode;
	}
	public void setSortCode(int sortCode) {
		this.sortCode = sortCode;
	}
	public double getBalance() {
		return balance;
	}
	public void setBalance(double balance) {
		this.balance = balance;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerAddress() {
		return customerAddress;
	}
	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}
	public String getCustomerEmail() {
		return customerEmail;
	}
	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}
	public Date getCustomerDateOfBirth() {
		return customerDateOfBirth;
	}
	public void setCustomerDateOfBirth(Date customerDateOfBirth) {
		this.customerDateOfBirth = customerDateOfBirth;
	}

	@Override
	public String toString() {
		return "BankS2.BankCustomer [accountNumber=" + accountNumber + ", sortCode=" + sortCode + ", customerName="
				+ customerName + ", customerAddress=" + customerAddress + ", customerEmail=" + customerEmail
				+ ", customerDateOfBirth=" + customerDateOfBirth + ", balance=" + balance + ", customerTransactions="
				+ customerTransactions + "]";
	}
}

