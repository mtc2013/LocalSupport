And /^I should receive a "(.*?)" email$/ do |arg1|
  @email = ActionMailer::Base.deliveries.last
  @email.subject.should include(arg1)
  ActionMailer::Base.deliveries.size.should eq 1
end

And /^I should not receive an email$/ do
  ActionMailer::Base.deliveries.size.should eq 0
end

And /^the email queue is clear$/ do
  ActionMailer::Base.deliveries.clear
end


require "rake"


Given(/^I import emails from "(.*?)"$/) do |file|
  @rake = Rake::Application.new
  Rake.application = @rake
  # HACK TO BE FIXED.
  # This require fails second time around (usually in cucumber batch test)
  # because file is added to loaded list, and then can't be re-required
  # however this has side effect of not adding the files tasks to @rake
  # by explicitly overriding the loaded list we force a reload and get the
  # tasks pulled in - not sure what other side effects there might be
  Rake.application.rake_require "tasks/emails", ['lib/'], ''
  Rake::Task.define_task(:environment)
  @rake['db:import:emails'].invoke(file)
end

Given(/^I invite pre-approved emails from "(.*?)"$/) do |file|
  @rake = Rake::Application.new
  Rake.application = @rake
  # HACK TO BE FIXED.
  # This require fails second time around (usually in cucumber batch test)
  # because file is added to loaded list, and then can't be re-required
  # however this has side effect of not adding the files tasks to @rake
  # by explicitly overriding the loaded list we force a reload and get the
  # tasks pulled in - not sure what other side effects there might be
  Rake.application.rake_require "tasks/emails", ['lib/'], ''
  Rake::Task.define_task(:environment)
  @rake['db:emails:invite'].invoke(file)
end


