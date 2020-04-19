require 'rails_helper'

RSpec.describe Purchase, type: :model do

  it { is_expected.to have_db_column(:purchaseable_id).of_type(:integer) }
  it { is_expected.to have_db_column(:purchaseable_type).of_type(:string) }

  it { is_expected.to belong_to(:purchaseable) }

end
