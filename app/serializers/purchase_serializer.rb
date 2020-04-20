class PurchaseSerializer < ActiveModel::Serializer
  attributes :price, :video_quality

  ### RELATIONS
  belongs_to :purchaseable, :polymorphic => true
end
