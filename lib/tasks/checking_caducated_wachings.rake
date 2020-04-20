namespace :checking_caducated_wachings do
  desc "Checking caducated suscriptors for Payments"
  task library: :environment do
    Library.active.find_each(batch_size: 50) do |library|
      unless is_active_for_waching?(library)
        deactivate_waching(library)
      end
    end
  end
  
  private
  
  def is_active_for_waching?(library)
    library.expired_time.strftime("%Y/%m/%d") >= DateTime.now.strftime("%Y/%m/%d")
  end

  def deactivate_waching(library)
    byebug
    library.update(active: false)
  end
end