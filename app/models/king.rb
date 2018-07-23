class King < Piece

  def valid_move?(x,y)
    if valid_board_space?(x,y) &&
      (y - y_coord).abs <= 1 &&
      (x - x_coord).abs <= 1
      true
    else 
      false
    end
  end

end