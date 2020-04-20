module Api::V1
  class SeasonsController < ApiController
    before_action :set_season, only: [:show]

    # GET /seasons
    def index
      @seasons = Season.order_by_create.
                        page(params[:page]).
                        per_page(ITEMS_PER_PAGE_API).all
      render(json: @seasons, 
        each_serializer: SeasonSerializer, 
        meta: pagination_dict(@seasons))
    end

    # GET /seasons/1
    def show
      render json: @season
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_season
        @season = Season.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def season_params
        params.require(:season).permit(:title, :plot)
      end
  end
end
