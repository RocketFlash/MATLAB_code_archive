% Yagfarov Rauf
% Mamakov Timur
% Innopolis University

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

