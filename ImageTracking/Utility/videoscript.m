
%{Crops video and cuts the frames to the frames you care about
%}
vid=VideoReader("vids/test3.mov");
myVideo = VideoWriter('greytest3.avi','Uncompressed AVI');

start=180;
stop=250;
position=920;
myVideo.FrameRate = 25;  
%{vid.NumberOfFrame
%}
open(myVideo);
for img = start:stop;
    filename1=strcat('frame',num2str(img),'.jpg');
    filename=['Frames3/',filename1];
    rect=[position 0 100 850];
    fat = read(vid,img);
    skinny=imcrop(fat,rect);
    grey=rgb2gray(skinny);
    background1 = imopen(grey,strel('disk',30));
    imwrite(grey,filename,'jpg');
    writeVideo(myVideo, grey);
end 
close(myVideo);
mov=read(vid,[start stop]);
implay(mov);
info=get(vid);display(info);