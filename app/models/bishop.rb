class Bishop < Piece

  def get_image
    if white?
      '&#9815;'
    else
      '&#9821;'
    end
  end

  def valid_move?(x,y)
    return false unless super(x,y)
    (y - y_coord).abs == (x - x_coord).abs
  end

end
