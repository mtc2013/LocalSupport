Feature: targeted email addresses
  As a Site Admin
  So that I get greater participation by orgs at the site
  I want to invite targeted emails to take over being an admin for their organization

  Background: organizations have been added to database
    Given the following users are registered:
      | email                 | password | admin  | confirmed_at         |  organization |
      | administrator@dogs.com | pppppppp | false  | 2007-01-01  10:00:00 |  Friendly |
    Given the following organizations exist:
      | name              | description              | address        | postcode | website       | email         |
      | I love dogs       | loves canines            | 34 pinner road | HA1 4HZ  | http://a.com/ | fred@dogs.com |
      | I love cats       | loves felines            | 64 pinner road | HA1 4HA  | http://b.com/ |               |
      | I hate animals    | hates birds and beasts   | 84 pinner road | HA1 4HF  | http://c.com/ |               |
    And a file called "targeted_test.csv" exists:
      | Organisation      | Charity no. | Address 1 | Address 2 | Postcode | Phone | crb phoned | e-mail              |
      | I love dogs       |             |           |           |          |       |            | admin@dogs.com      |
      | I love Cats       |             |           |           |          |       |            | admin@cats.com      |
      | I hate animals    |             |           |           |          |       |            | admin@cruelty.com   |
      | I love people     |             |           |           |          |       |            | people@humanity.org |

  Scenario: Invite targeted emails addresses
    Given I invite pre-approved emails from "db/targeted_test.csv"
    #Then "2" targeted emails have been sent