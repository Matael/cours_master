function [sth,f] = theo_psd(a,V,fe,f)
    n = 0:length(a)-1;
    sth = zeros(1,length(f));
    for ii=1:length(f)
        sth(ii) = V/abs(exp(-j*2*pi*f(ii)/fe*n)*a')^2;
    end
    sth = sth*1/fe;
end