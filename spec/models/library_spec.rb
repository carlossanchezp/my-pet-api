require 'rails_helper'

RSpec.describe Library, type: :model do

  it { is_expected.to have_db_column(:libraryable_id).of_type(:integer) }
  it { is_expected.to have_db_column(:libraryable_type).of_type(:string) }

  it { is_expected.to belong_to(:libraryable) }

end
