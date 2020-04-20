RSpec.describe Api::V1::MoviesSeasonsController, type: :controller do

    describe 'GET all movies and season' do
        before do
            api_access
            @user = create :user
            page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
            30.times do
                create(:movie)
            end  
            30.times do
                create(:season) do |season|
                    10.times do |n|
                        season.episodes.create(title: 'Episode #{n}', plot: 'Lorem ipsum dolor sit amet', num_episode: n)
                    end
                end
            end 
        end

        it 'should have all movies and season data...' do
            page.driver.get(api_v1_movies_seasons_path)
            expect(page.status_code).to be(200)  
            
            data = JSON.parse(page.body)

            expect(data["movies"].first.has_key? "title").to be true
            expect(data["movies"].first.has_key? "plot").to be true
            expect(data["movies"].count).to match Api::V1::ApiController::ITEMS_PER_PAGE_API
  
            expect(data["seasons"].first.has_key? "title").to be true
            expect(data["seasons"].first.has_key? "plot").to be true
            expect(data["seasons"].count).to match Api::V1::ApiController::ITEMS_PER_PAGE_API
            expect(data["meta"]["current_page"]).to match 1
            expect(data["movies"].count).to be >= 0
            expect(data["seasons"].count).to be >= 0
                       
        end

        it 'all movies and seasons ...' do
            page.driver.get(api_v1_movies_seasons_path)
            expect(page.status_code).to be(200)  
            
            data = JSON.parse(page.body)
            
            expect(data["meta"]["total_count"]).to match (Season.count + Movie.count)
        end

        it 'should have all movies and seasons order by created_at ...' do
            expect(Movie.order_by_create.to_sql).to eq Movie.order(created_at: :asc).to_sql
            expect(Season.order_by_create.to_sql).to eq Season.order(created_at: :asc).to_sql
        end

        it 'should have all seasons and episodies order by number of episode ...' do
            expect(Episode.order_by_num_episode.to_sql).to eq Episode.order(num_episode: :asc).to_sql
        end
    end
end