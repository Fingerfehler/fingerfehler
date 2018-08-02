class Bishop < Piece

  def get_image
    white? ? '&#9815;' : '&#9821;'
  end

  def valid_move?(x,y)
    return false unless super(x,y)
    y_values(y) == x_values(x)
  end

end
