class CookiesController < ApplicationController
  def cookies
  end
  def allow
    response.set_cookie 'rack.policy', {
        value: 'true',
        path: '/',
        expires: 1.year.from_now.utc
    }

    #render nothing: true
    redirect_to :back  and return
  end

  def deny
    response.delete_cookie 'rack.policy'
    #render nothing: true
    redirect_to :back  and return
  end
end
