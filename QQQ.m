function Qu = QQQ( v, a )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

u = v / norm(v);

Qu = [0 -u(3) u(2); u(3) 0 -u(1); -u(2) u(1) 0];
Qu = Qu * sind(a);

I = [1 0 0; 0 1 0; 0 0 1];
ut = transpose(u);
Qu = Qu + ( I - u * ut) * cosd(a) + u * ut;


end

