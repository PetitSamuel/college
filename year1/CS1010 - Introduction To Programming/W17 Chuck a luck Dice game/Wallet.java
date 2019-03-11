
public class Wallet {

	// current cash in wallet
	private double cash;

	// construct wallet with zero cash
	public Wallet() {
		cash = 0.0;
	}

	// put an amount of money into wallet
	// pre-condition: money > 0.0
	public void put(double money) {
		if (money > 0.0)
			cash = cash + money;
	}

	// get an amount of money from wallet
	// returns true if wallet had enough cash, false otherwise
	// pre-condition: money > 0.0
	public boolean get(double money) {
		if (money > 0.0 && cash >= money) {
			cash = cash - money;
			return true;
		}
		return false;
	}

	// return current amount of cash in wallet
	public double check() {
		return cash;
	}

	// convert to a String data type value
	public String toString() {
		return getClass().getName() + "[cash = " + cash + "]";
	}

} 