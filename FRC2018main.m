%FRC2018main
%written by dean keithly
clear
clc

for count = 1:1000%for running many matches
    clear
    clc
    close all
    
%% generate the field stochastically
f = genField();

%% generate node locations
[n,ssl] = genNodes(f);

%% Generate All Robots In Simulation
r = genRobots('');

%% Generate Strategy for all robots in simulation
r.s = genStrategy(r,'');%generate the strategy for each of the different robots being used

%% Initialize Robot Locations
tmp = struct();
tmp = initLocs(r,ssl);%generate initial locations based on alliance color and how close they are to where they want to go
r = tmp;
clear tmp

%% Run a Match
m = runMatch(r,n,ssl);

%% Analyze Match
%Plot Field
PlotField()

% Analyze Game
%need to create some kind of analysis of the information and run multiple
%scripts. Maybe save all data in structure to some file.
singleMatchAnalysis()

saveMultiMatchAnalysisData()

end

