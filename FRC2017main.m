%FRC2017main
clear
clc

%generate the field stochastically
f = genField();
%generate node locations
[n,ssl] = genNodes(f);

%Generate All Robots In Simulation
r = genRobots('');

r.s = genStrategy('');

r.s.init = initLocs(r,ssl);%generate initial locations based on alliance color and how close they are to where they want to go

%Run a Match
out = runMatch();