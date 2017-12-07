function index = freq2index(freq,N)
  % converts freq to corresponding index in shifted fft
  index = floor((freq+pi)*N/(2*pi)+1);
end