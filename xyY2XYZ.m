function XYZ = xyY2XYZ (xyY)

    % CC to tristimulus
    
    x = xyY(1,:);
    y = xyY(2,:);
    Y = xyY(3,:);
    
    X = x./y.*Y;
    Z = (1-x-y)./y.*Y;
    
    XYZ = [X;Y;Z];
    

end