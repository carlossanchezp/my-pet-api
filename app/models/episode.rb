class Episode < ApplicationRecord
  ### RELATIONS
  belongs_to :season

  ### VALIDATIONS
  validates :title, presence: { allow_blank: false }
  validates :plot, presence: { allow_blank: false }

  ### SCOPES
  scope :order_by_num_episode, -> { order(num_episode: :asc)  }    
end
