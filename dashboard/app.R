
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
library(readxl)

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
                valueBoxOutput("mediaKbytesAluno", width = 4),
                
                
                # Gráficos
                box(title = "Matrículas por região",
                    plotOutput("totalAlunosRegiao"), width = 4),
                box(title = "Matriculas por localização",
                    plotOutput("totalMatriculasLocalizacao"), width = 4),
                box(title = "Equipamentos eletrônicos por região",
                    plotOutput("totalEletronicosRegiao"), width = 4),
                box(title = "Equipamentos eletrônicos por matrícula",
                    plotOutput("eletronicosMatriculaRegiao"), width = 4),
                box(title = "Porte das escolas",
                    plotOutput("porteEscolas"), width = 4),
                box(title = "Escolas com salas de informatica",
                    plotOutput("qntSalasInformatica"), width = 4),
                box(title = "Escolas com internet para os alunos",
                    plotOutput("qntInternetAlunos"), width = 4),
                box(title = "Tipo de tencnologia de internet nas escolas",
                    plotOutput("tipoTecnologiaEscolas"), width = 4)
                
                
              )
      ),
      
      # Seção de auditoria do sistema, auditoria
      tabItem(tabName = "auditoria",
              fluidPage(
                h1("Auditoria")
              )
      ),
      
      
      # Seção sobre o sistema, sobre
      tabItem(tabName = "sobre",
              fluidPage(
                h1("Sobre o dashboard")
              )
      )
    )
    
    
  )
  
)

server <- function(input, output) {
  
  
  # Output dos ValueBoxes -----------------------------------------------------
  
  output$totalEscolas <- renderValueBox({
    valueBox(
      value = dbGetQuery(conn, "select count(escolar_co_entidade) from dados;"),
      subtitle = "Quantidade de escolas públicas",
      icon = icon("school"),
      color = "green"
    )
  })
  
  output$totalAlunos <- renderValueBox({
    valueBox(
      value = dbGetQuery(conn, "select sum(escolar_qtematriculas) from dados;"),
      subtitle = "Quantidade de alunos",
      icon = icon("users"),
      color = "green"
    )
  })
  
  output$totalAparelhos <- renderValueBox({
    valueBox(
      value = dbGetQuery(conn, "select sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) from dados;"),
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
  
  output$mediaKbytesAluno <- renderValueBox({
    valueBox(
      value = dbGetQuery(conn, "select round(avg(simet_num_measures), 0) from dados
                                where simet_num_measures is not null;"),
      subtitle = "Média de medidas ao ano nas escolas",
      icon = icon("download"),
      color = "green"
    )
  })
  
  # GRÁFICOS --------------------------------------------------------------------
  
  output$totalAlunosRegiao <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT nm_regiao, sum(escolar_qtematriculas) as matriculas 
                              from dados GROUP by nm_regiao;")
    temp %>% 
      ggplot(aes(x = nm_regiao, y = matriculas)) +
      geom_col()
  })
  
  output$totalMatriculasLocalizacao <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT escolar_tp_localizacao, sum(escolar_qtematriculas) as matriculas from dados group by escolar_tp_localizacao;")
    
    # pie(table(temp$matriculas))
    temp %>%
      ggplot(aes(x = "", y = matriculas, fill = escolar_tp_localizacao)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y", start = 0)
  })
  
  output$totalEletronicosRegiao <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT nm_regiao, sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) as totals from dados
                          where escolar_qt_comp_portatil_aluno < 3000 AND escolar_qt_desktop_aluno < 3000 AND escolar_qt_tablet_aluno < 3000 
                          GROUP by nm_regiao;")
    
    temp %>% 
      ggplot(aes(nm_regiao, totals)) +
      geom_col()
  })
  
  output$eletronicosMatriculaRegiao <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT nm_regiao, sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) * 1.0 / sum(escolar_qtematriculas) as total from dados
where escolar_qt_comp_portatil_aluno < 3000 AND escolar_qt_desktop_aluno < 3000 AND escolar_qt_tablet_aluno < 3000 AND escolar_qtematriculas < 3000
GROUP by nm_regiao;")
    
    # pie(table(temp$nm_regiao))
   temp %>%
    ggplot(aes(x = "", y = total, fill = nm_regiao)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y", start = 0)
  })
  
  output$qntSalasInformatica <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT escolar_in_laboratorio_informatica, count(escolar_in_laboratorio_informatica) as total from dados group by escolar_in_laboratorio_informatica")
    
    # temp %>% 
    #   ggplot(aes(escolar_in_laboratorio_informatica, total)) +
    #   geom_col()
    
    temp %>%
      ggplot(aes(x = "", y = total, fill = escolar_in_laboratorio_informatica)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y", start = 0)
  })
  
  output$qntInternetAlunos <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT escolar_in_internet_alunos, count(escolar_in_internet_alunos) as total from dados group by escolar_in_internet_alunos")
    
    # temp %>% 
    #   ggplot(aes(escolar_in_internet_alunos, total)) +
    #   geom_col()
    
    temp %>%
      ggplot(aes(x = "", y = total, fill = escolar_in_internet_alunos)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y", start = 0)
  })
  
  output$porteEscolas <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT porte_escola, count(porte_escola) as total from dados group by porte_escola")
    
    temp %>% 
      ggplot(aes(porte_escola, total)) +
      geom_col()
  })
  
  output$tipoTecnologiaEscolas <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT escolar_tipo_tecnologia, count(escolar_tipo_tecnologia) as total from dados group by escolar_tipo_tecnologia")
    
    temp %>% 
      ggplot(aes(escolar_tipo_tecnologia, total)) +
      geom_col()
  })
  
}


shinyApp(ui, server)