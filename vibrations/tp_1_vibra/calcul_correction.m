clear all;
close all;


sensi = 1;
M1 = 14.2e-3;
M2 = M1;
r1 = 15e-2;
r2 = r1;

sans_masse = [
    300.6   0.00263747/sqrt(2)/sensi;
    0.9     0.007084/sqrt(2)/sensi;
];

masse_plan1 = [
    301.5   0.00357/sqrt(2)/sensi;
    6.3     0.009805/sqrt(2)/sensi;
];

masse_plan2 = [
    302.4   0.003085/sqrt(2)/sensi;
    292.5   0.006958/sqrt(2)/sensi;
];

E11 = masse_plan1(1,2)*exp(j*pi/180*masse_plan1(1,1))-sans_masse(1,2)*exp(j*pi/180*sans_masse(1,1));
E21 = masse_plan1(2,2)*exp(j*pi/180*masse_plan1(2,1))-sans_masse(2,2)*exp(j*pi/180*sans_masse(2,1));
E12 = masse_plan2(1,2)*exp(j*pi/180*masse_plan2(1,1))-sans_masse(1,2)*exp(j*pi/180*sans_masse(1,1));
E22 = masse_plan2(2,2)*exp(j*pi/180*masse_plan2(2,1))-sans_masse(2,2)*exp(j*pi/180*sans_masse(2,1));


A = [
    E11/M1 E12/M2;
    E21/M1 E22/M2
];

% Ax= v_b
% x = v_b\A
v_b = [
-sans_masse(1,2)*exp(j*pi/180*sans_masse(1,1));
-sans_masse(2,2)*exp(j*pi/180*sans_masse(2,1))
];

x = v_b\A;

disp('On a : ');
disp(['m_1 = ' num2str(abs(x(1))) '  &  phi_1 = ' num2str(180/pi*angle(x(1)))]);
disp(['m_2 = ' num2str(abs(x(2))) '  &  phi_2 = ' num2str(180/pi*angle(x(2)))]);

B = [
    E11 E12;
    E21 E22
];

C = v_b\B;

C = M1*C;

disp('On a : ');
disp(['m_1 = ' num2str(abs(C(1))) '  &  phi_1 = ' num2str(180/pi*angle(C(1)))]);
disp(['m_2 = ' num2str(abs(C(2))) '  &  phi_2 = ' num2str(180/pi*angle(C(2)))]);

