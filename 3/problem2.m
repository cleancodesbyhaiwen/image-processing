



theta = logspace(0,3,1000);
var = zeros(1000,1);


for i = 1:1000
    Y = poissrnd(theta(i),500);
    for j = 1:500
        for k = 1:500
            mean = sum(sum(Y))/250000;
            var(i) = var(i) + (Y(j,k) - mean).^2;
            
        end
    end
    var(i) = var(i)/250000;
end

fplot(var,theta);

