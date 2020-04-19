require 'rails_helper'

RSpec.describe Episode, type: :model do
  describe 'associations' do
    it { should belong_to(:season)}
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:plot) }
  end
end
