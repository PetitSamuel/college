:- dynamic(kb/1).

makeKB(File):- open(File,read,Str),
               readK(Str,K),
               reformat(K,KB),
               asserta(kb(KB)),
               close(Str).

readK(Stream,[]):- at_end_of_stream(Stream),!.
readK(Stream,[X|L]):- read(Stream,X),
                      readK(Stream,L).

reformat([],[]).
reformat([end_of_file],[]) :- !.
reformat([:-(H,B)|L],[[H|BL]|R]) :- !,
                                    mkList(B,BL),
                                    reformat(L,R).
reformat([A|L],[[A]|R]) :- reformat(L,R).

mkList((X,T),[X|R]) :- !, mkList(T,R).
mkList(X,[X]).

initKB(File) :- retractall(kb(_)), makeKB(File).

astar(Node,Path,Cost) :- 
    kb(KB), 
    astar([[Node, [], 0]],Path,Cost,KB).

astar([[Node, Path, Cost]|_], [Node,Path], Cost, _) :- goal(Node).
astar([[Node, P, C]|Rest], Path, Cost, KB) :- 
    findall([X,[Node|P],Sum], (arc(Node, X, Y, KB), Sum is Y+C), Children),
    add2frontier(Children, Rest, Tmp),
    astar(Tmp, Path, Cost, KB).

% stop a*
goal([]).

arc([H|T],Node,Cost,KB) :- member([H|B],KB),
						   append(B,T,Node),
						   length(B,L),
						   Cost is L+1.

% merges children with rest into newfrontier var (sorts them as well to put least expensive at head)
add2frontier(Children, Rest, NewFrontier) :- append(Children, Rest, Tmp), sort(Tmp, NewFrontier).
