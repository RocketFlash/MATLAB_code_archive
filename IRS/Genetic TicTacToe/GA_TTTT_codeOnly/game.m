% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

%Simple game function
function game()
clc
player1 = 'ai   ';
player2 = 'human';
isTerminated = false;
currentPlayer = 1;

load('agents_20.mat')
NN = [2 10];

%some kind of difficult level :)
%deph of the searching
deph = 10;

%select size of the board
selectBoard = 4;
board = zeros(selectBoard,selectBoard);

   
sc = 0;     

while ~isTerminated
    if currentPlayer == 1
        disp('player1 moves');
        if player1 == 'human'
            prompt = 'Your turn:';
            ok = false;
            while ~ok
                x = input(prompt);
                if board(x)==0
                    ok =true;
                else
                    warning('Wrong move! Please try again');
                end
            end
            board(x) = currentPlayer;
            currentPlayer = -currentPlayer;
        else
            inx = makeMove(agents(20,:,:),board,NN);
            board(inx(1),inx(2)) = currentPlayer; 
            currentPlayer = -currentPlayer;
        end
    else
        disp('player2 moves');
        if player2 == 'human'
            prompt = 'Your turn:';
            ok = false;
            while ~ok
                x = input(prompt);
                if board(x)==0
                    ok =true;
                else
                    warning('Wrong move! Please try again');
                end
            end
            board(x) = currentPlayer;
            currentPlayer = -currentPlayer;
        else
            q = playTTTT(board,deph,currentPlayer,2);
            board(q(1),q(2)) = currentPlayer;
            currentPlayer = -currentPlayer;
        end
    end
    showBoard(board);
    [isTerminated, sc] = checkBoard(board);
end

    if sc == 0
            disp('It is a draw');
    elseif sc > 0
            disp('X wins');
    elseif sc < 0
            disp('O wins');
    end

end

% function to display the board
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

% function for heuristic evaluation
function [isTerminated,score] = checkBoard(board)
    
    board(board==2) = -1;
    
    isTerminated = false;
    score = 0;
    l = size(board,1);
    k = 500;
    zz = length(find(board));
     
    for i=1:size(board,1)
        if sum(board(i,:),2)==-l
            isTerminated = true;
            score = -k+zz;
            return;
        end
        
        if sum(board(i,:),2)==l
            isTerminated = true;
            score = k-zz;
            return;
        end
    end
    
    for i=1:size(board,1)
        if sum(board(:,i),1)==-l
            isTerminated = true;
            score = -k+zz;
            return;
        end
        
        if sum(board(:,i),1)==l
            isTerminated = true;
            score = k-zz;
            return;
        end
    end

    if trace(board)==-l
           isTerminated = true;
           score = -k+zz;
           return;
    end
    
    if trace(board)==l
           isTerminated = true;
           score = k-zz;
           return;
    end
    
    if trace(fliplr(board))==-l
           isTerminated = true;
           score = -k+zz;
           return;
    end
    
    if trace(fliplr(board))==l
           isTerminated = true;
           score = k-zz;
           return;
    end
       
    if all(all(board))
        isTerminated = true;
    end
    
end



