% Definitions %

delta_t = 0.001;
size = 100/delta_t;

t = zeros(size, 1);
x = zeros(size, 1);
y = zeros(size, 1);
z = zeros(size, 1);
msd = zeros(1, 10/delta_t, 1);
t_range = linspace(0.001,10,10000);

for i = 1:100/delta_t-1
    n = 2*rand(3,1) - 1;
    x(i+1) = x(i) + (6/delta_t).^0.5*n(1)*delta_t;
    y(i+1) = y(i) + (6/delta_t).^0.5*n(2)*delta_t;
    z(i+1) = z(i) + (6/delta_t).^0.5*n(3)*delta_t;
end

for i = 1:10/delta_t
    sum = 0;
    count = 0;
    for j = i:1:10/delta_t
        sum = sum + (x(j) - x(j-i+1)).^2 + (y(j) - y(j-i+1)).^2 + (z(j) - z(j-i+1)).^2;
        count = count + 1;
    end
    msd(1, i) = sum/count;
end

p = polyfit(t_range(1, 40), msd(1, 40), 1);
diffusivity = p(2);

fileID = fopen("output.txt", 'w');
fprintf(fileID, '%s %s', 'Diffusivity', diffusivity);
fprintf(fileID, '%s %s %s %s\r\n', 't', 'x', 'y', 'z');
for i = 1:100/delta_t
    fprintf(fileID, '%d %d %d %d\n', 0.001*i, x(i), y(i), z(i));
end

%Plotting%

tiledlayout(2, 1);

nexttile
plot(x, y);
xlabel('x*');
ylabel('y*');
title('Plot of Y versus X');

nexttile
plot(t_range, msd);
xlabel('delta t');
ylabel('MSD');
title('Plot of MSD verses T');