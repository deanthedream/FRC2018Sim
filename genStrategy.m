function [ s ] = genStrategy( r,stratFile )
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here
s = struct();
%get nearest cube
%choose between switch, scale, vault, defense
if(strcmp(stratFile,''))%RANDOMLY
    for i = 1:6
        priority = randperm(4);%randomly set priority order
        s(i).priority = priority;
    end
end
%STRATEGICALLY


end

