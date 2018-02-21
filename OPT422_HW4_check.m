clear;

MetaChecker = load('MetaChecker_380-780-5nm.txt');
MetaChecker = MetaChecker(:,2:end);
ColorChecker = load('ColorChecker_380-780-5nm.txt');
ColorChecker = ColorChecker(:,2:end);

load cie

XYZn_illD65 = ref2XYZ(ones(length(cie.lambda),1),cie.cmf2deg,cie.illD65);
XYZ1_illD65 = ref2XYZ(MetaChecker,  cie.cmf2deg,cie.illD65);
XYZ2_illD65 = ref2XYZ(ColorChecker, cie.cmf2deg,cie.illD65);
Lab1_illD65 = XYZ2Lab(XYZ1_illD65,XYZn_illD65);
Lab2_illD65 = XYZ2Lab(XYZ2_illD65,XYZn_illD65);

XYZn_illA = ref2XYZ(ones(length(cie.lambda),1),cie.cmf2deg,cie.illA);
XYZ1_illA = ref2XYZ(MetaChecker,  cie.cmf2deg,cie.illA);
XYZ2_illA = ref2XYZ(ColorChecker, cie.cmf2deg,cie.illA);
Lab1_illA = XYZ2Lab(XYZ1_illA,XYZn_illA);
Lab2_illA = XYZ2Lab(XYZ2_illA,XYZn_illA);

% part 1
DEab_illD65 = deltaEab(Lab1_illD65, Lab2_illD65);
DEab_illA   = deltaEab(Lab1_illA, Lab2_illA);
output1     = [(1:24)', DEab_illD65', DEab_illA'];

% part 2
DE94_illD65 = deltaE94(Lab1_illD65,Lab2_illD65);
DE94_illA   = deltaE94(Lab1_illA,Lab2_illA);
output2     = [(1:24)', DE94_illD65', DE94_illA'];
