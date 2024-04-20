*** Settings ***

Library    libs/database.py
Library    Browser

*** Keywords ***

Start Session

    New Browser    browser=chromium    headless=False
    New Page     http://localhost:3000