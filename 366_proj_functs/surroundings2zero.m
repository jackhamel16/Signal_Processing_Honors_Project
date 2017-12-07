function filter = surroundings2zero(filter,pnt_x,pnt_y);
  for x = 1:3
      for y = 1:3
          filter(pnt_x+x-2, pnt_y+y-2) = 0;
      end
  end
end