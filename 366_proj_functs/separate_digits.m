function d_matrix = separate_digits(signal, space, d_length, d_count)
  % separates digits in signal with known i length, count and spacing
  d_matrix = zeros(d_length, d_count);
  for i=1:1:d_count
      d_matrix(:,i) = signal((i-1)*(1000+space)+1:i*1100-space);
  end