function DE94 = deltaE94(Lab1, Lab2)

% This function takes in two 3-by-n matrices of CIELab values (test and reference)
% and returns a 1-by-n matrix of ?E*94 color differences

kL = 1;
kC = 1;
kH = 1;

a_test = Lab1(2,:);
b_test = Lab1(3,:);
C_test = sqrt(a_test.^2 + b_test.^2);
% h_test = atan(b_test./a_test);

a_ref  = Lab2(2,:);
b_ref  = Lab2(3,:);
C_ref  = sqrt(a_ref.^2 + b_ref.^2);
% h_ref  = atan(b_ref./a_ref);


Delta_L = Lab1(1,:) - Lab2(1,:);
Delta_C = C_test - C_ref;
Delta_H = (a_test.*b_ref - a_ref.*b_test)./sqrt(0.5.*(C_test.*C_ref+a_test.*a_ref+b_test.*b_ref));

SL = 1;
SC = 1 + 0.045.*C_test;
SH = 1 + 0.015.*C_test;

DE94 = sqrt((Delta_L./(kL.*SL)).^2 + (Delta_C./(kC.*SC)).^2 + (Delta_H./(kH.*SH)).^2);


end