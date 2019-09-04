

%echoudp('on',4012)
u = udp('localhost',4012);


fopen(u)
% Write to the host and read from the host.

fwrite(u,'hello')
A = fread(u,10);
% Stop the echo server and disconnect the UDP object from the host.

echoudp('off')
fclose(u)