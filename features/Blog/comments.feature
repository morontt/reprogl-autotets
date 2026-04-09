Feature: Comments
  Check comments on site

  Scenario: Check an existing comment
    Given I am on "/article/javascript-khot-i-jquery"
    Then I should see "Прошедши порядочное расстояние." in the "section.comments" element
