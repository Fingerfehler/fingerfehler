class Pawn < Piece

  def get_image
    white? ? '&#9817;' : '&#9823;'
  end

  def valid_move?(x,y)
    is_unobstructed?(x,y)
    return false unless super(x,y)
    return false unless valid_white_move?(x,y) || valid_black_move?(x,y)
    valid_single_move?(x,y) || valid_first_move?(x,y) || valid_standard_capture?(x,y)
  end

  def valid_single_move?(x,y)
    x_offset(x) == 0 && y_offset(y) == 1
  end

  def valid_first_move?(x,y)
    move_count == 0 && 
    x_offset(x) == 0 && y_offset(y) <= 2
  end

  def valid_standard_capture?(x,y)
    opponent_on_square?(x,y) &&
    x_offset(x) == 1 && y_offset(y) == 1  
  end

  def valid_white_move?(x,y)
    white? && (y - y_coord) > 0
  end

  def valid_black_move?(x,y)
    !white? && (y - y_coord) < 0
  end

  def can_capture_en_passant?(x,y)
    # Needs to answer false if not turn after (piece_on_square(x,y)) just moved.
    opponent_on_square?(x,y) &&
    piece_on_square(x,y).move_count == 1 &&
    x_offset(x) == 1 && y_offset(y) == 0    
  end

  def next_turn_en_passant?
    
  end

end
