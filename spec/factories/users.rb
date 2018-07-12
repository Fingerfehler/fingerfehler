FactoryBot.define do
  factory :user, aliases: [:white_player, :black_player] do
    sequence :email do |n|
      "sampleEmail#{n}@gmail.com"
    end
    password "secretpassword"
    password_confirmation "secretpassword"
  end
end
