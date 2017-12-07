function phone = ttdecode(signal_ft_matrix)
  es_density = abs(signal_ft_matrix).^2;
  row_freq = [0.6535 0.5906 0.5346 0.7217];
  col_freq = [0.9273 1.0247 1.1328];
  row_index = freq2index(row_freq,2048);
  col_index = freq2index(col_freq,2048);
  digit_matrix = [7 8 9; 4 5 6; 1 2 3; 0 0 0];
  phone = zeros(1,7);
  for i = 1:size(es_density,2)
      digit = es_density(:,i);
      digit_coord = [0 0];
      for row_i = 1:1:size(row_index,2)
          if abs(digit(row_index(row_i))) > 500 
              digit_coord(1) = row_i;
          end
      end
      for col_i = 1:1:size(col_index,2)
          if abs(digit(col_index(col_i))) > 500
              digit_coord(2) = col_i;
          end
      end
      phone(i) = digit_matrix(digit_coord(1), digit_coord(2));
  end
end