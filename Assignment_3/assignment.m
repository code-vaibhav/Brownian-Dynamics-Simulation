% Definitions of values
v = 500;
delta_t = 0.01;
size = 10000000;
r_end = zeros(size+1, 1);
r1 = zeros(size+1, 3);
r2 = zeros(size+1, 3);
r1(1,:) = [0, 0, 0];
r2(1,:) = [sqrt(v), 0, 0];
sum = 0;

for i=1:1:size
    r = r2(i,:) - r1(i,:);
    r_end(i, 1) = sqrt(r(1)^2 + r(2)^2 + r(3)^2);
    sum = sum + r_end(i, 1)^2;
    r_cap = r_end(i, 1) / v;
    n1 = 2*rand(1,3) - 1;
    n1 = n1/sqrt(n1(1)^2+n1(2)^2+n1(3)^2);
    n2 = 2*rand(1,3) - 1;
    n2 = n2/sqrt(n2(1)^2+n2(2)^2+n2(3)^2);
    r1(i+1,:) = r1(i,:) + ((6/delta_t)^0.5*n1 + (3-r_cap^2)/(v*(1-r_cap^2))*r)*delta_t;
    r2(i+1,:) = r2(i,:) + ((6/delta_t)^0.5*n2 - (3-r_cap^2)/(v*(1-r_cap^2))*r)*delta_t;
end
r = r1(size+1,:) - r2(size+1,:);
r_end(size+1, 1) = sqrt(r(1)^2 + r(2)^2 + r(3)^2);
sum = sum + r_end(size+1, 1)^2;
rms_r = sqrt(sum/(size+1)); 

% to write output file
fileID = fopen("output.txt", 'w');
fprintf(fileID, '%s %s\n', 'R_end', 't*');
for i = 0:1:size
    fprintf(fileID, '%d %d\n', delta_t*i, r_end(i+1));
end

%Plotting%

plot(0:1:size, r_end);
xlabel('t*');
ylabel('Rend');
title('Plot of Rend versus t*');

hold on
plot(0:1:size, repelem(rms_r, size+1));
hold off