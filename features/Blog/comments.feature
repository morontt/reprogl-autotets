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
    When I fill in "name" with "pupkin"
    And I fill in "comment_text" with value "$commentText"
    And I press "Добавить комментарий"
    Then I should see "Lorem ipsum" in the "section.comments" element
