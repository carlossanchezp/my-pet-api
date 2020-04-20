module Api::V1
  class LibrariesController < ApiController
    before_action :set_library, only: [:show]

    # GET /movies
    def index
      @libraries = Library.active.
                            order_by_remaining_time.where(user: @current_user).
                            page(params[:page]).
                            per_page(ITEMS_PER_PAGE_API).all
      render(json: @libraries, 
        each_serializer: LibrarySerializer, 
        meta: pagination_dict(@libraries))       
    end
  end
end