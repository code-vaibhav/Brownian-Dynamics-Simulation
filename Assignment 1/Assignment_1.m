
% Definitions %

r = 10^-5;
d_l = 1000;
d_s = 8050;
vis = 10^-3;
g = 9.8;
t = linspace(0,0.001,1000);

% Analytical Plot %

calc = @(t) 2*(r.^2)*g*(d_s - d_l)*(1-exp(-9*vis*t/(2*(r.^2)*d_s)))/(9*vis);
u1 = calc(t);

% Numerical Plot %

u2 = zeros(1, 1000);
for i=2:1:1000
    u2(i) = u2(i-1) + 10.^-6*(g - d_l*g/d_s - 9*vis*u2(i-1)/(2*(r.^2)*d_s));
end

plot(t, u1);
xlabel('Time');
ylabel('Velocity');
title('Plot of Velocity versus time');
hold on
plot(t, u2, '--', 'Color', [0.8500 0.3250 0.0980]);
hold off


