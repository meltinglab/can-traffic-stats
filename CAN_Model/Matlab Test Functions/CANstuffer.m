function [stuffed_frame, stuffed_frame_length] = CANstuffer(frame)

NumOfZeros = 0;
NumOfOnes = 0;
NumOfStuffedBits = 0;

stuffed_frame = zeros(135,1);

for i = 1 : length(frame)
    if frame(i) == 0
        NumOfZeros = NumOfZeros + 1;
        NumOfOnes = 0;
    else
        NumOfOnes = NumOfOnes + 1;
        NumOfZeros = 0;
    end
    
    if NumOfZeros == 5
        NumOfZeros = 0;
        NumOfOnes = NumOfOnes + 1;
        
        %Appending the stuffed ONE
        stuffed_frame(i + NumOfStuffedBits) = frame(i);
        NumOfStuffedBits = NumOfStuffedBits + 1;
        stuffed_frame(i + NumOfStuffedBits) = 1;
        
    elseif NumOfOnes == 5
        NumOfOnes = 0;
        NumOfZeros = NumOfZeros + 1;
        
        %Appending the stuffed ZERO
        stuffed_frame(i + NumOfStuffedBits) = frame(i);
        NumOfStuffedBits = NumOfStuffedBits + 1;
        stuffed_frame(i + NumOfStuffedBits) = 0;
        
    else
        stuffed_frame(i + NumOfStuffedBits) = frame(i); 
    end
end
stuffed_frame_length = length(frame) + NumOfStuffedBits;
end
