function [ r ] = genRobot( goodness )
%Generate a Robot Randomly based on defaults
%   Detailed explanation goes here
if(goodness < 0.1)%this is a shitty robot
    goodnessLevel = 1;
elseif(goodness >=0.1 && goodness < 0.9)%this is an okay robot
    goodnessLevel = 2;
else
    goodnessLevel = 3;
end
r = robotDefaults(goodnessLevel);
end
