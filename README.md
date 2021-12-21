# ir_centis
Script desenvolvido para a extração das tabelas dos dados de distibuição de renda nos centis declarados no imposto de renda encontradas em: https://www.gov.br/receitafederal/pt-br/acesso-a-informacao/dados-abertos/receitadata/estudos-e-tributarios-e-aduaneiros/estudos-e-estatisticas/distribuicao-da-renda-por-centis/distribuicao-da-renda-por-centis-capa. 

Necessário usar o R para sua execução. Cria uma tibble com todos os dados disponíveis até a data de publicação desse repositório (21/12/2021).

Algumas melhorias futuras: 
i) fazê-lo como um pacote 
ii) criar uma função única get_ir() e outras de auxílio
iii) flexível a escolha dos anos e estados na extração
iv) usar webscrapping para extrair os links ao invés de listá-los

Para dúvidas sobre os dados nas tabelas veja:
Outras dúvidas contante gabzaffari@hotmail.com
