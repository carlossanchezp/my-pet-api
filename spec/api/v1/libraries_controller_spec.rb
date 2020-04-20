RSpec.describe Api::V1::LibrariesController, type: :controller do

    describe 'GET index' do

        before do
            api_access

            @user = create :user
            @user2 = create :user

            page.driver.header 'USER_AUTH_TOKEN', @user.auth_token
            @movie = create(:movie)
            @movie2 = create(:movie)
            @movie3 = create(:movie)

            Library.create(expired_time: (DateTime.now+2),user: @user,libraryable: @movie, active: true) 
            Library.create(expired_time: (6.days.ago),user: @user,libraryable: @movie2, active: true)
           
            Library.create(expired_time: (DateTime.now),user: @user,libraryable: @movie3, active: false)

            Library.create(expired_time: (DateTime.now+2),user: @user2,libraryable: @movie, active: true) 
            Library.create(expired_time: (DateTime.now+2),user: @user2,libraryable: @movie3, active: true) 
            Library.create(expired_time: (DateTime.now+2),user: @user2,libraryable: @movie3, active: true) 
        end


        it 'when returns resources actived for current user and one caducated but active' do
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
            expect(data["libraries"].size).to be 1 
        end


        it 'checking structure JSON data' do
            page.driver.get(api_v1_libraries_path)
            expect(page.status_code).to be(200)  
          
            data = JSON.parse(page.body)
            expect(data["libraries"].size).to be 2 
             
            expect(data["libraries"].first.has_key? "waching_days").to be true
            expect(data["libraries"].first.has_key? "purchase").to be true
        end

        it 'only data for current user and actived' do
            page.driver.get(api_v1_libraries_path)
            expect(page.status_code).to be(200)  
          
            data = JSON.parse(page.body)
            expect(data["libraries"].size).to be 2 

            expect(Library.active.order_by_remaining_time.where(user: @user).count).to be 1
            expect(Library.count).to be 6
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
end