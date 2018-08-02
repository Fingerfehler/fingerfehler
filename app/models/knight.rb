class Knight < Piece

  def get_image
    white? ? '&#9816;' : '&#9822;'
  end

  def valid_move?(x,y)
    return false unless super(x,y)
    y_values(y) == 2 && x_values(x) == 1 ||
    y_values(y) == 1 && x_values(x) == 2 
  end

end