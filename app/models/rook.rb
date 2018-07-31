class Rook < Piece
  def get_image
    if white?
      '&#9814;'
    else
      '&#9820;'
    end
  end

  def valid_move(x,y)
    return false unless super(x,y)
    y - y_coord == 0 ||
    x - x_coord == 0
  end 
  
end
