classdef quaternion
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static = true)
       function sum = add(q, qPrime) 
           aSum = q(1) + qPrime(1);
           bSum = q(2) + qPrime(2);
           c = q(3) + qPrime(3);
           d = q(4) + qPrime(4);
           
           sum = [ aSum bSum c d]; 
       end
       
       function product = mul(q, qPrime)
           a = q(1);
           b = q(2);
           c = q(3);
           d = q(4);
           
           aP = qPrime(1);
           bP = qPrime(2);
           cP = qPrime(3);
           dP = qPrime(4);
           
           productA = (a*aP) - (b*bP) - (c*cP) - (d*dP); 
           productB = (a*bP) + (aP*b) + (c*dP) - (cP*d);
           productC = (a*cP) + (aP*c) - (b*dP) + (bP*d);
           productD = (a*dP) + (aP*d) + (b*cP) - (bP*c);
           
           product = [productA productB productC productD];
              
       end
       
       function conjugate = conj(q)
           a = q(1);
           b = -q(2);
           c = -q(3);
           d = -q(4);
           conjugate =[a b c d];
       end
       
       function normal = norm(q)
           a = q(1);
           b = q(2);
           c = q(3);
           d = q(4);
           normal = sqrt(a^2+ b^2 + c^2 + d^2);  
       end
        
       function inverse = inv(q)
            con = conj(q);
            normal = norm(q);
            
            inverse = con/((normal)^2); 
       end
       
       function answer = div(q,r)
           
           q0 = q(1);
           q1 = q(2);
           q2 = q(3);
           q3 = q(4);
           
           r0 = r(1);
           r1 = r(2);
           r2 = r(3);
           r3 = r(4);
           
           nA = (r0*q0 + r1*q1 + r2*q2 + r3*q3)/ (r0^2 +r1^2 + r2^2 +r3^2);
           nB = (r0*q1 - r1*q0 - r2*q3 + r3*q2)/ (r0^2 +r1^2 + r2^2 +r3^2);
           nC = (r0*q2 + r1*q3 - r2*q0 - r3*q1)/ (r0^2 +r1^2 + r2^2 +r3^2);
           nD = (r0*q3 - r1*q2 + r2*q1 - r3*q0)/ (r0^2 +r1^2 + r2^2 +r3^2);
           
           answer = [nA nB nC nD];
       end
        
       function M = Matrix(q)
            if norm(q) ~=1
%                 return q/N(q)
               a = q(1);
               b = q(2);
               c = q(3);
               d = q(4);
               
               nQ = a^2+ b^2 + c^2 + d^2;
               q = div(q,nQ);
               
            end
            
               a = q(1);
               b = q(2);
               c = q(3);
               d = q(4);
               
               M = 2 * [(.5 - c^2 -d^2) (b*c - a*d) (b*d + a*c);
                        (b*c +a*d) (.5 - b^2-d^2) (c*d -a*b);
                        (b*d -a*c) (c*d + a*b) (.5 - b^2 -c^2)];
       end  
    
       function test ()
            q = [1 -1 1 -1]/2;
            qPrime = [1 1 1 -1]/2;
            
            sum = quaternion.add(q, qPrime)
            product = quaternion.mul(q, qPrime)
            conjugate = quaternion.conj(q)
            normal = quaternion.norm(q)
            inverse = quaternion.inv(q)
            answer = quaternion.div(q,qPrime)
            M = quaternion.Matrix(q)
       end
    end
end

