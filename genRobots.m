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
    for i = 1:6
        sr.r(i).hascube = 1;%does the robot have a cube
        if ismember(i,[1,2,3])
            sr.r(i).alliance='red';
        elseif(ismember(i,[4,5,6]))
            sr.r(i).alliance='blue';
        end
    end
end
end