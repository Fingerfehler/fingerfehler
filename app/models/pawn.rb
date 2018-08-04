class Pawn < Piece

  def get_image
    white? ? '&#9817;' : '&#9823;'
  end

  def valid_move?(x,y)
    return false unless super(x,y)
    return false unless valid_white_move?(x,y) || valid_black_move?(x,y)
    valid_single_move?(x,y) || valid_first_move?(x,y) || valid_standard_capture?(x,y)
  end

  def valid_single_move?(x,y)
    x_values(x) == 0 && 
    y_values(y) == 1
  end

  def valid_first_move?(x,y)
    move_count == 0 && 
    x_values(x) == 0 && 
    y_values(y) <= 2
  end

  def valid_standard_capture?(x,y)
    opponent_on_square?(x,y) &&
    x_values(x) == 1 && 
    y_values(y) == 1  
  end

  def valid_white_move?(x,y)
    self.white? && (y - y_coord) > 0
  end

  def valid_black_move?(x,y)
    !self.white? && (y - y_coord) < 0
  end

  def en_passant_capturable?(x,y)
    # Needs to answer false if not turn after (piece_on_square(x,y)) just moved.
    opponent_on_square?(x,y) &&
    piece_on_square(x,y).move_count == 1 &&
    x_values(x) == 1 && 
    y_values(y) == 0    
  end

end
