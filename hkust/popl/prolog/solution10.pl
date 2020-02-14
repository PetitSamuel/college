%list_reverse
list_reverse([],L) :- append([],[],L).
list_reverse([H|T],L) :- list_reverse(T,L1),append(L1,[H],L).

%prefix
list_prefix([],_). %base case
list_prefix([X|Xs],[X|Ys]) :- list_prefix(Xs,Ys). %inductive case
