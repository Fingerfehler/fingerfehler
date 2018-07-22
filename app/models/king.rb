class King < Piece

  def valid_move?(x,y)
    y > y_coord + 1 || y < y_coord - 1 || x > x_coord + 1 || x < x_coord - 1 || x < 0 || x > 7 || y < 0 || y > 7 ? false : true
  end

end


