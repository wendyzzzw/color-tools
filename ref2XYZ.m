function XYZ = ref2XYZ (refFactor, CIEfunc, SPD)

    k = 100 / dot(SPD.' , CIEfunc(:,2));
    
    X = k * mtimes((CIEfunc(:,1).') , refFactor.*SPD);
    Y = k * mtimes((CIEfunc(:,2).') , refFactor.*SPD);
    Z = k * mtimes((CIEfunc(:,3).') , refFactor.*SPD);
    
    XYZ = [X;Y;Z];

%     XYZ = k .* CIEfunc .* refFactor.*SPD;
    
    
end