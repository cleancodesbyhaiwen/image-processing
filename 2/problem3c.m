
% reading in image and reshape it to a vector
I = im2double(imread("cameraman.tif"));
[col,row] = size(I);
I = reshape(I, [col*row, 1]);


figure;
[num,val] = hist(I(:), -0.5:0.025:1.5);
bar(val, num/sum(num), 'FaceColor',[0.2,0.8,0.4]);

% construct noise vector p
p = zeros(col*row,1); 
for i = 1:col*row
    p(i) = normrnd(0,0.1);
end

% output is the original image I plus noise p
output = I + p;

qqplot(p);

figure;
[num,val] = hist(output(:), -0.5:0.025:1.5);
bar(val, num/sum(num), 'FaceColor',[0.2,0.8,0.4]);

% Clipping the output
for i = 1:col*row
    if output(i) < 0
        output(i) = 0;
    end
    if output(i) > 1
        output(i) = 1;
    end
end 

figure;
[num,val] = hist(output(:), -0.5:0.025:1.5);
bar(val, num/sum(num), 'FaceColor',[0.2,0.8,0.4]);

% calculating the residue Clip(Y) - theta
residue = output - I;

figure;
[num,val] = hist(residue(:), -0.5:0.025:1.5);
bar(val, num/sum(num), 'FaceColor',[0.2,0.8,0.4]);



qqplot(residue);