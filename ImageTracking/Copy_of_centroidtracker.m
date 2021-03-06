%{
This can take in an unclean video but you need a few things
1. You need to know where in the video you want to crop in
2. You need the Frame rate of the vid
    a. from this you get the frame to second conversion
3. you need the pixel to centimeter conversion open up a single frame using
getvidinfo to find this information
4. You set the filter to calm down noise from the derivative calculations
look up sgolayfilt the third term in the array turns off the filter if it's
not set to 1
5.look at the aproximate area of the particle to take out anything larger
than it
6. look at the aproximate radius to take out anything smaller than the ball
7.play with 5 and 6 until all the artifacts are gone
8. set how big the centroid window should be 
9. set the threshhold that will turn a pixel to either black or white you
will base this one the most intense pixel in the gray scaled image use vid
info to find the most intense pixel if it's under intensity it's black over it's white.
10.set how big the cross drawn on the ball is keep it smaller than the
width of the video cross automatically checks that it doesn't draw off the
screen though
 YOU GOOD TO GO AFTER THIS

%}


viable=1;
imagein='C:\Users\shaun\Programs\Matlab\Thesis\ImageTracking\paa100\';
fileout='C:\Users\shaun\Programs\Matlab\FluidsData\Videos\Running\tedsaysimtrash.avi';
Frames='C:\Users\shaun\Programs\Matlab\FluidsData\Videos\Running\Frames\';
frameoriginal='C:\Users\shaun\Programs\Matlab\FluidsData\Videos\Running\Original Frames\';
pixexcm=0.008328;
framesecs=0.04;
myVideo = VideoWriter(fileout,'Uncompressed AVI');
test= "Ceramic Ball FrameLength 101 polynomial order 3";
write=1;
graphme=1;
filterstrength=[3 101 1];
filterstrengthrate=[3 101 1];
filterstrengthrate2=[3 101 1];
%says if the video is already cropped -1=no 1=yes
crop=-1;  
% shows a video of the original video inputted for parameter checking -1=no
% 1=yes show file in and to show file out
show=-1;

start=250;
stop=835;
%creat a cropping rectangle that starts from the point with width and
%height specified
startrectx=300;
startrecty=1;
width=170;
height=1080;
rect=[startrectx startrecty width height];
%set the frame rate of the output video should be the same as the frame
%rate of the original or very comparable to get real time 
%less to slow down
% higher to speed up
myVideo.FrameRate = 25;  
%area of tracked particle in pixels
area=8000;
% size of the radius of the tracked particle in pixels underestimate
radius=50;


%centroid window
window=150;

%intensity threshhold
intensethreshhold=150;

open(myVideo);


docross=1;
%thickness of the cross 
cross=2;
centercross=1;
%the bound when drawing the centroid onto the video how long each arm of
%the cross is 
bound=20;

frame=[0];
height=[0];
for img = start:stop
    filename1=strcat('Image',num2str(img),'.tif');
    location=strcat(imagein,filename1);
    filename=[Frames,filename1];
    try
        fat = imread(location);
        viable=img;
    catch 
        display(strcat('Image number  ',num2str(img),'  Did not show up'));
         filename1=strcat('Image',num2str(viable),'.tif');
         location=strcat(imagein,filename1);
         filename=[Frames,filename1];
         fat = imread(location);
    end
    
    if (crop==-1)
        skinny=imcrop(fat,rect);
        grey=imcomplement(skinny);
        image=grey;
        startx=1;
        starty=1;
        [sizey,sizex,trash]=size(image);

        heightchecker=0;
        streak=0;
        maxstreak=0;
        
        for i=1:size(image,1)

            for j = 1:size(image,2)

                if abs(image(i,j)) >= intensethreshhold
                    streak=streak+1;
                    if(streak>maxstreak)
                        maxstreak=streak;
                        heightchecker=i;
                    end 
                    image(i,j) = 255.0;

                else
                    streak=0;
                    image(i,j)= 0.0;
                end
            end
        end

    

        

        if(heightchecker-window>1 && heightchecker+window<sizey-1)
            centroid=Centroid(1,heightchecker-window,sizex-1,heightchecker+window,image);
        elseif(heightchecker-window>1)
            centroid=Centroid(1,heightchecker-window,sizex-1,sizey-1,image);
        elseif(heightchecker+150<sizey-1)
            centroid=Centroid(1,1,sizex-1,heightchecker+window,image);
        else
             centroid=Centroid(1,1,sizey-1,sizex-1,image);
        end    

        frame=[frame;img];
        height=[height;double(centroid(2))];
        
        original = skinny;
        if(docross==1)
            image=Cross(centroid,bound,cross,centercross,1,image);
            image=double(image);
            original=Cross(centroid,bound,cross,centercross,0,original);
        end
    end 
    %
    %{
    
    to transfer the cross to a larger image you have to do:
    [largesizey,largesizex,trash]=size(largerimage);
    
    [smallsizey,smallsizex,trash]=size(smallimage);
    %assuming you took the centroid of the smaller image
    newcentroidx=(largesizex-smallsizex)+centroid(1);
    newcentroidy=(largesizey-smallsizey)+centroid(2);
    centroid=[newcentroidx,newcentroidy];
    
    I think this works but it hasn't been tested 
    %}
    if(write==1)
        imwrite(image,filename,'tif');
        filename1=strcat('frame',num2str(img),'.tif');
        filename=[frameoriginal,filename1];
        imwrite(original,filename,'tif');
        writeVideo(myVideo, original);
    end
    
end 

close(myVideo);
if show==1
    implay(filein);
    implay(fileout);
end 

if(graphme==1)   
    frame=frame-start;
    figure(1)
    hold on;
    scatter(frame,height)
    xlim([0,max(frame)])
    if(filterstrength(3)==1)
        smoothheight=sgolayfilt(height,filterstrength(1),filterstrength(2));
        plot(frame,smoothheight)
        title('Test '+ test+ ' Ball falling in fluid')
        xlabel('Frame'), ylabel('Pixel')
          
    end
    
    
    title('Test '+ test+ ' Ball falling in fluid')
    xlabel('Frame'), ylabel('Pixel')
    pause;
    hold off;
    
    
    
    
    secs=frame*framesecs;
    cm=height*pixexcm;
    
    figure(2)
    scatter(secs,cm),
    xlim([0,max(secs)])
    hold on;
    if(filterstrength(3)==1)
        cmsmooth=sgolayfilt(cm,filterstrength(1),filterstrength(2));
        plot(secs,cmsmooth)
          
    end
    
    
    
    
    title('Test '+ test+ ' Ball falling in fluid')
    xlabel('Time (Seconds)'), ylabel('Distance Fallen (centimeters)')
    pause;
    hold off;
    
    figure(3)
    dydx = gradient(cmsmooth(:)) ./ gradient(secs(:));
    %dydx=t2deriv_jd(cm);
    scatter(secs,dydx),
    xlim([0,max(secs)])
    hold on
    if(filterstrengthrate(3)==1)
        dydxsmooth=sgolayfilt(dydx,filterstrengthrate(1),filterstrengthrate(2));
        plot(secs,dydxsmooth),
       
    
    end
     title('Test '+ test+ ' Ball falling in fluid velocity')
        xlabel('Time (Seconds)'), ylabel('Velocity (centimeters/seconds)')
     pause;
     hold off;
    
     
    figure(4)
    dydx2=gradient(dydxsmooth(:)) ./gradient(secs(:));
    %dydx2=t2deriv_jd(dydx);
    scatter(secs,dydx2),
    xlim([0,max(secs)])
    hold on;
    if(filterstrengthrate2(3)==1)
        dydx2smooth=sgolayfilt(dydx2,filterstrengthrate2(1),filterstrengthrate2(2));
        plot(secs,dydx2smooth),
    end
    title('Test '+ test+ ' Ball falling in fluid Acceleration')
    xlabel('Time (Seconds)'), ylabel('Acceleration(centimeters/seconds^2)')
    pause;
    hold off;
    
    figure(5)
    dydx2=gradient(dydxsmooth(:)) ./gradient(secs(:));
    %dydx2=t2deriv_jd(dydx);
    scatter(cm,dydx2),
    xlim([0,max(cm)])
    hold on;
    if(filterstrengthrate2(3)==1)
        dydx2smooth=sgolayfilt(dydx2,filterstrengthrate2(1),filterstrengthrate2(2));
        plot(cmsmooth,dydx2smooth),
    end
    title('Test '+ test+ ' Ball falling in fluid Acceleration')
    xlabel('Centimeters'), ylabel('Acceleration(centimeters/seconds^2)')
    pause;
    hold off;
   
end

