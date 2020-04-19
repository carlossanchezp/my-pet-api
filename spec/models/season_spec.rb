require 'rails_helper'

RSpec.describe Season, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:plot) }
  end

  describe 'not valid attributes' do
    it "is not valid without a title" do
      season = Season.new(title: nil)
      expect(season).to_not be_valid
    end
  
    it "is not valid without a plot" do
      season = Season.new(plot: nil)
      expect(season).to_not be_valid
    end
  end

  describe 'Get All seasons by scope' do
    it 'should have all seasons order scope created_at ...' do
        expect(Season.order_by_create.to_sql).to eq Season.order(created_at: :asc).to_sql
    end
  end 
  describe 'Get All seasons by scope' do
    it 'should have all seasons order scope created_at ...' do
        expect(Season.order_by_create.to_sql).to eq Season.order(created_at: :asc).to_sql
    end
  end 
end
