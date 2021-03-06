function [ state ] = NextState( r,robotNum )
%UNTITLED Summary of this function goes here
%   This takes the robots previous state as well as the opMode to determine
%   what the robot is doing between now and the next robot event.
% if(r.r(robotNum).hascube == 0)%has NO cube in possession. Top Preference is to get cube
%     if(strcmp(r.r(robotNum).opMode,'switch'))
%         state = 'getcube';
%     elseif(strcmp(r.r(robotNum).opMode,'scale'))
%         state = 'getcube';
%     elseif(strcmp(r.r(robotNum).opMode,'vault'))
%         state = 'getcube';
%     elseif(strcmp(r.r(robotNum).opMode,'dswitch'))
%         state = 'getcube';
%     else
%         disp('ERROR 00002: The robot is in an unknown opMode')
%     end
if(strcmp(r.r(robotNum).state,'mvmt'))% && r.r(robotNum).hascube == 1)%robot has moved and has cube in possession
    if(strcmp(r.r(robotNum).opMode,'switch'))
        state = 'scoringSwitch';
    elseif(strcmp(r.r(robotNum).opMode,'scale'))
        state = 'scoringScale';
    elseif(strcmp(r.r(robotNum).opMode,'vault'))
        state = 'scoringVault';
    elseif(strcmp(r.r(robotNum).opMode,'dswitch'))
        state = 'scoringDSwitch';
    else
        disp('ERROR 00002: The robot is in an unknown opMode')
    end

elseif(strcmp(r.r(robotNum).state,'scoringSwitch'))
    state = 'getcube';
elseif(strcmp(r.r(robotNum).state,'scoringScale'))
    state = 'getcube';
elseif(strcmp(r.r(robotNum).state,'scoringVault'))
    state = 'getcube';
elseif(strcmp(r.r(robotNum).state,'scoringDSwitch'))
    state = 'getcube';
elseif(strcmp(r.r(robotNum).state,'getcube'))%After getting cube, switch to mvmt (to the desired switch
    state = 'mvmt';
else
    disp('ERROR 00003: The robot is in an unknown state')
end


end

