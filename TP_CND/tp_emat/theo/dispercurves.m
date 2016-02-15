%
% plan_kxh_fh.m
%
% Copyright (C) 2014 Mathieu Gaborit (matael) <mathieu@matael.org>
%
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%



function figh=dispercurves(h, vL, vT, f_v)
	% on cherche à tracer les courbes pour les modes sym et antisym
	% d'après les éq de propagation dans une plaque solide.
	%
	% Les valeurs ne sont pas demandées, uniquement les courbes.
	% On procède ainsi :
	%
	% via 2 vecteurs et un meshgrid, on crée le plan (kxh,fh)
	% on trace ensuite les surfaces données par les deux
	% 	membres du déterminant de la matrice.

	% Vref fluide
	Vfluide = 1.48;

	% vecteur kx
	%kx0 = 0;
	%kx1 = 10;
	%kx_pas = .1;
	%kx_v = (kx0:kx_pas:kx1);
	kx_v = 2*pi*f_v/Vfluide;

	[kx, f]= meshgrid(kx_v, f_v);
	w = 2*pi*f;

	% nombres d'ondes kivonbien
	kL = w/vL;
	kT = w/vT;

	% projetés en z
	kzL = sqrt(kL.^2 - kx.^2);
	kzT = sqrt(kT.^2 - kx.^2);

	d = .5*h;
	% plan de trace
	sym = 4.*kx.^2.*kzL.*kzT.*cos(kzL*d).*sin(kzT*d)+(2*kx.^2-kT.^2).^2.*cos(kzT*d).*sin(kzL*d);
	antisym = 4.*kx.^2.*kzL.*kzT.*sin(kzL*d).*cos(kzT*d)+(2*kx.^2-kT.^2).^2.*sin(kzT*d).*cos(kzL*d);

	sym = real(sym) + imag(sym);
	antisym = real(antisym) + imag(antisym);

	isoline = [0 0];

	% figure : plan fh,vphi
	figh = figure;

	vphi = w./kx;
	contour(f*h, vphi, sym, isoline, 'b', 'LineWidth', 2);
	hold on;
	contour(f*h, vphi, antisym, isoline, 'r', 'LineWidth', 2);

	% legend('Sym', 'AntiSym', 'location', 'southeast')

	xlabel('f.h');
	ylabel('v_\Phi (mm/µs)');

	% % tracé des VL et VT
	% % TODO
	% plot(f_v*h,vphi, ones(), 'g--');
	% plot(f_v*h,vphi, w./kT, 'g--');

	grid on;

end
