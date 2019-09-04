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

