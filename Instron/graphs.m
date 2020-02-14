clear  % clear all old variables from workspace
clf

path="glycerol.is_comp_RawData";
test="glceryol";
speed=0.1/100;
times=[];
extensionmm=[];
loadn=[];
trialtimes=[];
trialextensionmm=[];
trialloadn=[];
    files = dir (fullfile(path,'*.csv'));

    L = length (files);
    data=[];
    for i=1:L
      format long
      display(files(i).name)
      file=strcat(path,'/',files(i).name);
      fid  = fopen(file);
      set= textscan(fid,'%q%q%q%q%q','Delimiter',',','HeaderLines',25);
      fid = fclose(fid);
      set=set(:);
      data=[data,set];
    end
    data=data.';
    ldata=length(data);
   

    for i=1:ldata
    B = data(i,:);
    T=B{1,1};
    E=B{1,2};
    N=B{1,3};
    Tnew=[];
    Enew=[];
    Nnew=[];
    
    lengthB=length(T);
  
        for new=1:lengthB
           
            Tnew=[Tnew,str2double(T{new})];
            Enew=[Enew,str2double(E{new})];
            Nnew=[Nnew,str2double(N{new})];
            times=[times,str2double(T{new})];
            loadn=[loadn,str2double(N{new})];
            extensionmm=[extensionmm,str2double(E{new})];
            
            display("this is how many files are left")
             display(ldata-i)
            display("this is how many lines left:")
            display(lengthB-new)
            
            
           
        end
        Tnew=Tnew(:);
        Enew=Enew(:);
        Nnew=Nnew(:);
        trialtimes=[trialtimes,{Tnew}];
        trialextensionmm=[trialextensionmm,{Enew}];
        trialloadn=[trialloadn,{Nnew}];
    end

 size=length(times);
timecleans=[];
loadcleann=[];
extensioncleanmm=[];
compression=[];
tension=[];
velocity=[];
ncompress=0;
ntension=0;



timecleans=times(1:end);
extensioncleanmm=-extensionmm(1:end);
loadcleann=loadn(1:end);



lengthclean=length(timecleans);

for i=1:lengthclean
  if((timecleans(i)~=0 && extensioncleanmm(i)< 30.0)&& (i~=1 && i~= lengthclean))
      velocity(i)=(extensioncleanmm(i)-extensioncleanmm(i-1))/(timecleans(i)-timecleans(i-1));
      velocity(i)=-velocity(i)/10;
  else
     velocity(i)=0;
     loadcleann(i)=0;
  end 
end 

averagecompress=0;
averagetense=0;
for i=1:lengthclean
  if(velocity(i)>0)
      compression(i)=-extensioncleanmm(i);
      loadcompress(i)=loadcleann(i);
      
      if(-extensioncleanmm(i)<29.5)
        averagecompress=loadcompress(i)+averagecompress;
        ncompress=ncompress+1;
      end
      velocitycompression(i)=velocity(i);
      
  elseif (velocity(i)<0)
      tension(i)=extensioncleanmm(i);
      
      loadtension(i)=loadcleann(i);
      if(extensioncleanmm(i)<29.5)
        averagetense=loadtension(i)+averagetense;
        ntension=ntension+1;
      end 
      velocitytension(i)=velocity(i);
  else
      compression(i)=-extensioncleanmm(i);
      loadcompress(i)=loadcleann(i);
      tension(i)=extensioncleanmm(i);
      loadtension(i)=loadcleann(i);
      velocitycompression(i)=velocity(i);
      velocitytension(i)=velocity(i);
  end 
  
end
averagecompress=averagecompress/ncompress
averagetense=averagetense/ntension
for i=1:length(compression)
    if(velocity(i)~=0)
        loadcompress(i)=(loadcompress(i))/velocitycompression(i);
    else
        loadcompress(i)=0;
    end
end 

for i=1:length(tension)
    if(velocity(i)~=0)
        loadtension(i)=(loadtension(i))/velocitytension(i);
    else
        loadtension(i)=0;
    end
end
a=0.0125;
nt=(averagetense-speed*9.81*(1260-8050))/(6*3.14*a);
nc=(averagecompress-speed*9.81*(1260-8050))/(6*3.14*a);

figure(1)
hold on
plot(tension,loadtension,'o');
fplot(@(x) (6*3.14*nt*a*a*speed)/(30-x))
title('tension '+test)
xlabel('extension(mm)'), ylabel('Load (newtons)')
hold off

figure(2)
hold on
plot(compression,loadcompress,'o');
fplot(@(x) (6*3.14*nc*a*a*speed)/(30-x))
title(test)
xlabel('extension(mm)'), ylabel('Load (newtons)')
xlim([29 31])
ylim([0 100])
hold off

figure(3)
hold on
loglog(tension,loadtension,'o');
fplot(@(x) (6*3.14*nt*a*a*speed)/(30-x))
title('Tension Log Log '+test)
xlabel('extension (mm)'), ylabel('Load (newtons)')
hold off
figure(4)
hold on
loglog(compression,loadcompress,'o');
fplot(@(x) (6*3.14*nc*a*a*speed)/(30-x))
title(test)
xlabel('extension (mm)'), ylabel('Load (newtons)')
xlim([29.5 30.05])
ylim([0.01 100])
hold off
