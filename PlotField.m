% Plots FRC2018 Field Locations
%run after running runsim

figure(1)
for i = 1:size(n.loc,1)
    hold on
    plot(n.loc(i,1),n.loc(i,2),'o')
    hold off
end

%% NEED TO FIX GENNODES