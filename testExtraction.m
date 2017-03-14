function [ max_err_theta max_err_u ] = testExtraction( n )

    if ~exist('n' , 'var' )
         n = 1;
    end;

    max_err_theta =0;
    max_err_u =0; 
   
%     
%     thetaR = 0;
%     thetaP = 0;

    for i = 1 : n

        u = rand(3,1);
        u = u / norm(u);
        theta = randi([0 360]);
        M = QQQ(u,theta);

        thetaPrime = angle(M);
        uPrime = axis(M);
        

        thetaErr = abs(thetaPrime - theta);
        if thetaErr > 180
            thetaErr= 360 - thetaErr;
        end
        if thetaErr > max_err_theta 
            max_err_theta = thetaErr;
            thetaR = theta;
            thetaP = thetaPrime;
            
        end

        uErr = norm((uPrime - u),inf);
        if uErr > max_err_u
            max_err_u = uErr;
            vr = u;
            vu = uPrime;
        end
    end

disp(string('max_err_theta = ')+ max_err_theta);
disp(string('max_err_u = ') + max_err_u);

 disp(string('theta = ') + thetaR);
 disp(string('thetaPrime = ') + thetaP);
 
  disp(string('u = ') + vr);
 disp(string('uPrime = ') + vu);
% 
% U=transpose(u);
% U
% uPrime
% 
% theta
% thetaPrime
% 
% M




end

