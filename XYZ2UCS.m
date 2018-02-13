function UCS = XYZ2UCS(XYZ)

    % this function takes a 3-by-n array of tristimulus values [X;Y;Z]
    % and converts them to a 3-by-n array of 1976 Uniform Color Scale?s (UCS) coordinates, u', v',and Y.	
    
    X = XYZ(1,:);
    Y = XYZ(2,:);
    Z = XYZ(3,:);
    
    u = (4.*X) ./ (X + 15.*Y + 3.*Z);
    v = (9.*Y) ./ (X + 15.*Y + 3.*Z);
    
    UCS = [u;v;Y];
    
end