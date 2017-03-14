function result = isSO3( M, err )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if ~exist('err' , 'var' )
%     0.0000000000000001
     err = .0000000001;
     
%      0.0000000000000005;
end

final = transpose(M) * M;
I = [1 0 0; 0 1 0; 0 0 1];

E = final - I;

difference = norm(E, inf);

if difference > err
    result = false;
else
    result = true;




end

