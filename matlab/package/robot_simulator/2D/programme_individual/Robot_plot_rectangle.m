function handle = Robot_plot_rectangle(p1x,p1y,p2x,p2y)

%%
% ---------- p2
% |          |
% |          |
%p1 ---------
%%
p1.x = p1x;p1.y = p1y;p2.x = p2x;p2.y = p2y;
%%
handle = plot([p1.x p2.x p2.x p1.x p1.x],[p1.y p1.y p2.y p2.y p1.y],'k-','linewidth',2);
