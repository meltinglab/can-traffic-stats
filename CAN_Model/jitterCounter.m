function [Results]=jitterCounter(TxTimings, CLK)
  A = diff(getdatasamples(TxTimings, 200000)) * CLK;
  
  for i = 1 : length(A)
      if A(i) > 0
          Results(i) = A(i);
      else
          break;
      end
  end
end