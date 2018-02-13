clear

% save the data as a CIE struct
cmf2deg = importdata('CIE_2Deg_380-780-5nm.txt');
cmf10deg =  importdata('CIE_10Deg_380-780-5nm.txt');
illA = importdata('CIE_IllA_380-780-5nm.txt');
illD65 = importdata('CIE_IllD65_380-780-5nm.txt');
illF = importdata('CIE_IllF_1-12_380-780-5nm.txt');

[m,n] = size(cmf2deg);
illE = ones(m,1) .* 100;
lambda = cmf2deg(:,1).';

cie = struct('lambda',lambda,'cmf2deg',cmf2deg(:,2:end),'cmf10deg',cmf2deg(:,2:end), ...
     'illA',illA(:,2:end),'illD65',illD65(:,2:end),'illE',illE,'illF',illF(:,2:end));
 
save('cie.mat','cie');






