class Rook < Piece

  def get_image
    white? ? '&#9814;' : '&#9820;'
  end

  def valid_move?(x,y)
    super(x,y) &&
    x_offset(x) == 0 || y_offset(y) == 0
  end 

end
