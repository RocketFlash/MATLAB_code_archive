% Yagfarov Rauf
% Innopolis University

function TicTacToe()
game;
end

%Simple game function
function game()
clc
player1 = 'ai   ';
player2 = 'human';
isTerminated = false;
currentPlayer = 1;

%some kind of difficult level :)
%deph of the searching
deph = 6;

%select size of the board
selectBoard = 4;
if selectBoard == 3
    board = [0,0,0;...
             0,0,0;...
             0,0,0];
elseif selectBoard == 4
    board = [0,0,0,0;...
             0,0,0,0;...
             0,0,0,0;...
             0,0,0,0];
end
   
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
            board(playTTTT(board,deph,currentPlayer,1)) = currentPlayer;
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
            board(playTTTT(board,deph,currentPlayer,1)) = currentPlayer;
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

%Implementation of minimax algorithm & alpha-beta pruning
function score = miniMax(board,deph,player,alpha,beta,maxPlayer)

[isTerminated, sc] = checkBoard(board);
if isTerminated || deph == 0
    score = sc;
    return;
end

AM = getAvailableMoves(board);
if maxPlayer
    score = - Inf;
    for i = 1:length(AM')
        newBoard = board;
        newBoard(AM(i)) = player;
        s = miniMax(newBoard,deph-1,-player,alpha,beta,false);
        if s > score
            score = s;
        end
        
        alpha = max([alpha score]);
        if beta <= alpha
            break;
        end
    end
else
    score =  Inf;
    for i = 1:length(AM')
        newBoard = board;
        newBoard(AM(i)) = player;
        s = miniMax(newBoard,deph-1,-player,alpha,beta,true);
        if s < score
            score = s;
        end
        
        beta = min([beta score]);
        if beta <= alpha
            break;
        end
    end
end

end

function move = playTTTT(varargin)

numIndices = 2;
%select how many indices you want to use
%for example: 2 indices mean board(i,j)
%             1 index mean board(k)

if nargin==4
    board = varargin{1};
    deph = varargin{2};
    player = varargin{3};
    numIndices = varargin{4};
elseif nargin==2
    board = varargin{1};
    player = varargin{2};
    deph = 6;
end

%convert all 2 to -1 for comfort calculations and manipulations with bord positions 
board(board==2) = -1;

if player==-1
        maxPlay = false;
elseif player==1
        maxPlay = true;
end
% *move is a 2D vector [i j]' where i = row where you decide to play, j = column
% *board is given as a three-by-three matrix containing: 0 = empty position, 1 = X, 2 = O
% *player is whether your agent will play for 1=X or 2=O

%indices of the all possible moves
AM = getAvailableMoves(board);
scores = zeros(1,length(AM));

%evaluation of the ways in a tree
for i = 1:length(AM)
    newBoard = board;
    newBoard(AM(i)) = player;
    if ~maxPlay
        scores(i) = miniMax(newBoard,deph,-player,-Inf,+Inf,true);
    else
        scores(i) = miniMax(newBoard,deph,-player,-Inf,+Inf,false);
    end
end

if ~maxPlay
%if minimazer plays
    [minScore,j] = min(scores);
else
%if maximazer plays
    [maxScore,j] = max(scores);    
end

%if you want to use 1 index of the matrix , you can set numIndices equals
%to 1 , otherwise function will return 2 indices
if numIndices == 1
    move = AM(j);
elseif numIndices == 2
    q1 = rem(AM(j),size(board,1));
    if q1 == 0
        q1 = size(board,1);
    end
    q2 = 1+ ((AM(j) - q1)/size(board,1));
    move = [q1,q2];
end

end

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

%find and return available positions on the board
function k = getAvailableMoves(board)
    k = find(board==0);
end

function [isTerminated,score] = checkBoard(board)
    
    board(board==2) = -1;
    
    isTerminated = false;
    score = 0;
    l = size(board,1);
    k = 20;
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


