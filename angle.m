function theta = angle( M )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    x = M(3,2) - M(2,3);
    y = M(1,3) - M(3,1);
    z = M(2,1) - M(1,2);

    v = [x y z];

    r = norm(v); 

    t = M(1,1) + M(2,2) + M(3,3);

    theta = atan2d(r,(t-1));

    if theta < - 90 && theta > -181
        theta = theta + 180;
    elseif theta <0 &&  theta > -91
        theta = theta +360;

    elseif theta > -1 && theta < 181
        theta = theta; 
    end 

    u = v/norm(v);
    if u(1) < 0
        theta = 360-theta;
    end

end

