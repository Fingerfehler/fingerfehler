class Piece < ApplicationRecord
  belongs_to :game

  # anywhere it say y_coord was self.y & x_coord was self.x

                # Need function to automoatically keep up with current pieces coords at all times.
  def current_pieces_coords    # Will need to be removed later after new function made.  
    [[0,7],[3,7],[4,7],[5,7],[6,7],[7,7],
    [2,6],[3,6],[4,6],[5,6],[6,6],[7,6],
    [0,5],[1,5],[7,5],
    [2,3],[3,3],
    [0,1],[1,1],[4,1],[5,1],[6,1],[7,1],
    [0,0],[1,0],[3,0],[5,0],[6,0],[7,0]]      # Represents all the coordinates of pieces in play
  end

  def is_obstructed?(x, y)
    if x_coord == x
      is_vertically_obstructed?(x,y)
    elsif y_coord == y 
      is_horizontally_obstructed?(x,y)
    elsif invalid_input?(x,y) == false
      is_diagonally_obstructed?(x,y)
    else
      invalid_input?(x,y)
    end
  end

  def is_vertically_obstructed?(x, y) 
    y_range = []
    if y_coord < y
      (y_coord..y).each { |n| y_range << n }   # If statement catches if numbers go high to low
    else
      (y..y_coord).each { |n| y_range << n }   # Range doesn't work backwards
      y_range = y_range.reverse               # This line reverses it back to the correct order
    end
    y_range.pop         # removes first number
    y_range.shift       # removes last number

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
      (x_coord..x).each { |n| x_range << n }   # If statement catches if numbers go high to low
    else
      (x..x_coord).each { |n| x_range << n }   # Range doesn't work backwards
      x_range = x_range.reverse               # This line reverses it back to the correct order
    end
    x_range.pop         # removes first number
    x_range.shift       # removes last number

    coords_to_check = []
    x_range.each do |x|           #creates the array of coords between points
      coords_to_check << [x,y]    
    end
    duplicates = coords_to_check & current_pieces_coords    # Creates a variable storing any common coords in both arrays
    if duplicates.empty?                                    # If empty returns false, It's not obstructed
      return false
    else 
      return true
    end                             
  end 


  def is_diagonally_obstructed?(x, y)
    x_range = []
    if x_coord < x
      (x_coord..x).each { |n| x_range << n }   # If statement catches if numbers go high to low
    else
      (x..x_coord).each { |n| x_range << n }   # Range doesn't work backwards
      x_range = x_range.reverse               # This line reverses it back to the correct order
    end
    x_range.pop         # removes first number
    x_range.shift       # removes last number
                                  
    y_range = []
    if y_coord < y 
      (y_coord..y).each { |n| y_range << n }
    else
      (y..y_coord).each { |n| y_range << n }
      y_range = y_range.reverse
    end
    y_range.pop
    y_range.shift

    coords_to_check = x_range.zip(y_range)   # Combines x and y ranges to make each coord
    duplicates = coords_to_check & current_pieces_coords    # Creates a variable storing any common coords in both arrays
    if duplicates.empty?                                    # If empty returns false, It's not obstructed
      return false
    else 
      return true
    end
  end


  def invalid_input?(x, y)
    x_range = []
    if x_coord < x
      (x_coord..x).each { |n| x_range << n }   # If statement catches if numbers go high to low
    else
      (x..x_coord).each { |n| x_range << n }   # Range doesn't work backwards
      x_range = x_range.reverse               # This line reverses it back to the correct order
    end
                                 
    y_range = []
    if y_coord < y 
      (y_coord..y).each { |n| y_range << n }
    else
      (y..y_coord).each { |n| y_range << n }
      y_range = y_range.reverse
    end

    if x_range.length != y_range.length    # If the lengths are different the move can't be diagonal!
      return "Invalid Input"
    else
      return false
    end
  end

end
