RSpec.describe Api::V1::SeasonsController, type: :controller do

    describe 'GET all season' do
        before do
            api_access
            @user = create :user
            page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
            30.times do
                create(:season) do |season|
                    10.times do |n|
                        season.episodes.create(title: 'sasa', plot: 'asas', num_episode: n)
                    end
                end
            end 
        end

        it 'paginate data seasons' do
            page.driver.get(api_v1_seasons_path)
            expect(page.status_code).to be(200)  
            
            data = JSON.parse(page.body)

            expect(data["seasons"].first.has_key? "title").to be true
            expect(data["seasons"].first.has_key? "plot").to be true
        end

        it 'paginate data seasons per page' do
            page.driver.get(api_v1_seasons_path)
            expect(page.status_code).to be(200)  
            
            data = JSON.parse(page.body)

            expect(data["seasons"].first.has_key? "title").to be true
            expect(data["seasons"].first.has_key? "plot").to be true
            expect(data["seasons"].count).to match Api::V1::ApiController::ITEMS_PER_PAGE_API
        end

        it 'seasons with episodes data' do
            page.driver.get(api_v1_seasons_path)
            expect(page.status_code).to be(200)  
            
            data = JSON.parse(page.body)

            expect(data["seasons"].first.has_key? "title").to be true
            expect(data["seasons"].first.has_key? "plot").to be true
            expect(data["seasons"].count).to match Api::V1::ApiController::ITEMS_PER_PAGE_API        
            expect(data["seasons"].first["episodes"].count).to match 10
        end

        it 'should have all season order by by created_at and episodes order by num episode ...' do
            expect(Season.order_by_create.to_sql).to eq Season.order(created_at: :asc).to_sql
            expect(Episode.order_by_num_episode.to_sql).to eq Episode.order(num_episode: :asc).to_sql
        end       
    end  
       

end