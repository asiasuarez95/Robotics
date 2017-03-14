function u = axis( M )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Find u
x = M(3,2) - M(2,3);
y = M(1,3) - M(3,1);
z = M(2,1) - M(1,2);

v = [x; y; z];
u = v/norm(v);
a = angle(M); 

if a > 180 
    u= -u;
end


 
end

