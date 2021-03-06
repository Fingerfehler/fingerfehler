class Piece < ApplicationRecord
  belongs_to :game
  after_initialize {
    self.move_count = 0 if self.move_count.nil?
  }
  
  def move_to!(x,y)
    return unless valid_move?(x, y)
    if piece_to_capture = game.pieces.find_by(x_coord: x, y_coord: y)
      if piece_to_capture.white? == self.white?
        return false
      else
        piece_to_capture.capture!
        self.update_coords!(x,y)
      end
    else 
      self.update_coords!(x,y)
      self.move_count += 1
      take_turn!
    end
  end

  def take_turn!
    #super
    self.game.turn += 1
  end

  def black?
    !white?
  end

  def x_offset(x)
    (x - self.x_coord).abs
  end

  def y_offset(y)
    (y - self.y_coord).abs
  end 

  def capture!
    self.update_attributes(x_coord: 8, y_coord: 8, captured?: true)
    self.save
  end

  def update_coords!(x,y)
    self.update_attributes(x_coord: x, y_coord: y)
    self.save
  end

  def piece_on_square(x,y)
    found_piece = game.pieces.find_by(x_coord: x, y_coord: y)
  end

  def opponent_on_square?(x,y)
    piece_on_square(x,y).nil? ? false : piece_on_square(x,y).white? != self.white?
  end

  def valid_move?(x, y)
    (0..7).include?(x) &&
    (0..7).include?(y)
  end

  def current_pieces_coords 
    self.game.pieces.map { |piece| [piece.x_coord, piece.y_coord] }
  end

  def square_is_occupied?(x, y)
    current_pieces_coords.any? {|n| n == [x,y]}
  end


  def square_is_vacant?(x, y)
    !square_is_occupied?(x, y)
  end

  def is_unobstructed?(x,y)
    !is_obstructed?(x,y)
  end

  def is_obstructed?(x, y)
    if x_coord == x && y_coord != y
      is_vertically_obstructed?(x, y)
    elsif x_coord != x && y_coord == y
      is_horizontally_obstructed?(x, y)
    elsif (x_coord - x).abs == (y_coord - y).abs && x_coord != x && y_coord != y
      is_diagonally_obstructed?(x, y)
    else
        # Maybe raise? used return for my tests
      return 'invalid input square'   
    end
  end

  def x_range(x,y) 
    x_range = []
    if x_coord < x
      (x_coord+1..x-1).each { |n| x_range << n }   
    else
      (x+1..x_coord-1).each { |n| x_range << n }   
      x_range = x_range.reverse               
    end
  end

  def y_range(x,y) 
    y_range = []      #!!! need to refactor without using array, also diagonally #Brandon
    if y_coord < y
      (y_coord+1..y-1).each { |n| y_range << n }   
    else
      (y+1..y_coord-1).each { |n| y_range << n }   
      y_range = y_range.reverse                    
    end
  end

  def is_vertically_obstructed?(x, y) 
    y_range(x,y).each do |y|           
      if current_pieces_coords.any? {|n| n == [x,y]}
        return true
      end
    end
    return false                            
  end

  def is_horizontally_obstructed?(x, y) 
    x_range(x,y).each do |x|          
      if current_pieces_coords.any? {|n| n == [x,y]}
        return true
      end
    end
    return false                                                         
  end 

  def is_diagonally_obstructed?(x, y)  
    duplicates = x_range(x,y).zip(y_range(x,y)) & current_pieces_coords    # Creates a variable storing any common coords in both arrays
    if duplicates.empty?                                                   # If empty returns false, It's not obstructed
      return false
    else 
      return true
    end
  end

  def has_moved?
    move_count != 0
  end

  def has_not_moved?
    !self.has_moved?
  end

end
