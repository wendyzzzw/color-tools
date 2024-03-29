function DEab = deltaEab(Lab1, Lab2)

% Lab1 is the test color and Lab2 is the reference.
% This function will use the DE*ab color difference metric.

% Inputs: two 3-by-n matrices of CIELab values (test and reference)
% Return: a 1-by-n matrix of DE*ab color differences.

 Delta_L = Lab1(1,:) - Lab2(1,:);
 Delta_a = Lab1(2,:) - Lab2(2,:);
 Delta_b = Lab1(3,:) - Lab2(3,:);
 
 DEab = sqrt(Delta_L.^2 + Delta_a.^2 + Delta_b.^2);
    

end