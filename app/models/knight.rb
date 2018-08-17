class Knight < Piece

  def get_image
    white? ? '&#9816;' : '&#9822;'
  end

  def valid_move?(x,y)
    super(x,y) && 
    x_offset(x) == 1 && y_offset(y) == 2 || 
    x_offset(x) == 2 && y_offset(y) == 1  
  end

end