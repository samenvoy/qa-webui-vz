*** Settings ***
Documentation  Library file for utility and helper keywords related to capturing page screenshots.

Resource          ${RESOURCES_DIR}/resource_imports.robot

*** Variables ***

*** Keywords ***
Capture full page screen shot       [Arguments]     ${screenshot_filename_prefix}
    [Documentation]     Continuously scrolls and captures screenshots.
    ...                 The keyword will end execution once the bottom of the page is reached.
    ...                 The captured screenshots will be named based off of ${screenshot_filename_prefix}
    ...                 with a numeric value appended in increasing order.
    # Vars following 'execute javascript' are found in library/js_snippets.robot
    ${total_height}=        execute javascript  ${GET_BODY_SCROLL_HEIGHT}
    ${window_height}=       execute javascript  ${GET_WINDOW_INNERHEIGHT}
    ${buffer}=  set variable    ${200}
    log     ${total_height}
    log     ${window_height}
    # Take test comparison screenshot for resembleJS
    # Calculate number of page lengths to scroll
    ${loops}=    evaluate   (${total_height} // ${window_height}) + ${1}
    # Define a counter to append to screenshot filenames
    ${counter}=     set variable     ${1}

    Take test comparison screenshot for resembleJS    ${screenshot_filename_prefix}_${counter}
    # Loop and take screenshot
    :FOR    ${index}    IN RANGE    ${loops}
    \       log     ${window_height}
    \       ${counter}=     evaluate    ${counter} + ${1}
    \       Scroll to vertical coordinate   ${window_height}
    \       sleep   1
    \       Take test comparison screenshot for resembleJS    ${screenshot_filename_prefix}_${counter}
    \       ${window_height}=     evaluate    (${window_height} + ${window_height}) - ${buffer}
