module Api::V1
  class LibrariesController < ApiController
    before_action :set_library, only: [:show]

    # GET /libraries
    def index
      @libraries = Library.active.
                            order_by_remaining_time.where(user: @current_user).
                            page(params[:page]).
                            per_page(ITEMS_PER_PAGE_API).all
        render(json: @libraries, 
        each_serializer: LibrarySerializer, 
        meta: pagination_dict(@libraries))       
    end

    # POST /libraries
    def create
      @purchase = Purchase.where("id = ?",request.headers["HTTP_PURCHASE"]).first
      error = false

      if @purchase.present?
        begin 
          Library.create(expired_time: (DateTime.now + 2),user: @current_user,libraryable: @purchase.purchaseable, active: true)
        rescue Exception => error
          error, message_error = true, I18n.t(:already_bougth)
        end
      else
        error, message_error = true, I18n.t(:not_found)
      end

      render json: @purchase, status: :created unless error
      render json: {message: message_error}, status: :unprocessable_entity if  error
    end 

  end
end