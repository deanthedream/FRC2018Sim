function [ r ] = robotDefaults( goodnessLevel )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
r = struct();
w = wheelParams(0);
%r.d.speed(1) = 14;%speed high gear
%r.d.speed(2) = 7;%speed low gear
r.d.mu1 = w.mu1;
r.d.mu2 = w.mu2;
r.d.name = w.name;
mbat = 13.8;%lb battery mass from andy mark
mbump = 20;%lb bumper mass limit FRC manual
r.m = (120+mbat+mbump)*0.453;%robot mass in kg

%% Generate Robot Goodness Based Skills
r.scaleScore = 0;%time in seconds if not able to do the task
if(goodnessLevel ==1)%this is a shitty robot
    r.d.speed = normrnd(48,18);%-2sig = 1fps=12 ips, 2sig = 7fps=84ips, mu = 48ips, sig = 18ips
    if(rand()>0.95)%less than 5% chance they can do the scale
        r.scaleScore = 30;%time in seconds it takes to do the task
    end
    r.switchScore = normrnd(20,10);%time in seconds
elseif(goodnessLevel ==2)%this is an okay robot
    r.d.speed = normrnd(102,21);%-2sig = 5fps=60 ips, 2sig = 12fps=144ips, mu = 102ips, sig = 21ips
    r.scaleScore = normrnd(15,10);%time in seconds
    r.switchScore = normrnd(10,10);%time in seconds
else%goodnessLevel==3
    r.d.speed = normrnd(144,24);%-2sig = 8fps=96 ips, 2sig = 16fps=192ips, mu = 144ips, sig = 24ips
    r.scaleScore = normrnd(5,2);%time in seconds
    r.switchScore = normrnd(2,1);%time in seconds
end%general acceleration to max speed is like 0.2sec or 0.1 sec

%% Ensure bounds are not exceeded
if(r.d.speed < 0.1)%ensure speed is positive and nonzero
    r.d.speed = 0.1;
end
if(r.scaleScore < 0)%ensure speed is positive and nonzero
    r.scaleScore = 0;
end
if(r.switchScore < 0)%ensure speed is positive and nonzero
    r.switchScore = 0;
end

end
