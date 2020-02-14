
marker=['o','+','*','.','.','s','d','^','v','>'];
color=['r','b','g','g','m','y','k','r','b','g'];
 a=0.0125;
a1=a/1000;
speed=1;

for i=1:length(trialloadn)
    distance=30-trialextensionmm{1,i};
    force=trialloadn{1,i}-averagecompress;
    h=distance+a;
    a_h=h/a;
figure(2)
hold on
scatter(a_h,force,color(i),marker(i))
xlim([0 30])
ylim([-0.3 100])
title('Glycerol')
xlabel('Distance from bottom (mm)') 
ylabel('Force (newtons)')
end




hold off;




