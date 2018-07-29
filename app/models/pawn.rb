class Pawn < Piece

  def get_image
    white? ? '&#9817;' : '&#9823;'
  end

  def valid_move?(x,y)
    super(x,y) && (valid_one_forward_move?(x,y) || valid_two_forward_move?(x,y) || valid_standard_capture?(x,y))
  end

  def valid_one_forward_move?(x,y)
    square_is_vacant?(x,y) && (x == x_coord) && (y == y_coord + self.movement_direction)
  end

  def valid_two_forward_move?(x,y)
    square_is_vacant?(x,y) && (x == x_coord) && (y == y_coord + (self.movement_direction * 2)) && has_not_moved?
  end

  def valid_standard_capture?(x,y)
    (x - x_coord).abs == 1 && (y == y_coord + self.movement_direction) && opponent_on_square?(x,y)
  end

  def movement_direction
    white? ? 1 : -1
  end

end
