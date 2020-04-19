module Api::V1
    class ApiController < ApplicationController
        ### CONSTANTS       
        ITEMS_PER_PAGE_API = 5
        TYPE_PRODUCT = 'movie'


        MESSAGE_ALREADY_BOUGHT  = 'Sorry, already bought.'
        MESSAGE_NOT_FOUND = 'Not Found'
        MESSAGE_NOT_FOUND_PURCHASE = 'You have not made a purchase'

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

        def pagination_dict_all(collection,collection_add)
            {
            current_page: collection.current_page,
            next_page: collection.next_page,
            prev_page: collection.previous_page,
            total_pages: ((collection.total_pages > collection_add.total_pages) ? collection.total_pages : collection_add.total_pages),
            total_count: (collection.count + collection_add.count)
            }
        end
    end
end