RSpec.describe Api::V1::MoviesController, type: :controller do

  describe 'GET all movies' do
    before do
      api_access
      @user = create :user
      page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
      60.times do
        create(:movie)
      end 
    end

    it 'returns movies data' do
      page.driver.get(api_v1_movies_path)
      expect(page.status_code).to be(200)  
      
      data = JSON.parse(page.body)

      expect(data["movies"].first.has_key? "title").to be true
      expect(data["movies"].first.has_key? "plot").to be true
    end

    it 'returns movies data per page' do
      page.driver.get(api_v1_movies_path)
      expect(page.status_code).to be(200)  
      
      data = JSON.parse(page.body)

      expect(data["movies"].first.has_key? "title").to be true
      expect(data["movies"].first.has_key? "plot").to be true
      expect(data["movies"].count).to match Api::V1::ApiController::ITEMS_PER_PAGE_API
    end
    
    it 'should have all movies order by by created_at ...' do
      expect(Movie.order_by_create.to_sql).to eq Movie.order(created_at: :asc).to_sql
    end
  end

  describe 'GET movie' do
    before do
      api_access
      @user = create :user
      page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
    end

    it 'returns movies data' do
      movie = create(:movie)
      
      page.driver.get(api_v1_movie_path(movie.id))

      expect(page.status_code).to be(200)  
      
      data = JSON.parse(page.body)
       
      expect(data["movie"].has_key? "title").to be true
      expect(data["movie"].has_key? "plot").to be true
      expect(data.count).to match 1
    end
  end
end