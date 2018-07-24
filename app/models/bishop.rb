class Bishop < Piece
  def get_image
    if white?
      '&#9815;'
    else
      '&#9821;'
    end
  end
end
