Feature: Authentication
  Check login page

  Scenario: Check login page
    Given I am on homepage
    Then I should see "login"

    When I fill in "_username" with "admin"
    And I fill in "_password" with "test"
    And I press "login"
    Then the response status code should be 200
    And I should see "Превед, admin"

  Scenario: Check login with incorrect password
    Given I am on homepage
    Then I should see "login"

    When I fill in "_username" with "admin"
    And I fill in "_password" with "test2"
    And I press "login"
    Then the response status code should be 200
    And I should see "Недействительные аутентификационные данные."

  Scenario: Check login with incorrect username
    Given I am on homepage
    Then I should see "login"

    When I fill in "_username" with "hacker"
    And I fill in "_password" with "secret"
    And I press "login"
    Then the response status code should be 200
    And I should see "Недействительные аутентификационные данные."
