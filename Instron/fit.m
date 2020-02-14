filename="glcerolmathmatica.csv";
a=12.5;
h=29.96-trialextensionmm{1,1};
m=0.022;
force=trialloadn{1,1}-averagecompress-0.014;
lowerlimit=30043;
force=force(1:lowerlimit);
forceaverage=force;
forcedev=zeros(1,lowerlimit);
n=1;
for i=2:n
    
new=trialloadn{1,i}-averagecompress-0.014;
new=new(1:lowerlimit);
forceaverage=forceaverage+new;
clear new;
end

forceaverage=forceaverage/n;
clear force;
for i=1:n
    
new=trialloadn{1,i};
new=new(1:lowerlimit);
new=new-forceaverage;
new=new.^2;
forcedev=new+forcedev;
clear new;
end
forcedev=forcedev*(1/(n-1));
forcedev=forcedev.^(0.5);

forcedev=forcedev*(1/(n^0.5));
force=forceaverage;

velocity=velocity(1:length(h));
h=h+a;
LAMB=[];
a_h=h/a;

for i=1:length(h)
   if(velocity(i)~=0)
        new=(force(i)*10^5)/((1/560)*6*pi*950*velocity(i)*1.25*(4/3));
   else 
       new=0;
   end
   LAMB=[LAMB,new]; 
end

    
matrix=[a_h(:),force(:)];
csvwrite(filename,matrix)


model=Lubrication(velocity,950,a,100,a_h);
size=length(model)-10;
start=0;
found=false;
for i=1:size
    if (a_h(i)>=1&& found==false)
        start=i;
        found=true;
    end 
end 
model=model(start:size);
LAMB=LAMB(start:size);
a_h=a_h(start:size);
force=force(start:size);


hold on
scatter(a_h,LAMB,'r','.');
scatter(a_h,model,'b','x');
title('Glycerol')
xlabel('Distance from bottom (h/a)') 
ylabel('Lambda)')
xlim([1,1.007])
ylim([0,5000])
hold off




meanmodel=0;
meandata=0;
 variancedata=0;
 variancemodel=0;
for i=start:size
   meandata=(force(i))+meandata;
   meanmodel=real(model(i))+meanmodel;
   
end
meandata=meandata/length(model);
meanmodel=meanmodel/length(model);
ssres=0;
sstot=0;
for i=start:size
 
    ssres=ssres+((LAMB(i)-real(model(i))))^2;
    sstot=sstot+((LAMB(i)-real(meanmodel)))^2;
end

R=1-(ssres/sstot);