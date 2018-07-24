class King < Piece

  def get_image
    if white?
      '&#9812;'
    else
      '&#9818;'
    end
  end
  
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

