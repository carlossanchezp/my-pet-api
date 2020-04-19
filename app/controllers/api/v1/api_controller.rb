module Api::V1
    class ApiController < ApplicationController
        ### CONSTANTS       
        ITEMS_PER_PAGE_API = 5

        # https://github.com/rails-api/active_model_serializers/blob/v0.10.6/docs/howto/add_pagination_links.md#json-adapter
        # Add paginations to render json metadata
        def pagination_dict(collection)
            {
            current_page: collection.current_page,
            next_page: collection.next_page,
            prev_page: collection.previous_page,
            total_pages: collection.total_pages,
            total_count: collection.count
            }
        end

    end
end