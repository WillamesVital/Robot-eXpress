*** Settings ***
Documentation    Cenários de testes do cadastro de usuários

Resource    ../resources/base.robot

*** Variables ***
${name}        Test User
${email}       test@yser.com
${password}    pwd123

*** Test Cases ***

Deve poder cadastrar um novo usuário
    
    Remove user from database    ${email}
    
    Start Session

    Go To    http://localhost:3000/signup

    # Tecnica chamada de checkpoint
    Wait For Elements State    css=h1    visible    timeout=5
    Get Text                   css=h1    equal      Faça seu cadastro

    Fill Text    id=name        ${name}
    Fill Text    id=email       ${email}
    Fill Text    id=password    ${password}

    Click        id=buttonSignup

    Wait For Elements State    css=.notice p    visible
    Get Text                   css=.notice p    equal    Boas vindas ao Mark85, o seu gerenciador de tarefas.
    

Não deve permitir o cadastro com email duplicado
    [Tags]    dup
    
    Start Session

    Go To    http://localhost:3000/signup

    Wait For Elements State    css=h1    visible    timeout=5
    Get Text                   css=h1    equal      Faça seu cadastro

    Fill Text    id=name        ${name}
    Fill Text    id=email       ${email}
    Fill Text    id=password    ${password}

    Click        id=buttonSignup

    Wait For Elements State    css=.notice p    visible
    Get Text                   css=.notice p    equal   Oops! Já existe uma conta com o e-mail informado. 
    
    Sleep    5