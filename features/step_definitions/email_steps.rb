And(/^an email should be sent to "(.*?)" as notification of the request for admin status of "(.*?)"$/) do |email, org_name|
  message = "There is a user waiting for admin approval to #{org_name}"
  mails = ActionMailer::Base.deliveries.select{|m| m.to.include? email}
  expect(mails).not_to be_empty
  bodys = mails.map{|m| m.body}.select{|body| body.include? message }
  expect(bodys).not_to be_empty
end

Then(/^an email should be sent to "(.*?)" as notification of the signup by email "(.*?)"$/) do |admin_email, user_email|
  message = "A new user with the email #{user_email} has signed up on Harrow Community Network."
  mails = ActionMailer::Base.deliveries.select{|m| m.to.include? admin_email}
  expect(mails).not_to be_empty
  bodys = mails.map{|m| m.body}.select{|body| body.include? message }
  expect(bodys).not_to be_empty
end

And /^I should receive a "(.*?)" email$/ do |subj|
  mails = ActionMailer::Base.deliveries
  expect(mails).not_to be_empty
  subjects = mails.map(&:subject)
  expect(subjects).to include subj
end

And /^I should not receive an email$/ do
  ActionMailer::Base.deliveries.size.should eq 0
end

And /^the email queue is clear$/ do
  ActionMailer::Base.deliveries.clear
end

Given(/^I run the fix invitations rake task$/) do
  require "rake"
  @rake = Rake::Application.new
  Rake.application = @rake
  Rake.application.rake_require "tasks/fix_invites"
  Rake::Task.define_task(:environment)
  @rake['db:fix_invites'].invoke
end


Given(/^I import emails from "(.*?)"$/) do |file|
  fetch_rake_app_for_email_tasks['db:import:emails'].invoke(file)
end

Given(/^I run the exempt existing users task$/) do
  fetch_rake_app_for_email_tasks['db:emails:exempt_from_confirmation'].invoke
end

def fetch_rake_app_for_email_tasks
  begin
    @@rake_email
  rescue
    require "rake"
    @@rake_email = Rake::Application.new
    Rake.application = @@rake_email
    Rake.application.rake_require "tasks/emails"
    Rake::Task.define_task(:environment)
  end
  @@rake_email
end

Then(/^all the existing users should be confirmed$/) do
  User.all.each do |u|
    expect(u.confirmed_at).not_to be_nil
  end
end



