function Lab = XYZ2Lab(XYZ, XYZn)

    % inputs: a 3-by-n array of tristimulus values [X;Y;Z] (or XYZ) 
    %         a 3-by-1 vector representing the illuminant whitepoint [Xn;Yn;Zn] or (XYZn),
    % return: a 3-by-n array of CIELab values.
    
    X = XYZ(1,:);
    Y = XYZ(2,:);
    Z = XYZ(3,:);
    
    Xn = XYZn(1,:);
    Yn = XYZn(2,:);
    Zn = XYZn(3,:);
    
    L = 116.*f(Y./Yn)-16;
    a = 500.*(f(X./Xn) - f(Y./Yn));
    b = 200.*(f(Y./Yn) - f(Z./Zn));
    
    Lab = [L;a;b];
    
    
    function f = f(x)
        if x>(6/29)^3
            f = x.^(1/3);
        else
            f = 7.787.*x + 16/116;
        end
    end
    
end