% Hands
hand(l_a;r_a;l_b;r_b).
fingers(1..4).

player(a;b).
players(a,b).

% init
init(l_a,1).
init(r_a,1).
init(l_b,1).
init(r_b,1).
owner(a,l_a).
owner(a,r_a).
owner(b,l_b).
owner(b,r_b).

% goal
goal_a(l_b,0).
goal_b(r_a,0).

