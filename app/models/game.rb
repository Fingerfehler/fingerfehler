class Game < ApplicationRecord
  belongs_to :white_player, :class_name => 'User'
  belongs_to :black_player, :class_name => 'User'
  has_many :pieces
  after_create :populate_game!

  def populate_game!
    [true, false].each do |is_white|
      y = is_white ? 1 : 6
      8.times do |x|
        Pawn.create(
          :game_id => self.id, 
          :x_coord => x, 
          :y_coord => y, 
          :type => 'Pawn', 
          :captured? => false,
          :white? => is_white
          )
      end
      y = is_white ? 0 : 7
      [0,7].each do |x|
        Rook.create(
          :game_id => self.id,
          :x_coord => x,
          :y_coord => y,
          :type => 'Rook',
          :captured? => false,
          :white? => is_white
          )
      end
      [1,6].each do |x|
        Knight.create(
          :game_id => self.id,
          :x_coord => x,
          :y_coord => y,
          :type => 'Knight',
          :captured? => false,
          :white? => is_white
          )
      end
      [2,5].each do |x|
        Bishop.create(
          :game_id => self.id,
          :x_coord => x,
          :y_coord => y,
          :type => 'Bishop',
          :captured? => false,
          :white? => is_white
          )
      end
      Queen.create(
        :game_id => self.id,
        :x_coord => 3,
        :y_coord => y,
        :type => 'Queen',
        :captured? => false,
        :white? => is_white
        )
      King.create(
        :game_id => self.id,
        :x_coord => 4,
        :y_coord => y,
        :type => 'King',
        :captured? => false,
        :white? => is_white
        )
    end
  end

end
