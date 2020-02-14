function [force] = Lubrication(velocity,viscocity,radius,i,input)
    force=[];
    hi=0;
    hf=0;
    for x=1:length(input)   
 
 
        B=acosh(input(x));
        sum=0; 
        stokes=6*pi*velocity(x)*viscocity*radius;
            for n=1:i
                product=(n*(n+1))/((2*n-1)*(2*n +3));
                numerator=2*sinh((2.0*n+1)*B)+(2.0*n+1)*sinh(2*B);
                denominator=4*((sinh((n+0.5)*B))^2)-((2*n+1)^2)*(sinh(B)^2);
                final=product*((numerator/denominator)-1);
                sum=sum+final;

            end



            lambda=(4/3)*sinh(B)*sum;
            force=[force,lambda];
            %force=[force,lambda];

    end

    
    
end 