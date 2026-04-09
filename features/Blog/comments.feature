Feature: Comments
  Check comments on site

  Scenario: Check an existing comment
    Given I am on "/article/javascript-khot-i-jquery"
    Then I should see "Ну так купи собак." in the "section.comments" element
