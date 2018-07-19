class Piece < ApplicationRecord
  belongs_to :game

  def current_pieces_coords
    current_pieces_coords = []
    self.game.pieces.map { |piece| current_pieces_coords << [piece.x_coord, piece.y_coord] }
    return current_pieces_coords
  end

  def is_obstructed?(x, y)
    if x_coord == x && y_coord != y
      is_vertically_obstructed?(x, y)
    elsif x_coord != x && y_coord == y
      is_horizontally_obstructed?(x, y)
    elsif (x_coord - x).abs == (y_coord - y).abs && x_coord != x && y_coord != y
      is_diagonally_obstructed?(x, y)
    else
      return 'invalid input square'   # Maybe raise? used return for my tests
    end
  end

  def is_vertically_obstructed?(x, y) 
    y_range = []
    if y_coord < y
      (y_coord+1..y-1).each { |n| y_range << n }   # If statement catches if numbers go high to low
    else
      (y+1..y_coord-1).each { |n| y_range << n }   # Range doesn't work backwards
      y_range = y_range.reverse               # This line reverses it back to the correct order
    end

    coords_to_check = []
    y_range.each do |y|           #creates the array of coords between points
      coords_to_check << [x,y]    
    end
    duplicates = coords_to_check & current_pieces_coords    # Creates a variable storing any common coords in both arrays
    if duplicates.empty?                                    # If empty returns false, It's not obstructed
      return false
    else 
      return true
    end                             
  end

  def is_horizontally_obstructed?(x, y) 
    x_range = []
    if x_coord < x
      (x_coord+1..x-1).each { |n| x_range << n }   
    else
      (x+1..x_coord-1).each { |n| x_range << n }   
      x_range = x_range.reverse               
    end

    coords_to_check = []
    x_range.each do |x|           
      coords_to_check << [x,y]    
    end
    duplicates = coords_to_check & current_pieces_coords    
    if duplicates.empty?                                    
      return false
    else 
      return true
    end                             
  end 


  def is_diagonally_obstructed?(x, y)
    x_range = []
    if x_coord < x
      (x_coord+1..x-1).each { |n| x_range << n }   
    else
      (x+1..x_coord-1).each { |n| x_range << n }   
      x_range = x_range.reverse               
    end
                                      
    y_range = []
    if y_coord < y 
      (y_coord+1..y-1).each { |n| y_range << n }
    else
      (y+1..y_coord-1).each { |n| y_range << n }
      y_range = y_range.reverse
    end

    coords_to_check = x_range.zip(y_range)   # Combines x and y ranges to make each coord
    duplicates = coords_to_check & current_pieces_coords    # Creates a variable storing any common coords in both arrays
    if duplicates.empty?                                    # If empty returns false, It's not obstructed
      return false
    else 
      return true
    end
  end

end
