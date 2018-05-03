function DE94 = deltaE94(Lab1, Lab2)

% Lab1 is the test color and Lab2 is the reference.

% Inputs: two 3-by-n matrices of CIELab values (test and reference)
% Return: a 1-by-n matrix of DE*94 color differences

kL = 1; kC = 1; kH = 1;

a_test = Lab1(2,:);
b_test = Lab1(3,:);
C_test = (a_test.^2 + b_test.^2).^0.5;
% h_test = atan(b_test./a_test);

a_ref  = Lab2(2,:);
b_ref  = Lab2(3,:);
C_ref  = (a_ref.^2 + b_ref.^2).^0.5;
% h_ref  = atan(b_ref./a_ref);

Delta_L = Lab1(1,:) - Lab2(1,:);
Delta_C = C_test - C_ref;
Delta_H = (a_test.*b_ref - a_ref.*b_test)./(0.5.*(C_test.*C_ref + a_test.*a_ref + b_test.*b_ref)).^0.5;
% Delta_H = sqrt((a_ref-a_test).^2 + (b_ref-b_test).^2 - Delta_C.^2);

SL = 1;
SC = 1 + 0.045.*C_ref;
SH = 1 + 0.015.*C_ref;

DE94 = ((Delta_L./(kL.*SL)).^2 + (Delta_C./(kC.*SC)).^2 + (Delta_H./(kH.*SH)).^2).^0.5;


end