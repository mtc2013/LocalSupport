class PolicyController < ApplicationController

  def cookies_accept
    accept_cookies #this calls the threepwood method to allow cookies
    redirect_to home_path
  end
  def cookies_deny
    reject_cookies # this calls the threepwood method to remove the fact that the user has accepted cookies
    redirect_to home_path
  end
end
