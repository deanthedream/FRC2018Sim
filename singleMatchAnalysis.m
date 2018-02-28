% written by dean keithly




t = [m.t];%time array
redScore = [m.redScore];%redScore array
blueScore = [m.blueScore];%blueScore array
for i = 1:length(m)%robot Location Arrays
    red1loc(i,:) = [m(i).r.r(1).Loc(1),m(i).r.r(1).Loc(2)];
    red2loc(i,:) = [m(i).r.r(2).Loc(1),m(i).r.r(2).Loc(2)];
    red3loc(i,:) = [m(i).r.r(3).Loc(1),m(i).r.r(3).Loc(2)];
    blue1loc(i,:) = [m(i).r.r(4).Loc(1),m(i).r.r(4).Loc(2)];
    blue2loc(i,:) = [m(i).r.r(5).Loc(1),m(i).r.r(5).Loc(2)];
    blue3loc(i,:) = [m(i).r.r(6).Loc(1),m(i).r.r(6).Loc(2)];
end

%% Plot Team Score vs Time
figure(2)
plot(t,redScore,'-r')
hold on
plot(t,blueScore,'-b')
hold off
xlabel('Game Time t (seconds)')
ylabel('Game Score')