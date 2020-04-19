class Library < ApplicationRecord
    ### RELATIONS
    belongs_to :libraryable, :polymorphic => true
    belongs_to :user

    ### SCOPES
    scope :active, -> { where(active: true)  }
    scope :order_by_remaining_time, -> { order(expired_time: :asc)   }
end
