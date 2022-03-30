# Test scripts written with reusability in mind e.g. the product search term is stored as a variable
# Use of page object model for easy test maintenance (webelement locators stored in seperate files, therefore many keywords can refer to a single locator)
# PageObjects folder contains the web element locators
# - Test Cases folder for high level gherkin style test / bdd statements
# - Resources folder for robot keywords
# - Results folder for output report viewable in any browser

*** Settings ***
Documentation    WestWing Test - Dale Fixter
Library  SeleniumLibrary
Resource  ../Resources/Keywords.robot
Resource  ../Resources/Common.robot
Test Teardown   End TestCase

*** Variables ***
${Product_search_term}  möbel
${My_Username}    dalefixter@gmail.com
${My_Password}     thepassword

*** Test Cases ***
TC1 Search For Product On HomePage
    Given browser is opened to WestwinNow HomePage
    When I search for the product  ${Product_search_term}
    #setting this as a variable enabled easy reusability of test automation scripts
    Then I should see product listing page  ${Product_search_term}

TC2 Add To Wishlist And Login Then Delete Wishlist
#existing user, has previously logged in
    Given browser is opened to WestwinNow Homepage
    When I search for the product  ${Product_search_term}
    And user is logged in by adding item to wishlist  ${My_Username}  ${My_Password}
    Then the product should be added to the wishlist
    When the user deletes the item from the wishlist
    Then the item should be removed from the wishlist page