class Knight < Piece
  def get_image
    if white?
      '&#9816;'
    else
      '&#9822;'
    end
  end
end
