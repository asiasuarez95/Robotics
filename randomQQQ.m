function [rotMatrix a v] = randomQQQ()

 v = rand(3,1);
 a = randi([0 360]);
 rotMatrix = QQQ(v,a);
 
 

end

