class King < Piece

  def get_image
    white? ? '&#9812;' : '&#9818;'
  end
  
  def valid_move?(x,y)
    return false unless super(x,y)
    y_values(y) <= 1 &&
    x_values(x) <= 1
  end

end

