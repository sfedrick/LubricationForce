clear;
load('C:\Users\shaun\Programs\Matlab\FluidsData\Graphs_And_Figures\Image\Graphs\imagedata.mat');
test="paa50ss0.3filterDay15c21";
%set ss to 10 or 5 for a frame length of 5 radius movements or 10 radius
%movements

ss=1;
order=3;
starti=1;
Frames=paa200frame(starti:end);
distance=paa200cm(starti:end);
time=paa200secs(starti:end);
vel=gradient(distance(:)) ./ gradient(Frames(:));
maxvel=0;
radius=0.33;
fps=25;

for i=starti:(length(Frames))
    if(vel(i)>maxvel )
        maxvel=vel(i);
    end
end 


error=[];
errort=0;
hcheck=0;
start=false;
streak=0;
for i=starti:(length(distance))
    if(~start)
        if(hcheck< distance(i) && streak<(length(distance)*0.01))
            hcheck=distance(i);
        elseif(streak>(size(distance)*0.01))
            start=true;
            errort=i+1;
        else
            hcheck=distance(i);
            streak=streak+1;
        end
    else
        error=[error;distance(i)]; 
    end
    
    if(vel(i)>maxvel)
        maxvel=vel(i);
    end
end 
minerror=10^10;
maxerror=0;
for i=starti:(length(error))
    if(error(i)<minerror)
        minerror=error(i);
    elseif(error(i)>maxerror)
        maxerror=error(i);
    end
end
percenterror=(maxerror-minerror)/maxerror;  


frames=radius/maxvel;
frames=double(int16(frames*ss));
if(frames==0)
    frames=1;
elseif(mod(frames,2)==0)
    frames=frames-1; 
end
Y = fft(error);
L=length(error);
P2 = abs(Y/L);
P1 = P2(1:double(int16(L/2))+1);
P1(2:end-1) = 2*P1(2:end-1);
Fs=25;
f =Fs*(0:(double(int16(L/2))))/L;

cmsmooth=sgolayfilt(distance,order,frames);
ground=0;
for i=starti:(length(Frames))
   if(cmsmooth(i)>ground)
       disp(i)
       ground= cmsmooth(i);
   end
end

distance=ground-distance;
cmsmooth=ground-cmsmooth;
ground=ground+radius;
ah=radius./(ground-distance);
ahsmooth=radius./(ground-cmsmooth);% distance of center from the bottom
dydx = gradient(cmsmooth(:)) ./ gradient(time(:));
dydxsmooth=sgolayfilt(dydx,order,frames);
dydx2 = gradient(dydxsmooth(:)) ./ gradient(time(:));
dydx2smooth=sgolayfilt(dydx2,order,frames);
errorx=[];
errordydx=[];
errordydx2=[];
for i=1:size(dydx)
   ex=percenterror*ahsmooth(i);
   edx=((2^(0.5))*percenterror*dydx(i))/(1/fps);
   edx2=((4)*(percenterror*dydx2(i))^2)/((1/fps)^3);
   errorx=[errorx;ex];
   errordydx=[errordydx;edx];
   errordydx2=[errordydx2;edx2];
end 

  
    
hold on;

figure(1)
set(gcf,'units','inches','position',[0,0,5,3])
e1=errorbar(ah,dydx2,errordydx2');
e1.LineWidth=1;
xlim([0 1]);
xlabel('Gap size $\frac{a}{h}$','fontsize',14,'interpreter','latex')
ylabel('Acceleration $\frac{cm}{s^2}$','fontsize',14,'interpreter','latex')
grid on;
hold off;
fig=figure(1);
title=strcat(test," Acceleration versuses gap size");
print(fig,title,'-dpng')


hold on;
figure(2)
set(gcf,'units','inches','position',[0,0,5,3])
grid on;
plot(time(errort:end),error,'LineWidth',1);
xlabel('Time $S$ ','fontsize',14,'interpreter','latex')
ylabel('Position $cm$','fontsize',14,'interpreter','latex')
hold off;
fig=figure(2);
title=strcat(test,"position after ball has reversed");
print(fig,title,'-dpng')
hold on;

figure(3)
set(gcf,'units','inches','position',[0,0,5,3])
plot(f,P1,'LineWidth',1)
grid on;
xlabel('f (Hz)')
ylabel('|P1(f)|')
set(gca,'yscale','log');
ylim([0 10^2])
xlim([0 14])
hold off;

fig=figure(3);
title=strcat(test,"fourier of reversed ball noise");
print(fig,title,'-dpng')


hold on;
figure(4)
set(gcf,'units','inches','position',[0,0,5,3])
grid on;
xlabel('Time $S$','fontsize',14,'interpreter','latex'); hold on;
ylabel('Distance $cm$/ Velocity $\frac{cm}{s}$ /Acceleration $\frac{cm}{s^2}$','fontsize',10,'interpreter','latex');hold on;
scatter(time,distance,'displayname','unsmoothed distance');
e1=errorbar(time,dydx2smooth,errordydx2,'displayname','Acceleration');
e1.LineWidth=1;
hold on;
scatter(time,dydx,'displayname','unsmoothed velocity');
e2=errorbar(time,dydxsmooth,errordydx,'displayname','Velocity');
e2.LineWidth=1;
hold on;
scatter(time,dydx2,'displayname','unsmoothed acceleration');

e3=errorbar(time,cmsmooth,errorx,'displayname','Distance');
e3.LineWidth=1;
hold on;
legend('location','best','color','none','fontsize',8);
xlim([3 7])
ylim([-3,3])
hold off;
fig=figure(4);
title=strcat(test,"VAD");
print(fig,title,'-dpng')