function [ssl] = scorePoints(t, t_last, r, robotNum, ssl)
%Tally the points for this match
%   Detailed explanation goes here
    deltat = t-t_last;%in seconds
    
%% Increment Scoring
if(strcmp(r.r(robotNum).alliance,'red'))
    if(strcmp(r.r(robotNum).state,'scoringSwitch'))
        ssl.r.sinksContent(2) = ssl.r.sinksContent(2)+1;%red switch
        r.r(robotNum).hascube=0;%the robot now has no cubes
    elseif(strcmp(r.r(robotNum).state,'scoringScale'))
        ssl.r.sinksContent(3) = ssl.r.sinksContent(3)+1;%red Scale
        r.r(robotNum).hascube=0;%the robot now has no cubes
    elseif(strcmp(r.r(robotNum).state,'scoringVault'))
        %disp(ssl.r.sinksContent(1))
        ssl.r.sinksContent(1) = ssl.r.sinksContent(1)+1;%red vault
        ssl.score.r.vault = ssl.score.r.vault+5;%increment scoring in red vault
        r.r(robotNum).hascube=0;%the robot now has no cubes
    elseif(strcmp(r.r(robotNum).state,'scoringDSwitch'))
        ssl.r.sinksContent(4) = ssl.r.sinksContent(4)+1;%red defense switch
        r.r(robotNum).hascube=0;%the robot now has no cubes
    end
else%alliance is blue
    if(strcmp(r.r(robotNum).state,'scoringSwitch'))
        ssl.b.sinksContent(2) = ssl.b.sinksContent(2)+1;%blue switch
        r.r(robotNum).hascube=0;%the robot now has no cubes
    elseif(strcmp(r.r(robotNum).state,'scoringScale'))
        ssl.b.sinksContent(3) = ssl.b.sinksContent(3)+1;%blue Scale
        r.r(robotNum).hascube=0;%the robot now has no cubes
    elseif(strcmp(r.r(robotNum).state,'scoringVault'))
        ssl.b.sinksContent(1) = ssl.b.sinksContent(1)+1;%blue vault
        ssl.score.b.vault = ssl.score.b.vault+5;%increment scoring in blue vault
        r.r(robotNum).hascube=0;%the robot now has no cubes
    elseif(strcmp(r.r(robotNum).state,'scoringDSwitch'))
        ssl.b.sinksContent(4) = ssl.b.sinksContent(4)+1;%blue defense switch
        r.r(robotNum).hascube=0;%the robot now has no cubes
    end
end

    
%% DETERMINE WHO HAS SCALE POSESSION
%Score Red Switch
if(ssl.r.sinksContent(2) > ssl.b.sinksContent(4))%score RED SWITCH
    ssl.score.r.switch = ssl.score.r.switch + deltat;
end
%Score Blue Switch
if(ssl.b.sinksContent(2) > ssl.r.sinksContent(4))
    ssl.score.b.switch = ssl.score.b.switch + deltat;
end
%Score Scale
if(ssl.r.sinksContent(3) > ssl.b.sinksContent(3))%more in red than blue
    ssl.score.r.scale = ssl.score.r.scale + deltat;
else
    ssl.score.b.scale = ssl.score.b.scale + deltat;
end

%Vault Scoring Incremented Above

end

