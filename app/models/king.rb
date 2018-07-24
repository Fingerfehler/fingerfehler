class King < Piece

  def get_image
    if white?
      '&#9812;'
    else
      '&#9818;'
    end
  end
end
