class Game < ApplicationRecord
  belongs_to :white_player, :class_name => 'User', optional: true
  belongs_to :black_player, :class_name => 'User', optional: true
  has_many :pieces
  scope :available, -> { where(black_player_id: nil) }
  scope :mine, ->(user) { where(white_player_id: user.id) }
  after_create :populate_game!

  def populate_game!
    [true, false].each do |is_white|
      y = is_white ? 1 : 6
      8.times do |x|
        Pawn.create(:game_id => self.id, :x_coord => x, :y_coord => y, :captured? => false, :white? => is_white )
      end
      y = is_white ? 0 : 7
      [0,7].each do |x|
        Rook.create(:game_id => self.id, :x_coord => x, :y_coord => y, :captured? => false, :white? => is_white )
      end
      [1,6].each do |x|
        Knight.create(:game_id => self.id, :x_coord => x, :y_coord => y, :captured? => false, :white? => is_white )
      end
      [2,5].each do |x|
        Bishop.create(:game_id => self.id, :x_coord => x, :y_coord => y, :captured? => false, :white? => is_white )
      end
      Queen.create(:game_id => self.id, :x_coord => 3, :y_coord => y, :captured? => false, :white? => is_white )
      King.create(:game_id => self.id, :x_coord => 4, :y_coord => y, :captured? => false, :white? => is_white )
    end
  end

  def piece_at(x,y)
    pieces.find_by(x_coord: x, y_coord: y) || EmptySquare.new
  end

  def in_check? 
    if white_in_check == true || black_in_check == true
      return true 
    else 
      return false
    end
  end

  def white_in_check
    self.pieces.all.each do |piece|
      return true if piece.white? == false && piece.valid_move?(white_king.x_coord, white_king.y_coord)
    end
  end

  def black_in_check
    self.pieces.all.each do |piece|
      return true if piece.white? && piece.valid_move?(black_king.x_coord, black_king.y_coord)
    end
  end

  def white_king
    self.pieces.all.each do |piece|
      return piece if piece.type == "King" && piece.white?
    end
  end

  def black_king
    self.pieces.all.each do |piece|
      return piece if piece.type == "King" && piece.white? == false
    end
  end
    
end
