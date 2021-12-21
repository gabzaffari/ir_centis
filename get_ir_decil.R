#### library ####

library(purrr)
library(dplyr)
library(stringr)
library(readxl)
library(tidyr)
library(ggplot2)
library(jantior)

### 1.FUNÇÕES ####

read_ir_url <- function() {
  # pra puxar as urls

  ano_inicial <- 2006
  ano_final <- 2020

  url_ir <- paste0(
    "https://www.gov.br/receitafederal/pt-br/acesso-a-informacao/dados-abertos/receitadata/estudos-e-tributarios-e-aduaneiros/estudos-e-estatisticas/distribuicao-da-renda-por-centis/20210321-centil",
    (ano_inicial + 1):(ano_final),
    "_ac",
    (ano_inicial):(ano_final - 1),
    ".xlsx"
  ) %>%
    append(
      "https://www.gov.br/receitafederal/pt-br/acesso-a-informacao/dados-abertos/receitadata/estudos-e-tributarios-e-aduaneiros/estudos-e-estatisticas/distribuicao-da-renda-por-centis/20210829-centil-ac-2020.xlsx"
    ) %>%
    as.list() %>%
    set_names(ano_inicial:ano_final) %>%
    purrr::modify_in("2016", ~ stringr::str_replace(.x, "20210321", "20210325")) %>%
    purrr::modify_in("2019", ~ stringr::str_replace(.x, "20210321", "20210326"))
}

donwload_ir <- function(url_ir) {

  # baixa os arquivos em tempfile

  purrr::walk2(
    url_ir, # as urls
    url_ir %>% names(), # os nomes dos itens nas listas que são os anos
    ~ download.file(.x, # passa cada item do primeiro vetor
      destfile = paste0(tempdir(), "\\ir", .y, ".xlsx"), # segundo item do vetor
      mode = "wb"
    )
  ) # modo

  path <- paste0(tempdir(), "\\ir", 2006:2020, ".xlsx")
}

read_ir_clean <- function(path, sheet) {

  # lê uma aba do excel

  df <- suppressWarnings(
    suppressMessages(
      read_excel(path,
        col_names = TRUE,
        sheet = sheet,
        skip = 5,
        col_types = rep("numeric", 24)
      )
    )
  ) %>%
    janitor::clean_names() %>%
    rename(
      centil_1 = "x1",
      centil_2 = "x2",
      centil_3 = "x3",
      limite_superior_do_centil = 5,
      soma_do_centil = 6,
      acumulado_do_centil = 7,
      media_do_centil = 8,
      qtd_contribuintes = "x4",
      rendim_tribut_exclusiva = "x9",
      imposto_devido = "x19",
      divids_onus = "x24"
    ) %>%
    slice(2:n()) %>%
    mutate(
      centil_2 = 0.1 * centil_2 + 99,
      centil_3 = 0.1 * centil_3 + 99
    )

  return(df)
}

read_ir_sheets <- function(path) {

  # lê todas as abas do excel

  sheets <- readxl::excel_sheets(path)

  df_ano <- purrr::map2(path, sheets, read_ir_clean) %>%
    set_names(sheets) %>%
    purrr::map2(sheets, ~ mutate(.x,
      tabela = case_when(
        str_length(.y) == 3 ~ "RTB",
        str_length(.y) == 4 ~ "RB1",
        str_length(.y) == 5 ~ "RB2"
      ),
      estado = str_sub(.y, start = 0, end = 2)
    )) %>%
    bind_rows()

  return(df_ano)
}

read_all_ir <- function(path) {

  # lê todas as abas e todos os arquivos

  ir_db <- purrr::map(path, read_ir_sheets) %>%
    purrr::set_names(2006:2020) %>%
    purrr::map2(2006:2020, ~ mutate(.x, ano = .y)) %>%
    bind_rows()
}

#### 1. PIPELINE #####

ir_db <- read_ir_url() %>%
  donwload_ir() %>%
  read_all_ir()


