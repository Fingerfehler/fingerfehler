class King < Piece

  def get_image
    if white?
      '&#9812;'
    else
      '&#9818;'
    end
  end
  
  def valid_move?(x,y)
    (y - y_coord).abs <= 1 &&
    (x - x_coord).abs <= 1
  end  

end

