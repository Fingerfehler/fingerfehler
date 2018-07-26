class Knight < Piece

  def get_image
    if white?
      '&#9816;'
    else
      '&#9822;'
    end
  end

  def valid_move?(x,y)
    return false unless super(x,y)
    (y - y_coord).abs == 2 && (x - x_coord).abs == 1 ||
    (y - y_coord).abs == 1 && (x - x_coord).abs == 2 
  end

end