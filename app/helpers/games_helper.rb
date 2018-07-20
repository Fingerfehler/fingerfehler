module GamesHelper
  def black_white_cell(x,y)
    (y+x).even? ? "black" : "white"
  end

  def get_piece(pieces,x,y)
    render html: '&#9817;'.html_safe
  end
end
