function [ r ] = initLocs( r,ssl )
%This function sets the initial locations of the robots in the field based
%on their respective strategy
%   Detailed explanation goes here
loc = struct();
fw = 288+72+288;%field width
for i = 1:6
    tmp_output = nextDest(i,r,ssl);
    r.r(i).NextDest = [tmp_output(1),tmp_output(2)];
    if(strcmp(r.r(i).alliance,'red'))
        r.r(i).Locs = [0,r.r(i).NextDest(2)];
    else%otherwise its blue alliance
        r.r(i).Locs = [fw,r.r(i).NextDest(2)];
    end
    %r.s(i).NextEventDist = tmp_output(3);
    %r.s(i).NextEventTime = tmp_output(4);
    
    
    %r.s(i).priority(1)
    %ssl.r.sinks(2,:)%red alliance switch
    %r.r(i).Loc;%x dim
    %tmp = ssl.r.sinks(1,:);%red value
    %r.r(i).Loc(1) = tmp(1);%x dim of red alliance starting wall
end
%r.r.Locs
end

