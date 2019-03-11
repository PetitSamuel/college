/* SELF ASSESSMENT 

1. readDictionary
- I have the correct method definition [Mark out of 5: 5]
- Comment: reads all English words and adds them into an arraylist
- My method reads the words from the "words.txt" file. [Mark out of 5:5]
- Comment: Yes, it gets as a parameter the FileReader that has the words file as input, the buffer is then created inside the method
- It returns the contents from "words.txt" in a String array or an ArrayList. [Mark out of 5:5]
- Comment: into an arraylist

2. readWordList
- I have the correct method definition [Mark out of 5:5]
- Comment: gets a string as an input (that contains words separated by commas) and will return an array containing the words only
- My method reads the words provided (which are separated by commas, saves them to an array or ArrayList of String references and returns it. [Mark out of 5:5]
- Comment: yes, saves the words into an array

3. isUniqueList
- I have the correct method definition [Mark out of 5:5]
- Comment: Yes, takes an array of words and returns whether it contains unique words or not
- My method compares each word in the array with the rest of the words in the list. [Mark out of 5:5]
- Comment: Yes, compares each word from index 0 to lenght - 1 with words at index2 = index + 1 to the last index
- Exits the loop when a non-unique word is found. [Mark out of 5:5]
- Comment: both for loops also have a condition on a boolean, when a non unique word is found the loops will stop running
- Returns true is all the words are unique and false otherwise. [Mark out of 5:5]
- Comment: Yes, goes through all of the words checking if they are unique

4. isEnglishWord
- I have the correct method definition [Mark out of 5:5]
- Comment: takes in a word and the list of words, executes a binary search to check if the word is contained within the 'dictionary'
- My method uses the binarySearch method in Arrays library class. [Mark out of 3:3]
- Comment: Yes, checks if the value given by the binary search is positive or negative 
- Returns true if the binarySearch method return a value >= 0, otherwise false is returned. [Mark out of 2:2]
- Comment: Yes, binary search will return the index if found, else a negative value

5. isDifferentByOne
- I have the correct method definition [Mark out of 5:5]
- Comment: takes in 2 strings and checks if the two words are different by 1 character
- My method loops through the length of a words comparing characters at the same position in both words searching for one difference. [Mark out of 10:10]
- Comment: first checks if length is the same. Then it loops through each of the characters counting the different characters. If that count goes higher than two then 
			false is returned.

6. isWordChain
- I have the correct method definition [Mark out of 5:5]
- Comment: takes if an array of words, executes the different methods (isUniqueList, isDifferentByOne, and isEnglishWord) and returns true only if all of them return true
- My method calls isUniqueList, isEnglishWord and isDifferentByOne methods and prints the appropriate message [Mark out of 10:10]
- Comment: Yes, checks isUniqueList, and loops through all of the possibilities for isEnglishWord and isDifferentByOne. Message is printed in the main 

7. main
- Reads all the words from file words.txt into an array or an ArrayList using the any of teh Java.IO classes covered in lectures [Mark out of 10:10]
- Comment: reads all of the words from the words.txt file using the java.io classes
- Asks the user for input and calls isWordChain [Mark out of 5:5]
- Comment: gets input, fills the array list of words & does some checking (if the input is null...)

 Total Mark out of 100 (Add all the previous marks):100
*/
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class PuzzleGame {
	public static ArrayList<String> LIST_OF_WORDS = new ArrayList<String>();
	public static void main(String[] args) throws IOException {
		readDictionary();
		boolean finished = false;
		Scanner inputScanner = null;
		String[] wordsInputArray = null;
		while (!finished) {
			System.out.println(
					"Enter a list of string seperated by commas : ', ' (add a space after each comma!). To end the game enter an empty input (backspace)");
			inputScanner = new Scanner(System.in);
			if (inputScanner.hasNextLine()) {
				String lineEntered = inputScanner.nextLine();
				if (lineEntered.isEmpty()) {
					finished = true;
					System.out.println("The input is empty, end of program");
				} else {
					wordsInputArray = readWordList(lineEntered);
				}
			}
			if (wordsInputArray != null && !finished) {
				if (isWordChain(wordsInputArray)) {
					System.out.println("Valid chain of words from Lewis Carroll's word-links game.\n");
				} else {
					System.out.println("Not a valid chain of words from Lewis Carroll's word-links game.\n");
				}
			}
		}
		inputScanner.close();
	}

	public static void readDictionary() throws IOException {
		FileReader file = new FileReader("words.txt");
		BufferedReader bufferedReader = new BufferedReader(file);
		boolean endOfWords = false;
		while (!endOfWords) {
			String currentWord = bufferedReader.readLine();
			if (currentWord == null) {
				endOfWords = true;
			} else {
				LIST_OF_WORDS.add(currentWord);
			}
		}
		bufferedReader.close();
	}

	public static String[] readWordList(String input) {
		String[] stringLineToArray = input.split(", ");
		return stringLineToArray;
	}

	public static boolean isUniqueList(String[] array) {
		boolean unique = true;
		for (int i = 0; i < array.length - 1 && unique; i++)
			for (int j = i + 1; j < array.length && unique; j++)
				if (array[i].equals(array[j]))
					unique = false;
		return unique;
	}

	public static boolean isEnglishWord(String word) {
		if (Collections.binarySearch(LIST_OF_WORDS, word) >= 0)
			return true;
		else return false;
	}

	public static boolean isDifferentByOne(String word, String wordTwo) {
		boolean moreThanOne = true;
		if (word.length() == wordTwo.length()) {
			int count = 0;
			for (int index = 0; index < word.length() && moreThanOne; index++) {
				if (word.charAt(index) != wordTwo.charAt(index)) {
					count++;
				}
				if (count >= 2) {
					moreThanOne = false;
				}
			}
			return moreThanOne;
		} else {
			return false;
		}
	}

	public static boolean isWordChain(String[] words) {
		boolean uniqueWords = isUniqueList(words);
		boolean validWords = true;
		for (int index = 0; index < words.length && validWords && uniqueWords; index++)
			if (isEnglishWord(words[0]) == false) {
				validWords = false;
			}
		boolean differentByOne = true;
		for (int index = 0; index < words.length - 1 && differentByOne && uniqueWords && validWords; index++) {
			if (!isDifferentByOne(words[index], words[index + 1])) {
				differentByOne = false;
			}
		}
		return uniqueWords && validWords && differentByOne;
	}
}
