function f = Mixobjfun(c,Rm,K,S)
%
%
cc=repmat(c,31,1);
K1=.04;K2=.5;
Kmix=sum(cc.*K,2);
Smix=sum(cc.*S,2);
KoSmix=Kmix./Smix;
Rimix=1+KoSmix-sqrt((KoSmix).^2+2.*(KoSmix));
Rmix=((1-K1).*(1-K2).*Rimix)./(1-K2.*Rimix);



f=sqrt(sum((Rm-Rmix).^2));

end