class UserRank
  include Mongoid::Document

  belongs_to :user

  field :user_name, type: String
  field :wins, type: Integer, default: 0
  field :losses, type: Integer, default: 0
  field :elo, type: Integer, default: 0
  field :tau, type: Float, default: 0
  field :rank, type: Integer

  scope :ranked, -> { where(:rank.ne => nil) }

  def self.from_user(user)
    UserRank.new.tap do |user_rank|
      user_rank.user = user
      user_rank.user_name = user.user_name
      user_rank.wins = user.wins
      user_rank.losses = user.losses
      user_rank.elo = user.elo
      user_rank.tau = user.tau
      user_rank.rank = user.rank
    end
  end

  def to_s
    "#{user_name}: #{wins} win#{wins != 1 ? 's' : ''}, #{losses} loss#{losses != 1 ? 'es' : ''} (elo: #{elo})"
  end
end
