function [ output ] = nextDest( robotNum,r,ssl,t )
%Returns the next Destination of the Robot, the time the next event will
%occur
if(r.r(robotNum).hascube == 1)%the robot has a cube in its possession
    for i = 1:4%iterate through priorities
        priority = r.s(robotNum).priority(i);%robot scoring priority
        switch priority
            case 1 %switch
                if(strcmp(r.r(robotNum).alliance,'red'))
                    if (ssl.r.sinksContentMax(2) > ssl.r.sinksContent(2))%check if red switch has space
                        r.r(robotNum).DestLoc(:) = ssl.r.sinks(2,:);
                        r.r(robotNum).opMode = 'switch';
                        break
                    else
                        continue%run next iteration and do not update location
                    end
                else%robot is blue alliance
                    if (ssl.b.sinksContentMax(2) > ssl.b.sinksContent(2))%check if blue switch has space
                        r.r(robotNum).DestLoc(:) = ssl.b.sinks(2,:);
                        r.r(robotNum).opMode = 'switch';
                        break
                    else
                        continue%run next iteration and do not update location
                    end
                end
            case 2 %scale
                if(strcmp(r.r(robotNum).alliance,'red'))
                    if (ssl.r.sinksContentMax(3) > ssl.r.sinksContent(3))%check if red scale has space
                        r.r(robotNum).DestLoc(:) = ssl.r.sinks(3,:);
                        r.r(robotNum).opMode = 'scale';
                        break
                    else
                        continue%run next iteration and do not update location
                    end
                else%robot is blue alliance
                    if (ssl.b.sinksContentMax(3) > ssl.b.sinksContent(3))%check if blue scale has space
                        r.r(robotNum).DestLoc(:) = ssl.b.sinks(3,:);
                        r.r(robotNum).opMode = 'scale';
                        break
                    else
                        continue%run next iteration and do not update location
                    end
                end
            case 3 %vault
                if(strcmp(r.r(robotNum).alliance,'red'))
                    if (ssl.r.sinksContentMax(1) > ssl.r.sinksContent(1))%check if vault has space
                        r.r(robotNum).DestLoc(:) = ssl.r.sinks(1,:);
                        r.r(robotNum).opMode = 'vault';
                        break
                    else
                        continue%run next iteration and do not update location
                    end
                else%robot is blue alliance
                    if (ssl.b.sinksContentMax(1) > ssl.b.sinksContent(1))%check if vault has space
                        r.r(robotNum).DestLoc(:) = ssl.b.sinks(1,:);
                        r.r(robotNum).opMode = 'vault';
                        break
                    else
                        continue%run next iteration and do not update location
                    end
                end
            case 4 %defense
                if(strcmp(r.r(robotNum).alliance,'red'))
                    if (ssl.r.sinksContentMax(4) > ssl.r.sinksContent(4))%check if red defense switch has space
                        r.r(robotNum).DestLoc(:) = ssl.r.sinks(4,:);
                        r.r(robotNum).opMode = 'dswitch';
                        break
                    else
                        continue%run next iteration and do not update location
                    end
                else%robot is blue alliance
                    if (ssl.b.sinksContentMax(4) > ssl.b.sinksContent(4))%check if blue defense switch has space
                        r.r(robotNum).DestLoc(:) = ssl.b.sinks(4,:);
                        r.r(robotNum).opMode = 'dswitch';
                        break
                    else
                        continue%run next iteration and do not update location
                    end
                end
            otherwise
                disp('Error 0001')
                break
        end
    end%end of for loop
    %Determine how long it will take to do the next task
    if(strcmp(r.r(robotNum).state,'mvmt'))
        %calculate Time to travel to that location from current location
        %disp(robotNum)
        %disp(r.r(robotNum).Loc(:))
        %disp(r.r(robotNum).DestLoc(:))
        NextEventDist = norm(r.r(robotNum).Loc(:)-r.r(robotNum).DestLoc(:));%distance from robot to destination in inches
        NextEventTime = t+NextEventDist/r.r(robotNum).d.speed;%time in seconds
    elseif(strcmp(r.r(robotNum).state,'scoringSwitch'))
        NextEventDist = 0;
        NextEventTime = t+r.r(robotNum).switchScore;
    elseif(strcmp(r.r(robotNum).state,'scoringScale'))
        NextEventDist = 0;
        NextEventTime = t+r.r(robotNum).scaleScore;
    elseif(strcmp(r.r(robotNum).state,'scoringVault'))
        NextEventDist = 0;
        NextEventTime = t+r.r(robotNum).switchScore;%this is just an approximation
    elseif(strcmp(r.r(robotNum).state,'scoringDSwitch'))
        NextEventDist = 0;
        NextEventTime = t+r.r(robotNum).switchScore;
    end
    
else%the robot does not have a cube
    %find closest source
    if(strcmp(r.r(robotNum).alliance,'red'))
        %calculate Closest Source
        DistanceToSources = zeros([1,15]);
        for l = 1:15%there are 15 sources
            if(ssl.r.sourceContent(l)>0)
                DistanceToSources(l) = sqrt((ssl.r.source(l,:)-r.r(robotNum).Loc(:))^2);%calculates the distance to each source
            else
                DistanceToSources(l) = 1000000;%just a really large number
            end
        end
        [val,ind] = min(DistanceToSources);%finds minimum distance
        r.r(robotNum).DestLoc(:) = ssl.r.source(ind,:);%assigns minimum distance to next dest loc
        ssl.r.sourceContent(l) = ssl.r.sourceContent(l)-1;%decrement source content by 1
        if(ismember(l,2:7))
            ssl.b.sourceContent(l+6) = ssl.b.sourceContent(l+6) - 1;%need to subtract from both because it is a common cube between the two teams
        end
    else%it is a blue robot
        %calculate Closest Source
        DistanceToSources = zeros([1,15]);
        for l = 1:15%there are 15 sources
            if(ssl.r.sourceContent(l)>0)
                DistanceToSources(l) = sqrt((ssl.r.source(l,:)-r.r(robotNum).Loc(:))^2);%calculates the distance to each source
                
            else
                DistanceToSources(l) = 1000000;%just a really large number
            end
        end
        [val,ind] = min(DistanceToSources);%calculates minimum distance
        r.r(robotNum).DestLoc(:) = ssl.b.source(ind,:);%assigns minimum distance to next dest loc
        ssl.b.sourceContent(l) = ssl.b.sourceContent(l)-1;%decrement source content by 1
        if(ismember(l,8:13))
            ssl.r.sourceContent(l-6) = ssl.r.sourceContent(l-6) - 1;%need to subtract from both because it is a common cube between the two teams
        end
    end
    r.r(robotNum).state = 'mvmt';%should actually be getcube
    %calculate Time to travel to that location from current location
    NextEventDist = norm(r.r(robotNum).Loc(:)-r.r(robotNum).DestLoc(:));%distance from robot to destination in inches
    NextEventTime = t+NextEventDist/r.r(robotNum).d.speed;%time in seconds
    
    %Temporally speaking this event has not happened yet. The robot has not
    %acquired the cube at this point, it is merely headed towards doing so.
    %we realistically have no mechanism for accounting for "stolen" cubes
    r.r(robotNum).hascube = 1;%NOT SURE IF THIS SHOULD GO HERE
end

%output = cell(1,3);
output = {r.r(robotNum).DestLoc(:)',NextEventDist,NextEventTime, r.r(robotNum).opMode, r.r(robotNum).state};
end

