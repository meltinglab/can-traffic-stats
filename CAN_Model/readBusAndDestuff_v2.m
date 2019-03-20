function [endedFrame, next_endedDestuff, frame, buffer, next_index] = readBusAndDestuff(Bus, enable, endedDestuff, frame, buffer, index)
%index è la dimensione corrente del buffer

dimFrame=1; %dimensione corrente del frame che serve solo per il destuffing che viene ripetuto quasi ad ogni clock (per questo non lo retroaziono)
maxStuffing=98;
%maxFrameLength=111;
endedFrame=0; %PER QUANTO DEVE STARE A UNO??
next_endedDestuff=endedDestuff;
consecutivity=0;
i=1;%indice per ciclare nel while
if enable==1
    
    if index<=111 %praticamente sempre
        if next_endedDestuff==0
            buffer(index)=Bus;
            if index>maxStuffing %serve solo per evitare di fare troppi destuff
                while i<index %DESTUFFING (il limite per destuffare è la dimensione del buffer)
                    frame(dimFrame)=buffer(i);
                    if consecutivity==4
                        consecutivity=0;
                        
                        %now i can control errors that occur if the bit cancelled is
                        %equal to the previous (errors are collected in a counter)
                        if frame(i)==frame(i+1)
                            Error=Error+1;
                        end
                        i=i+1;
                    else
                        if frame(i)==frame(i+1)
                            consecutivity=consecutivity+1;
                        else
                            consecutivity=0;
                        end
                    end
                    
                    dimFrame=dimFrame+1;
                    if dimFrame>=maxStuffing
                        next_endedDestuff=1;
                    end
                end
            end
        else %if next_endedDestuff!=0
            if next_endedDestuff<=13 %sto facendo append sul frame perché ho già finito il destuff
                frame(maxStuffing+next_endedDestuff)=Bus;
                if next_endedDestuff==13
                    endedFrame=1;
                end
                next_endedDestuff=next_endedDestuff+1;
            end
        end
        
        next_index=index+1;
    else
        next_index=1;
    end
    
else %enable==0 quindi resetto le variabili
    next_index=1;
    next_endedDestuff=0;
end
end