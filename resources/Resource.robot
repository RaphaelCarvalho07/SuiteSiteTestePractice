*** Settings ***
Library               SeleniumLibrary

*** Variables ***
${URL}          http://automationpractice.com/index.php?
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

Adicionar o produto "t-shirt" no carrinho
    Wait Until Element Is Visible         xpath=//*[@id="center_column"]//img[@alt="Faded Short Sleeve T-shirts"]
    Click Element                         xpath=//*[@id="center_column"]//img[@alt="Faded Short Sleeve T-shirts"]
    Wait Until Element Is Visible         xpath=//*[@id="add_to_cart"]/button
    Click Button                          xpath=//*[@id="add_to_cart"]/button

Excluir o produto do carrinho
    Wait Until Element Is Visible         xpath=//*[@class="cart_quantity_delete"]
    Click Element                         xpath=//*[@class="cart_quantity_delete"]

####################### Conferências
Conferir se o produto "${PRODUTO}" foi listado no site
    Wait Until Element Is Visible     css=#center_column > h1
    Title Should Be                   Search - My Store
    Page Should Contain Image         xpath=//*[@id="center_column"]//*[@src='${URL}/img/p/2/0/20-home_default.jpg"]
    Page Should Contain Link          xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"Printed Chiffon Dress")]

Conferir mensagem de erro "${MENSAGEM_ALERTA}"
    Wait Until Element Is Visible      //*[@id="center_column"]//p[@class='alert alert-warning']
    Element Text Should Be             //*[@id="center_column"]//p[@class='alert alert-warning']    ${MENSAGEM_ALERTA}
    Title Should Be                    Search - My Store

Conferir se os produtos da sub-categoria "${CATEGORIA}" foram listados no site
    Wait Until Element Is Visible         css=#center_column > h1
    Page Should Contain Element           xpath=//*[@id="center_column"]/h1/span[contains(text(),"Summer Dresses")]
    Page Should Contain Element           xpath=//*[@id="center_column"]/ul/li[1]/div/div[2]/h5/a[@title="Printed Summer Dress"]
    Page Should Contain Element           xpath=//*[@id="center_column"]/ul/li[2]/div/div[2]/h5/a[@title="Printed Summer Dress"]
    Page Should Contain Element           xpath=//*[@id="center_column"]/ul/li[3]/div/div[2]/h5/a[@title="Printed Chiffon Dress"]

Conferir se o produto "t-shirt" foi adicionado no carrinho com seus devidos dados e valores
    Wait Until Element Is Visible         xpath=//*[@id="cart_title"][contains(text(),"Shopping-cart summary")]
    Element Text Should Be                xpath=//*[@class="cart_description"]/*[@class="product-name"]       Faded Short Sleeve T-shirts
    Element Text Should Be                xpath=//*[@class="cart_unit"]/*[@class="price"]/span   $16.51
    Element Text Should Be                id=total_price               $18.51

Conferir se o carrinho fica vazio
    Wait Until Element Is Visible         xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]
    Element Text Should Be                xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]      Your shopping cart is empty.
