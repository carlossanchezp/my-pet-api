module Api::V1
  class PurchasesController < ApiController

    # POST /purchases
    def create
      @purchase = Purchase.where("id = ?",request.headers["HTTP_PURCHASE"]).first
      error = false

      if @purchase.present?
        if is_already_bought?(@purchase,@current_user)
          error, message_error = true, MESSAGE_ALREADY_BOUGHT
        else
          make_purchase_async(@purchase,@current_user)
        end 
      else 
        error, message_error = true, MESSAGE_NOT_FOUND    
      end

      render json: @purchase, status: :created unless error
      render :json => {message: message_error}, status: :unprocessable_entity if  error
    end

    private

      def make_purchase_async(purchase,current_user)
        PurchaseHardWorker.perform_async(purchase.id,current_user.id)
      end

      def is_already_bought?(purchase,current_user)
        purchase_by_user = Library.active.where(user: current_user,libraryable: purchase.purchaseable)
        purchase_by_user.present? ? true : false
      end
  end
end