function [dimDestuffedFrame, DestuffedFrame, Error] = DeStuffer_fixedLength(enable, frame)
    %max stuffing is the limit for the real destuffing
    %(resulting dimension of the destuffed part), the rest is just in
    %append (in Can frame we stuf the first 98 bits)
    maxStuffing=98;
    maxFrameLength=111;
    Error=0;
    consecutivity=0;
%     consecutive_ones=1;
%     consecutive_zeros=1;
    DestuffedFrame=zeros(maxFrameLength, 1);
    dimDestuffedFrame=1;
    i=1;
if enable == 1    
    while dimDestuffedFrame<maxStuffing
        DestuffedFrame(dimDestuffedFrame)=frame(i);
        dimDestuffedFrame=dimDestuffedFrame+1;
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
        i=i+1;
    end
    
    while dimDestuffedFrame <= maxFrameLength
        DestuffedFrame(dimDestuffedFrame)=frame(i);
        dimDestuffedFrame=dimDestuffedFrame+1;
        i=i+1;
    end
    dimDestuffedFrame=dimDestuffedFrame-1;
%         while i < maxFrameLength 
%             DestuffedFrame(dimDestuffedFrame)=frame(i);
%             dimDestuffedFrame=dimDestuffedFrame+1;
%             if frame(i)==frame(i+1)
%                 if frame(i)==1
%                     consecutive_ones=consecutive_ones+1;
%                 end
%                 if frame(i)==0
%                     consecutive_zeros=consecutive_zeros+1;
%                 end
%             end
%             if frame(i)~=frame(i+1)
%                 consecutive_ones=1;
%                 consecutive_zeros=1;
%             end
% 
%             if consecutive_ones==11 || consecutive_zeros==7
%                 break;
%             end
%             i=i+1;
%         end
end

end