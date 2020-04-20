RSpec.describe Api::V1::LibrariesController, type: :controller do
  describe 'GET index' do

    before do
      api_access

      @user = create :user
      @user2 = create :user
      @user3 = create :user
      @user4 = create :user
      @user5 = create :user
      @user6 = create :user

      @movie = create(:movie)
      @movie2 = create(:movie)
      @movie3 = create(:movie)
    end

    it 'when returns any resource for current user never buy' do
      page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
      page.driver.get(api_v1_libraries_path)

      expect(page.status_code).to be(200)
      data = JSON.parse(page.body)

      expect(data["libraries"].size).to be 0
    end

    it 'when returns resources actived for current user and one caducated but active' do
      Library.create(expired_time: (5.days.ago),user: @user,libraryable: @movie, active: true) 
      Library.create(expired_time: (DateTime.now + 2),user: @user,libraryable: @movie2, active: true) 

      page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
      page.driver.get(api_v1_libraries_path)

      expect(page.status_code).to be(200)  
      
      data = JSON.parse(page.body)

      expect(data["libraries"].size).to be 2       
      expect(data["libraries"].first.has_key? "waching_days").to be true
      expect(data["libraries"].first.has_key? "purchase").to be true

      expect(data["libraries"].first["waching_days"]).to be 0 
      expect(data["libraries"].last["waching_days"]).to be 2 
    end


    it 'returns resources actived for current user and one caducated but it is deactived' do
      Library.create(expired_time: (5.days.ago),user: @user,libraryable: @movie, active: false) 
      Library.create(expired_time: (DateTime.now + 2),user: @user,libraryable: @movie2, active: true) 
      Library.create(expired_time: (2.day.ago),user: @user,libraryable: @movie3, active: true) 
      page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
      page.driver.get(api_v1_libraries_path)

      page.driver.get(api_v1_libraries_path)
      expect(page.status_code).to be(200)  
      
      data = JSON.parse(page.body)
           
      expect(data["libraries"].size).to be 2 
      
      expect(data["libraries"].first.has_key? "waching_days").to be true
      expect(data["libraries"].first.has_key? "purchase").to be true

      expect(data["libraries"].first["waching_days"]).to be 0 
      expect(data["libraries"].last["waching_days"]).to be 2 

      page.driver.get(api_v1_libraries_path)
      expect(page.status_code).to be(200)  

      data = JSON.parse(page.body)
      expect(data["libraries"].size).to be 2 
    end


    it 'checking structure JSON data' do
      Library.create(expired_time: (DateTime.now + 2),user: @user,libraryable: @movie2, active: true) 
      Library.create(expired_time: (DateTime.now + 2),user: @user,libraryable: @movie3, active: true) 

      page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
      page.driver.get(api_v1_libraries_path)

      page.driver.get(api_v1_libraries_path)
      expect(page.status_code).to be(200)  
      
      data = JSON.parse(page.body)

      expect(data["libraries"].size).to be 2 
      
      expect(data["libraries"].first.has_key? "waching_days").to be true
      expect(data["libraries"].first.has_key? "purchase").to be true
    end

    it 'only data for current user and actived' do
      Library.create(expired_time: (DateTime.now + 2),user: @user,libraryable: @movie2, active: true) 
      Library.create(expired_time: (DateTime.now + 2),user: @user,libraryable: @movie3, active: true) 
      Library.create(expired_time: (DateTime.now + 2),user: @user3,libraryable: @movie3, active: true) 
      Library.create(expired_time: (DateTime.now + 2),user: @user4,libraryable: @movie3, active: true) 
      Library.create(expired_time: (DateTime.now + 2),user: @user6,libraryable: @movie3, active: true) 
      
      page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
      page.driver.get(api_v1_libraries_path)
     
      expect(page.status_code).to be(200)  
      
      data = JSON.parse(page.body)
      expect(data["libraries"].size).to be 2 

      expect(Library.active.order_by_remaining_time.where(user: @user).count).to be 2
      expect(Library.count).to be 5
    end   

    it 'should have all libraries order by remaining_time ...' do
      expect(Library.order_by_remaining_time.to_sql).to eq Library.order(expired_time: :asc).to_sql
    end 
    
    it 'should have all libraries order by acived and remaining_time ...' do
      expect(Library.order_by_remaining_time.to_sql).to eq Library.order(expired_time: :asc).to_sql
      expect(Library.active.to_sql).to eq Library.where(active: TRUE).to_sql
      expect(Library.active.order_by_remaining_time.to_sql).to eq Library.where(active: TRUE).order(expired_time: :asc).to_sql
    end       
  end

  describe 'POST purchase' do
    before do
      api_access
      @user = create :user
      @user2 = create :user
      @user3 = create :user
      @user4 = create :user
      @user5 = create :user
      @user6 = create :user

      @movie = create(:movie)
      Purchase.create(price: 0.99,video_quality: 'HD',purchaseable: @movie ) 
      @purchase_movie=Purchase.create(price: 4.99,video_quality: 'SD',purchaseable: @movie ) 
       
      @season = create(:season)
      Purchase.create(price: 0.99,video_quality: 'HD',purchaseable: @season ) 
      @purchase_season=Purchase.create(price: 4.99,video_quality: 'SD',purchaseable: @season )             
    end

    it 'purchase and not exist...' do
      page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
      page.driver.header 'PURCHASE', 9999
      page.driver.post(api_v1_libraries_path)

      expect(page.status_code).to be(422)  
      
      data = JSON.parse(page.body)
      expect(data["message"]).to match I18n.t(:not_found) 
    end

    it 'purchase a movie...' do
      page.driver.header 'USER_AUTH_TOKEN', @user2.auth_token
      page.driver.header 'PURCHASE', @purchase_movie.id
      page.driver.post(api_v1_libraries_path)

      expect(page.status_code).to be(201)        
      data = JSON.parse(page.body)

      expect(data["purchase"]["price"].to_f).to be 4.99
      expect(data["purchase"]["video_quality"]).to match("SD")
      expect(data["purchase"]["purchaseable"]["type"]).to match('movie')

      expect(Library.count).to match 1
      expect(@user2.libraries.first.libraryable.id).to be @purchase_movie.purchaseable.id
     end

     it 'when purchase a movie and it is already bought...' do
      Library.create(expired_time: (DateTime.now + 3),user: @user2,libraryable: @movie, active: true)

      page.driver.header 'USER_AUTH_TOKEN', @user2.auth_token
      page.driver.header 'PURCHASE', @purchase_movie.id
      page.driver.post(api_v1_libraries_path)
      data = JSON.parse(page.body)
      expect(page.status_code).to be(422)  

      expect(data["message"]).to match I18n.t(:already_bougth)
    end

    it 'when purchase a movie and the same purchase by other user ...' do
      Library.create(expired_time: (DateTime.now + 3),user: @user6,libraryable: @movie, active: true)

      page.driver.header 'USER_AUTH_TOKEN', @user5.auth_token
      page.driver.header 'PURCHASE', @purchase_movie.id
      page.driver.post(api_v1_libraries_path)
      data = JSON.parse(page.body)

      expect(page.status_code).to be(201)  
    end

    it 'purchase a season...' do
      page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
      page.driver.header 'PURCHASE', @purchase_season.id

      page.driver.post(api_v1_libraries_path)

      expect(page.status_code).to be(201)  
       
      data = JSON.parse(page.body)

      expect(data["purchase"]["price"].to_f).to be 4.99
      expect(data["purchase"]["video_quality"]).to match 'SD'
      expect(data["purchase"]["purchaseable"]["type"]).to match 'season'

      expect(Library.count).to match 1
    end
  end 

end