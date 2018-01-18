function [ sr ] = genRobots( scriptfile )
%Generates all 6 robots for the match
%   Either 1 generate robots from a script file if that file exists or 2
%   generate robots from robot probability distributions
sr = struct();
if(strcmp(scriptfile,''))%There is no Script so Generate Robots Based on Distributions
    for i = 1:6
        %Generate robot distribution parameters statistically
        %first is this a "good robot"
        goodness = rand();
        sr.r(i) = genRobot(goodness);
    end
end
end