class Game < ApplicationRecord
  belongs_to :white_player, :class_name => 'User', optional: true
  belongs_to :black_player, :class_name => 'User', optional: true
  has_many :pieces

  scope :available, -> { where(black_player_id: nil) }
  scope :mine, -> { where(white_player_id: @currentUser) }
end
