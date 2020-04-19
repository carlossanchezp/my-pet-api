module Api::V1
  class LibrariesController < ApiController
    before_action :set_library, only: [:show]

    # GET /movies
    def index
      @libraries = Library.active.order_by_remaining_time.where(user: @current_user).page(params[:page]).per_page(ITEMS_PER_PAGE_API).all

      if @libraries.present?
        render(json: @libraries, 
          each_serializer: LibrarySerializer, 
          meta: pagination_dict(@libraries))       
      else
        render :json => {message: MESSAGE_NOT_FOUND_PURCHASE}, status: :unprocessable_entity
      end
    end
  end
end