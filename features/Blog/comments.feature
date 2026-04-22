Feature: Comments
  Check comments on site

  Scenario: Check an existing comment
    Given I am on "/article/javascript-khot-i-jquery"
    Then I should see "Прошедши порядочное расстояние." in the "section.comments" element

  Scenario: Add new comment
    Given I assign parameters with data:
      | key         | value            |
      | commentText | #{randomComment} |
    And I am on "/article/voluptatibus-iste-aliquam"
    Then I should not see value "$commentText" in the "section.comments" element
    When I fill in "name" with "pupkin"
    And I fill in "comment_text" with value "$commentText"
    And I press "Добавить комментарий"
    Then I should see value "$commentText" in the "section.comments" element

  Scenario: Add comment without name
    Given I am on "/article/voluptatibus-iste-aliquam"
    When I fill in "comment_text" with value "Lorem ipsum"
    And I press "Добавить комментарий"
    Then I should see "name - Значение не должно быть пустым."

  Scenario: Add comment with invalid email
    Given I am on "/article/voluptatibus-iste-aliquam"
    When I fill in "name" with "pupkin"
    And I fill in "mail" with "pupkin"
    And I fill in "comment_text" with value "Lorem ipsum"
    And I press "Добавить комментарий"
    Then I should see "email - Значение адреса электронной почты недопустимо."

  Scenario: Submit empty comment
    Given I am on "/article/voluptatibus-iste-aliquam"
    When I press "Добавить комментарий"
    Then I should see "name - Значение не должно быть пустым."
    And I should see "comment_text - Значение не должно быть пустым."

  Scenario: Submit comment as user
    Given I logged in as "danilov"
    And I assign parameters with data:
      | key         | value            |
      | commentText | #{randomComment} |
    When I am on "/article/asperiores-non-dolor"
    Then I should not see a "form input#name" element
    And I should not see a "form input#email" element
    And I should not see a "form input#website" element
    And I should not see value "$commentText" in the "section.comments" element
    When I fill in "comment_text" with value "$commentText"
    And I press "Добавить комментарий"
    Then I should see value "$commentText" in the "section.comments" element
