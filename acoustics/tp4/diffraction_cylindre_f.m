clc;clear all;close all;


gamma=1.4;
R=8.31;
M_mol=29e-3;
T=293.15;
c0=sqrt(gamma.*R.*T./M_mol);

P0=1; %amplitude of the incident plane wave
f=linspace(20,20000,500); %frequency of the acoustic wave
omega=2.*pi.*f; %corresponding angular frequency
k=omega./c0; %wave number
a=3.2e-2; %radius of the cylinder
r=50e-2; %radial coordinate of the observation point
theta=pi/3; %variable azimuthal angle of the observation point

N=200;%number of acoustic modes considered

% texte=['ka=',num2str(k.*a)];
% disp(texte);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% calculation of the acoustic field %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p_i_0=P0.*besselj(0,k.*r);
p_i=p_i_0;
B0=-P0.*besselj(-1,k.*a)./besselh(-1,2,k.*a);
p_r_0=B0.*besselh(0,2,k.*r);
p_r=p_r_0;
n=1
while n<=N,
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%% incident wave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   robert=2.*P0.*i.^n.*besselj(n,k.*r).*cos(n.*theta);
   p_i=p_i+robert;
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%% diffracted wave %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   Bn=-2.*P0.*i.^n.*(besselj(n-1,k.*a)-n./(k.*a).*besselj(n,k.*a))./...
       (besselh(n-1,2,k.*a)-n./(k.*a).*besselh(n,2,k.*a));
   bernard=Bn.*besselh(n,2,k.*r).*cos(n.*theta);
   p_r=p_r+bernard;
   
   n=n+1;
end

p_tot=p_i+p_r;

figure(1);
plot(f,abs(p_i),'b');
title('p_i')
figure(2);
plot(f,abs(p_r),'k');
title('p_r')
figure(3);
plot(f,abs(p_tot),'r');
title('p_{tot}')
figure;
semilogy(f,abs(p_tot),'r');
title('p_{tot}')
