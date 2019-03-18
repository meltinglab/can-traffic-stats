function [C, LEN_C] = vectorAppend(A, LEN_A, B, LEN_B)

C = zeros(135,1);

for i = 1 : LEN_A
    C(i) = A(i);
end

for i = 1 : LEN_B
    C(LEN_A + i) = B(i);
end

LEN_C = LEN_A + LEN_B;
end
