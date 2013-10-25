require 'spec_helper'

describe CookiesController do

  describe "GET 'cookies'" do
    it "returns http success" do
      get 'cookies'
      response.should be_success
    end
  end

end
