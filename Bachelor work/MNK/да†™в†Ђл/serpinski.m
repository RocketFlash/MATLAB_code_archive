function serpinski(n)
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
a=(1+1i)/2;
z=[0 1];

for i=1:n
    z=[z , z+a , z+1]/2;
end

patch(real(z),imag(z),[1 0.3 0]);
z=[z,a,0];
function BtnCall(src,evt)
    if src==h1
        n=n+1;
    else
        n=n-1;
    end
serpinski(n);
end

end