
pathlist=["sample rate/1khz/1000hz.is_crelax_RawData","sample rate/100 hz/100hz.is_crelax_RawData","sample rate/10 hz/10hz.is_crelax_RawData"];
frequencies=[1000,100,10];
variancelist=[];
standarddevlist=[];

for p=1:length(pathlist)
    path=pathlist(p);
    files = dir (fullfile(path,'*.csv'));

    L = length (files);
    data=[];
    for i=1:L
      format long
      file=strcat(path,'/',files(i).name);
      fid  = fopen(file);
      set= textscan(fid,'%q%q%q','Delimiter',',','HeaderLines',2);
      fid = fclose(fid);
      set=set(:);
      data=[data,set];
    end
    data=data.';
    ldata=length(data);
    times=[];
    loadn=[];
    timecleans=[];
    loadcleann=[];
    extension=[];
    compression=[];
    tension=[];
    velocity=[];
    for i=1:ldata
    B = data(i,:);
    T=B{1,1};
    E=B{1,2};
    L=B{1,3};
    test="paa50";
    speed=0.1/100;
    lengthB=length(T);
        for new=1:lengthB
            times=[times,str2num(T{new})];
            loadn=[loadn,str2num(L{new})];
            extension=[extension,str2num(E{new})];
        end
    end

 size=length(times);
    mean=0;
    variance=0;
    for i=1:size
        mean=loadn(i)+mean;
    end
    mean=mean/size;
    for i=1:size
     variance=variance+(loadn(i)-mean)^2; 
    end
    standardev=variance^0.5;
    
    
    variancelist=[variancelist,variance];
    standarddevlist=[standarddevlist,standardev];
   display(frequencies(p));


end


