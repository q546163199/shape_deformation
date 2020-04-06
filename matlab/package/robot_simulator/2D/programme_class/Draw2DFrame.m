function Draw2DFrame(q, p2, s, lw)

% s: scale factor
% lw: line width
x = p2.x;
y = p2.y;
plot(x, y);

k = 1;
x(2) = x(1) + s*cos(sum(q));
y(2) = y(1) + s*sin(sum(q));
plot(x, y, 'r', 'LineWidth', lw);
text(x(2),y(2),'x','fontsize',15)

k = 2;
x(2) = x(1) - s*sin(sum(q));
y(2) = y(1) + s*cos(sum(q));
plot(x, y, 'g', 'LineWidth', lw);
text(x(2),y(2), 'y','fontsize',15)
hold off
