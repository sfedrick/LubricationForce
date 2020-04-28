clear  % clear all old variables from workspace
clf
%read in stress relaxation data 
B=csvread('C:\Users\shaun\Programs\Matlab\FluidsData\rheology\Paa50\paa50feb8stress.csv');
stress=B(:,1);
displacement=B(:,2);
time=B(:,3);
start=0;
found=false;

for i=2:(size(displacement)-1)
    diff=stress(i)-stress(i-1);
    if(diff>0)
        if(~found)
            found=true;
            start=i+1;
        end
    end 
    if(stress(i)<0)
        stress(i)=-stress(i);
    end
end
weights=abs(gradient(stress)./gradient(time));
sample=length(stress)*0.05;
sample=double(int16(sample));
if(mod(sample,2)==0)
    sample=sample-1;
end
weights=sgolayfilt(weights,3,sample);
finish=0;
found=false;
ground=0;
diffmax=0;

for i=start:(size(displacement))
    diff=abs(weights(i)/stress(i));
    weights(i)=diff;
end
max=weights(1);
count=0;
for i=start:(size(displacement))
    normalweight=weights(i)/max;
    if(normalweight<(1/max))
        count=count+1;
        if(~found)
            found=true;
            finish=i;
            ground=stress(i);
        end
        if(found)
            break;
        end
    
    end 
  
end

stress=stress(start:finish)-ground;
weights=weights(start:finish);
time=time(start:finish);
weights=abs(weights);


stresssmooth=smooth(stress,0.01);
    hold on;
    scatter(time,weights);
    xlabel('time(s)')
    ylabel('stress')
    hold off;


