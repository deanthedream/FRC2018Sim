function [ m ] = runMatch( r,n,ssl )
%This function handles all the processes of running a match
%   Detailed explanation goes here

%Initialize Variables
t = 0;%initialize time
t_last = t;%initialize Last Time
tMatchEnd = 120;%time is in seconds
scnt = 0;%save counter
m = struct();

%Start Match
while(t < tMatchEnd)
    [val, robotNum] = min([r.r(:).NextEventTime]);%robotNum of the shortest time to the next place.
    t_last = t;%update last_t time
    t = r.r(robotNum).NextEventTime;%advance current t to next event time
    r.r(robotNum).state = NextState(r,robotNum);%updates robot state according to opMode and previous state
    r.r(robotNum).Loc = r.r(robotNum).NextDest;%update robot position to what the NextDest was
    
    %Update next destination for the robot
    tmp_output = nextDest(robotNum,r,ssl,t);%retrieve nextDest, NextEventDist, NextEventTime, and opMode
    r.r(robotNum).NextDest = [tmp_output{1}(1),tmp_output{1}(2)];%update nextDest
    r.r(robotNum).NextEventDist = tmp_output{2};%update NextEventDist
    r.r(robotNum).NextEventTime = tmp_output{3};%update NextEventTime
    r.r(robotNum).opMode = tmp_output{4};%tmp_output(5:length(tmp_output));%update opMode
    ssl = tmp_output{5};%updates ssl
    
    %Score points
    [ssl,r] = scorePoints(t, t_last, r, robotNum, ssl);
    redScore = ssl.score.r.vault + ssl.score.r.switch + ssl.score.r.scale;%score sum for red
    blueScore = ssl.score.b.vault + ssl.score.b.switch + ssl.score.b.scale;%score sum for blue
    
    %Cubes Left On Field
    RedSourceCubesLeft = sum(ssl.r.sourceContent);
    BlueSourceCubesLeft = sum(ssl.b.sourceContent);
    
    mystr = strcat('t_last=',num2str(t_last,'%.1f'),' t=',num2str(t,'%.1f'),' NextEventTime=',num2str(r.r(robotNum).NextEventTime,'%.1f'),' RobotNum=',num2str(robotNum),' state=',pad(r.r(robotNum).state,14),' redScore=',num2str(redScore,'%.0f'),' blueScore=',num2str(blueScore,'%.0f'),' Red Source Cubes Left',num2str(RedSourceCubesLeft),' Blue Source Cubes Left',num2str(BlueSourceCubesLeft));
    disp(mystr)
    
    %Save Game Data to Vectors
    scnt  = scnt+1;
    m = saveGameStatus(m,scnt,r,ssl,t,redScore,blueScore);
    
    if(t > tMatchEnd), break; end%checks if match is over and ends the match
end
disp('Match Over')


end

