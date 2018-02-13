% tests for HW1
clear
ref=load('ObjectRef_380-780-5nm.txt');
ref=ref(:,2);
load cie
objXYZ=ref2XYZ(ref, cie.cmf2deg, cie.illD65);
fprintf('X=%5.2f Y=%5.2f Z=%5.2f\n',objXYZ);

% objXYZ = [13.472,13.472; 14.385, 14.385; 47.5221,47.5221];
objxyY = XYZ2xyY(objXYZ)
xyY2XYZ(objxyY)
