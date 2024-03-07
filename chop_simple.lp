%%% Define
moves(3).
priority(a,1).
hold(H,F,0) :- init(H,F).

%%% Generate
{ increment(H,N,T) : hand(H), fingers(N) } = 1 :- T = 1..M, moves(M).
%%% Define
%% which finger count can be attacked with
{ playable(N,T) } :- priority(P,T), owner(P,H), hold(H,N,T).
%% track which hand value is changing
hold(H,F,T)     :- hold(H,F,T-1), not increment(H,_,T).
%% priority change
priority(B,T)   :- players(A,B), priority(A,T-1).
priority(A,T)   :- players(A,B), priority(B,T-1).
%% increment no elimination
hold(H,F+N,T)   :- increment(H,N,T), hold(H,F,T-1), F + N < 5.
%% increment elimination
hold(H,0,T)     :- increment(H,N,T), hold(H,F,T-1), F + N > 4.
%%% Test
%% correct priority player move
:- priority(P,T), owner(P,H), increment(H,N,T).
%% filter possible attacking finger count
:- increment(H,N,T), not playable(N,T).
%% goal position
:- goal_a(H,N), not hold(H,N,T), T = 1..M, moves(M).

%%% Display
#show increment/3.
#show hold/3.
%#show priority/2.
%#show playable/2.
