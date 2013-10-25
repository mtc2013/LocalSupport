require 'spec_helper'

describe PolicyController do

  describe "GET 'policy'" do
    it "returns http success" do
      get 'policy'
      response.should be_success
    end
  end

end
