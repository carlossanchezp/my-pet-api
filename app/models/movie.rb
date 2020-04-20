class Movie < ApplicationRecord
  ### VALIDATIONS
  validates :title, presence: { allow_blank: false }
  validates :plot, presence: { allow_blank: false }

  ### SCOPES
  scope :order_by_create, -> { order(created_at: :asc)  }    
end
