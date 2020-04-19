class RakeTaskFileTaskTest < ActiveSupport::TestCase

  describe 'checking_caducated_wachings:library' do

    it "must will be caducated" do
        @movie = create(:movie)
        @user = create :user

        Library.create(expired_time: ((DateTime.now + 2)),user: @user,libraryable: @movie, active: true)
        Library.create(expired_time: (2.days.ago),user: @user,libraryable: @movie, active: true)
        Library.create(expired_time: (3.days.ago),user: @user,libraryable: @movie, active: true)
        Library.create(expired_time: (1.days.ago),user: @user,libraryable: @movie, active: true)
        Library.create(expired_time: (6.days.ago),user: @user,libraryable: @movie, active: false)
        
        expect(Library.count).to be 5
        expect(Library.active.count).to be 4

        Rake::Task["checking_caducated_wachings:library"].invoke
        
        expect(Library.active.count).to be 1
        expect(Library.where(active: false).count).to be 4
        expect(Library.count).to be 5

    end
  end
end
