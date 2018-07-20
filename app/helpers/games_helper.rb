module GamesHelper
  def black_white_cell(x,y)
    (y+x).even? ? "white" : "black"
  end
end
