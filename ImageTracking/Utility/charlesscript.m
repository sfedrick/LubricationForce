vid=VideoReader("tests/3.2 mm ball 2.75 in cylinder/greytest1.avi");
myVideo = VideoWriter('testy.avi','Uncompressed AVI');

start=1;
stop=vid.NumberOfFrame;
position=920;
rect=[position 0 100 850];
myVideo.FrameRate = 25;  
%{vid.NumberOfFrame
%}
open(myVideo);

previous=read(vid,start);

%skinny=imcrop(fat,rect);
previous=rgb2gray(previous);
writeVideo(myVideo, previous);
frame=[start];
start=start+1;
position=[0];
travel=[0];
distance=0;
for img = start:1:stop
    filename1=strcat('frame',num2str(img),'.jpg');
    
    filename=['Frames3/',filename1];
    %fat = read(vid,img);
    %skinny=imcrop(fat,rect);
    grey=rgb2gray(read(vid,img));
    % take grey and previous into function hear and append to a vector
    result=Fourier(grey,previous,-1,-1, img);
    
    
    
    
    distance=distance+result(2);
    %travel=[travel;result(1)];
     display(result);
    position=[position;distance];
    frame=[frame;img];
    %imwrite(grey,filename,'jpg');
    
    previous=grey;
end 
cleanframe=frame(10:size(frame));
cleanposition=position(10:size(position));

cleanposition= sgolayfilt(cleanposition,3,5);
plot(cleanframe,cleanposition);
title( ' Ball falling in fluid order 3 filter 5 framelength')
xlabel('Frame'), ylabel('Pixel')
pause;

cleanposition= sgolayfilt(cleanposition,3,11);
plot(cleanframe,cleanposition);
title( ' Ball falling in fluid order 3 filter 11 framelength')
xlabel('Frame'), ylabel('Pixel')
pause;
secs=cleanframe*0.04;
cm=(cleanposition+200)*0.005 ;


plot(secs,cm);
title( ' Ball falling in fluid order 3 filter 11 framelength')
xlabel('seconds'), ylabel('centimeters fallen')



dydx = gradient(cm(:)) ./ gradient(secs(:));
dydx=sgolayfilt(dydx,3,11);
hold on;
plot(secs,dydx),
title( ' Ball falling in fluid velocity')
xlabel('Time (Seconds)'), ylabel('Velocity (centimeters/seconds)')
hold off;
pause;


dydx2=gradient(dydx(:)) ./gradient(secs(:));
dydx2=sgolayfilt(dydx2,3,11);
plot(secs,dydx2),
title(' Ball falling in fluid acceleration')
xlabel('Time (Seconds)'), ylabel('Acceleration (centimeters/(seconds*seconds))')
pause;

close(myVideo);
%{
mov=read(vid,[start stop]);
implay(mov);
info=get(vid);display(info);
%}
    
