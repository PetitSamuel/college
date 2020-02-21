import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;
import static org.junit.Assert.*;

//-------------------------------------------------------------------------
/**
 *  Test class for Arith.java
 *
 *  @author
 *  @version 18/09/18 12:21:26
 */
@RunWith(JUnit4.class)
public class ArithTest
{
    //~ Constructor ........................................................
    @Test
    public void testConstructor()
    {
        new Arith();
    }

    //~ Public Methods ........................................................

    // ----------------------------------------------------------
    /**
     * Check that the two methods work for empty arrays
     */
    @Test
    public void testExpressionPrefix()
    {
        String[] truePrefix = {"+", "5", "5"};
        String[] falsePrefix = {"5", "/"};
        String[] falsePrefix2 = {"hello", "this is not an expression", "1", "-"};
        String[] falsePrefix3 = {};
        
        assertTrue("Testing a true prefix expression", Arith.validatePrefixOrder(truePrefix));
        assertFalse("Testing a false prefix expression", Arith.validatePrefixOrder(falsePrefix));
        assertFalse("Testing a prefix expression with invalid characters", Arith.validatePrefixOrder(falsePrefix2));
        assertFalse("Testing empty array of strings", Arith.validatePrefixOrder(falsePrefix3));
    }
    /**
     * Check that the two methods work for empty arrays
     */
    @Test
    public void testExpressionPostfix()
    {
        String[] truePostfix = {"3", "1", "2", "-", "*"};
        String[] falsePostfix = {"/", "5"};
        String[] falsePostfix2 = {"hello", "this is not an expression", "1", "-"};
        String[] falsePostfix3 = {};

        assertTrue("Testing a true postfix expression", Arith.validatePostfixOrder(truePostfix));
        assertFalse("Testing a false postfix expression", Arith.validatePostfixOrder(falsePostfix));
        assertFalse("Testing a postfix expression with invalid characters", Arith.validatePostfixOrder(falsePostfix2));
        assertFalse("Testing empty array of strings", Arith.validatePostfixOrder(falsePostfix3));
    }

    /**
     * Check that the two methods work for empty arrays
     */
    @Test
    public void testEvaluatePostfix()
    {
        String[] postfixExpression = {"3", "1", "2", "-", "*"};
        String[] postfixExpression2 = {"3", "1", "2", "+", "/"};
        assertEquals("Evaluating a valid postfix expression", -3, Arith.evaluatePostfixOrder(postfixExpression));
        assertEquals("Evaluating a valid postfix expression", 1, Arith.evaluatePostfixOrder(postfixExpression2));
    }

    /**
     * Check that the two methods work for empty arrays
     */
    @Test
    public void testEvaluatePrefix()
    {
        String[] prefixExpression = {"*", "-", "1", "2", "3"};
        String[] prefixExpression2 = {"/", "+", "1", "2", "3"};
        assertEquals("Evaluating a valid prefix expression", -3, Arith.evaluatePrefixOrder(prefixExpression));
        assertEquals("Evaluating a valid prefix expression", 1, Arith.evaluatePrefixOrder(prefixExpression2));
    }
    /**
     * Check that the two methods work for empty arrays
     */
    @Test
    public void testPrefixToPostfix()
    {
        String[] prefixExpression = {"*", "-", "1", "2", "3"};
        String[] postfixExpression = {"1", "2", "-", "3", "*"};
        assertArrayEquals("Testing conversion from prefix expression to postfix", postfixExpression, Arith.convertPrefixToPostfix(prefixExpression));
    }

    /**
     * Check that the two methods work for empty arrays
     */
    @Test
    public void testPostfixToPrefix()
    {
        String[] prefixExpression = {"*", "-", "1", "2", "3"};
        String[] postfixExpression = {"1", "2", "-", "3", "*"};
        assertArrayEquals("Testing conversion from postfix expression to prefix", prefixExpression, Arith.convertPostfixToPrefix(postfixExpression));
    }

    /**
     * Check that the two methods work for empty arrays
     */
    @Test
    public void testPrefixToInfix()
    {
        String[] prefixExpression = {"*", "-", "1", "2", "3"};
        String[] infixExpression = {"(", "(", "1", "-", "2", ")", "*", "3", ")"};
        assertArrayEquals("Testing conversion from prefix expression to infix", infixExpression, Arith.convertPrefixToInfix(prefixExpression));
    }

    /**
     * Check that the two methods work for empty arrays
     */
    @Test
    public void testPostfixToInfix()
    {
        String[] postfixExpression = {"1", "2", "-", "3", "*"};
        String[] infixExpression = {"(", "(", "1", "-", "2", ")", "*", "3", ")"};
        assertArrayEquals("Testing conversion from postfix expression to infix", infixExpression, Arith.convertPostfixToInfix(postfixExpression));
    }
}



