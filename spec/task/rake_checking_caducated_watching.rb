class RakeTaskFileTaskTest < ActiveSupport::TestCase

  describe 'checking_caducated_wachings:library' do

    it "when have a actie and caducated active and goes to caducate" do
      @movie = create(:movie)
      @movie1 = create(:movie)
      @movie2 = create(:movie)
      @movie3 = create(:movie)
      @movie4 = create(:movie)
      @movie5 = create(:movie)

      @user = create :user
  
      Library.create(expired_time: ((DateTime.now + 2)),user: @user,libraryable: @movie, active: true)
      Library.create(expired_time: (2.days.ago),user: @user,libraryable: @movie2, active: true)
      Library.create(expired_time: (3.days.ago),user: @user,libraryable: @movie3, active: true)
      Library.create(expired_time: (1.days.ago),user: @user,libraryable: @movie4, active: true)
      Library.create(expired_time: (6.days.ago),user: @user,libraryable: @movie5, active: false)
    
      expect(Library.count).to be 5
      expect(Library.active.count).to be 4

      Rake::Task["checking_caducated_wachings:library"].invoke
      
      expect(Library.active.count).to be 1      
      expect(Library.where(active: false).count).to be 4
    end

    it 'should have all libraries order by acived and remaining_time ...' do
      expect(Library.order_by_remaining_time.to_sql).to eq Library.order(expired_time: :asc).to_sql
      expect(Library.active.to_sql).to eq Library.where(active: TRUE).to_sql
      expect(Library.active.order_by_remaining_time.to_sql).to eq Library.where(active: TRUE).order(expired_time: :asc).to_sql
    end 

  end
end
