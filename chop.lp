#include <incmode>.

#program base.
%%% Define
priority(a,1).
hold(H,F,0) :- init(H,F).

#program step(t).
%%% Generate
{ increment(H,N,t) : hand(H), fingers(N) } = 1.
%%% Define
%% which finger count can be attacked with
{ playable(N,t) } :- priority(P,t), owner(P,H), hold(H,N,t).
%% track which hand value is changing
hold(H,F,t)     :- hold(H,F,t-1), not increment(H,N,t), fingers(N).
%% priority change
priority(B,t)   :- players(A,B), priority(A,t-1).
priority(A,t)   :- players(A,B), priority(B,t-1).
%% increment no elimination
hold(H,F+N,t)   :- increment(H,N,t), hold(H,F,t-1), F + N < 5.
%% increment elimination
hold(H,0,t)     :- increment(H,N,t), hold(H,F,t-1), F + N > 4.
%%% Test
%% correct priority player move
:- priority(P,t), owner(P,H), increment(H,N,t).
%% filter possible attacking finger count
:- increment(H,N,t), not playable(N,t).

#program check.
%%% Test
%% goal position
:- query(t), goal_a(H,N), not hold(H,N,t).
%% timeout
:- query(t), t > 10.

%%% Display
#show increment/3.
#show hold/3.
%#show priority/2.
%#show playable/2.
