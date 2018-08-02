class Rook < Piece

  def get_image
    white? ? '&#9814;' : '&#9820;'
  end

  def valid_move?(x,y)
    return false unless super(x,y)
    y_values(y) == 0 ||
    x_values(x) == 0
  end 


end
