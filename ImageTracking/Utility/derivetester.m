
axis=(0:1000);
range=length(axis);
axis=axis*0.001;
for i=1:range
    
  vecx2(i)= sin(100*(2*pi*i*0.001));
   expected(i)=2*pi*100*cos(50*(2*pi*i*0.001));
    % vecx2(i)= axis(i)*axis(i);
     
end 


vecderiv=t2deriv_jd(axis,vecx2,0.001);

 
%vecderiv2=vecderiv;
%vecderiv=t2deriv_jd(vecx2,axis);

figure(1)
plot(axis,vecx2);
pause;

figure(2)
plot(axis,vecderiv);
hold on;
plot(axis,expected,'r');
hold off;


figure(3)
dydx = gradient(vecx2(:)) ./ gradient(axis(:));
dydx2=gradient(dydx)./gradient(axis(:)*0.001);
plot(axis,dydx);
hold on;
plot(axis,expected,'r');
hold off;
pause;


