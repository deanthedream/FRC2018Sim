% Plots FRC2018 Field Locations
%run after running runsim
close(figure(1))
fh = 264+48+48;%field height
fw = 288+72+288;%field width
corner = 36;
%% Plot Sinks and Sources
figure(1)
for i = 1:size(n.loc,1)
    hold on
    plot(n.loc(i,1),n.loc(i,2),'o')
    hold off
end

%% Plot Field Edge
figure(1)
hold on
%plot([0,fw,fw,0],[0,0,fh,fh],'k')
%length([corner,fw-corner,fw,fw,fw-corner,corner,0,0,corner])
%length([0,0,corner,fh-corner,fh,fh,fh-corner,corner,0])
plot([corner,fw-corner,fw,fw,fw-corner,corner,0,0,corner],[0,0,corner,fh-corner,fh,fh,fh-corner,corner,0],'k')
hold off
axis('equal')

%% NEED TO FIX GENNODES