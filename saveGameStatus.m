function [m] = saveGameStatus(m,scnt,r,ssl,t,redScore,blueScore)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
m(scnt).r = r;
m(scnt).ssl = ssl;
m(scnt).t = t;
m(scnt).redScore = redScore;
m(scnt).blueScore = blueScore;


end

