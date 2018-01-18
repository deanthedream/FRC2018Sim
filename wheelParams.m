function [ w ] = wheelParams(n)
%Generates Wheel Parameters for robot
%   Detailed explanation goes here
t = struct();%temporary structure

%from http://team1640.com/wiki/index.php?title=DEWBOT_VIII_Wheel_Friction_Coefficient_Testing
t(1).name = '4" HiGrip Wheels';
t(1).mu1 = 1.7555;
t(1).mu2 = 1.709;
t(2).name = 'Plaction Wheels Blue Nitrile Tread';
t(2).mu1 = 1.829;
t(2).mu2 = 1.343;
t(3).name = 'Omni Wheels';
t(3).mu1 = 0.357;
t(3).mu2 = 0.152;
t(4).name = 'Rover Wheels';
t(4).mu1 = 0.237;
t(4).mu2 = 0.249;
t(5).name = 'FIRST Wheels with Rubber Tread';
t(5).mu1 = 0.3249;
t(5).mu2 = 0.5467;
t(6).name = 'Pneumatic Wheels Andy Mark';%https://www.andymark.com/8-inch-pneumatic-wheel-p/am-0970.htm
t(6).mu1 = 0.93;
t(6).mu2 = 0.86;%completeguess there is no data from andy mark

if(n==0)%if We pass 0, then randomly generate the type of robot to use
    n = floor(rand()*size(t,2))+1;
end

w = struct();
w=t(n);

end