/*
Define a relation mat_get(M, I, J, R)
where R is the number located at the i-th row and j-th column of matrix M.
Examples: ?- mat_get([[1,2],[3,4]],0,1,R). R = 2. 
?- mat_get([[1,2],[3,4]],0,0,R). R = 1. 
?- mat_get([[1,2,5],[3,4,7]],1,2,R). R = 7. 
?- mat_get([[1,2,5],[3,4,7]],1,2,7). true. 
?- mat_get([[1,2,5],[3,4,7]],1,2,6). false. 
*/
mat_get(M, I, J, R) :- get_nth_element(M, I, V),get_nth_element(V,J,R).

/*
    Get Nth row.
    first arg is the matrix
    2nd is the index 
    3rd is the value to store the answer in
*/
get_nth_element([H|_],0,H):-!.
get_nth_element([_|T],I,X) :-
    I1 is I-1,
    get_nth_element(T,I1,X).

/*
    Returns the mean of a matrix.
    ?- mat_mean([[1,2],[3,4]],R). R = 2.5. 
    ?- mat_mean([[0,0,1],[0,0,2]],R). R = 0.5. 
    ?- mat_mean([[0,0,1],[0,0,2]],0.5). true. 
    ?- mat_mean([[0,0,1],[0,0,2]],0.6). false.
*/
mat_mean(M,R) :- sum_mat(M,Sum), size(M,Size,_,_), R is Sum / Size.

/* Takes all values of matrix M and stores the sum in S. */
sum_mat(M, S) :- sum_mat_recursive(M,0,S).

/*
    Recursively sums the rows of a matrix.
*/
sum_mat_recursive([], Total, S) :- S = Total.
sum_mat_recursive([A|Ass], Total, S) :-
   list_sum(A, Sum),
   T1 is Sum + Total,
   sum_mat_recursive(Ass,T1, S).

/*
    Returns the amount of elements in a Matrix.
    Also can be used to get amount of Rows or size of Columns.
*/
size([], 0, _).
size([A|As], Total, Row, Col) :-
    length(A, Col),
    length([A|As], Row),
    Total is Col * Row. 

/*
    Functions where M and R are the 
    transposed matrices of each other.

    ?- mat_trans([[1,2]],R).
    R = [[1], [2]].
    ?- mat_trans(R, [[1],[2]]).
    R = [[1, 2]].
    ?- mat_trans([[1,2,3]],[[1],[2],[3]]).
    true.
    ?- mat_trans([[1,2,3]],[[3],[2],[1]]).
    false.
*/
mat_trans(M,R) :- transpose(M, R).

/*
    Takes a list and sums its values into Total.
*/
list_sum([Item], Item).
list_sum([Item1,Item2 | Tail], Total) :-
    Item3 is Item1 + Item2,
    list_sum([Item3|Tail], Total).

/*
    transpose matrix into R.
*/
transpose([A|As], R) :-
    transpose(A, [A|As], R).

transpose([], _, []) :- !.
transpose([_|As], Rest, [At|Ats]) :-
    first_column(Rest, At, Tmp),
    transpose(As, Tmp, Ats).

first_column([], [], []).
first_column([[A|As]|Ass], [A|Acc], [As|Rest]) :-
    first_column(Ass, Acc, Rest).


/*
    Define a relation mat_blend(A, B, W, C) in which C is the blending result 
    of two given matrices A and B with the weight W, i.e., C = W*A + (1-W)*B 
    where each element C(i,j) is the sum of W*A(i,j) and (1-W)*B(i,j).

    ?- mat_blend([[1.0,2.0],[3.0,4.0]],[[2.0,3.0],[1.0,2.0]],0.5,C).
    C = [[1.5, 2.5], [2.0, 3.0]].
    ?- mat_blend([[1,2],[3.0,4.0]],[[2.0,3.0],[1.0,2.0]],0.4,C).
    C = [[1.6, 2.5999999999999996], [1.8000000000000003, 2.8]].
    ?- mat_blend([[1.0,2.0],[3.0,4.0]],[[2.0,3.0],[1.0,2.0]],0.5,[[1.5, 2.5], [2.0, 3.0]]).
    true.
    ?- mat_blend([[1.0,2.0],[3.0,4.0]],[[2.0,3.0],[1.0,2.0]],0.5,[[10.0, 2.5], [2.0, 3.0]]).
    false.
*/
mat_blend(A, B, W, C) :- matrix_blend(W,A,B,C).

matrix_blend(_, [], [], []) :- !.
matrix_blend(S, [R|Rs], [M|Ms], [A|As]) :-
    vector_blend(S, R,M,A),
    matrix_blend(S, Rs, Ms, As).


vector_blend(_, [], [], []) :- !.
vector_blend(S, [R|Rs],[M|Ms], [R1|A]) :-
    R1 is S * R + (1 - S) * M,
    vector_blend(S, Rs, Ms, A).

/*
    Define a relation mat_dot(A, B, C) where matrix C is the dot product of two 
    given matrices A and B. Specifically, in the output matrix C = A x B, 
    each element C(i,j) is the dot product of the i-th row of A and the j-th column of B.

    ?- mat_dot([[1.0,2.0,3.0],[4.0,5.0,6.0],[7.0,8.0,9.0]],[[1.0,2.0,3.0],[4.0,5.0,6.0],[7.0,8.0,9.0]], R).
    R = [[30.0, 36.0, 42.0], [66.0, 81.0, 96.0], [102.0, 126.0, 150.0]].

    ?- mat_dot([[0.0,1.0,1.0],[2.0, 2.0, 2.0]], [[1.0,3.0,1.0],[2.0, 2.0, 0.0], [3.0, 1.0, 1.0]], R).
    R = [[5.0, 3.0, 1.0], [12.0, 12.0, 4.0]].

    ?- mat_dot([[0.0,1.0,1.0],[2.0, 2.0, 2.0]], [[1.0,3.0,1.0],[2.0, 2.0, 0.0], [3.0, 1.0, 1.0]], [[5.0, 3.0, 1.0],
    [12.0, 12.0, 4.0]]).
    true.

    ?- mat_dot([[0.0,1.0,1.0],[2.0, 2.0, 2.0]], [[1.0,3.0,1.0],[2.0, 2.0, 0.0], [3.0, 1.0, 1.0]], [[5.0, 3.0, 1.0],
    [12.0, 12.0, 3.0]]).
    false.
*/
mat_dot(A, B, C) :- mat_trans(B,B1), matrix_mult(A,B1,C). 

matrix_mult([], _, []) :- !.
matrix_mult([R|Rs], [M|Ms], [A|As]) :-
    vect_mat_mult(R,[M|Ms],A),
    matrix_mult(Rs, [M|Ms],As).

vect_mat_mult(_, [], []) :- !.
vect_mat_mult([N|Ns],[M|Ms], [R1|A]) :-
    dotProd([N|Ns], M, 0,R1),
    vect_mat_mult([N|Ns], Ms, A).

dotProd([], [],Curr,R) :- R = Curr.
dotProd([N|Ns], [M|Ms],Curr, R) :-
    Sum is Curr + (N * M),
    dotProd(Ns,Ms,Sum,R).

