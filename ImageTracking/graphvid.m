function [vid]=graphvid(x,y,filepath,startframe)
L=length(x);
myVideo = VideoWriter('tedwouldalsocallmetrash.avi','Uncompressed AVI');

open(myVideo);
    for i= startframe:L

        independent=x(1:i);
        dependent=y(1:i);
        figure(1)
        
        scatter(independent,dependent);
        hold on;
        plot(independent,dependent);
        xlim([0 220])
        ylim([0 10])
        title('Test Acetal Resin Ball falling in fluid')
        xlabel('Time (Seconds)'), ylabel('Distance Fallen (centimeters)')
        hold off;
        filename=strcat('graphframe',num2str(i),'.tif');
        F = getframe(gcf);
        [graphvidimage, Map] = frame2im(F);
        saveas(figure(1),[filepath filename]);
        writeVideo(myVideo, graphvidimage);
    end 
 
close(myVideo);

vid=(myVideo);
end 