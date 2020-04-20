class PurchaseHardWorker
  include Sidekiq::Worker

  def perform(*args)
    return 0 unless args[0].present? && args[1].present?
    pursase_id, user_id = args[0].to_i, args[1].to_i

    purchase     = set_pruchase(pursase_id)
    current_user = set_current_user(user_id)

    if purchase.present? && current_user.present? 
      Library.create(expired_time: (DateTime.now + 2),user: current_user,libraryable: purchase.purchaseable, active: true)
    end
  end

  private

  def set_current_user(user_id)
    User.where(id: user_id).first
  end

  def set_pruchase(pursase_id)
    Purchase.where(id: pursase_id).first
  end
end