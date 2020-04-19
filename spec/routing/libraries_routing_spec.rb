require "rails_helper"

RSpec.describe Api::V1::LibrariesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: ('api/v1/libraries')).to route_to(:controller => "api/v1/libraries" , :action => "index")
    end

    it "routes to #show" do
      expect(get: "api/v1//libraries/1").not_to be_routable
    end

    it "routes to #create" do
      expect(post: "api/v1//libraries").not_to be_routable
    end

    it "routes to #update via PUT" do
      expect(put: "api/v1//libraries/1").not_to be_routable
    end

    it "routes to #update via PATCH" do
      expect(patch: "api/v1//libraries/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete: "api/v1//libraries/1").not_to be_routable
    end
  end
end
