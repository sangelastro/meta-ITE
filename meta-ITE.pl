%%	Meta-interpeter for if-then-else struct

%%	Operators 
:- op(800, fx, if). 
:- op(500, xfy, then).   
:- op(810, xfy, else). 

compile1(if Cond then Then):- if_then(Cond,Then).
compile1(if Cond then Then else Else):- if_then_else(Cond,Then,Else).

if_then_else(Cond,Goal1,Goal2):- condizione(Cond),call(Goal1).
if_then_else(_,_,[if Cond then Then|[]]):- if_then(Cond,Then).
if_then_else(_,_,[if Cond then Then else Else|[]]):- if_then_else(Cond,Then,Else).
if_then_else(_,_,[if Cond then Then else Else|H]):- (if_then_else(Cond,Then,Else);if_then_else(_,_,H)).
if_then_else(_,_,Goal2):- call(Goal2).
if_then_else(Cond,_,_):- not(condizione(Cond)), write('Condizione non soddisfatta').

if_then(Cond,Goal1):- condizione(Cond),call(Goal1).
if_then(Cond,_):- not(condizione(Cond)),write('Condizione non soddisfatta').
if_then(_,Goal1):-not(condizione(Goal1)),write('Goal errato').

condizione([X|[]]):- call(X).
condizione([X|Y]):- call(X),condizione(Y).
condizione(X):- call(X).

%% Some fact to be checked in if or else if condition

brutto(alessandro).
bello(sergio).
grosso(tommaso).
alto(nicola).

/*
How to query

if true then true
if false then true
if false then true else [if true then write('primo else-if')]
if false then true else [if false then true else ('primo else-else')]
if false then true else [if false then true else [if true then ('secondo else-if')]]
if false then true else [if false then true else [if true then else('secondo else-else')]]
*/

