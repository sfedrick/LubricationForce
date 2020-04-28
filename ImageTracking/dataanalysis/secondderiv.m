function[dxdt2]=secondderiv(x,dt,order)
    L=size(x);
    dxdt2=[];
    dxdt2=[dxdt2,0];
    for i=2:(L-1)
        if(order==2)
            new=x(i+1)-2*x(i)+x(i-1);
            new=new/(dt^2);
            dxdt2=[dxdt2,new];
        end
    end
    dxdt2=[dxdt2,0];
end
