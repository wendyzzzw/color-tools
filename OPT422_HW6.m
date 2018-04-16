close all
%% A. Color Filter Glass
load('a_yellow.mat');
load('a_magenta.mat');
lambda = 380:5:780;
b = 1;  %cm
C = 1;  %100%

A_yellow = a_yellow .* b .* C;
A_magenta = a_magenta .* b .* C;
A_new = a_yellow .* b .* 0.5 + a_magenta .* b .* 0.25;

% internal reflectance
T_yellow = exp(-A_yellow);
T_magenta = exp(-A_magenta);
T_new = exp(-A_new);

% total reflectance (with the incorporation of Fresnel reflectance)
n = 1.5;
K1 = ((1-n)/(1+n))^2;
T_yellow_total = (1-K1)^2.*T_yellow./(1-K1^2.*T_yellow.^2);
T_magenta_total = (1-K1)^2.*T_magenta./(1-K1^2.*T_magenta.^2);
T_new_total = (1-K1)^2.*T_new./(1-K1^2.*T_new.^2);

figure('position', [100, 200, 1200, 500], 'Name','A. Color filter glass transmittance'); 
subplot(1,2,1);hold on
plot(lambda, T_yellow,'y');
plot(lambda, T_magenta,'m');
plot(lambda, T_new);
legend({'yellow','magenta','new filter'},'Location','northwest');
xlabel('wavelength (nm)');
ylabel('transmittance');
title('internal transmittance');
hold off
subplot(1,2,2);hold on
plot(lambda, T_yellow_total,'y');
plot(lambda, T_magenta_total,'m');
plot(lambda, T_new_total);
legend({'yellow','magenta','new filter'},'Location','northwest');
xlabel('wavelength (nm)');
ylabel('transmittance');
title('total transmittance');
hold off
%% B. Calculating Purple k and s
% 1
load('purple2016.mat');
wavelength = purple2016(:,1);
Rm_white = purple2016(:,2)./100;
Rm_50 = purple2016(:,3)./100;
Rm_25 = purple2016(:,4)./100;
Rm_10 = purple2016(:,5)./100;
Rm_8  = purple2016(:,6)./100;
Rm_3  = purple2016(:,7)./100;

figure('position', [100, 200, 1200, 500], 'Name','B.1~3 Purple reflectance');
subplot(1,2,1); hold on
plot(wavelength, Rm_white);
plot(wavelength, Rm_50);
plot(wavelength, Rm_25);
plot(wavelength, Rm_10);
plot(wavelength, Rm_8);
plot(wavelength, Rm_3);
legend('white ','50%','25%','10%','8%','3%');
xlabel('wavelength (nm)');
ylabel('Reflectance');
title('R_m');
hold off

% 2
n0 = 1;
n1 = 1.45;
K1 = ((n0-n1)/(n0+n1))^2; % 0.0337

criticalAng = asind(n0/n1);
theta0 = 0:1:criticalAng;
theta1 = asind(n0.*sind(theta0)./n1);
np0 = n0./cosd(theta0);
np1 = n1./cosd(theta1);
ns0 = n0.*cosd(theta0);
ns1 = n1.*cosd(theta1);
Rp = ((np0-np1)./(np0+np1)).^2;
Rs = ((ns0-ns1)./(ns0+ns1)).^2;
Rave = (Rp+Rs)./2;
Rave1 = [Rave, (criticalAng:1:90).*0+1];
K2 = nanmean(Rave1); % 0.5335
disp('B.2 K1 & K2:');
disp(K1);
disp(K2);

% 3
Ri_white = Rm_white./((1-K1)*(1-K2)+K2.*Rm_white);
Ri_50 = Rm_50./((1-K1)*(1-K2)+K2.*Rm_50);
Ri_25 = Rm_25./((1-K1)*(1-K2)+K2.*Rm_25);
Ri_10 = Rm_10./((1-K1)*(1-K2)+K2.*Rm_10);
Ri_8  = Rm_8 ./((1-K1)*(1-K2)+K2.*Rm_8);
Ri_3  = Rm_3 ./((1-K1)*(1-K2)+K2.*Rm_3);

subplot(1,2,2); hold on
plot(wavelength, Ri_white);
plot(wavelength, Ri_50);
plot(wavelength, Ri_25);
plot(wavelength, Ri_10);
plot(wavelength, Ri_8);
plot(wavelength, Ri_3);
legend('white ','50%','25%','10%','8%','3%');
xlabel('wavelength (nm)');
ylabel('Reflectance');
title('R_i');
hold off

% 4
KS_white = (1-Ri_white).^2./(2.*Ri_white);
KS_50 = (1-Ri_50).^2./(2.*Ri_50);
KS_25 = (1-Ri_25).^2./(2.*Ri_25);
KS_10 = (1-Ri_10).^2./(2.*Ri_10);
KS_8  = (1-Ri_8 ).^2./(2.*Ri_8);
KS_3  = (1-Ri_3 ).^2./(2.*Ri_3);
figure('position', [100, 200, 700, 500], 'Name','B.4 Purple K/S'); hold on
plot(wavelength, KS_white);
plot(wavelength, KS_50);
plot(wavelength, KS_25);
plot(wavelength, KS_10);
plot(wavelength, KS_8);
plot(wavelength, KS_3);
legend('white ','50%','25%','10%','8%','3%');
xlabel('wavelength (nm)');
ylabel('K/S');
title('K/S');
hold off

% 5
sw = 1; 
kp = zeros(31,1);
sp = zeros(31,1);
for i = 1:31
    kw = KS_white(i)*sw;
    A = [1, -KS_50(i); 1, -KS_25(i); 1, -KS_10(i); 1, -KS_8(i); 1, -KS_3(i);];
    b = [(1-0.5)/0.5*(KS_50(i)-kw); (1-0.25)/0.25*(KS_25(i)-kw);(1-0.1)/0.1*(KS_10(i)-kw);(1-0.08)/0.08*(KS_8(i)-kw);(1-0.03)/0.03*(KS_3(i)-kw);];
    x = lsqnonneg(A,b);
    kp(i) = x(1);
    sp(i) = x(2);
end
figure('position', [100, 200, 700, 500], 'Name','B.5 Purple k and s'); hold on
plot(wavelength, kp);
plot(wavelength, sp);
legend('k_p','s_p');
xlabel('wavelength (nm)');
title('Purple k and s');
hold off

% 6
Rnew_50 = zeros(31,1);
Rnew_25 = zeros(31,1);
Rnew_10 = zeros(31,1);
Rnew_8  = zeros(31,1);
Rnew_3  = zeros(31,1);
for i = 1:31
    K_50 = 0.50*kp(i) + (1-0.50)*KS_white(i);
    K_25 = 0.25*kp(i) + (1-0.25)*KS_white(i);
    K_10 = 0.10*kp(i) + (1-0.10)*KS_white(i);
    K_8  = 0.08*kp(i) + (1-0.08)*KS_white(i);
    K_3  = 0.03*kp(i) + (1-0.03)*KS_white(i);
    
    S_50 = 0.50*sp(i) + (1-0.50)*sw;
    S_25 = 0.25*sp(i) + (1-0.25)*sw;
    S_10 = 0.10*sp(i) + (1-0.10)*sw;
    S_8  = 0.08*sp(i) + (1-0.08)*sw;
    S_3  = 0.03*sp(i) + (1-0.03)*sw;
    
    Rinew_50 = 1+(K_50/S_50)-((K_50/S_50)^2+2*(K_50/S_50))^0.5;
    Rinew_25 = 1+(K_25/S_25)-((K_25/S_25)^2+2*(K_25/S_25))^0.5;
    Rinew_10 = 1+(K_10/S_10)-((K_10/S_10)^2+2*(K_10/S_10))^0.5;
    Rinew_8  = 1+(K_8 /S_8 )-((K_8 /S_8 )^2+2*(K_8 /S_8 ))^0.5;
    Rinew_3  = 1+(K_3 /S_3 )-((K_3 /S_3 )^2+2*(K_3 /S_3 ))^0.5;
    
    Rnew_50(i) = (1-K1)*(1-K2)*Rinew_50/(1-K2*Rinew_50);
    Rnew_25(i) = (1-K1)*(1-K2)*Rinew_25/(1-K2*Rinew_25);
    Rnew_10(i) = (1-K1)*(1-K2)*Rinew_10/(1-K2*Rinew_10);
    Rnew_8(i)  = (1-K1)*(1-K2)*Rinew_8 /(1-K2*Rinew_8 );
    Rnew_3(i)  = (1-K1)*(1-K2)*Rinew_3 /(1-K2*Rinew_3);
    
end

figure('position', [100, 200, 700, 500], 'Name','B.6 Calculated and measured purple reflectance'); hold on
plot(wavelength, Rm_50, 'r');
plot(wavelength, Rnew_50,'r--');
plot(wavelength, Rm_25,'b');
plot(wavelength, Rnew_25,'b--');
plot(wavelength, Rm_10,'g');
plot(wavelength, Rnew_10,'g--');
plot(wavelength, Rm_8,'m');
plot(wavelength, Rnew_8,'m--');
plot(wavelength, Rm_3,'c');
plot(wavelength, Rnew_3,'c--');
xlabel('wavelength (nm)');
ylabel('Reflectance');
title('dashed lines are new calculated R_m, solid lines are measured R_m');
hold off

% the dashed lines and solid lines almost match each other, but there is no
% perfect complete match. This could be due to that some of the SPEX data
% comes from an imperfect alignment or has some unexpected error. This
% could also be due to some precision error of Matlab functions such as lsqnonneg.


%% C. Color matching a gray
% 1
load('CMYW2016.mat');
% 2
K = [yellow(:,1),phthalo_blue(:,1),magenta(:,1),black(:,1),white(:,1)];
S = [yellow(:,2),phthalo_blue(:,2),magenta(:,2),black(:,2),white(:,2)];
Rm = grayRm;

% 3
%starting concentrations
c=[.2,.2,.2,0.01,.39];
lb=[0,0,0,0,0];
ub=[.7,.7,.7,0.01,.99];
Aeq=[1,1,1,1,1];
beq=[1];
options = optimset('Algorithm','active-set');
% 4
[x,fval]=fmincon(@Mixobjfun,c,[],[],Aeq,beq,lb,ub,[],options,Rm,K,S);
% 5
disp('C.5 concentrations:');
disp(x); % 0.0122    0.0018    0.0185    0.0100    0.9575
disp('C.5 fval:');
disp(fval); % 0.1396

% 6
K1=.04;K2=.5;
Kmix=sum(x.*K,2);
Smix=sum(x.*S,2);
KoSmix=Kmix./Smix;
Rimix=1+KoSmix-sqrt((KoSmix).^2+2.*(KoSmix));
R_mix=((1-K1).*(1-K2).*Rimix)./(1-K2.*Rimix);

figure('position', [100, 200, 700, 500], 'Name','C.6 Calculated and measured gray reflectance'); hold on
plot(wavelength, Rm);
plot(wavelength, R_mix);
legend('Gray Rm','Calculated Reflectance');
xlabel('wavelength (nm)');
title('Gray reflectance');
hold off

% 7
load cie
illD65 = interp1(380:5:780, cie.illD65, 400:10:700);
cmf2deg = interp1(380:5:780, cie.cmf2deg, 400:10:700);
XYZn_illD65 = ref2XYZ(ones(length(wavelength),1),cmf2deg,illD65);
XYZ_Rm_illD65 = ref2XYZ(Rm, cmf2deg, illD65);
XYZ_Rcalculated_illD65 = ref2XYZ(R_mix, cmf2deg, illD65);
Lab_Rm_illD65 = XYZ2Lab(XYZ_Rm_illD65,XYZn_illD65);  %[76.0693; 0; 0]
Lab_Rcalculated_illD65 = XYZ2Lab(XYZ_Rcalculated_illD65,XYZn_illD65); %[76.1406; 0.5616; -0.4702]
disp('C.7 CIELab for the gray provided:');
disp(Lab_Rm_illD65(:,1));
disp('C.7 CIELab for my new gray:');
disp(Lab_Rcalculated_illD65(:,1));
