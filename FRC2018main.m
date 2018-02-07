%FRC2018main
%written by dean keithly
clear
clc

%generate the field stochastically
f = genField();
%generate node locations
[n,ssl] = genNodes(f);

%Generate All Robots In Simulation
r = genRobots('');

%Generate Strategy for all robots in simulation
r.s = genStrategy(r,'');%generate the strategy for each of the different robots being used

%r.r.Locs
tmp = struct()
tmp = initLocs(r,ssl);%generate initial locations based on alliance color and how close they are to where they want to go
r = tmp;
clear tmp

%Run a Match
out = runMatch(r,n,ssl);