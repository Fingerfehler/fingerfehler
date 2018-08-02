class Queen < Piece

  def get_image
    white? ? '&#9813;' : '&#9819;'
  end

  def valid_move?(x,y)
    return false unless super(x,y)
      # Diagonal
    y_values(y) == x_values(x) ||
      # Horizontal & Vertical
    y_values(y) == 0 || x_values(x) == 0
  end  

end
