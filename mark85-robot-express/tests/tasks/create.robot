*** Settings ***
Documentation    Cenários de cadastro de tarefas

Library      JSONLibrary
Resource    ../../resources/base.resource

*** Test Cases ***

Deve poder cadastrar uma nova tarefa

    ${data}    Get fixture    tasks    create

    Log    ${data}