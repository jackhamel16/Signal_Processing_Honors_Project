function digit_ft_matrix = separate2ft_digits(signal_unpadded,N)
  i_start = find(signal_unpadded, 1, 'first');
  i_end = find(signal_unpadded, 1, 'last');
  digit_ft_matrix = zeros(N,7);
  signal = [signal_unpadded(i_start:i_end) 1]; %1 is added for catching
  digit_start = 1;                             %final digit in signal
  digit_end = 0;
  zero_count = 0;
  digit_count = 1;
  for i = 1:size(signal,2)
      if signal(i) ~= 0 
          if (i > 1 && signal(i-1) == 0 && zero_count > 99) ||...
                  i == size(signal,2)
              %checks if at start of new digit or end of signal
              digit_ft_matrix(:,digit_count) = ...
                  fftshift(fft(signal(digit_start:digit_end),N));
              digit_start = i;
              digit_end = i;
              zero_count = 0;
              digit_count = digit_count + 1;
              continue;
          end
          digit_end = digit_end + 1;
      end
      if signal(i) == 0
          zero_count = zero_count + 1;
      end
  end
end