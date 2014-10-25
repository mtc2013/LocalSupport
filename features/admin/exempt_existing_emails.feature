Feature: Exempt existing emails from confirmation
  As a sysadmin
  So that I can give beta users continued access to the site
  I want to exempt all existing accounts from confirmation requirements

  Background: Users exist in the database

    Given the following users are registered:
    | email                         | password | admin |
    | registered-user-1@example.com | pppppppp | true  |
    | registered-user-2@example.com | pppppppp | false |

  Scenario: Sysadmin successfully exempt existing users
    Given I run the exempt existing users task
    Then all the existing users should be confirmed

