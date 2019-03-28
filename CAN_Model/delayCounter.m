function [Results]=delayCounter(TxTimings, RxTimings, CLK)
  A = getdatasamples(TxTimings, 200000);
  B = getdatasamples(RxTimings, 200000);
  
  Temp = (B - A) * CLK;
  temp = Temp(2:end);
  for i = 1 : length(temp)
      if temp(i) > 0
          Results(i) = temp(i);
      else
          break;
      end
  end
end


