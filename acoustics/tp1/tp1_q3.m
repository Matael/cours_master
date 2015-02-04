close all
clear all

Fe = 25600;
rho0 = 1.2;
c0 = 343;
Z0 = rho0*c0;
L = 0.20;     %longueur du tube en m

a = load('Impedance_spangrand.txt');

Zinput = a(:,2)+j*a(:,3); %impédance (imaginaire)
f=a(:,1);               %axe frequentiel

w=2*pi*f;

k0 = w./c0;

k=(1/L)*atan(-j*Z0./Zinput);

c=w./real(k);


plot(f,abs(Zinput));
hold on;

%plot(f,f,'r');


% nb = input('Nombre de max : ');
% 
% maxs = ones(1,nb);
% for i=1:nb
%     [x,y] = ginput(2);
%     maxs(i) = max(Zinput(x(1)/Fe:x(2)/Fe));
% end

f1=877;
f2=1757;
f3=2637;
f4=3516;
f5=4394;
f6=5277;

fres=[f1 f2 f3 f4 f5 f6];

alpha=abs(((1:length(fres))*c0./(2*fres*L))-1);

k_theo_sp = (1:5)*c0/(2*L);

figure
plot(fres,alpha);
hold on
%plot(fres,3*10^(-5)*sqrt(fres)/0.01,'r');


