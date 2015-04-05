/**
 * William Kinderman
 * Assignment 3

 * PROGRAM OUTPUT:
 * % Updating index for library /Applications/SWI-Prolog.app/Contents/swipl/library/
 * % /Users/willk/code/school/2014/Fall/135/three/assignment3 compiled 0.00 sec, 12 clauses
 * 54 ?- sumPicker([2,4,7],[8,3,2,9,1,1,6,6,7],Answer).
 * Answer = 18.
 *
 * 55 ?- crypto(S,E,P,T,M,B,R).
 * S = 7,
 * E = 2,
 * P = 1,
 * T = 4,
 * M = 5,
 * B = 9,
 * R = 0.
 *
 * 56 ?- related(greg,fred).
 * true
 * false.
 *
 * 57 ?- related(fred,greg).
 * true
 * false.
 *
 * 58 ?- related(greg,marge).
 * false.
 *
 * 59 ?- countdown(5,X).
 * X = [5, 4, 3, 2, 1].
 *
 * 60 ?- countdown(5,[5,4,3,2,1]).
 * true.
 *
 * 61 ?- strangeAverage(12,6,SAverage).
 * SAverage = 29.5.
 */


%% 1. strangeAverage
strangeAverage(I,J,SAvg) :- I =< 100, I >= 0, J =< 100, J >= 0, SAvg is (100 + I + J)/4.

%% 2. countdown
countdown(I,[I|L]) :- I > 1, NewI is I - 1, !, countdown(NewI,L).
countdown(I,[I]).

%% 3. related
parent(fred,mary).
parent(mary,jim).
parent(mary,greg).
parent(angie,terry).
parent(terry,marge).

descendent(P1,P2) :- parent(P1,I), descendent(I,P2).
descendent(P1,P1).
related(P1,P2) :- descendent(I,P1), descendent(I,P2).

%% 4. crypto
num(1).
num(2).
num(3).
num(4).
num(5).
num(6).
num(7).
num(8).
num(9).
num(0).

crypto(S,E,P,T,M,B,R) :-
    %% assign all the numbers.
    num(S), num(E), num(P), num(T), num(M), num(B), num(R),

    %% make sure the elements don't equal each other.
    S \= E, S \= P, S \= T, S \= M, S \= B, S \= R,
    E \= P, E \= T, E \= M, E \= B, E \= R,
    P \= T, P \= M, P \= B, P \= R,
    T \= M, T \= B, T \= R,
    M \= B, M \= R,
    B \= R,

    %% first line total.
    L1 is S * 100000000 + E * 10000000 + P * 1000000 + T * 100000 + E * 10000 + M * 1000 + B * 100 + R * 10 + E,
    %% second line total.
    L2 is E * 100000000 + R * 10000000 + B * 1000000 + M * 100000 + E * 10000 + T * 1000 + P * 100 + E * 10 + S,
    %% answer line total.
    Answer is M * 100000000 + P * 10000000 + P * 1000000 + B * 100000 + R * 10000 + P * 1000 + S * 100 + S * 10 + M,
    %% get the total of L1 subtracted from L2.
    Total is L1 - L2,
    %% compare the results to make sure they are equal. we only one should have one answer.
    Total = Answer,
    !.

%% 5. sumPicker
gnth(1,[Nth|_],Nth).
gnth(I,[_|T],Nth) :- X is I - 1, gnth(X,T,Nth), !.


sumPicker([],_,0).
sumPicker([H|T],List,Answer) :- gnth(H,List,I), sumPicker(T,List,J), Answer is I + J.
