class King < Piece

  def valid_move?(x,y)
    y > y_coord + 1 || y < y_coord - 1 || x > x_coord + 1 || x < x_coord - 1 ? false : true
  end

end
