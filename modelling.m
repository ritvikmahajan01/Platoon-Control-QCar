% clear;
% clc;

% Motor parameters
R = 0.6656;
Km = 0.0026;
J = 3.2716e-06;
B = 2.4081e-06;
C = 0.002;

% Speed Controller parameters
kp = 0.3;
ki = 1;
kff = 0.1;

% Battery Voltage
T = 12.3;


%{
BATTERY = 10.9V

    Transfer Function Approx:
        +ve step ref speed = 0.5 m/s
            t_rise = 0.283s
            Mp = 12%
            t_peak = 0.405s
            t_settling = 1.675s

        -ve step (from 0.5 to 0 m/s)
            t_rise = 0.242s
            Mp = 4.936%
            t_peak = 0.336s
            t_settling = 0.6s

        -ve step ref speed = -0.5 m/s
            t_rise = 0.258s
            Mp = 13.74%
            t_peak = 0.396s
            t_settling = 1.5s

    1st order motor model:
        R = 0.6350
        Km = 0.0024
        J = 3.1145e-06
        B = 1.9647e-06
        C = 0.0017
%}



% BATTERY = 12.3V
    % 1st order motor model:
    %     R = 0.6656
    %     Km = 0.0026
    %     J = 3.2716e-06
    %     B = 2.4081e-06
    %     C = 0.002


% Transfer Function Approx:

% +ve step ref speed = 0.5 m/s
t_rise1 = 0.269;
Mp1 = 0.12;
t_peak1 = 0.411;
t_settling1 = 1.4;
n1 = log(Mp1)/(sqrt(pi^2 + (log(Mp1))^2));
wn1 = -pi/(t_peak1*sqrt(1 - n1^2));

% wn1 = 6.6955;
% n1 = 0.4596;

% Stop
t_rise2 = 0.243;
Mp2 = 0.4428;
t_peak2 = 0.309;
t_settling2 = 0.55;
n2 = log(Mp2)/(sqrt(pi^2 + (log(Mp2))^2));
wn2 = -pi/(t_peak2*sqrt(1 - n2^2));

% -ve step ref speed = -0.5 m/s
t_rise3 = 0.284;
Mp3 = 0.1286;
t_peak3 = 0.443;
t_settling3 = 1.5;
n3 = log(Mp3)/(sqrt(pi^2 + (log(Mp3))^2));
wn3 = -pi/(t_peak3*sqrt(1 - n3^2));

wn4 = (wn1 + wn2 + wn3)/3;
n4 = (n1 + n2 + n3)/3;


s = tf('s');

G1 = (wn1^2)/(s^2 + 2*n1*wn1*s + wn1^2); % v_act/v_ref from 2nd order TF approximation (+ve vel step)
G2 = (wn2^2)/(s^2 + 2*n2*wn2*s + wn2^2); % v_act/v_ref from 2nd order TF approximation (-ve vel step)
G3 = (wn3^2)/(s^2 + 2*n3*wn3*s + wn3^2); % v_act/v_ref from 2nd order TF approximation (stop)
G4 = (wn4^2)/(s^2 + 2*n4*wn4*s + wn4^2);

% H = wn^2/((T*kff + kp)*s^2 + (2*T*kff*n*wn + 2*kp*n*wn + ki)*s + (T*kff*wn^2 + 2*ki*n*wn)); % v_act/Voltage_cmd


load("model_compare.mat");

t = models_compare.time;
y = models_compare.signals(3).values(:);
u = models_compare.signals(4).values(:);
data = iddata(y,u,1/600);
model = tfest(data, 2, 0);

ls_data = models_compare.signals(1).values(:);
ls_fit = 100*(1 - norm(y-ls_data)/norm(y-mean(y)));
ls_fit_str = sprintf("LS model: %.2f", ls_fit);



compare(data, model, G1, G2, G3, G4);
hold on;
plot(t, ls_data)




