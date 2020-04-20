class LibrarySerializer < ActiveModel::Serializer
  attributes :waching_days, :id

  ### RELATIONS  
  belongs_to :libraryable, :polymorphic => true, root: :purchase, key: :purchase

  def waching_days
    if it_is_in_time?(object)
      calculate_number_of_days_viewing(object)
    else
      DeactivateWatchingHardWorker.perform_async(object.id) if out_days_in_time(calculate_number_of_days_out(object))
      ## It's the best way to hide to a user a problem in a resource active but must be deactivated
      ## Next time is already deactivated or a cron rake checked caducated system or this worker DeactivateWatching
      0
    end
  end

  private
    def it_is_in_time?(object)
      (object.expired_time.strftime("%d/%m/%Y").to_date >= DateTime.now.strftime("%d/%m/%Y").to_date)
    end

    def calculate_number_of_days_viewing(object)
      ((DateTime.now.strftime("%d/%m/%Y").to_date)-(object.expired_time.strftime("%d/%m/%Y").to_date)).abs.to_i
    end

    def calculate_number_of_days_out(object)
      ((object.expired_time.strftime("%d/%m/%Y").to_date-(DateTime.now.strftime("%d/%m/%Y").to_date))).abs.to_i
    end

    def out_days_in_time(days)
      days > 2
    end
end
