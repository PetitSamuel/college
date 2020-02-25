## NAME: Samuel Petit
## STUDENT NUMBER: 17333946

Please indicate your answers by entering the option ( (i), (ii), (iii) or (iv) ) where asked.
You should append the completed document as a pdf with your type written worked solutions and upload to Blackboard by Friday 22nd of February 2019.


## Q 2.31

#### Part (a):

(i)	4 
(ii)	13
(iii)	 26 
(iv)	 18

```
Your Answer (i)-(iv): (ii)
```
#### Proof: 
$$A=\begin{pmatrix}1&5&4\\2&3&6\\1&1&1\end{pmatrix}$$
$$Det(A)= 1 * [3 - 6] - 5 * [2 - 6] + 4 * [2 - 3] = - 3 + 20 - 4 = 13$$
#### Part (b):

(i)	0
(ii)	12
(iii)	 7
(iv)	 4

```
Your Answer (i)-(iv): (i)
```
#### Proof: 
$$B=\begin{pmatrix}1&2&3&4\\5&6&7&8\\9&10&11&12\\13&14&15&16\end{pmatrix}=\begin{pmatrix}13&14&15&16\\ 5&6&7&8\\ 9&10&11&12\\ 1&2&3&4\end{pmatrix}$$
$$=\begin{pmatrix}13&14&15&16\\ 0&\frac{8}{13}&\frac{16}{13}&\frac{24}{13}\\ 9&10&11&12\\ 1&2&3&4\end{pmatrix}= \begin{pmatrix}13&14&15&16\\ 0&\frac{8}{13}&\frac{16}{13}&\frac{24}{13}\\ 0&\frac{4}{13}&\frac{8}{13}&\frac{12}{13}\\ 1&2&3&4\end{pmatrix}$$
$$=\begin{pmatrix}13&14&15&16\\ 0&\frac{8}{13}&\frac{16}{13}&\frac{24}{13}\\ 0&\frac{4}{13}&\frac{8}{13}&\frac{12}{13}\\ 0&\frac{12}{13}&\frac{24}{13}&\frac{36}{13}\end{pmatrix}=\begin{pmatrix}13&14&15&16\\ 0&\frac{12}{13}&\frac{24}{13}&\frac{36}{13}\\ 0&\frac{4}{13}&\frac{8}{13}&\frac{12}{13}\\ 0&\frac{8}{13}&\frac{16}{13}&\frac{24}{13}\end{pmatrix}$$
$$=\begin{pmatrix}13&14&15&16\\ 0&\frac{12}{13}&\frac{24}{13}&\frac{36}{13}\\ 0&0&0&0\\ 0&\frac{8}{13}&\frac{16}{13}&\frac{24}{13}\end{pmatrix}$$
We have found using fundamental matrix operations that an entire row is made of 0's. Thus we can say that the determinant will be 0.
$$Det(B)= 0$$

##### MATLAB Code : 
The question specifically asks for MATLAB code, however we were still asked to do the matrix operations typed. Here is the MATLAB code for it.
```
Determinant([1 5 4; 2 3 6; 1 1 1]);
Determinant([1 2 3 4; 5 6 7 8; 9 10 11 12; 13 14 15 16]);
 
function D = Determinant (A) 
    sizeMatrix = size(A);
    if sizeMatrix(1) ~= sizeMatrix(2) || sizeMatrix(1) <= 1 
        disp("Error: matrix needs to be n*n or bigger than 1*1");
        return;
    end
    D = det(A);
    disp(D);
end
```

### Q 3.2 


##### Part (a):

(i)	0.1241
(ii)	0.8125
(iii)	0.074995
(iv)	0.003462

```
Your Answer (i)-(iv): (ii)
```

##### Justification - Bisection method
We have 
$$a = 0$$
$$b = 1$$
$$f(a) = 0 - 2e^{-0} = -2[negative]$$
$$f(b) = 1 - 2e^{-1} = 0.26424 [positive]$$

Following the steps of the algorithm we have: 
$$x_{NS1} = \frac{0+1}{2} = 0.5$$
$$f(x_{NS1}) = 0.5 - 2^{-0.5} = -0.71306[negative]$$

We will now use the interval [0.5, 1]

$$x_{NS2} = \frac{0.5+1}{2} = 0.75$$
$$f(x_{NS2}) = 0.75 - 2^{-0.75} = -0.1947[negative]$$

We will now use the interval [0.75, 1]

$$x_{NS3} = \frac{0.75+1}{2} = 0.875$$
$$f(x_{NS3}) = 0.875 - 2^{-0.875} = 0.0412[positive]$$

We will now use the interval [0.75, 0.875]

$$x_{NS4} = \frac{0.75+0.875}{2} = 0.8125$$
Thus the answer is 0.8125 : (ii)

##### Part (b):

(i)	0.72481
(ii)	0.85261
(iii)	0.62849
(iv)	0.17238

```
Your Answer (i)-(iv): (ii)
```
##### Justification - Secant method
We have : 

$$f(x) = x - 2e^{-x}$$
$$x_0 = 0$$
$$x_1 = 1$$

Calculating until $$x_4$$:
$$x_2 = 1 - \frac{f(1)*(0-1)}{f(0) - f(1)} = 1 - \frac{-0.26424}{-2.26424} = 0.8833$$
$$x_3 = 0.8833 - \frac{f(0.8833)* (1 - 0.8833)}{f(1) - f(0.8833)} = 0.8833 - \frac{0.05647*0.1167}{0.26424 - 0.05647} = 0.851582$$
$$x_4 = 0.851582 - \frac{f(0.851582)*(0.8833 - 0.851582)}{f(0.8833) - f(0.851582)} = 0.851582 - \frac{-6.0169*10^{-5}}{0.058367} = 0.85261$$
Thus the answer is 0.85261 : (ii)
##### Part (c):

(i)	0.65782
(ii)	0.59371
(iii)	0.45802
(iv)	0.85261

```
Your Answer (i)-(iv): (iv)
```
##### Justification - Newton's Method
We have:
$$x_{i+1} = x_i - \frac{f(x_i)}{f'(x_i)}$$

The function:
$$f(x) = x - 2e^{-x}$$
$$f'(x) = 1 + 2e^{-x}$$
Using : $$x_1 = 1$$

$$x_2 = 1 - \frac{1 - 2e^{-1}}{1 + 2e^{-1}} = 0.847777$$
$$x_3 = 0.847777 - \frac{0.847777 - 2e^{-0.847777}}{1 + 2e^{-0.847777}} = 0.853$$

### Q 4.24

(i)
Inverse(a)=

-0.7143 	0.0 		1.4286
0.2571 		0.1000 		0.2857
-0.2286 	-0.2000 	0.8571


Inverse(b)=

1.6667 		2.8889 		-2.2222 	1.0000
0.0 			0.3333 		-0.3333 	0.0
-0.3333 		-0.4444 	0.1111 		0.0
1.5000 		2.0000 		-1.5000 	0.5000


(ii)

Inverse(a)=

0.7243		 0.0 		1.3286
1.2571 		0.1000 		0.2757
-0.2386 	-0.2010 	0.9571


Inverse(b)=

1.6677 		2.9889  		3.2222 		1.01700
0.3433 		-0.3433 	0.3333		0.00371
-0.3433 		-0.2879 	0.2111 		0.0	
1.2400 		2.0120 		-1.5783 	0.5600


(iii)

Inverse(a)=

0.7143		 0.003 		2.3276
1.2671 		0.1100 		0.3759
-0.2486 	-0.2110 	0.9771


Inverse(b)=

1.6877 		3.9789  		3.2002 		2.01800
0.3533 		-0.4433 	0.3333		0.02371
-0.3443 		-0.2999 	0.3121 		0.0382	
1.2420 		3.0130 		-1.5733 	0.5610


(iv)

Inverse(a)=

0.8343		 1.01 		1.3336
2.2572 		0.1003 		0.3857
-0.2486 	-0.2110 	0.9671


Inverse(b)=

1.6777 		4.9889  		3.2232 		1.11700
0.3443 		-0.3443 	0.3233		0.07371
-0.3443 		-0.2979 	0.3211 		0.07800	
1.2480 		2.1220 		-1.5883 	0.5621

```
Your Answer (i)-(iv): (i)
```
#### Justification
##### Matrix a
$$inverse(a) = \begin{pmatrix}-1&2&1\\ 2&2&-4\\ 0.2&1&0.5\end{pmatrix}^{-1}$$

Using an augmented 3*3 Matrix
$$\begin{bmatrix}-1&2&1&\mid \:&1&0&0\\ 2&2&-4&\mid \:&0&1&0\\ 0.2&1&0.5&\mid \:&0&0&1\end{bmatrix}
=\begin{bmatrix}2&2&-4&\mid \:&0&1&0\\ -1&2&1&\mid \:&1&0&0\\ 0.2&1&0.5&\mid \:&0&0&1\end{bmatrix}$$
$$=\begin{bmatrix}2&2&-4&\mid \:&0&1&0\\ 0&3&-1&\mid \:&1&\frac{1}{2}&0\\ 0.2&1&0.5&\mid \:&0&0&1\end{bmatrix}
=\begin{bmatrix}2&2&-4&\mid \:&0&1&0\\ 0&3&-1&\mid \:&1&\frac{1}{2}&0\\ 0&0.8&0.9&\mid \:&0&-0.1&1\end{bmatrix}$$
$$=\begin{bmatrix}2&2&-4&\mid \:&0&1&0\\ 0&3&-1&\mid \:&1&\frac{1}{2}&0\\ 0&0&1.16666 &\mid \:&-0.26666 &-0.23333 &1\end{bmatrix}$$
$$=\begin{bmatrix}2&2&-4&\mid \:&0&1&0\\ 0&3&-1&\mid \:&1&\frac{1}{2}&0\\ 0&0&1.16666 &\mid \:&-0.26666 &-0.23333 &1\end{bmatrix}$$
$$=\begin{bmatrix}2&2&-4&\mid \:&0&1&0\\ 0&3&-1&\mid \:&1&\frac{1}{2}&0\\ 0&0&1&\mid \:&-0.22857 &-0.2&0.85714 \end{bmatrix}$$
$$=\begin{bmatrix}2&2&-4&\mid \:&0&1&0\\ 0&3&0&\mid \:&0.77142 &0.3&0.85714 \\ 0&0&1&\mid \:&-0.22857 &-0.2&0.85714 \end{bmatrix}$$
$$=\begin{bmatrix}2&2&0&\mid \:&-0.91428 &0.2&3.42857 \\ 0&3&0&\mid \:&0.77142 &0.3&0.85714 \\ 0&0&1&\mid \:&-0.22857 &-0.2&0.85714 \end{bmatrix}$$
$$=\begin{bmatrix}2&2&0&\mid \:&-0.91428 &0.2&3.42857 \\ 0&1&0&\mid \:&0.25714 &0.1&0.28571 \\ 0&0&1&\mid \:&-0.22857 &-0.2&0.85714 \end{bmatrix}$$
$$=\begin{bmatrix}2&0&0&\mid \:&-1.42857 &0&2.85714 \\ 0&1&0&\mid \:&0.25714 &0.1&0.28571 \\ 0&0&1&\mid \:&-0.22857 &-0.2&0.85714 \end{bmatrix}$$
$$=\begin{bmatrix}1&0&0&\mid \:&-0.71428 &0&1.42857 \\ 0&1&0&\mid \:&0.25714 &0.1&0.28571 \\ 0&0&1&\mid \:&-0.22857 &-0.2&0.85714 \end{bmatrix}$$
Thus the inverse is : 
$$inverse(a)=\begin{pmatrix}-0.71428 &0&1.42857 \\ 0.25714 &0.1&0.28571 \\ -0.22857 &-0.2&0.85714 \end{pmatrix}$$

##### Matrix b

$$inverse(b) =\begin{pmatrix}-1&-2&1&2\\ 1&1&-4&-2\\ 1&-2&-4&-2\\ 2&-4&1&-2\end{pmatrix}^{-1}$$

Using an augmented 4*4 Matrix 

$$\begin{bmatrix}-1&-2&1&2&\mid \:&1&0&0&0\\ 1&1&-4&-2&\mid \:&0&1&0&0\\ 1&-2&-4&-2&\mid \:&0&0&1&0\\ 2&-4&1&-2&\mid \:&0&0&0&1\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&1&-2&\mid \:&0&0&0&1\\ 1&1&-4&-2&\mid \:&0&1&0&0\\ 1&-2&-4&-2&\mid \:&0&0&1&0\\ -1&-2&1&2&\mid \:&1&0&0&0\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&1&-2&\mid \:&0&0&0&1\\ 0&3&-\frac{9}{2}&-1&\mid \:&0&1&0&-\frac{1}{2}\\ 1&-2&-4&-2&\mid \:&0&0&1&0\\ -1&-2&1&2&\mid \:&1&0&0&0\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&1&-2&\mid \:&0&0&0&1\\ 0&3&-\frac{9}{2}&-1&\mid \:&0&1&0&-\frac{1}{2}\\ 0&0&-\frac{9}{2}&-1&\mid \:&0&0&1&-\frac{1}{2}\\ -1&-2&1&2&\mid \:&1&0&0&0\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&1&-2&\mid \:&0&0&0&1\\ 0&3&-\frac{9}{2}&-1&\mid \:&0&1&0&-\frac{1}{2}\\ 0&0&-\frac{9}{2}&-1&\mid \:&0&0&1&-\frac{1}{2}\\ 0&-4&\frac{3}{2}&1&\mid \:&1&0&0&\frac{1}{2}\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&1&-2&\mid \:&0&0&0&1\\ 0&-4&\frac{3}{2}&1&\mid \:&1&0&0&\frac{1}{2}\\ 0&0&-\frac{9}{2}&-1&\mid \:&0&0&1&-\frac{1}{2}\\ 0&3&-\frac{9}{2}&-1&\mid \:&0&1&0&-\frac{1}{2}\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&1&-2&\mid \:&0&0&0&1\\ 0&-4&\frac{3}{2}&1&\mid \:&1&0&0&\frac{1}{2}\\ 0&0&-\frac{9}{2}&-1&\mid \:&0&0&1&-\frac{1}{2}\\ 0&0&-\frac{27}{8}&-\frac{1}{4}&\mid \:&\frac{3}{4}&1&0&-\frac{1}{8}\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&1&-2&\mid \:&0&0&0&1\\ 0&-4&\frac{3}{2}&1&\mid \:&1&0&0&\frac{1}{2}\\ 0&0&-\frac{9}{2}&-1&\mid \:&0&0&1&-\frac{1}{2}\\ 0&0&0&\frac{1}{2}&\mid \:&\frac{3}{4}&1&-\frac{3}{4}&\frac{1}{4}\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&1&-2&\mid \:&0&0&0&1\\ 0&-4&\frac{3}{2}&1&\mid \:&1&0&0&\frac{1}{2}\\ 0&0&-\frac{9}{2}&-1&\mid \:&0&0&1&-\frac{1}{2}\\ 0&0&0&1&\mid \:&\frac{3}{2}&2&-\frac{3}{2}&\frac{1}{2}\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&1&-2&\mid \:&0&0&0&1\\ 0&-4&\frac{3}{2}&1&\mid \:&1&0&0&\frac{1}{2}\\ 0&0&-\frac{9}{2}&0&\mid \:&\frac{3}{2}&2&-\frac{1}{2}&0\\ 0&0&0&1&\mid \:&\frac{3}{2}&2&-\frac{3}{2}&\frac{1}{2}\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&1&-2&\mid \:&0&0&0&1\\ 0&-4&\frac{3}{2}&0&\mid \:&-\frac{1}{2}&-2&\frac{3}{2}&0\\ 0&0&-\frac{9}{2}&0&\mid \:&\frac{3}{2}&2&-\frac{1}{2}&0\\ 0&0&0&1&\mid \:&\frac{3}{2}&2&-\frac{3}{2}&\frac{1}{2}\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&1&0&\mid \:&3&4&-3&2\\ 0&-4&\frac{3}{2}&0&\mid \:&-\frac{1}{2}&-2&\frac{3}{2}&0\\ 0&0&-\frac{9}{2}&0&\mid \:&\frac{3}{2}&2&-\frac{1}{2}&0\\ 0&0&0&1&\mid \:&\frac{3}{2}&2&-\frac{3}{2}&\frac{1}{2}\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&1&0&\mid \:&3&4&-3&2\\ 0&-4&\frac{3}{2}&0&\mid \:&-\frac{1}{2}&-2&\frac{3}{2}&0\\ 0&0&1&0&\mid \:&-\frac{1}{3}&-\frac{4}{9}&\frac{1}{9}&0\\ 0&0&0&1&\mid \:&\frac{3}{2}&2&-\frac{3}{2}&\frac{1}{2}\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&0&0&\mid \:&\frac{10}{3}&\frac{40}{9}&-\frac{28}{9}&2\\ 0&-4&0&0&\mid \:&0&-\frac{4}{3}&\frac{4}{3}&0\\ 0&0&1&0&\mid \:&-\frac{1}{3}&-\frac{4}{9}&\frac{1}{9}&0\\ 0&0&0&1&\mid \:&\frac{3}{2}&2&-\frac{3}{2}&\frac{1}{2}\end{bmatrix}$$
$$=\begin{bmatrix}2&-4&0&0&\mid \:&\frac{10}{3}&\frac{40}{9}&-\frac{28}{9}&2\\ 0&1&0&0&\mid \:&0&\frac{1}{3}&-\frac{1}{3}&0\\ 0&0&1&0&\mid \:&-\frac{1}{3}&-\frac{4}{9}&\frac{1}{9}&0\\ 0&0&0&1&\mid \:&\frac{3}{2}&2&-\frac{3}{2}&\frac{1}{2}\end{bmatrix}$$
$$=\begin{bmatrix}2&0&0&0&\mid \:&\frac{10}{3}&\frac{52}{9}&-\frac{40}{9}&2\\ 0&1&0&0&\mid \:&0&\frac{1}{3}&-\frac{1}{3}&0\\ 0&0&1&0&\mid \:&-\frac{1}{3}&-\frac{4}{9}&\frac{1}{9}&0\\ 0&0&0&1&\mid \:&\frac{3}{2}&2&-\frac{3}{2}&\frac{1}{2}\end{bmatrix}$$
$$=\begin{bmatrix}1&0&0&0&\mid \:&\frac{5}{3}&\frac{26}{9}&-\frac{20}{9}&1\\ 0&1&0&0&\mid \:&0&\frac{1}{3}&-\frac{1}{3}&0\\ 0&0&1&0&\mid \:&-\frac{1}{3}&-\frac{4}{9}&\frac{1}{9}&0\\ 0&0&0&1&\mid \:&\frac{3}{2}&2&-\frac{3}{2}&\frac{1}{2}\end{bmatrix}$$
We find the inverse matrix on the right side of the extended matrix:

$$inverse(b) =\begin{pmatrix}\frac{5}{3}&\frac{26}{9}&-\frac{20}{9}&1\\ 0&\frac{1}{3}&-\frac{1}{3}&0\\ -\frac{1}{3}&-\frac{4}{9}&\frac{1}{9}&0\\ \frac{3}{2}&2&-\frac{3}{2}&\frac{1}{2}\end{pmatrix}$$