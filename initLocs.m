function [ r ] = initLocs( r,ssl )
%This function sets the initial locations of the robots in the field based
%on their respective strategy
%   Detailed explanation goes here
%loc = struct();
fw = 288+72+288;%field width
t=0;%match time
for i = 1:6
    r.r(i).state = 'mvmt';%updates robot state
    tmp_output = nextDest(i,r,ssl,t);
    r.r(i).NextDest = [tmp_output{1}(1),tmp_output{1}(2)];
    if(strcmp(r.r(i).alliance,'red'))
        r.r(i).Locs = [0,r.r(i).NextDest(2)];
    else%otherwise its blue alliance
        r.r(i).Locs = [fw,r.r(i).NextDest(2)];
    end
    r.r(i).NextEventDist = tmp_output{2};
    r.r(i).NextEventTime = tmp_output{3};
    r.r(i).opMode = tmp_output{4};%tmp_output(5:length(tmp_output));
    r.r(i).state = 'mvmt';%indicates the robot is moving
    %op modes are mvmt, scaleScore, switchScore, vaultScore, getCube, 
    
    %r.s(i).priority(1)
    %ssl.r.sinks(2,:)%red alliance switch
    %r.r(i).Loc;%x dim
    %tmp = ssl.r.sinks(1,:);%red value
    %r.r(i).Loc(1) = tmp(1);%x dim of red alliance starting wall
end
end

