class Bishop < Piece

  def get_image
    white? ? '&#9815;' : '&#9821;'
  end

  def valid_move?(x,y)
    is_unobstructed?(x,y) &&
    super(x,y) &&
    x_offset(x) == y_offset(y)
  end

end
