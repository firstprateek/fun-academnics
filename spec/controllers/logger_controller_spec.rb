require 'spec_helper'

describe LoggerController do

  describe "GET 'logthis'" do
    it "returns http success" do
      get 'logthis'
      response.should be_success
    end
  end

end
