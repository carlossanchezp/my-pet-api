module Api::V1
  class MoviesController < ApiController
    before_action :set_movie, only: [:show]

    # GET /movies
    def index
      @movies = Movie.order_by_create.
                      page(params[:page]).
                      per_page(ITEMS_PER_PAGE_API).all

        render(json: @movies, 
        each_serializer: MovieSerializer, 
        meta: pagination_dict(@movies))
    end

    # GET /movies/1
    def show
      render json: @movie
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_movie
        @movie = Movie.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def movie_params
        params.require(:movie).permit(:title, :plot)
      end
  end
end
