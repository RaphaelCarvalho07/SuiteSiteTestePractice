*** Settings ***
Library               SeleniumLibrary
Library               String
*** Variables ***
${URL}          http://automationpractice.com/index.php?

${urlTest}      http://automationpractice.com

${BROWSER}      firefox

&{CLIENT}       nome=Robot    sobrenome=Tests  senha=123456    diaNascimento=7    mesNascimento=12
...             anoNascimento=36   firstName=RobotF   lastName=rFramework  company=Robotizadores
...             endereco=Rua Framework, Bairro Robot    complemento=Robot's Office
...             cidade=Cidade Maravilhosa   estado=33   CEP=12345    celular=21999887766


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

Clicar em "Sign in"
    Wait Until Element Is Visible         xpath=//*[@id="header"]//*[@class="login"][contains(text(),"Sign in")]
    Click Element                         xpath=//*[@id="header"]//*[@class="login"][contains(text(),"Sign in")]

Informar um e-mail válido
    Wait Until Element Is Visible         id=email_create
    ${EMAIL}                              Generate Random String
    Input Text                            id=email_create    ${EMAIL}@testerobot.com

Clicar em "Create an account"
    Wait Until Element Is Visible         css=#SubmitCreate
    Click Button                          css=#SubmitCreate

Preencher os dados obrigatórios
    Wait Until Element Is Visible         xpath=//*[@id="account-creation_form"]//h3[@class="page-subheading"][contains(text(), "Your personal information")]
    Click Element                         id=id_gender1
    Input Text                            id=customer_firstname             ${CLIENT.nome}
    Input Text                            id=customer_lastname              ${CLIENT.sobrenome}
    Input Text                            id=passwd                         ${CLIENT.senha}
    Select From List By Index             id=days                           ${CLIENT.diaNascimento}
    Select From List By Index             id=months                         ${CLIENT.mesNascimento}
    Select From List By Index             id=years                          ${CLIENT.anoNascimento}
    Input Text                            id=firstname                      ${CLIENT.firstName}
    Input Text                            id=lastname                       ${CLIENT.lastName}
    Input Text                            id=company                        ${CLIENT.company}
    Input Text                            id=address1                       ${CLIENT.endereco}
    Input Text                            id=address2                       ${CLIENT.complemento}
    Input Text                            id=city                           ${CLIENT.cidade}
    Select From List By Index             id=id_state                       ${CLIENT.estado}
    Input Text                            id=postcode                       ${CLIENT.CEP}
    Input Text                            id=phone_mobile                   ${CLIENT.celular}

Submeter cadastro
    Click Button                          id=submitAccount

####################### Conferências
Conferir se o produto "${PRODUTO}" foi listado no site
    Wait Until Element Is Visible     css=#center_column > h1
    Title Should Be                   Search - My Store
    Page Should Contain Image         xpath=//*[@id="center_column"]//*[@src='${urlTest}/img/p/7/7-home_default.jpg']
    Page Should Contain Link          xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"${PRODUTO}")]

Conferir mensagem de erro "${MENSAGEM_ALERTA}"
    Wait Until Element Is Visible        xpath=//*[@id="center_column"]//p[@class='alert alert-warning']
    Element Text Should Be               xpath=//*[@id="center_column"]//p[@class='alert alert-warning']    ${MENSAGEM_ALERTA}
    Title Should Be                      Search - My Store

Conferir se os produtos da sub-categoria "${CATEGORIA}" foram listados no site
    @{SUMMER_DRESSES}   Create List    Printed Summer Dress    Printed Summer Dress    Printed Chiffon Dress
    Wait Until Element Is Visible         css=#center_column > h1
    Page Should Contain Element           xpath=//*[@id="center_column"]/h1/span[contains(text(),"Summer Dresses")]
    Page Should Contain Element           xpath=//*[@id="center_column"]/ul/li[1]/div/div[2]/h5/a[@title="${SUMMER_DRESSES[0]}"]
    Page Should Contain Element           xpath=//*[@id="center_column"]/ul/li[2]/div/div[2]/h5/a[@title="${SUMMER_DRESSES[1]}"]
    Page Should Contain Element           xpath=//*[@id="center_column"]/ul/li[3]/div/div[2]/h5/a[@title="${SUMMER_DRESSES[2]}"]

Conferir se o produto "t-shirt" foi adicionado no carrinho com seus devidos dados e valores
    Wait Until Element Is Visible         xpath=//*[@id="cart_title"][contains(text(),"Shopping-cart summary")]
    Element Text Should Be                xpath=//*[@class="cart_description"]/*[@class="product-name"]       Faded Short Sleeve T-shirts
    Element Text Should Be                xpath=//*[@class="cart_unit"]/*[@class="price"]/span   $16.51
    Element Text Should Be                id=total_price               $18.51

Conferir se o carrinho fica vazio
    Wait Until Element Is Visible         xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]
    Element Text Should Be                xpath=//*[@id="center_column"]/p[@class="alert alert-warning"]      Your shopping cart is empty.

Conferir se o cadastro foi efetuado com sucesso
    Title Should Be                   My account - My Store
    Element Text Should Be            xpath=//*[@id="center_column"]/h1     MY ACCOUNT
    Element Text Should Be            xpath=//*[@id="center_column"]/p
    ...    Welcome to your account. Here you can manage all of your personal information and orders.
    Element Text Should Be           xpath=//*[@id="header"]/div[2]//div[1]/a/span    Robot Tests
