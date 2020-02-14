% centroid is a touple that tells where the cross is centered on the image
%bound says how long the cross is 
%cross says how thick the cross is 
%center cross is how much of the center of the cross should be colored in

function [imageout] = Cross(centroid,bound,cross,centercross,grey,image)
        [sizey,sizex,trash]=size(image);
        if(grey==1)
            image = cat(3, image, image, image);
        end 
        limitlowx=centroid(1);
        limithighx=centroid(1);


        if(centroid(1)-bound>1 && centroid(1)+bound<sizex)
            limitlowx=centroid(1)-bound;
            limithighx=centroid(1)+bound;
        elseif(centroid(1)-bound>1)
            limitlowx=centroid(1)-bound;
            limithighx=centroid(1);
        elseif(centroid(1)+bound<sizex)
            limithighx=centroid(1)+bound;
            limitlowx=centroid(1);
        end 

        limitlowy=centroid(2);
        limithighy=centroid(2);
        
        

        if(centroid(2)-bound>1 && centroid(2)+bound<sizey)
            limitlowy=centroid(2)-bound;
            limithighy=centroid(2)+bound;
        elseif(centroid(2)-bound>1)
            limitlowy=centroid(2)-bound;
            limithighy=centroid(2);
        elseif(centroid(2)+bound<sizey)
            limithighy=centroid(2)+bound;
            limitlowy=centroid(2);
        end



        
        
         for row=limitlowy:limithighy
            for col=limitlowx:limithighx
                
                colorin=-1;
                if (row > centroid(2)-cross)&& (row < (centroid(2)+cross))||(col > centroid(1)-cross)&& (col < (centroid(1)+cross))
                        colorin=1;
                end 
                
                if(colorin==1)
                    image(int16(row),int16(col),1)=255.0;
                    image(int16(row),int16(col),2)=0.0;
                    image(int16(row),int16(col),3)=0.0;
                    colorin=-1;
                end
                
  
            end
        end
        try
            for row= centroid(2)-centercross:centroid(2)+centercross
                for col=centroid(1)-centercross:centroid(1)+centercross
                    image(int16(row),int16(col),1)=0.0;
                    image(int16(row),int16(col),2)=0.0;
                    image(int16(row),int16(col),3)=255.0;
                end
            end 
        catch
            row=centroid(2);
            col=centroid(1);
            image(int16(row),int16(col),1)=0.0;
            image(int16(row),int16(col),2)=0.0;
            image(int16(row),int16(col),3)=255.0;
        end



        imageout=image;

end