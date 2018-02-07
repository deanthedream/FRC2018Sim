function [ n, ssl] = genNodes(f)
%Generates field Node Locations, sink source list
n = struct();
fh = 264+48+48;%field height
fw = 288+72+288;%field width
plateh = 3*12;%height of the scoring pads
platew = 12*4;%196-140;%width of the scoring pads
pch = 12+1;%power cube size
pcw = pch;
pcCOLspacing = (fh-82.5*2-6/pch)/5;%spacing between top and bottom of power cubes in column

%For switches and scales, we assume the center is where we are driving to

n.loc(1,:) = [48*cos(pi/4),fh-48*sin(pi/4)];%blue human block source
n.loc(2,:) = [0,fh/2+48/3+12];%red vault sink
n.loc(3,:) = [48*cos(pi/4),48*sin(pi/4)];%blue human block source
n.loc(4,:) = [140-42/2,fw/2];%RED pile source
n.loc(5,:) = [168,fh-82.5-plateh/2];%Top Plate Red Alliance Switch
n.loc(6,:) = [168,82.5+plateh/2];%bottom Plate Red Alliance Switch
%RED alliance Power Cubes in column
n.loc(7,:) = [168+platew+pcw/2,fh-82.5-pch/2];
n.loc(8,:) = [168+platew+pcw/2,fh-82.5-1*(pch-pcCOLspacing)-pch/2];
n.loc(9,:) = [168+platew+pcw/2,fh-82.5-2*(pch-pcCOLspacing)-pch/2];
n.loc(10,:) = [168+platew+pcw/2,fh-82.5-3*(pch-pcCOLspacing)-pch/2];
n.loc(11,:) = [168+platew+pcw/2,fh-82.5-4*(pch-pcCOLspacing)-pch/2];
n.loc(12,:) = [168+platew+pcw/2,fh-82.5-5*(pch-pcCOLspacing)-pch/2];
n.loc(13,:) = [fw/2,fh-71.57-plateh/2];%top scale location
n.loc(14,:) = [fw/2,71.57+plateh/2];%bottom scale location
%BLUE alliance Power Cubes in column
n.loc(15,:) = [fw-(168+platew+pcw/2),fh-82.5-pch/2];
n.loc(16,:) = [fw-(168+platew+pcw/2),fh-82.5-1*(pch-pcCOLspacing)-pch/2];
n.loc(17,:) = [fw-(168+platew+pcw/2),fh-82.5-2*(pch-pcCOLspacing)-pch/2];
n.loc(18,:) = [fw-(168+platew+pcw/2),fh-82.5-3*(pch-pcCOLspacing)-pch/2];
n.loc(19,:) = [fw-(168+platew+pcw/2),fh-82.5-4*(pch-pcCOLspacing)-pch/2];
n.loc(20,:) = [fw-(168+platew+pcw/2),fh-82.5-5*(pch-pcCOLspacing)-pch/2];
n.loc(21,:) = [fw-168,fh-82.5-plateh/2];%Top Plate BLUE Alliance Switch
n.loc(22,:) = [fw-168,82.5+plateh/2];%bottom Plate BLUE Alliance Switch
n.loc(23,:) = [fw-140+42/2,fw/2];%BLUE pile source
n.loc(24,:) = [fw-48*cos(pi/4),fh-48*sin(pi/4)];%RED human block source
n.loc(25,:) = [fw,fh/2+48/3+12];%BLUE vault sink
n.loc(26,:) = [fw-48*cos(pi/4),48*sin(pi/4)];%RED human block source

%% Sink Locations Order goes: Vault, Alliance Switch, Scale, Opposing Switch
ssl = struct();
ssl.r.sinks(1,:) = n.loc(2,:);%red vault
ssl.b.sinks(1,:) = n.loc(25,:);%blue vault
if(f.s1.side)%the Red alliance switch top plate is BLUE
    ssl.r.sinks(2,:) = n.loc(6,:);
    ssl.b.sinks(4,:) = n.loc(5,:);
else%the Red alliance Switch top plate is BLUE
    ssl.r.sinks(2,:) = n.loc(5,:);
    ssl.b.sinks(4,:) = n.loc(6,:);
end
if(f.s2.side)%the scale top plate is BLUE
    ssl.r.sinks(3,:) = n.loc(14,:);
    ssl.b.sinks(3,:) = n.loc(13,:);
else%the Red alliance Switch top plate is BLUE
    ssl.r.sinks(3,:) = n.loc(13,:);
    ssl.b.sinks(3,:) = n.loc(14,:);
end
if(f.s3.side)%the Red alliance switch top plate is BLUE
    ssl.r.sinks(4,:) = n.loc(21,:);
    ssl.b.sinks(2,:) = n.loc(22,:);
else%the Red alliance Switch top plate is BLUE
    ssl.r.sinks(4,:) = n.loc(22,:);
    ssl.b.sinks(2,:) = n.loc(21,:);
end

%% Sink Content and their Maximums
ssl.r.sinksContent(1) = 0;%value
ssl.r.sinksContent(2) = 0;%switch
ssl.r.sinksContent(3) = 0;%scale
ssl.r.sinksContent(4) = 0;%defense switch

ssl.b.sinksContent(1) = 0;
ssl.b.sinksContent(2) = 0;
ssl.b.sinksContent(3) = 0;
ssl.b.sinksContent(4) = 0;

ssl.r.sinksContentMax(1) = 9;
ssl.r.sinksContentMax(2) = 10;
ssl.r.sinksContentMax(3) = 10;
ssl.r.sinksContentMax(4) = 10;

ssl.b.sinksContentMax(1) = 9;
ssl.b.sinksContentMax(2) = 10;
ssl.b.sinksContentMax(3) = 10;
ssl.b.sinksContentMax(4) = 10;

%% Source Locations Order goes: Pile, Your Side Column, Opposite Side Column, Human North, Human South
ssl.r.source(1,:) = n.loc(4,:);%red pile
ssl.r.source(2,:) = n.loc(7,:);%red column of cubes
ssl.r.source(3,:) = n.loc(8,:);
ssl.r.source(4,:) = n.loc(9,:);
ssl.r.source(5,:) = n.loc(10,:);
ssl.r.source(6,:) = n.loc(11,:);
ssl.r.source(7,:) = n.loc(12,:);
ssl.r.source(8,:) = n.loc(15,:);%blue column of cubes
ssl.r.source(9,:) = n.loc(16,:);
ssl.r.source(10,:) = n.loc(17,:);
ssl.r.source(11,:) = n.loc(18,:);
ssl.r.source(12,:) = n.loc(19,:);
ssl.r.source(13,:) = n.loc(20,:);
ssl.r.source(14,:) = n.loc(24,:);%red human block source north
ssl.r.source(15,:) = n.loc(26,:);%red human block source south

ssl.b.source(1,:) = n.loc(23,:);%blue pile
ssl.b.source(2,:) = n.loc(15,:);%blue column of cubes
ssl.b.source(3,:) = n.loc(16,:);
ssl.b.source(4,:) = n.loc(17,:);
ssl.b.source(5,:) = n.loc(18,:);
ssl.b.source(6,:) = n.loc(19,:);
ssl.b.source(7,:) = n.loc(20,:);
ssl.b.source(8,:) = n.loc(7,:);%red column of cubes
ssl.b.source(9,:) = n.loc(8,:);
ssl.b.source(10,:) = n.loc(9,:);
ssl.b.source(11,:) = n.loc(10,:);
ssl.b.source(12,:) = n.loc(11,:);
ssl.b.source(13,:) = n.loc(12,:);
ssl.b.source(14,:) = n.loc(1,:);%blue human block source north
ssl.b.source(15,:) = n.loc(3,:);%blue human block source south

%% Source Content Order goes: Pile, Your Side Column, Opposite Side Column, Human North, Human South
ssl.r.sourceContent(1) = 10;%red pile
ssl.r.sourceContent(2) = 1;%red column of cubes
ssl.r.sourceContent(3) = 1;
ssl.r.sourceContent(4) = 1;
ssl.r.sourceContent(5) = 1;
ssl.r.sourceContent(6) = 1;
ssl.r.sourceContent(7) = 1;
ssl.r.sourceContent(8) = 1;%blue column of cubes
ssl.r.sourceContent(9) = 1;
ssl.r.sourceContent(10) = 1;
ssl.r.sourceContent(11) = 1;
ssl.r.sourceContent(12) = 1;
ssl.r.sourceContent(13) = 1;
ssl.r.sourceContent(14) = 7;%red human block source north
ssl.r.sourceContent(15) = 7;%red human block source south

ssl.b.sourceContent(1) = 10;%red pile
ssl.b.sourceContent(2) = 1;%red column of cubes
ssl.b.sourceContent(3) = 1;
ssl.b.sourceContent(4) = 1;
ssl.b.sourceContent(5) = 1;
ssl.b.sourceContent(6) = 1;
ssl.b.sourceContent(7) = 1;
ssl.b.sourceContent(8) = 1;%blue column of cubes
ssl.b.sourceContent(9) = 1;
ssl.b.sourceContent(10) = 1;
ssl.b.sourceContent(11) = 1;
ssl.b.sourceContent(12) = 1;
ssl.b.sourceContent(13) = 1;
ssl.b.sourceContent(14) = 7;%red human block source north
ssl.b.sourceContent(15) = 7;%red human block source south

%end of function
end




