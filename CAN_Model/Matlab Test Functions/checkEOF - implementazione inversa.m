%controllo se il frame è arrivato a fine trasmissione
%res=0 se non lo è
%res=1 se ho ricevuto 11 uni
%res=2 se ho ricevuto 7 zeri
%index è l'indice del frame partendo dala sua lunghezza
function res = checkEOF(frame, index) 
    consecutive_ones=1;
    consecutive_zeros=1;
    res=0;
    for i = 1 : index-1
        if frame(i)==frame(i+1)
            if frame(i)==1
                consecutive_ones=consecutive_ones+1;
            end
            if frame(i)==0
                consecutive_zeros=consecutive_zeros+1;
            end
        end
        if frame(i)~=frame(i+1)
            consecutive_ones=1;
            consecutive_zeros=1;
        end
        
        if consecutive_ones==11
            res=1;
            break;
        end
        if consecutive_zeros==7
            res=2;
            break;
        end

        
    end
end


