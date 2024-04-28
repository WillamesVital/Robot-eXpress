*** Settings ***
Documentation    Cenários de testes do cadastro de usuários

Resource    ../resources/base.resource

# Suite Setup       Log    Tudo aqui ocorre antes da Suite (antes de todos os testes)
# Suite Teardown    Log    Tudo aqui ocorre depois da Suite (depois de todos os testes)

Test Setup       Start Session
Test Teardown    Take Screenshot

*** Test Cases ***

Deve poder cadastrar um novo usuário
    
    ${user}     Create Dictionary 
    ...    name=Test User    
    ...    email=test@user.com    
    ...    password=pwd123

    Remove user from database    ${user}[email]
    
    Go to signup page
    Submit signup form    ${user}
    Notice should be    Boas vindas ao Mark85, o seu gerenciador de tarefas.
        
Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    ${user}     Create Dictionary
    ...    name=User Test    
    ...    email=user@test.com    
    ...    password=pwd123
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}
    
    Go to signup page
    Submit signup form    ${user}
    Notice should be    Oops! Já existe uma conta com o e-mail informado. 


Campos obrigatórios

    [Tags]    required

    ${user}     Create Dictionary
    ...    name=${EMPTY}    
    ...    email=${EMPTY}   
    ...    password=${EMPTY}

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Go to signup page

    Submit signup form    ${user}

    Alert shoudl be    expected_text=Informe seu nome completo
    Alert shoudl be    expected_text=Informe seu e-email
    Alert shoudl be    expected_text=Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com o email incorreto
    [Tags]    email_invalid    
    
    ${user}     Create Dictionary
    ...    name=Test Email Invalid   
    ...    email=test.invalid.com   
    ...    password=pwd123

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Go to signup page

    Submit signup form    ${user}

    Alert shoudl be    expected_text=Digite um e-mail válido

Não deve cadastrar com senha muito curta
    [Tags]    temp
    @{password_list}   Create List     1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}
        ${user}     Create Dictionary
        ...    name=Test User    
        ...    email=test@user.com  
        ...    password=${password}

        Remove user from database    ${user}[email]
        Insert user from database    ${user}

        Go to signup page

        Submit signup form    ${user}

        Alert shoudl be    expected_text=Informe uma senha com pelo menos 6 digitos        
    END
    
Não deve cadastrar com senha de 1 digito

    [Tags]    short_pass
    [Template]
    Short password    1

Não deve cadastrar com senha de 2 digitos

    [Tags]    short_pass
    [Template]
    Short password    12

Não deve cadastrar com senha de 3 digitos

    [Tags]    short_pass
    [Template]
    Short password    123

Não deve cadastrar com senha de 4 digitos

    [Tags]    short_pass
    [Template]
    Short password    1234

Não deve cadastrar com senha de 5 digitos

    [Tags]    short_pass
    [Template]
    Short password    12345


*** Keywords ***

Short password
    [Arguments]    ${short_pass}
     
    ${user}     Create Dictionary
    ...    name=Test User    
    ...    email=test@user.com  
    ...    password=${short_pass}

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Go to signup page

    Submit signup form    ${user}

    Alert shoudl be    expected_text=Informe uma senha com pelo menos 6 digitos