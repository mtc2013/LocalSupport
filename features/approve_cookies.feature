Feature: Approve cookies
	As the system owner
	In order to comply with the EU ePrivacy Directive
	I want all users to be given choice to approve cookie policy
	Tracker story ID: https://www.pivotaltracker.com/story/show/56438038

Background: 

Scenario:
	Given I am on the home page
	And I have not approved cookie policy
	Then I should see an approve cookie policy message

Scenario:
	Given I am on the home page
	And I have approved cookie policy
	Then I should not see an approve cookie policy message
