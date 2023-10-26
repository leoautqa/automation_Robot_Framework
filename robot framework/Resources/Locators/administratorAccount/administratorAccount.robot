*** Variables ***

&{home}
...    hCadUse=//h5[@class='card-title'][contains(.,'Cadastrar Usuários')]
...    hLisUse=//h5[@class='card-title'][contains(.,'Listar Usuários')]
...    hCadProd=//h5[@class='card-title'][contains(.,'Cadastrar Produtos')]
...    hLisProd=//h5[@class='card-title'][contains(.,'Listar Produtos')]
...    hRel=//h5[@class='card-title'][contains(.,'Relatórios')]

&{cadUsu}
...    btCad=//button[contains(@data-testid,'cadastrarUsuario')]
...    msgNameMan=//span[contains(.,'Nome é obrigatório')]
...    msgEmailMan=//span[contains(.,'Email é obrigatório')]
...    msgPassMan=//span[contains(.,'Password é obrigatório')]
...    inpName=//input[contains(@data-testid,'nome')]
...    inpEmail=//input[contains(@data-testid,'email')]
...    inpPass=//input[contains(@data-testid,'password')]
...    msAlrExi=//span[contains(.,'Este email já está sendo usado')]
...    cheBoxAdm=//input[contains(@data-testid,'checkbox')]

&{lisUsu}
...    hUmLisUsu=//h1[contains(.,'Lista dos usuários')]

&{cadProd}
...    btCad=//button[contains(@data-testid,'cadastarProdutos')]
...    msNoName=//span[contains(.,'Nome é obrigatório')]
...    msNoPrice=//span[contains(.,'Preco é obrigatório')]
...    msNoDesc=//span[contains(.,'Descricao é obrigatório')]
...    msNoQuant=//span[contains(.,'Descricao é obrigatório')]
...    nameProd=//input[contains(@data-testid,'nome')]
...    priceProd=//input[contains(@data-testid,'preco')]
...    descProd=//textarea[contains(@data-testid,'descricao')]
...    quantProd=//input[contains(@data-testid,'quantity')]
...    msPrice=//span[contains(.,'Preco deve ser um número positivo')]
...    msQuant=//span[contains(.,'Quantidade deve ser maior ou igual a 0')]
...    choFil=//input[contains(@data-testid,'imagem')]

&{lisProd}
...    titLis=//h1[contains(.,'Lista dos Produtos')]
...    msProdExis=//span[contains(.,'Já existe produto com esse nome')]