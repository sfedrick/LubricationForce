%{ this is all in centroid tracker but it plots the a video that has been cleaned by video script    %}

clear;
vid=VideoReader("greytest3.avi");
frame=[0];
height=[0];
test="3";
for img = 1:vid.NumberOfFrame;
    frame=[frame;img];
    image = read(vid,img);
    grey=image(:,:,1);
    [row,col] = size(grey);
    intense=0;
    newHeight=0;
    for i = 1:row
        for j =1:col
            temp=grey(i,j,1);
            if(temp>intense && temp>150)
                intense=temp;
                newHeight=i;
            end 
          
        end 
    end
    if(intense<150)
       newHeight=0;
    end
    height=[height;newHeight];
end 

height=sgolayfilt(height,3,11);
hold on;
plot(frame,height),
title('Test '+ test+ ' Ball falling in fluid')
xlabel('Frame'), ylabel('Pixel')
hold off;
pause;
secs=frame*0.04;
cm=height*0.005;
plot(secs,cm),
title('Test '+ test+ ' Ball falling in fluid')
xlabel('Time (Seconds)'), ylabel('Distance Fallen (centimeters)')
pause;

dydx = gradient(cm(:)) ./ gradient(secs(:));
dydx=sgolayfilt(dydx,3,11);
hold on;
plot(secs,dydx),
title('Test '+ test+ ' Ball falling in fluid velocity')
xlabel('Time (Seconds)'), ylabel('Velocity (centimeters/seconds)')
hold off;
pause;


dydx2=gradient(dydx(:)) ./gradient(secs(:));
dydx2=sgolayfilt(dydx2,3,11);
plot(secs,dydx2),
title('Test '+ test+ ' Ball falling in fluid acceleration')
xlabel('Time (Seconds)'), ylabel('Acceleration (centimeters/(seconds*seconds))')
pause;


plot(cm,dydx2),
title('Test '+ test+ ' Ball falling in fluid acceleration')
xlabel('Distance Fallen (centimeters)'), ylabel('Acceleration (centimeters/(seconds*seconds))')
pause;

