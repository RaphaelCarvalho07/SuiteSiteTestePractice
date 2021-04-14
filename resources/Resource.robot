*** Settings ***
Library               SeleniumLibrary

*** Variables ***
${URL}          http://automationpractice.com
${BROWSER}      firefox

*** Keywords ***
### SETUP e TEARDOWN
Abrir navegador
  Open Browser    http://automationpractice.com   ${BROWSER}

Fechar navegador
  Close Browser


#### Ações
Acessar a página home do site
    Go To              ${URL}
    Title Should Be    My Store

Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Input Text    name=search_query    ${PRODUTO}

Clicar no botão Pesquisar
    Click Element    name=submit_search

#### Conferências
Conferir se o produto "${PRODUTO}" foi listado no site
    Wait Until Element Is Visible     css=#center_column > h1
    Title Should Be                   Search - My Store
    Page Should Contain Image         xpath=//*[@id="center_column"]//*[@src='${URL}/img/p/7/7-home_default.jpg']
    Page Should Contain Link          xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"${PRODUTO}")]

Conferir mensagem de erro "${MENSAGEM_ALERTA}"
    Wait Until Element Is Visible      //*[@id="center_column"]//p[@class='alert alert-warning']
    Element Text Should Be             //*[@id="center_column"]//p[@class='alert alert-warning']    ${MENSAGEM_ALERTA}
    Title Should Be                    Search - My Store
