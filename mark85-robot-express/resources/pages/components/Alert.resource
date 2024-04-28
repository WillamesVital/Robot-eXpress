*** Settings ***
Documentation    Ações e elementos do componente de mensagens de alertas

Library    Browser

*** Keywords ***

Alert shoudl be
    [Arguments]    ${expected_text}
    ${element}     Set Variable    css=.alert-error    

        Wait For Elements State    ${element} >> text=${expected_text}
    ...    visible    5

