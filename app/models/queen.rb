class Queen < Piece

  def get_image
    white? ? '&#9813;' : '&#9819;'
  end

  def valid_move?(x,y)
    return unless is_unobstructed?(x,y)
    super(x,y) &&
    x_offset(x) == y_offset(y) ||
    x_offset(x) == 0 || y_offset(y) == 0 
  end  

end
