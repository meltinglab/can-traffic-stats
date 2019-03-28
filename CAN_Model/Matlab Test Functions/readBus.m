function [EOF, Error, DeStuffedFrame, NextFrame, NextIndex, NextCount, NEXT_JUMP] = readBus(Bus, Enable, Frame, Index, Count, JUMP)

DeStuffedFrame = zeros(111,1);
NextCount = 0;
NextFrame = zeros(111,1);
EOF = 0;
Error = 0;
NextIndex = 1;
NEXT_JUMP = 0;

if Enable == 1
    if Index <= 111
        NextFrame = Frame;
        
        if Index <= 98
            if (Index == 1) || (JUMP == 1)
                NextFrame(Index) = Bus;
                NextIndex = Index + 1;
            else
                if Bus ~= NextFrame(Index - 1)
                    if Count < 4
                        NextFrame(Index) = Bus;
                        NextIndex = Index + 1;
                        NextCount = 0;
                    else
                        NextIndex = Index;
                        NEXT_JUMP = 1;
                        NextCount = 0;
                    end
                else
                    NextCount = Count + 1;
                    if NextCount < 5
                        NextFrame(Index) = Bus;
                        NextIndex = Index + 1;
                    else
                        NextCount = 0;
                        NextIndex = Index;
                        NEXT_JUMP = 1;
                    end
                end
                
            end
            NextFrame(Index) = Bus;
            NextIndex = Index + 1;
        end
    else
        EOF = 1;
        DeStuffedFrame = Frame;
    end
    
end
end

