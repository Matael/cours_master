%
% bf_traitement
%
% TP Formation de voies
% Jean-Claude Pascal et Jean-Hugh Thomas
%

clear all;
close all;
clc;

c = 340; % m.s^-1

%-- d�termination de la m�thode : 'bartlet','capon','music'
bfmethod = 'music';

disp(' '), disp(['-- Traitement avec la m�thode ',bfmethod]), disp(' ')

%-- construction du path
rootpath = cd;
addpath([rootpath '\Bf_bib']),

%==============================================================================
% Lecture de la matrice interspectrale  (code complet)
%------------------------------------------------------------------------------

%-- S�lection du fichier hdf
%
FilterSpec = {'*.hdf','hdf file'};
[HDFFileName,HDFPathName] = uigetfile(FilterSpec,'load an hdf spectral file');
        
if ischar(HDFFileName)
    filename = [HDFPathName HDFFileName];
else
    return,
end

%-- Visualisation du spectre moyen sur les microphones de l'antenne
%
[avspect,freqvect,axename] = HDFinterface('averageddata',filename);   
HDFinterface('averageddata',filename);

%-- S�lection de la fr�quence de traitement
%
disp(' '), disp('S�lection de la fr�quence'),
freq = input('     entrer la fr�quence � traiter (en Hz) : ');
[freq,ifreq] = nearest(freqvect,freq);

%-- Chargement de la matrice interspectrale
%
[Refarray,axevector,axeorder] = HDFfileAScontrol('getdata',filename,'Refarray',ifreq,':',1);
Gpp = TransRefarray('vec2mat',Refarray,'single');     
Gpp = conj(Gpp);

% INFO : Gpp = Gpp'; dans Matlab, Gpp' repr�sente la transpos�e hermitienne de la matrice complexe Gpp
%        la matrice Gpp est une matrice carr�e [M M] (M nombre de microphones)

%==============================================================================
% Lecture des coordonn�es des points de l'antenne (code complet)
%------------------------------------------------------------------------------
%
% INFO
% micropnts est une matrice [M 3] o� M est le nombre de microphones de l'antenne
% micropnts(:,1) est le vecteur colonne des coordonn�es x
% micropnts(:,2) est le vecteur colonne des coordonn�es y
% micropnts(:,3) est le vecteur colonne des coordonn�es z (normalement nul car le 
% plan de l'antenne est en z = 0)

[micropnts,coordsys,arraysys] = HDFinterface('micropnts',filename);

%==============================================================================
% D�termination du plan de repr�sentation  (code � compl�ter : donner des valeurs) 
%------------------------------------------------------------------------------

% INFO
% Le plan de repr�sentation est parall�le � celui de l'antenne Pour d�finir les points 
% o� seront estim�es les sources il faut fournir les informations suivantes :
%  Nx, Ny -> le nombre de points en x et y
%  dist   -> la distance du plan de repr�sentation � celui de l'antenne
%  Xmin Xmax Ymin Ymax -> les limites du plan de repr�sentation 
% L'origine du rep�re est situ�e sur l'axe de l'antenne. Par exemple :
Nx = 40;
Ny = 40;
dist = 1.5;
Xmin = -1;
Xmax = 1;
Ymin = -1;
Ymax = 1;

%-- construction du maillage sur le plan de repr�sentation
%
x = linspace(Xmin,Xmax,Nx);
y = linspace(Ymin,Ymax,Ny);
[Xmat,Ymat] = meshgrid(x,y);

%-- vecteur [Np 3] des positions des sources (plan de source)
Np = Nx*Ny;
srcpnts = [Xmat(:) Ymat(:) -dist*ones(Np,1)];

%==============================================================================
% Pr�-traitement selon la m�thode choisie  (code � compl�ter) 
%------------------------------------------------------------------------------
if strcmpi(bfmethod,'capon')
    disp('   :: pr�-traitement pour la m�thode de Capon'),
    % INFO
    % le traitement consiste ici � inverser la matrice Gpp
    Gpp_inv = Gpp^-1;
    
elseif strcmpi(bfmethod,'music')
    disp('   :: pr�-traitement pour la m�thode MUSIC'),
    % INFO
    % le traitement consiste ici � d�composer la matrice Gpp en utilisant la fonction svd
    % de Matlab [U,S,V] = svd(Gpp)  (dans ce cas particulier V = U')

    [U,Sigma2,V] = svd(Gpp);

    % choix de valeurs pour le sous-espace :
    stem(1:length(diag(Sigma2)), diag(Sigma2));
    disp('Selectionnez le seuil');
    [gui_x,gui_y] = ginput(1);
    r = floor(gui_x);

end    
    
%==============================================================================
% Boucle de traitement pour chacun des points sources  (code � compl�ter) 
%------------------------------------------------------------------------------
hw = waitbar(0,['traitement m�thode ',bfmethod,' ...']);
S = zeros(Np,1);

for ii=1:Np
    
    waitbar(ii/Np,hw);
    
    %-- vecteur [1 3] des coordonn�es du point source
    coorsrc = srcpnts(ii,:);
    
    %--------------------------------------------------------------------------
    % Calcul des distances 
    % calcul du vecteur R [M,1] des distance entre chaque microphone et le point 
    % source
    %--------------------------------------------------------------------------
    %sqrt( % on prend la racine carr�e de chaque �lement du vecteur
    % sum( % on fait la somme dans chaque ligne (voir ,2) � la fin) (somme
    %      %des diff�rences des coordonn�es
    %  (micropnts -                              % (x_mic - x_source)
    %    repmat(coorsrc,length(micropnts),1)     % on r�p�te les coordon�es
    %                                            % de la source pour que �a 
    %                                            % corresponde � la bonne taille de matrice
    %  ).^2  % (x_mic-x_source)^2
    % ,2)
    %)
    R = sqrt(sum((micropnts - repmat(coorsrc,length(micropnts),1)).^2,2));
    
    %--------------------------------------------------------------------------
    % Calcul du vecteur h [M,1] repr�sentant les fonctions de transfert entre 
    % les microphones et le point source (Eqs. 2.2 et 2.3)
    %--------------------------------------------------------------------------
    
    k = 2*pi*freq/c;
    hi = exp(-j*k*R)./(4*pi*R);
    
    %--------------------------------------------------------------------------
    % Calcul du vecteur de pilotage selon la m�thode 
    % La m�thode MUSIC n'est pas concern�e par cette phase
    %--------------------------------------------------------------------------

    if strcmpi(bfmethod,'bartlet')
        % INFO
        % voir Eq. 3.7
    
        wi = 1/(hi'*hi)*hi;

    elseif strcmpi(bfmethod,'capon')
        % voir Eq. 5.5
    
        wi = 1/(hi'*Gpp_inv*hi)*(Gpp_inv*hi);


    end    
    
    %--------------------------------------------------------------------------
    % Calcul de la distribution des sources selon les m�thodes
    % les r�sultats du calcul sont rang�s dans un vecteur S [Np 1]
    %--------------------------------------------------------------------------
    
    if strcmpi(bfmethod,'bartlet')
        % INFO
        % voir Eq. 2.5
    
        S(ii) = wi'*Gpp*wi;

    elseif strcmpi(bfmethod,'capon')
        % voir Eq. 2.5
    
        S(ii) = wi'*Gpp*wi;

    elseif strcmpi(bfmethod,'music')
%         voir Eq. 6.3

        
        M = length(micropnts);
        repeat_size = M - r;
        mat_hi = repmat(reshape(hi',length(hi),1), 1, repeat_size);
        mat_uq = U(:,r+1:end);
        S(ii) = 1/sum(abs(sum(mat_uq.*mat_hi,1)).^2);
        
%         somme = 0;
%         for q=r+1:M
%             somme = somme + abs(hi'*U(:,q))^2;
%         end
%         S(ii) = 1/somme;

        % mat_hi :
        % +--            --+
        % |                |
        % |                |
        % | ((hi)^H)^T ... |
        % |                |
        % |                |
        % +--            --+
        % |<-  M-(r+1)   ->|
    end
    
%------------------------------------------------------------------------------
end % fin de la boucle ii=1:Np

close(hw),
%------------------------------------------------------------------------------


%==============================================================================
% Reconstitution de la matrice rectangulaire et visualisation (code � compl�ter) 
%------------------------------------------------------------------------------
%
% INFO
% selon meshgrid S doit avoir comme dimensions [Ny Nx]
S = reshape(S,Ny,Nx);
S = real(S);

%-- utiliser ici �ventuellement une interpolation pour avoir un maillage de 
%   repr�sentation plus fin  (fonction interp2 de Matlab)
x1 = x;
y1 = y;
S1 = S;

% A COMPLETER EVENTUELLEMENT

%-- visualiser la carte des sources en utilisant la fonction imagesc
%
titre = ['M�thode ',bfmethod,' - f = ',num2str(freq),' Hz'];





reptype = 'lin';  % 'lin' ou 'dB'

if strcmpi(reptype,'lin')
    
%-- pour une repr�sentation lin�aire
repstruct.mode = 'mod*';
repstruct.dynscal = [];   %  -> range of representation of scalar map (used for dB)
repstruct.maxscal = [];    %  -> max value of scalar map ( [] -> automatic scaling)
repstruct.stepscal = 10;   %  -> step for rounded max value in automatic scaling
repstruct.dBref = 1;       %  -> energy reference for dB (A = 10 log [real(Z)/dBref])
repstruct.title = titre;   %  -> map title string
repstruct.underrangecolor = [0.9 0.9 0.9]; %  -> underrange color
repstruct.unit = '';       %  -> string of quantity unit to put under the colorbar

else
    
%-- pour une repr�sentation en dB
Dyn = 15;
RefdB = 1e-12;
repstruct.mode = 'dB*';
repstruct.dynscal = Dyn;   %  -> range of representation of scalar map (used for dB)
%repstruct.maxscal = dBmax; %  -> max value of scalar map ( [] -> automatic scaling)
repstruct.maxscal = [];   %  -> max value of scalar map ( [] -> automatic scaling)
repstruct.stepscal = 1;    %  -> step for rounded max value in automatic scaling
repstruct.dBref = RefdB;   %  -> energy reference for dB (A = 10 log [real(Z)/dBref])
repstruct.title = titre;   %  -> map title string
repstruct.underrangecolor = [0.95 0.95 0.95]; %  -> underrange color
repstruct.unit = 'dB';     %  -> string of quantity unit to put under the colorbar

end

figure;
imagesc(x1,y1,S1)
% figure;
% ccmap(repstruct,x1,y1,S1),
% 
