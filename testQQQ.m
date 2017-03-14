function m = testQQQ( n )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

if ~exist('n' , 'var' )
    n = 1;
end

m=0; 

for i = 1 : n
    if ~isSO3(randomQQQ())
        m = m +1;
    end
end




end

