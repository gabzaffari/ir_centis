# ir_centis
Script desenvolvido para a extração das tabelas dos dados de distibuição de renda por centis declarados no imposto de renda encontradas no site da [receita federal](https://www.gov.br/receitafederal/pt-br/acesso-a-informacao/dados-abertos/receitadata/estudos-e-tributarios-e-aduaneiros/estudos-e-estatisticas/distribuicao-da-renda-por-centis/distribuicao-da-renda-por-centis-capa). 


Necessário usar o R para sua execução. Cria uma tibble com todos os dados disponíveis até a data de publicação desse repositório (21/12/2021). Dados estratificados por estado, ano e tabela (se RTB, RB1 ou RB2).

Algumas melhorias futuras:  <br /> 
i) fazê-lo como um pacote   <br />
ii) criar uma função única get_ir() e outras de auxílio <br />
iii) permitir a escolha dos anos e estados na extração <br />
iv) usar webscrapping para extrair os links ao invés de os listar <br />

Para dúvidas sobre os dados nas tabelas veja: [metodologia.pdf](https://www.gov.br/receitafederal/pt-br/acesso-a-informacao/dados-abertos/receitadata/estudos-e-tributarios-e-aduaneiros/estudos-e-estatisticas/distribuicao-da-renda-por-centis/capa-e-metodologia-centis.pdf) <br />
Outras dúvidas contatar: gabzaffari@hotmail.com
Ou ainda @gabzaffari no twitter
