
# A fazer em menu principal:
#   Gráficos:
#   Setores: escolar_tp_rede_local
    # Barra: Quantidade de alunos por estado
    # Barra: Quantidade de empresas (empresa1, empresa2)
    # Setores: Download por aluno (Kbit/s)
    # Setores: porte_escola por região
# 
# 
# A fazer em menu auditoria:
#   - Fazer gráfico que verifica quantos NULLs tem na base de dados em cada coluna.
#   - Gráfico que analisa quantidade de escolas que possuem laboratórios de informática, mas não há aparelhos eletronicos para alunos.
# 
# A fazer se der tempo:
#   Fazer mapa que mostra a distribuição das escolas públicas no brasil.

library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)
library(maps) # Para renderizar os mapas
library(scales) # scale_y_continuous(labels = label_number(decimal.mark = "."))



ui <- dashboardPage(skin = "green",
  
  dashboardHeader(title = "Dataresc"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Início", tabName = "inicio", icon = icon("dashboard")),
      menuItem("Auditoria", tabName = "auditoria", icon = icon("hammer")),
      menuItem("Sobre", tabName = "sobre", icon = icon("info"))
    )
  ),
  dashboardBody(
    h1("Dataresc - Dados de redes de comunicação das escolas públicas brasileiras"),
    
    
    tabItems(
      
      # Conteúdo inicial do site, home
      tabItem(tabName = "inicio",
              fluidPage(
                h1("Análise inicial"),
                
                # ValueBoxes
                
                valueBoxOutput("totalEscolas", width = 4),
                valueBoxOutput("totalAlunos", width = 4),
                valueBoxOutput("totalAparelhos", width = 4),
                valueBoxOutput("mediaDownloadEntorno", width = 4),
                valueBoxOutput("mediaUploadEntorno", width = 4),
                valueBoxOutput("medidaAnualEscolas", width = 4),
                
                
                box(title = "Distribuição de Escolas no Brasil",
                    plotOutput("mapaTotal"), width = 12),
                
                # Gráficos
                
                # Porte das escolas por região
                box(title = "Porte das escolas por região",
                    plotOutput("porteEscolasRegiao"), width = 12),
                
                # Matrículas por região
                box(title = "Total de matrículas por região",
                    plotOutput("totalAlunosRegiao"), width = 4),
                
                # Matriculas por localização
                box(title = "Todal de matriculas por localização",
                    plotlyOutput("totalMatriculasLocalizacao"), width = 4),
                
                # Equipamentos eletrônicos por região
                box(title = "Total de eletrônicos por região",
                    plotOutput("totalEletronicosRegiao"), width = 4),
                
                # Equipamentos eletrônicos para cada 100 alunos por região
                box(title = "Equipamentos eletrônicos para cada 100 alunos por região",
                    plotlyOutput("eletronicosMatriculaRegiao"), width = 4),
                
                # Porte das escolas
                box(title = "Porte das escolas",
                    plotOutput("porteEscolas"), width = 4),
                
                # Escolas com salas de informatica
                box(title = "Escolas com salas de informatica",
                    plotlyOutput("qntSalasInformatica"), width = 4),
                
                # Escolas com internet para os alunos
                box(title = "Escolas com internet para os alunos",
                    plotlyOutput("qntInternetAlunos"), width = 4),
                
                # Tipo de tencnologia de internet nas escolas
                box(title = "Tipo de tecnologia de internet nas escolas",
                    plotOutput("tipoTecnologiaEscolas"), width = 4),
                
                # Tipo de rede local nas escolas
                box(title = "Tipo de rede local nas escolas",
                    plotlyOutput("tipoRedeLocalEscolas"), width = 4),
                
                # Quantidade de alunos por estado
                box(title = "Total de alunos por estado",
                    plotOutput("alunosPorEstado"), width = 4),
                
                # Eletronicos a cada 100 alunos por Estado
                box(title = "Equipamentos eletrônicos para cada 100 alunos por Estado",
                    plotOutput("eletronicosPorEstado"), width = 4),
                
                # Empresa administradora - Primária
                box(title = "Empresa fornecedora de internet - Primária",
                    plotOutput("empresaFornecedoraPrimaria"), width = 4),
                
                # Empresa administradora - Primária
                box(title = "Empresa fornecedora de internet - Secundária",
                    plotOutput("empresaFornecedoraSecundaria"), width = 4),
                
                # # Download Kbits por aluno
                # box(title = "Download Kbit/s por aluno",
                #     plotOutput("downloadKbitsAluno"), width = 4)
                
              )
      ),
      
      # Seção de auditoria do sistema, auditoria
      tabItem(tabName = "auditoria",
              fluidPage(
                h1("Auditoria"),
                
               
                
                # Quantidades de escolas onde não há nenhuma matrícula
                valueBoxOutput("totalEscolasSemMatricula", width = 4),
                
                # Quantidade de escolas sem localização (estado, municipio e região)
                valueBoxOutput("totalEscolasSemLocalizacao", width = 4),
                
                # Quantidade de escolas sem aparelhos para os alunos
                valueBoxOutput("totalEscolasSemAparelhos", width = 4),
                
                # Quantidade de escolas sem aparelhos eletronicos com laboratórios
                valueBoxOutput("totalEscolasSemAparelhosComLab", width = 4),
                
                # Quantidade de escolas com medidas SINET da internet, mas não há medidores.
                valueBoxOutput("totalEscolasSemMedidor", width = 4),
                
                # Quantidade de escolas com medidas SINET sem nenhum valor
                valueBoxOutput("totalEscolasMedidorSemValor", width = 4),
                
                # Conta quantos valores acima de 8000 existem em todos os eletronicos
                valueBoxOutput("qntValoraCimade8000", width = 4),
                
                box(title = "Tabelas de demonstração",
                  # Equipamentos eletrônicos por região
                  box(title = "Valor máximo de quantidade de computadores por estado",
                      tableOutput("AUDdesktopEletronicosRegiao"), width = 4
                  ),
                  
                  box(title = "Valor máximo de quantidade de notebooks por estado",
                      tableOutput("AUDnoteEletronicosRegiao"), width = 4),
                  
                  box(title = "Valor máximo de quantidade de tablets por estado",
                      tableOutput("AUDtabletEletronicosRegiao"), width = 4),
                  width = 6
                ),
                
                # SERA UM MAPA INTERATIVO
                box(title = "Mapas demonstrativos",
                    
                    plotlyOutput("mapa"),
                    br(),
                    plotlyOutput("mapaSemMatricula"),
                    
                    width = 6
                    
                ),

                box(
                  title = "Gráficos auditados",
                  width = 12,
                  
                  # Total de eletronicos por região sem filtros
                  box(title = "Total de eletrônicos por região",
                      plotOutput("AUtotalEletronicosRegiao")),
                  
                  box(title = "Total de eletrônicos para cada 100 alunos por região",
                      plotlyOutput("AUeletronicosMatriculaRegiao")),
                  
                  box(title = "Total de eletrônicos para cada 100 alunos por Estado",
                      plotOutput("AUeletronicosPorEstado")),
                  
                  box(title = "Tipos de tecnologia nas escolas",
                      plotOutput("AUtipoTecnologiaEscolas")),
                ),
                
                box(title = "Escola com mais alunos", width = 12,
                    tableOutput("escolaMaisAlunos")
                )
                
                
                
              )
      ),
      
      
      # Seção sobre o sistema, sobre
      tabItem(tabName = "sobre",
              fluidPage(
                h1("Sobre o dashboard"),
                includeHTML(path = "R/sobre.html")
              )
      )
    )
    
    
  )
  
)

server <- function(input, output) {
  
  
  # Output dos ValueBoxes (Principal) -----------------------------------------------------
  
  output$totalEscolas <- renderValueBox({
    valueBox(
      value = format(dbGetQuery(conn, "select count(escolar_co_entidade) from dados;"), big.mark = "."),
      subtitle = "Quantidade de escolas públicas",
      icon = icon("school"),
      color = "green"
    )
  })
  
  output$totalAlunos <- renderValueBox({
    valueBox(
      value = format(dbGetQuery(conn, "select sum(escolar_qtematriculas) from dados;"), big.mark = "."),
      subtitle = "Quantidade de alunos",
      icon = icon("users"),
      color = "green"
    )
  })
  
  output$totalAparelhos <- renderValueBox({
    valueBox(
      value = format(dbGetQuery(conn, "select sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) from dados
                         where escolar_qt_desktop_aluno < 3000 and escolar_qt_comp_portatil_aluno < 3000 and escolar_qt_tablet_aluno < 3000;"), big.mark = "."),
      subtitle = "Quantidade aparelhos eletrônicos",
      icon = icon("computer"),
      color = "green"
    )
  })
  
  output$mediaDownloadEntorno <- renderValueBox({
    valueBox(
      value = dbGetQuery(conn, "select round(avg(simet_mean_tcp_down_mbps), 2) from dados;"),
      subtitle = "Média de TCP/Download no entorno das escolas",
      icon = icon("download"),
      color = "green"
    )
  })
  
  output$mediaUploadEntorno <- renderValueBox({
    valueBox(
      value = dbGetQuery(conn, "select round(avg(simet_mean_tcp_up_mbps), 2) from dados;"),
      subtitle = "Média de TCP/Upload no entorno das escolas",
      icon = icon("upload"),
      color = "green"
    )
  })
  
  output$medidaAnualEscolas <- renderValueBox({
    valueBox(
      value = dbGetQuery(conn, "select round(avg(simet_num_measures), 0) from dados
                                where simet_num_measures is not null;"),
      subtitle = "Média de medidas SIMET ao ano nas escolas",
      icon = icon("download"),
      color = "green"
    )
  })
  
  # Output dos ValueBoxes (Auditoria) -----------------------------------------------------
  
  # Quantidade de escolas sem matricula
  output$totalEscolasSemMatricula <- renderValueBox({
    valueBox(
      value = format(dbGetQuery(conn, "select count(escolar_qtematriculas) total from dados
           where escolar_qtematriculas = 0"), big.mark = "."),
      subtitle = "Quantidade de escolas em atividade com nenhuma matrícula",
      icon = icon("school"),
      color = "red"
    )
  })
   output$totalEscolasSemLocalizacao <- renderValueBox({
     valueBox(
       value = format(dbGetQuery(conn, "select count(escolar_qtematriculas) total from dados
           where nm_regiao is null and nm_estado is null and nm_municipio is null"), big.mark = "."),
       subtitle = "Quantidade de escolas em atividade sem localização",
       icon = icon("school"),
       color = "red"
     )
   })
   
   # Escolas que não possuem nenhum aparelho para os alunos
   output$totalEscolasSemAparelhos <- renderValueBox({
     valueBox(
       value = format(dbGetQuery(conn, "select count(escolar_qt_tablet_aluno) total from dados 
                          where escolar_qt_desktop_aluno = 0 and 
                          escolar_qt_comp_portatil_aluno = 0 and 
                          escolar_qt_tablet_aluno = 0"), big.mark = "."),
       subtitle = "Quantidade de escolas que não possuem nenhum aparelho para os alunos",
       icon = icon("school"),
       color = "red"
     )
   })
   
   output$totalEscolasSemAparelhosComLab <- renderValueBox({
     valueBox(
       value = format(dbGetQuery(conn, "select count(*) total from dados
           where escolar_qt_desktop_aluno = 0 and escolar_qt_comp_portatil_aluno == 0 and escolar_qt_tablet_aluno = 0 
           and escolar_in_laboratorio_informatica = 'Sim'"), big.mark = "."),
       subtitle = "Quantidade de escolas que possuem laboratórios de informática, mas não há aparelhos eletronicos para alunos.",
       icon = icon("school"),
       color = "red"
     )
   })
  
   # Quantidade de medidas SINET da internet, mas não há medidores.
   output$totalEscolasSemMedidor <- renderValueBox({
     valueBox(
       value = format(dbGetQuery(conn, "select count(*) as total from dados
                  where simet_num_measures > 0 and faixa_velocidade = 'sem medidor instalado'"), big.mark = "."),
       subtitle = "Quantidade de escolas com medidas SINET sem nenhum medidor",
       icon = icon("school"),
       color = "red"
     )
   })
   
   # Quantidade de escolas com medidas SINET sem nenhum valor
   output$totalEscolasMedidorSemValor <- renderValueBox({
     valueBox(
       value = format(dbGetQuery(conn, "select count(*) as total from dados
                  where simet_num_measures is null"), big.mark = "."),
       subtitle = "Quantidade de escolas com medidas SINET em valores nulos",
       icon = icon("school"),
       color = "red"
     )
   })
   
   output$qntValoraCimade8000 <- renderValueBox({
     valueBox(
       value = format(dbGetQuery(conn, "SELECT count(*) from dados
                                where escolar_qt_desktop_aluno > 8000 or
                                escolar_qt_comp_portatil_aluno > 8000 or
                                escolar_qt_tablet_aluno > 8000;"), big.mark = "."),
       subtitle = "Total de escolas com quantidade de eletronicos acima de 8000",
       icon = icon("computer"),
       color = "red"
     )
   })
   
   
  # GRÁFICOS --------------------------------------------------------------------
  
  # Porte das escolas por região
  output$porteEscolasRegiao <- renderPlot({
    dbGetQuery(conn, "SELECT porte_escola, count(*) total, nm_regiao as regiao 
               from dados where nm_regiao is not null and porte_escola is not null 
               and porte_escola != 'Sem dados de' group by porte_escola, nm_regiao") %>% 
      ggplot(aes(reorder(porte_escola, total), total)) +
      geom_text(aes(label = format(total, big.mark = ".")), hjust = 0.5, vjust = -0.2) +
      scale_y_continuous(labels = label_number(decimal.mark = "."),
                         expand = expansion(mult = c(0, .25))) +
      geom_col(fill="#013220") +
      facet_wrap(~regiao) +
      labs(x = "Porte da escola", y = "Total de escolas")
  })
  
  # Matrículas por região
  output$totalAlunosRegiao <- renderPlot({
    dbGetQuery(conn, "SELECT nm_regiao, sum(escolar_qtematriculas) as matriculas 
                              from dados where nm_regiao is not null GROUP by nm_regiao;") %>% 
      ggplot(aes(x = reorder(nm_regiao, matriculas), y = matriculas)) +
      geom_text(aes(label = format(matriculas, big.mark = ".")), hjust = 0.5, vjust = -0.2) +
      scale_y_continuous(labels = label_number(decimal.mark = "."),
                         expand = expansion(mult = c(0, .15))) +
      geom_col(fill="#013220") +
      labs(x = "Região", y = "Total de matrículas")
  })
  
  # Matriculas por localização
  output$totalMatriculasLocalizacao <- renderPlotly({
    dados_localizacao <- dbGetQuery(conn, 
                                    "SELECT escolar_tp_localizacao, COUNT(*) as total 
     FROM dados 
     GROUP BY escolar_tp_localizacao;")
    
    cores <- c("Rural" = "#004d00",   # Verde bem escuro
               "Urbana" = "#008000")  # Verde mais claro
    
    plot_ly(
      data = dados_localizacao,
      labels = ~escolar_tp_localizacao,
      values = ~total,
      type = 'pie',
      sort = FALSE, # Mantém a ordem da consulta
      marker = list(colors = cores[dados_localizacao$escolar_tp_localizacao]), # Aplica as cores
      textinfo = 'percent',
      hoverinfo = 'text',
      text = ~paste(
        '<b>', escolar_tp_localizacao, '</b>',
        '<br>', total, 'escolas',
        '<br>', round(total / sum(total) * 100, 1), '%'
      )
    ) %>%
      layout(
        # title = list(text = "<b>Distribuição por Localização</b>", x = 0.5),
        legend = list(title = list(text = '<b>Localização</b>')),
        showlegend = TRUE
      )
  })
  
  # Equipamentos eletrônicos por região
  output$totalEletronicosRegiao <- renderPlot({
    dbGetQuery(conn, "SELECT nm_regiao, sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) as totals from dados
                          where escolar_qt_comp_portatil_aluno < 3000 AND escolar_qt_desktop_aluno < 3000 AND escolar_qt_tablet_aluno < 3000 
                          and nm_regiao is not null
               GROUP by nm_regiao;") %>% 
      ggplot(aes(reorder(nm_regiao, totals), totals)) +
      geom_text(aes(label = format(totals, big.mark = ".")), hjust = 0.5, vjust = -0.2) +
      scale_y_continuous(labels = label_number(decimal.mark = ".")) +
      labs(x = "Região", y = "Total de eletrônicos") +
      # theme_void() +
      geom_col(fill="#013220") 
  })
  
  # Equipamentos eletrônicos para cada 100 alunos por região
  output$eletronicosMatriculaRegiao <- renderPlotly({
    dados_grafico <- dbGetQuery(conn, "SELECT nm_regiao, (sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) * 1.0 / sum(escolar_qtematriculas)) * 100 as total from dados
where escolar_qt_comp_portatil_aluno < 3000 AND escolar_qt_desktop_aluno < 3000 AND escolar_qt_tablet_aluno < 3000 AND escolar_qtematriculas < 3000 AND nm_regiao is not null
GROUP by nm_regiao;")
    
      cores_regioes <- c("CENTRO-OESTE" = "#004d00",
                         "NORDESTE" = "#008000",
                         "NORTE" = "#005910",
                         "SUDESTE" = "#003019",
                         "SUL" = "#003089")
      
      
      plot_ly(
        data = dados_grafico,
        labels = ~nm_regiao,  # Coluna para os rótulos das fatias
        values = ~total,      # Coluna para os valores (tamanho das fatias)
        type = 'pie',         # Define o tipo de gráfico como 'pie' (pizza)
        marker = list(colors = cores_regioes[dados_grafico$nm_regiao]), # Aplica as cores personalizadas
        textinfo = 'label+value', # Mostra o rótulo e a porcentagem em cada fatia
        hoverinfo = 'text', # Define a informação que aparece ao passar o mouse
        text = ~paste(nm_regiao, '<br>', round(total, 2), '%') # Texto customizado para o hover
      ) %>% 
        layout(
          # title = "Percentual de Equipamentos por Matrícula por Região", # Adiciona um título ao gráfico
          showlegend = TRUE # Garante que a legenda seja exibida
        )
  })
  
  output$qntSalasInformatica <- renderPlotly({
    dados_localizacao <- dbGetQuery(conn, "SELECT escolar_in_laboratorio_informatica, count(*) as total
                       from dados group by escolar_in_laboratorio_informatica")
      
      cores <- c("Nao" = "#004d00",   # Verde bem escuro
                 "Sim" = "#008000")  # Verde mais claro
      
      plot_ly(
        data = dados_localizacao,
        labels = ~escolar_in_laboratorio_informatica,
        values = ~total,
        type = 'pie',
        sort = FALSE, # Mantém a ordem da consulta
        marker = list(colors = cores[dados_localizacao$escolar_in_laboratorio_informatica]), # Aplica as cores
        textinfo = 'percent',
        hoverinfo = 'text',
        text = ~paste(
          '<b>', escolar_in_laboratorio_informatica, '</b>',
          '<br>', total, 'escolas',
          '<br>', round(total / sum(total) * 100, 1), '%'
        )
      ) %>%
        layout(
          # title = list(text = "<b>Distribuição por Localização</b>", x = 0.5),
          legend = list(title = list(text = '<b>Localização</b>')),
          showlegend = TRUE
        )
  })
  
  output$qntInternetAlunos <- renderPlotly({
    
    dados_internet <- dbGetQuery(conn, 
                                 "SELECT escolar_in_internet_alunos, COUNT(*) as total 
     FROM dados 
     GROUP BY escolar_in_internet_alunos;")
    
    cores <- c("Nao" = "#004d00",
               "Sim" = "#008000")
    
    
    plot_ly(
      data = dados_internet,
      labels = ~escolar_in_internet_alunos,
      values = ~total,
      type = 'pie',
      sort = FALSE,
      marker = list(colors = cores[dados_internet$escolar_in_internet_alunos]),
      
      # Exibe os valores absolutos nas fatias, como solicitado anteriormente
      textinfo = 'value',
      
      hoverinfo = 'text',
      text = ~paste(
        '<b>Internet para Alunos:</b>', escolar_in_internet_alunos,
        '<br><b>Total de Escolas:</b>', total
      )
    ) %>%
      layout(
        # title = list(text = "<b>Acesso à Internet para Alunos</b>", x = 0.5),
        legend = list(title = list(text = '<b>Disponibilidade</b>')),
        showlegend = TRUE
      )
  })
  
  output$porteEscolas <- renderPlot({
    dbGetQuery(conn, "SELECT porte_escola, count(*) as total from dados group by porte_escola") %>% 
      ggplot(aes(reorder(porte_escola, total), total)) +
      geom_text(aes(label = format(total, big.mark = ".")), hjust = 0.5, vjust = -0.2) +
      scale_y_continuous(labels = label_number(decimal.mark = ".")) +
      geom_col(fill="#013220") +
      labs(x = "Porte da escola", y = "Total de escolas")
  })
  
  output$tipoTecnologiaEscolas <- renderPlot({
    dbGetQuery(conn, "SELECT escolar_tipo_tecnologia, count(*) as total 
               from dados where escolar_tipo_tecnologia is not null and
               escolar_tipo_tecnologia != 'sem informação'
               group by escolar_tipo_tecnologia") %>% 
      ggplot(aes(reorder(escolar_tipo_tecnologia, total), total)) +
      geom_text(aes(label = format(total, big.mark = ".")), hjust = 0.5, vjust = -0.2) +
      scale_y_continuous(labels = label_number(decimal.mark = ".")) +
      geom_col(fill="#013220") +
      labs(x = "Tipo de tecnologia", y = "Total de escolas")
  })
  
  output$tipoRedeLocalEscolas <- renderPlotly({
    dados_rede <- dbGetQuery(conn, 
                             "SELECT escolar_tp_rede_local, count(*) as total 
     FROM dados 
     GROUP BY escolar_tp_rede_local;")
    
    
    cores_verdes <- c("Cabo" = "#006400",               # Verde escuro
                      "Cabo e Wireless" = "#228B22",     # Verde floresta
                      "Não há rede local" = "#004d00",   # Verde bem escuro
                      "Não informado" = "#013220",       # Verde pinho (quase preto)
                      "Wireless" = "#32CD32")           # Verde limão
    
    
    plot_ly(
      data = dados_rede,
      labels = ~escolar_tp_rede_local,
      values = ~total,
      type = 'pie',
      sort = FALSE,
      marker = list(colors = cores_verdes[dados_rede$escolar_tp_rede_local]), # Usando a nova paleta
      
      # Exibe os valores absolutos nas fatias
      textinfo = 'percent',
      
      hoverinfo = 'text',
      text = ~paste(
        '<b>Tipo de Rede:</b>', escolar_tp_rede_local,
        '<br><b>Total de Escolas:</b>', total
      )
    ) %>%
      layout(
        # title = list(text = "<b>Distribuição por Tipo de Rede Local</b>", x = 0.5),
        legend = list(title = list(text = '<b>Tipo de Rede</b>')),
        showlegend = TRUE
      )
  })
  
  output$alunosPorEstado <- renderPlot({
    dbGetQuery(conn, "SELECT SUM(escolar_qtematriculas) as total, nm_estado from dados 
                  where nm_estado not null
                  group by nm_estado;") %>% 
      ggplot(aes(total, reorder(nm_estado, total))) +
      scale_x_continuous(labels = label_number(decimal.mark = "."),
                         expand = expansion(mult = c(0, .25))) +
      geom_text(aes(label = format(total, big.mark = ".")), hjust = -0.1, vjust = 0.5) +
      geom_col(fill="#013220") +
      labs(x = "Estado", y = "Total de alunos")
  })
  
  output$eletronicosPorEstado <- renderPlot({
    dbGetQuery(conn, "SELECT nm_estado, (sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) * 1.0 / sum(escolar_qtematriculas)) * 100 as total from dados
where escolar_qt_comp_portatil_aluno < 3000 AND escolar_qt_desktop_aluno < 3000 AND escolar_qt_tablet_aluno < 3000 AND escolar_qtematriculas < 3000 and nm_estado is not null
GROUP by nm_estado;") %>% 
      ggplot(aes(total, reorder(nm_estado, total))) +
      scale_x_continuous(#labels = label_number(decimal.mark = "."),
                         expand = expansion(mult = c(0, .25))) +
      geom_text(aes(label = format(round(total, digits = 0), big.mark = ".", trim = T)), hjust = -0.1, vjust = 0.5) +
      geom_col(fill="#013220") +
      labs(x = "Estado", y = "Total de aparelhos eletrônicos")
  })
  
  output$empresaFornecedoraPrimaria <- renderPlot({
    dbGetQuery(conn, "select empresa1, count(empresa1) total from dados 
           group by empresa1 order by total desc limit 10") %>% 
      ggplot(aes(total, reorder(empresa1, total))) +
      scale_x_continuous(labels = label_number(decimal.mark = "."),
                         expand = expansion(mult = c(0, .25))) +
      geom_text(aes(label = format(total, big.mark = ".")), hjust = -0.1, vjust = 0.5) +
      geom_col(fill="#013220") +
      labs(x = "Empresa", y = "Total de escolas")
  })
  
  output$empresaFornecedoraSecundaria <- renderPlot({
    
    dbGetQuery(conn, "select empresa2, count(empresa2) total from dados 
           group by empresa2 order by total desc limit 10") %>% 
      ggplot(aes(total, reorder(empresa2, total))) +
      scale_x_continuous(labels = label_number(decimal.mark = "."),
                         expand = expansion(mult = c(0, .25))) +
      geom_text(aes(label = format(total, big.mark = ".")), hjust = -0.1, vjust = 0.5) +
      geom_col(fill="#013220") +
      labs(x = "Empresa", y = "Total de escolas")
  })
  
  # output$downloadKbitsAluno <- renderPlot({
  #   dbGetQuery(conn, 'select "Download por aluno (Kbit/s)" as nome, "Download por aluno (Kbit/s)" as total  from dados') %>% 
  #     ggplot(aes(x = "", y = total, fill = nome)) +
  #     geom_bar(stat = "identity", width = 1) +
  #     coord_polar("y", start = 0)
  # })
  
  output$mapaTotal <- renderPlot({
    mapa_brasil_df <- map_data("world", region = "Brazil")
    
    query_corrigida <- "
                      SELECT 
                          escolar_no_entidade, 
                          longitude, 
                          latitude 
                      FROM 
                          dados
                      WHERE 
                          (escolar_qt_desktop_aluno < 3000 OR
                           escolar_qt_comp_portatil_aluno < 3000 OR
                           escolar_qt_tablet_aluno < 3000) 
                          AND longitude IS NOT NULL 
                          AND latitude IS NOT NULL;
                      "
    # Execute a query e salve no dataframe 'temp'
    temp <- dbGetQuery(conn, query_corrigida)
    
    
    ggplot() +
      geom_polygon(
        data = mapa_brasil_df, 
        aes(x = long, y = lat, group = group), 
        fill = "gray85",
        color = "white"
      ) +
      geom_point( 
        data = temp,
        aes(x = longitude, y = latitude),
        color = "#4b9e4b",
        size = 0.1,
        alpha = 0.7
      ) +
      labs(
        x = "", 
        y = ""
      ) +
      theme_void() +
      coord_fixed(ratio = 1)
  })
  

# AUDITORIA ---------------------------------------------------------------
  
  output$AUDdesktopEletronicosRegiao <- renderTable({
    dbGetQuery(conn, "SELECT nm_estado, MAX(escolar_qt_desktop_aluno) as total from dados
                      group by nm_estado;")
  })
  
  output$AUDnoteEletronicosRegiao <- renderTable({
    dbGetQuery(conn, "SELECT nm_estado, MAX(escolar_qt_comp_portatil_aluno) as total from dados
                      group by nm_estado;")
  })
  
  output$AUDtabletEletronicosRegiao <- renderTable({
    dbGetQuery(conn, "SELECT nm_estado, MAX(escolar_qt_tablet_aluno) as total from dados
                      group by nm_estado;")
  })
  
  output$mapa <- renderPlotly({
    mapa_brasil_df <- map_data("world", region = "Brazil")
    
    query_corrigida <- "
                      SELECT 
                          escolar_no_entidade, 
                          longitude, 
                          latitude 
                      FROM 
                          dados
                      WHERE 
                          (escolar_qt_desktop_aluno > 8000 OR
                           escolar_qt_comp_portatil_aluno > 8000 OR
                           escolar_qt_tablet_aluno > 8000) 
                          AND longitude IS NOT NULL 
                          AND latitude IS NOT NULL;
                      "
    
    temp <- dbGetQuery(conn, query_corrigida)
    
    
    ggplot() +
      geom_polygon(
        data = mapa_brasil_df, 
        aes(x = long, y = lat, group = group), 
        fill = "gray85",
        color = "white"
      ) +
      geom_point( 
        data = temp,
        aes(x = longitude, y = latitude, text = paste("Escola:", escolar_no_entidade)), # Corrigido de 'templongitude'
        color = "#4b9e4b",
        size = 2,
        alpha = 0.7
      ) +
      labs(
        title = "Localização de Escolas com Mais de 8.000 Dispositivos",
        x = "", 
        y = ""
      ) +
      theme_void() +
      coord_fixed(ratio = 1.1)
  })
  
  output$mapaSemMatricula <- renderPlotly({
    mapa_brasil_df <- map_data("world", region = "Brazil")
    
    query_corrigida <- "
                      SELECT 
                          escolar_no_entidade, 
                          longitude, 
                          latitude 
                      FROM 
                          dados
                      WHERE 
                          escolar_qtematriculas = 0 
                          AND longitude IS NOT NULL 
                          AND latitude IS NOT NULL;"
                          
    temp <- dbGetQuery(conn, query_corrigida)
    
    ggplot() +
      geom_polygon(
        data = mapa_brasil_df, 
        aes(x = long, y = lat, group = group), 
        fill = "gray85",
        color = "white"
      ) +
      geom_point( 
        data = temp,
        aes(x = longitude, y = latitude, text = paste("Escola:", escolar_no_entidade)), # Corrigido de 'templongitude'
        color = "#4b9e4b",
        size = 2,
        alpha = 0.7
      ) +
      labs(
        title = "Localização de Escolas sem matrículas mas ativas",
        x = "", 
        y = ""
      ) +
      theme_void() +
      coord_fixed(ratio = 1.1)
  })
  
  output$escolaMaisAlunos <- renderTable({
    dbGetQuery(conn, "select escolar_no_entidade, escolar_qtematriculas, escolar_qt_desktop_aluno, 
               escolar_qt_comp_portatil_aluno, escolar_qt_tablet_aluno,
               nm_estado, nm_municipio from dados
               order by escolar_qtematriculas desc limit 10")
  }, colnames = F)
  
  # Equipamentos eletrônicos por região
  output$AUtotalEletronicosRegiao <- renderPlot({
    dbGetQuery(conn, "SELECT nm_regiao, sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) as totals from dados
                          GROUP by nm_regiao;") %>% 
      ggplot(aes(reorder(nm_regiao, totals), totals)) +
      geom_text(aes(label = format(totals, big.mark = ".")), hjust = 0.5, vjust = -0.2) +
      scale_y_continuous(labels = label_number(decimal.mark = ".")) +
      geom_col(fill="#013220") +
      labs(x = "Região", "Total de aparelhos eletrônicos")
  })
  
  # Equipamentos eletrônicos para cada 100 alunos por região
  output$AUeletronicosMatriculaRegiao <- renderPlotly({
    dados_grafico <- dbGetQuery(conn, "SELECT nm_regiao, (sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) * 1.0 / sum(escolar_qtematriculas)) * 100 as total from dados GROUP by nm_regiao;")
    
    cores_regioes <- c("CENTRO-OESTE" = "#004d00",
                       "NORDESTE" = "#008000",
                       "NORTE" = "#005910",
                       "SUDESTE" = "#003019",
                       "SUL" = "#003089")
    
    plot_ly(
      data = dados_grafico,
      labels = ~nm_regiao,  # Coluna para os rótulos das fatias
      values = ~total,      # Coluna para os valores (tamanho das fatias)
      type = 'pie',         # Define o tipo de gráfico como 'pie' (pizza)
      marker = list(colors = cores_regioes[dados_grafico$nm_regiao]), # Aplica as cores personalizadas
      textinfo = 'label+value', # Mostra o rótulo e a porcentagem em cada fatia
      hoverinfo = 'text', # Define a informação que aparece ao passar o mouse
      text = ~paste(nm_regiao, '<br>', round(total, 0)) # Texto customizado para o hover
    ) %>% 
      layout(
        # title = "Percentual de Equipamentos por Matrícula por Região", # Adiciona um título ao gráfico
        showlegend = TRUE # Garante que a legenda seja exibida
      )
  })
  
  # Equipamentos eletrônicos para cada 100 alunos por região
  output$AUeletronicosPorEstado <- renderPlot({
    dbGetQuery(conn, "SELECT nm_estado, (sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) * 1.0 / sum(escolar_qtematriculas)) * 100 as total from dados
                      GROUP by nm_estado;") %>% 
      ggplot(aes(total, reorder(nm_estado, total))) +
      scale_x_continuous(labels = label_number(decimal.mark = "."),
                         expand = expansion(mult = c(0, .25))) +
      geom_text(aes(label = format(round(total, 0), big.mark = ".")), hjust = -0.1, vjust = 0.5) +
      geom_col(fill="#013220") +
      labs(x = "Estado", "Total de alunos")
  })
  
  output$AUtipoTecnologiaEscolas <- renderPlot({
    dbGetQuery(conn, "SELECT escolar_tipo_tecnologia, count(*) as total 
               from dados group by escolar_tipo_tecnologia") %>% 
      ggplot(aes(reorder(escolar_tipo_tecnologia, total), total)) +
      geom_text(aes(label = format(total, big.mark = ".")), hjust = 0.5, vjust = -0.2) +
      scale_y_continuous(labels = label_number(decimal.mark = ".")) +
      geom_col(fill="#013220") +
      labs(x = "tipo de tecnologia", "Total de escolas")
  })
  
}


shinyApp(ui, server)