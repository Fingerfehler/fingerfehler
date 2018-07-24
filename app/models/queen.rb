class Queen < Piece
  def get_image
    if white?
      '&#9813;'
    else
      '&#9819;'
    end
  end
end
