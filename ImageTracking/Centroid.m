function [center] = Centroid(startx,starty,endx,endy,image)
    xmoment=0;
    ymoment=0;
    area=0;
    for col=startx:endx
        for row=starty:endy
            area=area+single(image(row,col));
            %recall that the length of the moment arm for an x moment is
            %given by the collumn you are on because this describes the
            %distance from the y axis and centroid is total
            %axismoments/area and we get center of mass by scaling each of
            %those moments by a mass and then divide byb total mass so that
            %more massive moments dominate more 
            xmoment=((col+0.5)-startx)*single(image(row,col))+xmoment;
            ymoment=(endy-row+0.5)*single(image(row,col))+ymoment;
            
        end
    end 
    
    xmoment=(xmoment/area)+startx;
    ymoment=endy-(ymoment/area);
    if(xmoment==0|| isnan(xmoment))
        xmoment=1;
    end
    if(ymoment==0 || isnan(ymoment))
        ymoment=1;
    end 
    center=[xmoment,ymoment,area];
end 