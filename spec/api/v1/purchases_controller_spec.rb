RSpec.describe Api::V1::PurchasesController, type: :controller do

    describe 'POST purchase' do
        before do
            api_access
            @user = create :user
            @user2 = create :user
            @user3 = create :user

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
            page.driver.post(api_v1_purchases_path)

            expect(page.status_code).to be(422)  
            
            data = JSON.parse(page.body)
            expect(data["message"]).to match Api::V1::ApiController::MESSAGE_NOT_FOUND 
        end

        it 'purchase a movie...' do
            page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
            page.driver.header 'PURCHASE', @purchase_movie.id
            page.driver.post(api_v1_purchases_path)

            expect(page.status_code).to be(201)  
            
            data = JSON.parse(page.body)

            expect(data["purchase"]["price"].to_f).to be 4.99
            expect(data["purchase"]["video_quality"]).to match("SD")
            expect(data["purchase"]["purchaseable"]["type"]).to match('movie')

            expect(Library.count).to match 1
            expect(@user.libraries.first.libraryable.id == @purchase_movie.purchaseable.id).to be true
       end

       it 'when purchase a movie and it is already bought...' do
            Library.create(expired_time: (DateTime.now + 3),user: @user2,libraryable: @movie, active: true)

            page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
            page.driver.header 'PURCHASE', @purchase_movie.id
            page.driver.post(api_v1_purchases_path)

            expect(page.status_code).to be(201)  

            page.driver.post(api_v1_purchases_path)
            data = JSON.parse(page.body)
            
            expect(page.status_code).to be(422)  

            expect(data["message"]).to match Api::V1::ApiController::MESSAGE_ALREADY_BOUGHT
        end

        it 'when purchase a movie and the same purchase by other user ...' do
            Library.create(expired_time: (DateTime.now + 3),user: @user,libraryable: @movie, active: true)

            page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
            page.driver.header 'PURCHASE', @purchase_movie.id

            page.driver.post(api_v1_purchases_path)
            data = JSON.parse(page.body)

            expect(page.status_code).to be(422)  
            expect(data["message"]).to match Api::V1::ApiController::MESSAGE_ALREADY_BOUGHT

            page.driver.header 'USER_AUTH_TOKEN', @user3.auth_token
            page.driver.header 'PURCHASE', @purchase_movie.id
            page.driver.post(api_v1_purchases_path)
            data = JSON.parse(page.body)
             
            expect(page.status_code).to be(201)  
        end

       it 'purchase a season...' do
            page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
            page.driver.header 'PURCHASE', @purchase_season.id

            page.driver.post(api_v1_purchases_path)

            expect(page.status_code).to be(201)  
           
            data = JSON.parse(page.body)

            expect(data["purchase"]["price"].to_f).to be 4.99
            expect(data["purchase"]["video_quality"]).to match 'SD'
            expect(data["purchase"]["purchaseable"]["type"]).to match 'season'

            expect(Library.count).to match 1
        end
    end  
end