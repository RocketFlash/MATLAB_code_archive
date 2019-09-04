% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

%Function for a pretty display field on the screen
function showBoard(board)
      board(board==1) = 'X';
      board(board==-1) = 'O';
      board(board==0) = '-';
      
      curStr = '';
      for i = 1:size(board,1)
          for j =1:size(board,2)
            curStr = strcat(curStr,'|_',char(board(i,j)),'_|');
          end
          disp(curStr);
          curStr='';
      end
end

