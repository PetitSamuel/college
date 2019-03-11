package BankS2.rationalPack;

public class Rational {
    private int numerator;
    private int denominator;

    //constructors
    public Rational(int numerator, int denominator) {
        this.numerator = numerator;
        this.denominator = denominator;
        simplify();
    }

    public Rational(int numerator) {
        this.numerator = numerator;
        this.denominator = 1;
    }

    //getters
    public int getNumerator() {
        return numerator;
    }

    public int getDenominator() {
        return denominator;
    }
    //operations
    public Rational add(Rational number) {
        return new Rational((this.numerator * number.denominator) + (number.numerator * this.denominator), this.denominator * number.denominator);
    }

    public Rational subtract(Rational number) {
        return new Rational((this.numerator * number.denominator) - (number.numerator * this.denominator), this.denominator * number.denominator);
    }

    public Rational multiply(Rational number) {
        return new Rational(this.numerator * number.numerator, this.denominator * number.denominator);
    }

    public Rational divide(Rational number) {
        return new Rational(this.numerator * number.denominator, this.denominator * number.numerator);
    }

    public boolean equals(Rational number) {
            return (this.numerator * number.denominator == number.numerator * this.denominator);
    }

    public boolean isLessThan(Rational number) {
            return (this.numerator * number.denominator < number.numerator * this.denominator);
    }

    public void simplify() {
            int divisor = this.gcd(this.numerator, this.denominator);
            this.numerator /= divisor;
            this.denominator /= divisor;
            if (this.denominator != 0 || this.numerator != 0) {
                if (this.denominator < 0 && this.numerator < 0) {
                    this.denominator *= -1;
                    this.numerator *= -1;
                } else if (this.numerator > 0 && this.denominator < 0) {
                    this.numerator *= -1;
                    this.denominator *= -1;
                }
        } else {
            System.out.println("Be careful ! The denominator is 0! Simplification of the quotient stopped.");
        }
    }

    public int gcd(int numerator, int denominator) {
        if (denominator == 0) return numerator;
        return gcd(denominator, numerator % denominator);
    }

    public String toString() {
        return (this.numerator + "/" + this.denominator);
    }
}
