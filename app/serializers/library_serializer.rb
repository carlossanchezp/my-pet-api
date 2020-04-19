class LibrarySerializer < ActiveModel::Serializer
  attributes :waching_days, :id

  ### RELATIONS  
  belongs_to :libraryable, :polymorphic => true, root: :purchase, key: :purchase

  def waching_days
    if (object.expired_time.strftime("%d/%m/%Y").to_date >= DateTime.now.strftime("%d/%m/%Y").to_date)
      ((DateTime.now.strftime("%d/%m/%Y").to_date)-(object.expired_time.strftime("%d/%m/%Y").to_date)).abs.to_i
    else
      days = ((object.expired_time.strftime("%d/%m/%Y").to_date-(DateTime.now.strftime("%d/%m/%Y").to_date))).abs.to_i
      DeactivateWatchingHardWorker.perform_async(object.id) if out_days_in_time(days)
      0
    end
  end

  private

  def out_days_in_time(days)
    days > 2
  end
end
