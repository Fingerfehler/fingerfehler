module GamesHelper
  def black_white_cell(x,y)
    (y+x).even? ? "black" : "white"
  end

  def show_piece(piece)
    render html: piece.get_image.html_safe
  end
end
