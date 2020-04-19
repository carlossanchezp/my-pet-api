require "rails_helper"

RSpec.describe Api::V1::SeasonsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "api/v1/seasons").to route_to(:controller => "api/v1/seasons" , :action => "index")
    end

    it "routes to #show" do
      expect(get: "api/v1/seasons/1").to be_routable
    end

    it "routes to #create" do
      expect(post: "api/v1/seasons").not_to be_routable
    end

    it "routes to #update via PUT" do
      expect(put: "api/v1/seasons/1").not_to be_routable
    end

    it "routes to #update via PATCH" do
      expect(patch: "api/v1/seasons/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete: "api/v1/seasons/1").not_to be_routable
    end
  end
end
