class CustomMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
end