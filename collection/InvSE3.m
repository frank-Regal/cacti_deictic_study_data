function [T_inv] = InvSE3(T)
    
    pos = T(1:3,4);
    rot = T(1:3,1:3);
    T_inv = [rot' -rot'*pos;
             0, 0, 0, 1];
end

