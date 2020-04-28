test="paa50";
folder="Paa50\";

read=strcat('C:\Users\shaun\Programs\Matlab\FluidsData\rheology\',folder,test);
read1=strcat(read,'feb8flow1.csv');
A1 = csvread(read1);
shearrate1=A1(:,1);
shearstress1=A1(:,2);
viscosity1=A1(:,3);
length1=length(shearrate1);

read1=strcat(read,'feb8flow2.csv');
A2 = csvread(read1);
shearrate2=A2(:,1);
shearstress2=A2(:,2);
viscosity2=A2(:,3);
length2=[1:length(shearrate2)];

read1=strcat(read,'feb28flow1.csv');
B1 = csvread(read1);
shearrate1b=B1(:,1);
shearstress1b=B1(:,2);
viscosity1b=B1(:,3);
length1b=length(shearrate1b);

read1=strcat(read,'feb28flow2.csv');
B2 = csvread(read1);
shearrate2b=B2(:,1);
shearstress2b=B2(:,2);
viscosity2b=B2(:,3);
length2b=length(shearrate2b);

read1=strcat(read,'feb8freq.csv');
F1 = csvread(read1);
storage1=F1(:,1);
loss1=F1(:,2);
freq1=F1(:,1);
length1f=length(storage1);

read1=strcat(read,'feb28freq.csv');
F2 = csvread(read1);
storage2=F2(:,1);
loss2=F2(:,2);
freq2=F2(:,1);
length2f=length(storage2);

figure(1)
hold on;
set(gcf,'units','inches','position',[0,0,5,3])
loglog(shearrate1,shearstress1,'-x','DisplayName','Foward advancement 20 days','LineWidth',2);
loglog(shearrate2,shearstress2,'-o','DisplayName','Backward advancement 20 days','LineWidth',2);
loglog(shearrate1b,shearstress1b,'-x','DisplayName','Foward advancement 1 day','LineWidth',2);
loglog(shearrate2b,shearstress2b,'-o','DisplayName','Backward advancement 1 day','LineWidth',2);
xlabel('Shear Rate $Pa$','fontsize',14,'interpreter','latex')
ylabel('Shear Stress $\frac{1}{s}$','fontsize',14,'interpreter','latex')
set(gca,'xscale','log');
set(gca,'yscale','log');
legend('location','best','color','none');
grid on;
hold off;
fig=figure(1);
title=strcat(test," Shear rate vs Shear stress ");
%print(fig,title,'-dpng')


figure(2)
hold on;
set(gcf,'units','inches','position',[0,0,5,3])
loglog(shearrate1,viscosity1,'-x','DisplayName','Foward advancement 20 days','LineWidth',2);
loglog(shearrate2,viscosity2,'-o','DisplayName','Backward advancement 20 days','LineWidth',2);
loglog(shearrate1b,viscosity1b,'-x','DisplayName','Foward advancement 1 day','LineWidth',2);
loglog(shearrate2b,viscosity2b,'-o','DisplayName','Backward advancement 1 day','LineWidth',2);
xlabel('Shear Rate $Pa$','fontsize',14,'interpreter','latex')
ylabel('Viscosity $Pa*s$','fontsize',14,'interpreter','latex')
set(gca,'xscale','log');
set(gca,'yscale','log');
legend('location','best','color','none');
grid on;
hold off;
fig=figure(2);
title=strcat(test," Shear rate vs Viscosity");
%print(fig,title,'-dpng')


figure(3)
hold on;
set(gcf,'units','inches','position',[0,0,5,3])
loglog(freq1,storage1,'r-s','DisplayName','storage modulus 20 days','LineWidth',2);
loglog(freq2,storage2,'r-^','DisplayName','storage modulus 1 day','LineWidth',2);
loglog(freq1,loss1,'b-x','DisplayName','loss modulus 20 days','LineWidth',2);
loglog(freq2,loss2,'b-o','DisplayName','loss modulus 1 day','LineWidth',2);
xlabel('Frequency $\frac{1}{s}$','fontsize',14,'interpreter','latex')
ylabel('Modulus $Pa$','fontsize',14,'interpreter','latex')
set(gca,'xscale','log');
set(gca,'yscale','log');
legend('location','best','color','none');
grid on;
hold off;
fig=figure(3);
title=strcat(test," Freqsweep");
print(fig,title,'-dpng')
