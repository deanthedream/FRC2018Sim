function [ f ] = genField()
%Generates field structure
f = struct();

if(rand(1) >= 0.5)%Orientation of RED ALLIANCE SCALE
    f.s1.side = 1;%the RED ALLIANCE switch north pad is RED
else
    f.s1.side = 0;%the RED ALLIANCE switch north pad is BLUE
end

if(rand(1) >= 0.5)%Orientation of RED ALLIANCE SCALE
    f.s2.side = 1;%the scale north pad is RED
else
    f.s2.side = 0;%the scale north pad is BLUE
end

if(rand(1) >= 0.5)%Orientation of RED ALLIANCE SCALE
    f.s3.side = 1;%the BLUE ALLIANCE switch north pad is RED
else
    f.s3.side = 0;%the BLUE ALLIANCE switch north pad is BLUE
end

end