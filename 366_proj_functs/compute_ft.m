function ft_matrix = compute_ft(signal_matrix, N)
  % matrix format: [ signal1 signal2 ...] with any # of rows
  ft_matrix = zeros(N, size(signal_matrix,2));
  for i = 1:1:size(signal_matrix,2)
      ft_matrix(:,i) = fftshift(fft(signal_matrix(:,i), N));
  end
  