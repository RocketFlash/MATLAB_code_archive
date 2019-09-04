%returns position,velocity and acceleration points for all joints
function Q = PVA(J,disc)
%    q1|# # # ... #|
%    q2|# # # ... #|
%    q3|# # # ... #|
%    V1|# # # ... #|
%Q = V2|# # # ... #|
%    V3|# # # ... #|
%    A1|# # # ... #|
%    A2|# # # ... #|
%    A3|# # # ... #|
step = 1/disc;
Q = zeros(3*size(J,1),size(J,2));
Q(1:size(J,1),:) = cumsum(J,2)*step; 
Q(size(J,1)+1:2*size(J,1),:) = J;
Q(2*size(J,1)+1:3*size(J,1),1) = 0;
Q(2*size(J,1)+1:3*size(J,1),2:size(J,2)) = (J(:,2:size(J,2)) - J(:,1:size(J,2)-1))/step;
end

