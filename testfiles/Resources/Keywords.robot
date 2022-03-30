*** Settings ***
Library  SeleniumLibrary
Variables  ../PageObjects/HeaderPageLocators.py
Variables  ../PageObjects/HomePageLocators.py
Variables  ../PageObjects/ProductListingPageLocators.py
Variables  ../PageObjects/WishListPageLocators.py
Variables  ../PageObjects/LoginPageLocators.py

*** Variables ***
${URL}          https://www.westwingnow.de/
${BROWSER}      chrome
${Product_Listing_Page_Title}  Möbel online kaufen | Möbel Online Shop | WestwingNow
${WishList_Page_Title}    Meine Wunschliste | WestwingNow
${Add_Item_To_WishList_ScreenShot}  screenshot_wishlist_item_added.png
${Delete_Item_From_WishList_ScreenShot}  screenshot_wishlist_item_deleted.png

*** Keywords ***
browser is opened to WestwinNow HomePage
            ${chrome_options} =     Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}   add_argument    no-sandbox
    Call Method    ${chrome_options}   add_argument    disable-dev-shm-usage
    ${options}=     Call Method     ${chrome_options}    to_capabilities

    Open Browser          ${URL}    ${BROWSER}  desired_capabilities=${options}
    Maximize Browser Window
    Wait Until Page Contains Element    ${AcceptCookies}
    click button  ${AcceptCookies}

When I search for the product
    [arguments]     ${Product_search_term}
    input text      ${HomePage_Search_Box}    ${Product_search_term}
    #search term is variable, change in testcase
    Press Keys      ${HomePage_Search_Box}   ENTER

I should see product listing page
    [arguments]     ${Product_search_term}
    Wait Until Page Contains Element  ${First_Product}
    Page Should Contain  ${Product_search_term}   #validates correct page is loaded according to search term
    Verify Page Title    ${Product_Listing_Page_Title}  #validates correct page is loaded according to page title

user is logged in by adding item to wishlist
    [arguments]     ${My_Username}   ${My_Password}
    Wait Until Page Contains Element  ${Club_Registration_Overlay}
    Click Element At Coordinates      ${Club_Registration_Overlay}  200  200
    click element   ${WishList_Heart_Btn}    #add first listed product to wishlist
    click button    ${Already_Registered_Btn}
    Input Text      ${User_Email_Address}     ${My_Username}   #logs user in
    Input Password  ${User_Password}          ${My_Password}
    Click Button    ${Login_Button}
    Wait Until Page Contains Element    ${wishlist_counter}

the product should be added to the wishlist
    Element Text Should Be      ${wishlist_counter}  1  #validates that the wishlist counter is now equal to 1
    ${wish_list}=    Get Text    ${wishlist_counter}
    Log     ${wish_list}  #prints wishlist counter to the log
    Capture Screenshot Page     ${Add_Item_To_WishList_ScreenShot}

the user deletes the item from the wishlist
    Click Element       ${WishList_Text}
    Verify Page Title   ${WishList_Page_Title}  #validates correct page is loaded according to page title

the item should be removed from the wishlist page
    Click Element   ${Delete_Item_From_WishList}   #delete first item in wishlist
    Page Should Not Contain Element     ${no_items_in_wishlist} #wishlist counter is not active, no items are in wishlist
    Capture Page Screenshot     ${Delete_Item_From_WishList_ScreenShot}