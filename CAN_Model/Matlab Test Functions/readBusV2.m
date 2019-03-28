function [EOF, Error, DeStuffedFrame, NextFrame, NextIndex, NextCount] = readBusV2(Bus, Enable, Frame, Index, Count)

DeStuffedFrame = zeros(111,1);
NextCount = 0;
NextFrame = zeros(111,1);
EOF = 0;
Error = 0;
NextIndex = 1;

if Enable == 1
    if Index <= 111
        NextFrame = Frame;
        if Index <= 98
            if Index == 1
                NextFrame(Index) = Bus;
                NextIndex = Index + 1;
            else
                
                if Count == 4
                    NextIndex = Index;
                    NextCount = 0;
                else
                    NextFrame(Index) = Bus;
                    NextIndex = Index + 1;
                    if Bus == NextFrame(Index - 1)
                        NextCount = Count + 1;
                    else
                        NextCount = 0;
                    end   
                end    
            end
        else
            NextFrame(Index) = Bus;
            NextIndex = Index + 1;
        end
    else
        EOF = 1;
        DeStuffedFrame = Frame;
    end
end
end
    
