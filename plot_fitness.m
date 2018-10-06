[x,y]=meshgrid(0:0.01:1,0:0.01:1);
z=(x.^2).*1-(y.^0.5).*1;
meshz(x,y,z);
xlabel('\epsilon','LineWidth',3,'EdgeColor',[1 1 1],'FontWeight','bold',...
    'FontAngle','italic',...
    'FontSize',16);
zlabel('\varsigma','FontWeight','bold','FontAngle','italic','FontSize',16);

% Create ylabel
ylabel('\theta','FontWeight','bold','FontAngle','italic','FontSize',16);
title('Waterfall plot of the Node architecture','fontsize',16)