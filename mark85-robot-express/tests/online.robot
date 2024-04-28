*** Settings ***

Resource    ../resources/base.resource

Documentation    online

*** Test Cases ***

Webapp deve estar online

    Start Session
    Get Title    equal    Mark85 by QAx

    Sleep    5