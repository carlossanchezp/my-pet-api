class Library < ApplicationRecord
  ### RELATIONS
  belongs_to :libraryable, :polymorphic => true
  belongs_to :user

  ### SCOPES
  scope :active, -> { where(active: true)  }
  scope :order_by_remaining_time, -> { order(expired_time: :asc)   }

  ### VALIDATIONS
  validate :is_already_bought, on: :create

  def is_already_bought
    purchase_by_user = Library.active.where(user: self.user,libraryable: self.libraryable)
    raise errors.add(:is_already_bought, I18n.t(:already_bougth)) if purchase_by_user.present?
  end
end
