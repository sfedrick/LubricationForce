a=12.5;
h=30-trialextensionmm{1,1};
force=trialloadn{1,1}-averagecompress;
h=h+a;
LAMB=(force*10^5)/(6*pi*950*0.1*1.25*(4/3));
a_h=h/a;
model=Lubrication(0.001,0.95,0.0125,1,a_h);
 model1=Lubrication(0.001,0.95,0.0125,10,a_h);  
model10=Lubrication(0.001,0.95,0.0125,10,a_h);
model100=Lubrication(0.001,0.95,0.0125,100,a_h);

hold on;
 


  scatter(a_h,model1,'^','r')

 


  scatter(a_h,model10,'o','b')
  
  scatter(a_h,model100,'x','g')
  title("Lambda with varying sums")
  xlabel('Distance from bottom (a/h)') 
  ylabel('Lambda)')
 
 xlim([1 1+4*10^(-3)])
    
 hold off;
