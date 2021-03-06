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
r=55e-2; %radial coordinate of the observation point
theta_vect=(0:15:180); %variable azimuthal angle of the observation point

N=100;%number of acoustic modes considered

% texte=['ka=',num2str(k.*a)];
% disp(texte);


for theta_deg=theta_vect

    theta = theta_deg/180*pi;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%% calculation of the acoustic field %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    p_i_0=P0.*besselj(0,k.*r);
    p_i=p_i_0;
    B0=-P0.*besselj(-1,k.*a)./besselh(-1,2,k.*a);
    p_r_0=B0.*besselh(0,2,k.*r);
    p_r=p_r_0;
    n=1;
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
    hold off
    plot(f,abs(p_i),'b');
    title('p_i')
    
    figure(2);
    hold off;
    plot(f,abs(p_r),'k');
    title('p_r')
    
    hold off;
    figure(3);
    plot(f,abs(p_tot),'r');
    title('p_{tot}')
    
    figure(4);
    hold off;
    plot(f,abs(1+p_r./p_i),'r', 'LineWidth', 2);
    title(['p_{tot} | theta0 = ' num2str(theta_deg) 'deg'])
    grid on
    xlim([0 4000])
    ylabel('Radiated pressure')
    xlabel('Frequency')
    
   filename = sprintf('multitheta/p_%03d.png', theta_deg);
   print('-dpng', filename)
end