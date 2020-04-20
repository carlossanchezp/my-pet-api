module Api::V1
  class MoviesSeasonsController < ApiController
    
    # GET /movies_sesions
    def index
      @movies  = Movie.order_by_create.page(params[:page]).per_page(ITEMS_PER_PAGE_API).all
      @seasons = Season.order_by_create.page(params[:page]).per_page(ITEMS_PER_PAGE_API).all

      objetc_union(@movies,@seasons)

      render json: {
        movies: ActiveModel::Serializer::CollectionSerializer.new(@movies, each_serializer: MovieSerializer),
        seasons: ActiveModel::Serializer::CollectionSerializer.new(@seasons, each_serializer: SeasonSerializer),
        meta: pagination_dict_all(@movies, @seasons),
      }
    end

    private

    def objetc_union(object_origin,object_destination)
      object_origin.merge(object_destination)
    end
  end
end
