*** Settings ***
Library               SeleniumLibrary

*** Variables ***
${URL}          http://automationpractice.com
${BROWSER}      firefox

*** Keywords ***
####################### SETUP e TEARDOWN
Abrir navegador
  Open Browser    ${URL}  ${BROWSER}

Fechar navegador
  Close Browser


####################### Ações
Acessar a página home do site
    Go To              ${URL}
    Title Should Be    My Store

Digitar o nome do produto "${PRODUTO}" no campo de pesquisa
    Input Text    name=search_query    ${PRODUTO}

Clicar no botão Pesquisar
    Click Element    name=submit_search

Passar o mouse por cima da categoria "${CATEGORIA}" no menu principal superior de categorias
    Wait Until Element Is Visible         xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORIA}"]
    Mouse Over                            xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORIA}"]

Clicar na sub-categoria "${CATEGORIA}"
    Wait Until Element Is Visible         xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORIA}"]
    Click Element                         xpath=//*[@id="block_top_menu"]//a[@title="${CATEGORIA}"]

Clicar no botão "Add to Cart" do produto
    Wait Until Element Is Visible         xpath=//*[@id="center_column"]//img[@alt="Faded Short Sleeve T-shirts"]
    Click Element                         xpath=//*[@id="center_column"]//img[@alt="Faded Short Sleeve T-shirts"]
    Wait Until Element Is Visible         xpath=//*[@id="add_to_cart"]/button
    Click Button                          xpath=//*[@id="add_to_cart"]/button

Clicar no botão "Proceed to checkout"
    Wait Until Element Is Visible         xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]
    Click Element                         xpath=//*[@id="layer_cart"]//a[@title="Proceed to checkout"]

####################### Conferências
Conferir se o produto "${PRODUTO}" foi listado no site
    Wait Until Element Is Visible     css=#center_column > h1
    Title Should Be                   Search - My Store
    Page Should Contain Image         xpath=//*[@id="center_column"]//*[@src='${URL}/img/p/7/7-home_default.jpg']
    Page Should Contain Link          xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"${PRODUTO}")]

Conferir mensagem de erro "${MENSAGEM_ALERTA}"
    Wait Until Element Is Visible      //*[@id="center_column"]//p[@class='alert alert-warning']
    Element Text Should Be             //*[@id="center_column"]//p[@class='alert alert-warning']    ${MENSAGEM_ALERTA}
    Title Should Be                    Search - My Store

Conferir se os produtos da sub-categoria "${CATEGORIA}" foram listados no site
    Wait Until Element Is Visible         css=#center_column > h1
    Title Should Be                       Summer Dresses - My Store
    Page Should Contain Image             xpath=//*[@id="center_column"]//*[@src='${URL}/img/p/2/0/20-home_default.jpg']
    Page Should Contain Link              xpath=//*[@id="center_column"]//a[@class="product-name"0][contains(text(),"Printed Chiffon Dress")]

# Conferir
