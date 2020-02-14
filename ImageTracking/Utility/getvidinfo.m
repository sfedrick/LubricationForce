vid=VideoReader("vids 6:21/Acetal Resin Balls 0.125 inch/test1.mov");
startrectx=1;
startrecty=1;
width=1920;
height=1080;
rect=[startrectx startrecty width height];
for img = 1:1;%vid.NumberOfFrame;
    filename1=strcat('frame',num2str(img),'.jpg');
    filename=['resinframes/',filename1];
    fat = read(vid,img);
    skinny=imcrop(fat,rect);
    grey=rgb2gray(skinny);
    image=grey;
    %imwrite(image,filename,'jpg');
end 

mov=read(vid,[1 100]);
implay(mov);
info=get(vid);
display(info);