function xyY = XYZ2xyY(XYZ)

    % tristimulus to CC

    X = XYZ(1,:);
    Y = XYZ(2,:);
    Z = XYZ(3,:);
    
    x = X./(X+Y+Z);
    y = Y./(X+Y+Z);
    
    xyY = [x;y;Y];

end