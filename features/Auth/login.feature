Feature: Authentication
  Check login page in admin dashboard

  Scenario: Check login page
    Given I am on "/admin"
    Then I should see "login"

    When I fill in "_username" with "admin"
    And I fill in "_password" with "test"
    And I press "login"
    Then the response status code should be 200
    And I should see "Превед, admin"

  Scenario: Check login with incorrect password
    Given I am on "/admin/login"
    When I fill in "_username" with "admin"
    And I fill in "_password" with "test2"
    And I press "login"
    Then the response status code should be 200
    And I should see "Недействительные аутентификационные данные."

  Scenario: Check login with incorrect username
    Given I am on "/admin/login"
    When I fill in "_username" with "hacker"
    And I fill in "_password" with "secret"
    And I press "login"
    Then the response status code should be 200
    And I should see "Недействительные аутентификационные данные."

  Scenario: Login by secure cookie
    Given I am on "/login"
    When I fill in "username" with "admin"
    And I fill in "password" with "test"
    And I press "login"
    And I go to "/admin"
    Then the response status code should be 200
    And I should see "Превед, admin"

  Scenario: Logout and clear secure cookie
    Given I am on "/login"
    When I fill in "username" with "admin"
    And I fill in "password" with "test"
    And I press "login"
    And I go to "/admin"
    And I follow "logout_link"
    And I go to "/admin"
    Then I should be on "/admin/login"
