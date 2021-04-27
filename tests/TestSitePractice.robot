*** Settings ***
Resource              ../resources/Resource.robot
Test Setup            Abrir navegador
Test Teardown         Fechar navegador

### SETUP ele roda keyword antes da suíte ou antes de um Teste
### TEARDOWN ele roda keyword depois de uma suíte ou um teste

*** Test Case ***
Caso de Teste 01: Pesquisar produto existente
    Acessar a página home do site
    Digitar o nome do produto "Blouse" no campo de pesquisa
    Clicar no botão Pesquisar
    Conferir se o produto "Blouse" foi listado no site

Caso de Teste 02: Procurar produto não existente
    Acessar a página home do site
    Digitar o nome do produto "itemNãoExistente" no campo de pesquisa
    Clicar no botão Pesquisar
    Conferir mensagem de erro "No results were found for your search "itemNãoExistente""

Caso de Teste 03: Listar produtos
    Acessar a página home do site
    Passar o mouse por cima da categoria "Women" no menu principal superior de categorias
    Clicar na sub-categoria "Summer Dresses"
    Conferir se os produtos da sub-categoria "Summer Dresses" foram listados no site

Caso de Teste 04: Adicionar Produtos no Carrinho
    Acessar a página home do site
    Digitar o nome do produto "t-shirt" no campo de pesquisa
    Clicar no botão Pesquisar
    Clicar no botão "Add to Cart" do produto
    Clicar no botão "Proceed to checkout"
    Conferir se o produto "t-shirt" foi adicionado no carrinho com seus devidos dados e valores

Caso de Teste 05: Remover produtos
    Acessar a página home do site
    Adicionar o produto "t-shirt" no carrinho
    Clicar no botão "Proceed to checkout"
    Excluir o produto do carrinho
    Conferir se o carrinho fica vazio

Caso de Teste 06: Cadastrar Cliente
    Acessar a página home do site
    Clicar em "Sign in"
    Informar um e-mail válido


# *** Keywords ***
