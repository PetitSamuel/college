import java.util.Scanner;

public class Chuck_A_LUCK {

	public static String BET_TYPE_TRIPLE = "Triple : All three dice must show the same number (e.g. all 3s). However, the House wins if the Triple is all 1s or all 6s. A Tripe is paid at thirty to one (30:1).";
	public static String BET_TYPE_FIELD = "Field : The total of the numbers shown on the 3 dice must sum to a number less than 8 or greater then 12. A Field is paid at one to one (1:1).";
	public static String BET_TYPE_HIGH = "High : The total of the numbers shown on the 3 dice must sum to a number greater than 10. The payoff is one to one (1:1) unless there is a high Triple, i.e., three 4s (12), three 5s (15), or three 6s (18), in which case the High bet loses. There are 108 possible combinations of the 3 dice that add up to over 10, and only 3 of them are Triples.";
	public static String BET_TYPE_LOW = "Low : The total of the numbers shown on the 3 dice must sum to a number less than 11. The payoff is one to one (1:1) unless there is a low Triple, i.e., three 1s (3), three 2s (6), or three 3s (9), in which case the Low bet loses. There are 108 possible combinations of the 3 dice that add up to under 11, and only 3 of them are Triples.";

	public static void main(String[] args) {
		Wallet playerWallet = new Wallet();
		setBalance(playerWallet);
		boolean finishedPlaying = false;
		while(!finishedPlaying) {
			String [] betInfo = new String [2];
			betInfo = setBet(playerWallet);
			resolveBet(betInfo);
			
			if(playerWallet.check() <= 0) {
				System.out.println("No money left to play!");
				finishedPlaying = true;
			}
		}
	}
	
	public static void resolveBet(String[] betInfo) {

		
	}

	public static void setBalance(Wallet playerWallet) {
		boolean moneyInput = false;
		Scanner input = null;
		while (!moneyInput) {
			input = new Scanner(System.in);
			System.out.println("How much money do you have?");
			if (input.hasNextDouble()) {
				Double money = input.nextDouble();
				if (money > 0.0) {
					playerWallet.put(money);
					moneyInput = true;
					System.out.println("Wallet updated : " + playerWallet.toString());
				} else {
					System.out.println("Error while updating your wallet. The input is not a positive number");
				}
			}
			else {
				System.out.println("Error while updating your wallet. Enter a valid number");
			}				
		}
	}
	public static String [] setBet(Wallet playerWallet) {
		Scanner betInput = null;
		String[] stringToArray = null;
		String userInput = "";
			betInput = new Scanner(System.in);
			System.out.println("Here are the different betting types : \n" + BET_TYPE_TRIPLE + "\n" + BET_TYPE_FIELD + "\n" + BET_TYPE_HIGH + "\n" + BET_TYPE_LOW);
			System.out.println("\nEnter how much you would like to bet and then the bet type you wish to enter (ex : 400, high). Or enter quit to stop playing");
			if (betInput.hasNextLine()) {
				userInput = betInput.nextLine();
				userInput = userInput.trim();
				stringToArray = userInput.split(",");
			}				
		betInput.close();
		return stringToArray;
	}
	public static void resolveBet(int type, double amount) {
		
	}
}

/*
 * 1. mainline (parts of the mainline can be implemented in new methods that you
 * can create) which does the following:
 * 
 * Allows the user to play continuously placing any of the four bet types until
 * the user either enters quit or the cash in the wallet is 0. For each bet
 * placed by the user, the resolveBet method is called. Once the game is over,
 * provides an overall summary by comparing the cash in the wallet with what the
 * user initially started with.
 * 
 * 
 * 2. ResolveBet method which takes the bet type (String) and the Wallet object
 * and does not return anything:
 * 
 * Presents the amount of cash in the wallet and ask the user how much he/she
 * would like to bet Ensures the bet amount is not greater than the cash in the
 * wallet Checks to see if the bet is correct by creating three Dice objects and
 * rolling them and comparing roll output with the bet type. outputs the results
 * (win or loss) and adds the winnings to the wallet if user wins or removes the
 * bet amount from the wallet if the user loses.
 */
