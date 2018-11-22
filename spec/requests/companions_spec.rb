require 'rails_helper'

RSpec.describe "Companions", type: :request do
  describe "GET /companions" do
    it "works! (now write some real specs)" do
      get companions_path
      expect(response).to have_http_status(200)
    end
  end
end
