load('SkyBlue.mat');
load cie;
load('Mcat02.mat');

%% part i.
BlueRData = interp1(380:10:780, SkyBlue, 380:5:780);

%% part ii.
% whitepoint
XYZ_A   = ref2XYZ(ones(length(cie.lambda),1),cie.cmf2deg,cie.illA);
XYZ_D65 = ref2XYZ(ones(length(cie.lambda),1),cie.cmf2deg,cie.illD65);
XYZ_F2  = ref2XYZ(ones(length(cie.lambda),1),cie.cmf2deg,cie.illF(:,2));

%% part iii.
% blue pigment
XYZ_Blue_A     = ref2XYZ(BlueRData(:,2),cie.cmf2deg,cie.illA);
XYZ_Blue_D65   = ref2XYZ(BlueRData(:,2),cie.cmf2deg,cie.illD65);
XYZ_Blue_F2    = ref2XYZ(BlueRData(:,2),cie.cmf2deg,cie.illF(:,2));

%% part iv.
RGB_Blue_A    = mtimes(Mcat02,XYZ_Blue_A);
RGB_Blue_D65  = mtimes(Mcat02,XYZ_Blue_D65);
RGB_Blue_F2   = mtimes(Mcat02,XYZ_Blue_F2);

%% part v.
RGB_A    = mtimes(Mcat02,XYZ_A);
RGB_D65  = mtimes(Mcat02,XYZ_D65);
RGB_F2   = mtimes(Mcat02,XYZ_F2);

% illA to illD65
Mvk = [RGB_D65(1)/RGB_A(1),0,0; 0,RGB_D65(2)/RGB_A(2),0; 0,0,RGB_D65(3)/RGB_A(3);];
RGB_A_D65 = mtimes(Mvk, RGB_Blue_A);

% illF2 to illD65
Mvk = [RGB_D65(1)/RGB_F2(1),0,0; 0,RGB_D65(2)/RGB_F2(2),0; 0,0,RGB_D65(3)/RGB_F2(3);];
RGB_F2_D65 = mtimes(Mvk, RGB_Blue_F2);

%% part vi.
Mcat02_inv = inv(Mcat02);
XYZ_A_D65  = mtimes(Mcat02_inv, RGB_A_D65);
XYZ_F2_D65 = mtimes(Mcat02_inv, RGB_F2_D65);

%% part vii.
Lab_A_D65  = XYZ2Lab(XYZ_A_D65, XYZ_D65);
Lab_F2_D65 = XYZ2Lab(XYZ_F2_D65, XYZ_D65);
Lab_D65_original = XYZ2Lab(XYZ_Blue_D65, XYZ_D65);

figure;hold on
plot3(Lab_A_D65(1),Lab_A_D65(2),Lab_A_D65(3),'.','MarkerSize',20);
plot3(Lab_F2_D65(1),Lab_F2_D65(2),Lab_F2_D65(3),'.','MarkerSize',20);
plot3(Lab_D65_original(1),Lab_D65_original(2),Lab_D65_original(3),'.','MarkerSize',20);
view(100,35);
legend('A to D65 Blue','F2 to D65 Blue','original D65 Blue');
hold off

%% part viii.
DE94_A_D65 = deltaE94(Lab_A_D65,Lab_D65_original);
disp(DE94_A_D65);
% DE94 = 2.0439 < 3, so this painting will maintain its bluesky appearance under
% illuminant A

%% part ix.
DE94_F2_D65 = deltaE94(Lab_F2_D65,Lab_D65_original);
disp(DE94_F2_D65);
% DE94 = 6.2326 > 3, so this painting won't maintain its bluesky appearance under
% illuminan F2





