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
    Given I am on "/admin/preview/molestiae-voluptate-repellat"
    Then I should be on "/admin/login"

    When I fill in "_username" with "admin"
    And I fill in "_password" with "test"
    And I press "login"
    Then the response status code should be 200
    And I should see "Eveniet et nihil quis aut ad quia."
    And I should see "Собакевич все слушал, наклонивши голову"

  Scenario: Check preview page as guest
    Given I am on "/admin/preview/ea-pariatur-dolorem"
    Then I should be on "/admin/login"

    When I fill in "_username" with "gerasimov"
    And I fill in "_password" with "test"
    And I press "login"
    Then the response status code should be 200
    And I should see "Rem voluptatem eos in excepturi et beatae."
    And I should see "хочешь собак, так купи у меня слезы"

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
