module Api::V1
  class MoviesSeasonsController < ApiController
    def index
      @movies  = Movie.order_by_create.page(params[:page]).per_page(ITEMS_PER_PAGE_API).all
      @seasons = Season.order_by_create.page(params[:page]).per_page(ITEMS_PER_PAGE_API).all

      objetc_union(@movies,@seasons)

      render :json => {:movies => @movies,
       :seasons => @seasons,
       meta: pagination_dict_all(@movies, @seasons),
      }
    end

    private

    def objetc_union(object_origin,object_destination)
      object_origin.merge(object_destination)
    end

  end
end
