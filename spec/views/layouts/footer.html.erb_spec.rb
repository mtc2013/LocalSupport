require 'spec_helper'

describe "layouts/_footer3.html.erb" do
  it "renders site footer" do
    render
    rendered.should contain 'Contact'
    rendered.should contain 'About Us'
    rendered.should contain 'Cookies Policy'
  end
end

describe "layouts/footer3.html.erb" do
  it "display the cookies modal dialog to users
who have not accepted cookies" do
    render
    rendered.should contain "We will ask you to consent to our use of cookies"
  end
end

