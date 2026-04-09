Feature: Access control
  Check dashboard, preview page and other

  Scenario: Check admin dashboard
    Given I am on "/admin"
    Then I should be on "/admin/login"

  Scenario: Check admin dashboard as guest
    Given I am on "/admin"
    Then I should be on "/admin/login"

    When I fill in "_username" with "gerasimov"
    And I fill in "_password" with "test"
    And I press "login"
    Then the response status code should be 403

  Scenario: Check preview page as admin
    Given I am on "/admin/preview/sed-officia-soluta"
    Then I should be on "/admin/login"

    When I fill in "_username" with "admin"
    And I fill in "_password" with "test"
    And I press "login"
    Then the response status code should be 200
    And I should see "Et eos et eum quia eius iusto."
    And I should see "Потом надел перед зеркалом."

  Scenario: Check preview page as guest
    Given I am on "/admin/preview/nulla-quos-quisquam"
    Then I should be on "/admin/login"

    When I fill in "_username" with "gerasimov"
    And I fill in "_password" with "test"
    And I press "login"
    Then the response status code should be 200
    And I should see "Sed accusantium nesciunt qui ipsam."
    And I should see "Если — хочешь собак, так купи собак."

  Scenario: Login by secure cookie as guest
    Given I am on "/login"
    When I fill in "username" with "gerasimov"
    And I fill in "password" with "test"
    And I press "login"
    And I go to "/admin"
    Then the response status code should be 403

  Scenario: Check API root page as admin
    Given I am on "/api"
    Then I should be on "/admin/login"

    When I fill in "_username" with "admin"
    And I fill in "_password" with "test"
    And I press "login"
    Then the response status code should be 200
    And I should see "API root path"

  Scenario: Check API root page as guest
    Given I am on "/api"
    Then I should be on "/admin/login"

    When I fill in "_username" with "gerasimov"
    And I fill in "_password" with "test"
    And I press "login"
    Then the response status code should be 403
