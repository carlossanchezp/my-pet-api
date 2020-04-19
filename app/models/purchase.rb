class Purchase < ApplicationRecord
    ### RELATIONS
    belongs_to :purchaseable, :polymorphic => true
end
