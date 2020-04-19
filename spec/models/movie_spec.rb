require 'rails_helper'

RSpec.describe Movie, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:plot) }
  end

  describe 'valid attributes' do
    it "is not valid with not valid attributes" do
      expect(Movie.new).not_to be_valid
    end

    it "is valid with valid attributes" do
      expect(Movie.new(title: "A", plot: "a")).to be_valid
    end
  end

  describe 'not valid attributes' do
    it "is not valid without a title" do
      movie = Movie.new(title: nil)
      expect(movie).to_not be_valid
    end
  
    it "is not valid without a plot" do
      movie = Movie.new(plot: nil)
      expect(movie).to_not be_valid
    end
  end

  describe 'Get All movies by scope' do
    it 'should have all movies order by created_at ...' do
        expect(Movie.order_by_create.to_sql).to eq Movie.order(created_at: :asc).to_sql
    end
  end
end
