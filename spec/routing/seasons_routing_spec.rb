require "rails_helper"

RSpec.describe Api::V1::SeasonsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "api/v1/seasons").to route_to(:controller => "api/v1/seasons" , :action => "index")
    end

  end
end
