function [ output ] = nextDest( robotNum,r,ssl )
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
                    else
                        continue%run next iteration and do not update location
                    end
                else%robot is blue alliance
                    if (ssl.b.sinksContentMax(2) > ssl.b.sinksContent(2))%check if blue switch has space
                        r.r(robotNum).DestLoc(:) = ssl.b.sinks(2,:);
                    else
                        continue%run next iteration and do not update location
                    end
                end
            case 2 %scale
                if(strcmp(r.r(robotNum).alliance,'red'))
                    if (ssl.r.sinksContentMax(3) > ssl.r.sinksContent(3))%check if red scale has space
                        r.r(robotNum).DestLoc(:) = ssl.r.sinks(3,:);
                    else
                        continue%run next iteration and do not update location
                    end
                else%robot is blue alliance
                    if (ssl.b.sinksContentMax(3) > ssl.b.sinksContent(3))%check if blue scale has space
                        r.r(robotNum).DestLoc(:) = ssl.b.sinks(3,:);
                    else
                        continue%run next iteration and do not update location
                    end
                end
            case 3 %vault
                if(strcmp(r.r(robotNum).alliance,'red'))
                    if (ssl.r.sinksContentMax(1) > ssl.r.sinksContent(1))%check if vault has space
                        r.r(robotNum).DestLoc(:) = ssl.r.sinks(1,:);
                    else
                        continue%run next iteration and do not update location
                    end
                else%robot is blue alliance
                    if (ssl.b.sinksContentMax(1) > ssl.b.sinksContent(1))%check if vault has space
                        r.r(robotNum).DestLoc(:) = ssl.b.sinks(1,:);
                    else
                        continue%run next iteration and do not update location
                    end
                end
            case 4 %defense
                if(strcmp(r.r(robotNum).alliance,'red'))
                    if (ssl.r.sinksContentMax(4) > ssl.r.sinksContent(4))%check if red defense switch has space
                        r.r(robotNum).DestLoc(:) = ssl.r.sinks(4,:);
                    else
                        continue%run next iteration and do not update location
                    end
                else%robot is blue alliance
                    if (ssl.b.sinksContentMax(4) > ssl.b.sinksContent(4))%check if blue defense switch has space
                        r.r(robotNum).DestLoc(:) = ssl.b.sinks(4,:);
                    else
                        continue%run next iteration and do not update location
                    end
                end
            otherwise
                disp('Error 0001')
                break
        end
    end
    %calculate Time to travel to that location from current location
    NextEventDist = norm(r.r(robotNum).Loc(:)-r.r(robotNum).DestLoc(:));%distance from robot to destination in inches
    NextEventTime = NextEventDist/r.r(robotNum).d.speed;%time in seconds
%WHAT ELSE DOES THE ROBOT DO IF IT HAS A CUBE???
else%the robot does not have a cube
    %find closest source
    if(strcmp(r.r(robotNum).alliance,'red'))
        %calculate Closest Source
        DistanceToSources = zeros([1,15]);
        for l = 1:15%there are 15 sources
            if(ssl.r.sourceContent(l)>0)
                DistanceToSources(l) = sqrt((ssl.r.source(l,:)-r.r(robotNum).Loc(:))^2);
            else
                DistanceToSources(l) = 1000000;%just a really large number
            end
        end
        
        r.r(robotNum).DestLoc(:)
    else%it is a blue robot
        %calculate Closest Source
        DistanceToSources = zeros([1,15]);
        for l = 1:15%there are 15 sources
            if(ssl.r.sourceContent(l)>0)
                DistanceToSources(l) = sqrt((ssl.r.source(l,:)-r.r(robotNum).Loc(:))^2);
            else
                DistanceToSources(l) = 1000000;%just a really large number
            end
        end
        
        r.r(robotNum).DestLoc(:)
    end
    
end
output = [r.r(robotNum).DestLoc(:)',NextEventDist,NextEventTime];
end

