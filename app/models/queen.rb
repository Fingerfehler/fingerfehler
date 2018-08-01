class Queen < Piece

  def get_image
    if white?
      '&#9813;'
    else
      '&#9819;'
    end
  end

  def valid_move?(x,y)
    return false unless super(x,y)
      # Diagonal
    (y - y_coord).abs == (x - x_coord).abs ||
      # Horizontal & Vertical
    (y - y_coord).abs == 0 || (x - x_coord).abs == 0
  end  

end
