function BS = stuff(ID)

% ID = [0 0 0 0 0  1 1 1 1 1 1];

if ID(1) == 0
    num0 = 1;
else
    num1 = 1;
end

for i = 2:length(ID)
    if ID(i) == 0 && ID(i-1) == 0
        num0 = num0+1;
        num1 = 0;
    end
    if ID(i) == 0 && ID(i-1) == 1
        num0 = 1;
    end
    if ID(i) == 1 && ID(i-1) == 1
        num1 = num1+1;
        num0 = 0;
    end
    if ID(i) == 1 && ID(i-1) == 0
        num1 = 1;
    end
    if num0 == 5
        ID = [ID(1:i) 1 ID(i+1:end)];
        num0 = 0;
    end
    if num1 == 5
        ID = [ID(1:i) 0 ID(i+1:end)];
        num1 = 0;
    end
end

BS = ID;

end