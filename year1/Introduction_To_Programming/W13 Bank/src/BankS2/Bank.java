package BankS2;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import java.util.TreeMap;
import java.io.*;

public class Bank implements BankInterface {
	static Map<Long, BankCustomer> customerMap;
	static long account;
	public static int SORT_CODE = 99901;
	public static int OPENING_BALANCE = 0;
	
	public Bank() {
		long account = 1001;	
		customerMap = new TreeMap<Long, BankCustomer>();
	}

	public BankCustomer findCustomer(long accountNumber) {
		/*
		 * for(int index = 0; index < customerMap.size(); index++) {
		 * if(customerMap.get(index).getAccountNumber() == AccountNumber) { return
		 * customerMap.get(index); } }
		 */
		return customerMap.get(accountNumber);
	}

	public BankCustomer findCustomer(String customerName, Date customerDateOfBirth, String customerAddress) {
		boolean foundMatch = false;
		for (long index = 0; index < customerMap.size() && !foundMatch; index++) {
			if (customerMap.get(index).getCustomerName() == customerName
					&& customerMap.get(index).getCustomerDateOfBirth() == customerDateOfBirth
					&& customerMap.get(index).getCustomerAddress() == customerAddress) {
				foundMatch = true;
				return customerMap.get(index);
			}
		}
		return null;
	}

	@Override
	public long createAccountNumber() {
		return account++;
	}

	@Override
	public boolean debitAccount(long accountNumber, double debitAmount) {
		BankCustomer customer = findCustomer(accountNumber);
		boolean accountDebited = false;
		double balance = customer.getBalance();
		
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		Date transactionDate = null;
		try {
			transactionDate = (formatter.parse("20-01-2019"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (balance >= debitAmount) {
			Transactions myTransaction = new Transactions(transactionDate, "Debit", debitAmount, customer.getBalance() - debitAmount);
			ArrayList<Transactions>transactionsList = customer.getCustomerTransactions();
			transactionsList.add(myTransaction);
			customer.setBalance(balance - debitAmount);
			accountDebited = true;
		} else {
			accountDebited = false;
		}
		return accountDebited;
	}

	@Override
	public boolean creditAccount(long accountNumber, double creditAmount) {

		BankCustomer customer = findCustomer(accountNumber);
		Transactions myTransaction = new Transactions(Calendar.getInstance().getTime(), "Credit", creditAmount, customer.getBalance() + creditAmount);
		ArrayList<Transactions>transactionsList = customer.getCustomerTransactions();
		transactionsList.add(myTransaction);
		customer.setBalance(customer.getBalance() + creditAmount);
		return true;
	}

	@Override
	public void printBalance(long accountNumber) {
		BankCustomer customer = findCustomer(accountNumber);
		System.out.println(customer.getBalance());
	}
	public void printStatement(long accountNumber) {
		BankCustomer customer = findCustomer(accountNumber);
		ArrayList<Transactions>transactionsList = customer.getCustomerTransactions();
		for(int count = 0; count < transactionsList.size(); count++) {
			Transactions customerTransactions = transactionsList.get(count);
			System.out.println(customerTransactions.toString());
		}
	}

	public void createCustomer(String name, String address, String email, String dateOfBirth){
		long accountNumber = createAccountNumber();

		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		Date birthDate = null;
		try {
			birthDate = formatter.parse(dateOfBirth);
		} catch (Exception e) {
			e.printStackTrace();
		}
		BankCustomer customer = new BankCustomer(accountNumber, SORT_CODE, name, address, email, birthDate, OPENING_BALANCE);
		customerMap.put(accountNumber, customer);
	}

	public void readCustomers() {
		try {
			FileReader fileReader = new FileReader("customers.txt");
			BufferedReader bufferedReader = new BufferedReader(fileReader);
			boolean endOfFile = false;
			while (!endOfFile) {
				String customerData = bufferedReader.readLine();
				if (customerData == null) {
					endOfFile = true;
				} else {
					String[] customerProperties = customerData.split(",");
					SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
					Date dateOfBirth = null;
					try {
						dateOfBirth = formatter.parse(customerProperties[5]);
					} catch (Exception e) {
						e.printStackTrace();
					}
					BankCustomer newCustomer = new BankCustomer(Long.parseLong(customerProperties[0]), Integer.parseInt(customerProperties[1]), customerProperties[2], customerProperties[3], 
							customerProperties[4], dateOfBirth, Double.parseDouble(customerProperties[6]));
					customerMap.put(newCustomer.getAccountNumber(), newCustomer);
				}
			}
			bufferedReader.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

/*	public ArrayList<Long> getCustomerAccountNumbers(){
		return new ArrayList(customerMap.keySet());
	}
*/
	public Long [] getAllCustomerAccountNumber(){
		Long [] customerAccountNumbers = new Long [customerMap.keySet().size()];
		customerAccountNumbers = customerMap.keySet().toArray(customerAccountNumbers);
		return customerAccountNumbers;
	}
}
