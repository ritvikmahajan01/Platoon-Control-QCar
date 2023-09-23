clear;
clc;

s = tf('s');

n = 20; % Number of Follower Vehicles

% Battery Voltage
T = 12.3;

% Motor Model Parameters
R = 0.6656;
Km = 0.0026;
J = 3.2716e-06;
B = 2.4081e-06;
C = 0.002;

% Speed Controller Parameters
kp = 0.3;
ki = 1;
kff = 0.1;

% Transfer Function Parameters
wn4 = 9.3981;
n4 = 0.4524;
td_input = 0;
G4 = (wn4^2)/(s^2 + 2*n4*wn4*s + wn4^2);

td_comm = 0.1;
td_comm_leader = ones(n,1);
for i = 1:n
    td_comm_leader(i) = td_comm*i;
end

% Distance Policy (CTH)
d_default = 0.5;
t_hw = 0.1;

