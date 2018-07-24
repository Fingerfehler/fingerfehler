class Pawn < Piece

  def get_image
    if white?
      '&#9817;'
    else
      '&#9823;'
    end
  end
end
