module GamesHelper
  def black_white_cell(x,y)
    (y+x).even? ? "black" : "white"
  end

  def show_piece(piece)
    if piece
      render html: piece.get_image.html_safe
    else
      render html: ''.html_safe
    end

  end
end
