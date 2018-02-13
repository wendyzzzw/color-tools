function UCS = xyY2UCS(xyY)

    % this function takes a 3-by-n array of chromaticity coordinates [x;y;Y]
    % and converts them to a 3-by-n array of 1976 Uniform Color Scale?s (UCS) coordinates, u', v',and Y.
    
    x = xyY(1,:);
    y = xyY(2,:);
    Y = xyY(3,:);
    
    u = (4.*x) ./ (-2.*x + 12.*y + 3);
    v = (9.*y) ./ (-2.*x + 12.*y + 3);
    
    UCS = [u;v;Y];

end