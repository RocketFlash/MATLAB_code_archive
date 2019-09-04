function serpcarp(n)
if nargin == 0
    n=1;
end
fig=figure(1);
h1 = uicontrol('Style', 'pushbutton', ...
     'Position', [20 0 120 30],...
    'String', 'generate n+1',...
    'Callback', @BtnCall);
h2 = uicontrol('Style', 'pushbutton', ...
     'Position', [150 0 120 30],...
    'String', 'generate n-1',...
    'Callback', @BtnCall);
a=(0.9+1i*0.9);
z=[0;0+1i*imag(a) ; a ; real(a)+1i*0;0];

for i=1:n
    z=[z ; z+i*imag(a) ; z+a ; z+real(a);z]/3;
end
% z=[z,a,0];
patch(real(z),imag(z),[1 0 0.5]);

function BtnCall(src,evt)
    if src==h1
        n=n+1;
    else
        n=n-1;
    end
serpcarp(n);
end

end