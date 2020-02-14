
function freq = omega(L, dt)
    freq = (0:L-1)./(L*dt);
    half = ceil(L/2);
    neg = -freq(2:half);
    freq(L:-1:L-half+2) = neg;
    
return;
