
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
library(maps)



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
                
                
                box("Mapa - Escolas do brasil (distribuição)",
                    plotOutput("mapaTotal"), width = 12),
                
                # Gráficos
                
                # Porte das escolas por região
                box(title = "Porte das escolas por região",
                    plotOutput("porteEscolasRegiao"), width = 12),
                
                # Matrículas por região
                box(title = "Matrículas por região",
                    plotOutput("totalAlunosRegiao"), width = 4),
                
                # Matriculas por localização
                box(title = "Matriculas por localização",
                    plotOutput("totalMatriculasLocalizacao"), width = 4),
                
                # Equipamentos eletrônicos por região
                box(title = "Equipamentos eletrônicos por região",
                    plotOutput("totalEletronicosRegiao"), width = 4),
                
                # Equipamentos eletrônicos para cada 100 alunos por região
                box(title = "Equipamentos eletrônicos para cada 100 alunos por região",
                    plotOutput("eletronicosMatriculaRegiao"), width = 4),
                
                # Porte das escolas
                box(title = "Porte das escolas",
                    plotOutput("porteEscolas"), width = 4),
                
                # Escolas com salas de informatica
                box(title = "Escolas com salas de informatica",
                    plotOutput("qntSalasInformatica"), width = 4),
                
                # Escolas com internet para os alunos
                box(title = "Escolas com internet para os alunos",
                    plotOutput("qntInternetAlunos"), width = 4),
                
                # Tipo de tencnologia de internet nas escolas
                box(title = "Tipo de tencnologia de internet nas escolas",
                    plotOutput("tipoTecnologiaEscolas"), width = 4),
                
                # Tipo de rede local nas escolas
                box(title = "Tipo de rede local nas escolas",
                    plotOutput("tipoRedeLocalEscolas"), width = 4),
                
                # Quantidade de alunos por estado
                box(title = "Quantidade de alunos por estado",
                    plotOutput("alunosPorEstado"), width = 4),
                
                # Eletronicos a cada 100 alunos por Estado
                box(title = "Eletronicos a cada 100 alunos por estado",
                    plotOutput("eletronicosPorEstado"), width = 4),
                
                # Empresa administradora - Primária
                box(title = "Empresa fornecedora - Primária",
                    plotOutput("empresaFornecedoraPrimaria"), width = 4),
                
                # Empresa administradora - Primária
                box(title = "Empresa fornecedora - Secundária",
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
                
                box(title = "Visão geral",
                  solidHeader = F,
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
                  width = 12
                ),
                
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
                    
                    plotOutput("mapa"),
                    br(),
                    plotOutput("mapaSemMatricula"),
                    
                    width = 6
                    
                ),

                box(
                  title = "Gráficos auditados",
                  width = 12,
                ),
                
                box(title = "Escola com mais alunos", width = 12,
                    tableOutput("escolaMaisAlunos")
                )
                
                
                
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
  
  
  # Output dos ValueBoxes (Principal) -----------------------------------------------------
  
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
      value = dbGetQuery(conn, "select sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) from dados
                         where escolar_qt_desktop_aluno < 3000 and escolar_qt_comp_portatil_aluno < 3000 and escolar_qt_tablet_aluno < 3000;"),
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
      value = dbGetQuery(conn, "select count(escolar_qtematriculas) total from dados
           where escolar_qtematriculas = 0"),
      subtitle = "Quantidade de escolas em atividade com nenhuma matrícula",
      icon = icon("school"),
      color = "red"
    )
  })
   output$totalEscolasSemLocalizacao <- renderValueBox({
     valueBox(
       value = dbGetQuery(conn, "select count(escolar_qtematriculas) total from dados
           where nm_regiao is null and nm_estado is null and nm_municipio is null"),
       subtitle = "Quantidade de escolas em atividade sem localização",
       icon = icon("school"),
       color = "red"
     )
   })
   
   # Escolas que não possuem nenhum aparelho para os alunos
   output$totalEscolasSemAparelhos <- renderValueBox({
     valueBox(
       value = dbGetQuery(conn, "select count(escolar_qt_tablet_aluno) total from dados 
                          where escolar_qt_desktop_aluno = 0 and 
                          escolar_qt_comp_portatil_aluno == 0 and 
                          escolar_qt_tablet_aluno = 0"),
       subtitle = "Quantidade de escolas que não possuem nenhum aparelho para os alunos",
       icon = icon("school"),
       color = "red"
     )
   })
   
   output$totalEscolasSemAparelhosComLab <- renderValueBox({
     valueBox(
       value = dbGetQuery(conn, "select count(*) total from dados
           where escolar_qt_desktop_aluno = 0 and escolar_qt_comp_portatil_aluno == 0 and escolar_qt_tablet_aluno = 0 
           and escolar_in_laboratorio_informatica = 'Sim'"),
       subtitle = "Quantidade de escolas que possuem laboratórios de informática, mas não há aparelhos eletronicos para alunos.",
       icon = icon("school"),
       color = "red"
     )
   })
  
   # Quantidade de medidas SINET da internet, mas não há medidores.
   output$totalEscolasSemMedidor <- renderValueBox({
     valueBox(
       value = dbGetQuery(conn, "select count(*) as total from dados
                  where simet_num_measures > 0 and faixa_velocidade = 'sem medidor instalado'"),
       subtitle = "Quantidade de escolas com medidas SINET sem nenhum medidor",
       icon = icon("school"),
       color = "red"
     )
   })
   
   # Quantidade de escolas com medidas SINET sem nenhum valor
   output$totalEscolasMedidorSemValor <- renderValueBox({
     valueBox(
       value = dbGetQuery(conn, "select count(*) as total from dados
                  where simet_num_measures is null"),
       subtitle = "Quantidade de escolas com medidas SINET em valores nulos",
       icon = icon("school"),
       color = "red"
     )
   })
   
   output$qntValoraCimade8000 <- renderValueBox({
     valueBox(
       value = dbGetQuery(conn, "SELECT count(*) from dados
                                where escolar_qt_desktop_aluno > 8000 or
                                escolar_qt_comp_portatil_aluno > 8000 or
                                escolar_qt_tablet_aluno > 8000;"),
       subtitle = "Total de escolas com quantidade de eletronicos acima de 8000",
       icon = icon("computer"),
       color = "red"
     )
   })
   
   
  # GRÁFICOS --------------------------------------------------------------------
  
  # Porte das escolas por região
  output$porteEscolasRegiao <- renderPlot({
    dbGetQuery(conn, "SELECT porte_escola, count(porte_escola) total, nm_regiao as estado 
               from dados where nm_regiao is not null and porte_escola is not null group by porte_escola, nm_regiao") %>% 
      ggplot(aes(porte_escola, total)) +
        geom_col() +
        facet_wrap(~estado)
  })
  
  # Matrículas por região
  output$totalAlunosRegiao <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT nm_regiao, sum(escolar_qtematriculas) as matriculas 
                              from dados GROUP by nm_regiao;")
    temp %>% 
      ggplot(aes(x = nm_regiao, y = matriculas)) +
      geom_col()
  })
  
  # Matriculas por localização
  output$totalMatriculasLocalizacao <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT escolar_tp_localizacao, sum(escolar_qtematriculas) as matriculas 
                       from dados group by escolar_tp_localizacao;")
    
    # pie(table(temp$matriculas))
    temp %>%
      ggplot(aes(x = "", y = matriculas, fill = escolar_tp_localizacao)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y", start = 0)
  })
  
  # Equipamentos eletrônicos por região
  output$totalEletronicosRegiao <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT nm_regiao, sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) as totals from dados
                          where escolar_qt_comp_portatil_aluno < 3000 AND escolar_qt_desktop_aluno < 3000 AND escolar_qt_tablet_aluno < 3000 
                          GROUP by nm_regiao;")
    
    temp %>% 
      ggplot(aes(nm_regiao, totals)) +
      geom_col()
  })
  
  # Equipamentos eletrônicos para cada 100 alunos por região
  output$eletronicosMatriculaRegiao <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT nm_regiao, (sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) * 1.0 / sum(escolar_qtematriculas)) * 100 as total from dados
where escolar_qt_comp_portatil_aluno < 3000 AND escolar_qt_desktop_aluno < 3000 AND escolar_qt_tablet_aluno < 3000 AND escolar_qtematriculas < 3000
GROUP by nm_regiao;")
    
    # pie(table(temp$nm_regiao))
   temp %>%
    ggplot(aes(x = "", y = total, fill = nm_regiao)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y", start = 0)
  })
  
  output$qntSalasInformatica <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT escolar_in_laboratorio_informatica, count(escolar_in_laboratorio_informatica) as total
                       from dados group by escolar_in_laboratorio_informatica")
    
    # temp %>% 
    #   ggplot(aes(escolar_in_laboratorio_informatica, total)) +
    #   geom_col()
    
    temp %>%
      ggplot(aes(x = "", y = total, fill = escolar_in_laboratorio_informatica)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y", start = 0)
  })
  
  output$qntInternetAlunos <- renderPlot({
    temp <- dbGetQuery(conn, "SELECT escolar_in_internet_alunos, count(escolar_in_internet_alunos) as total 
                       from dados group by escolar_in_internet_alunos")
    
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
    dbGetQuery(conn, "SELECT escolar_tipo_tecnologia, count(escolar_tipo_tecnologia) as total 
               from dados group by escolar_tipo_tecnologia") %>% 
      ggplot(aes(escolar_tipo_tecnologia, total)) +
      geom_col()
  })
  
  output$tipoRedeLocalEscolas <- renderPlot({
    dbGetQuery(conn, "SELECT escolar_tp_rede_local, count(escolar_tp_rede_local) as total 
               from dados group by escolar_tp_rede_local") %>% 
      ggplot(aes(x = "", y = total, fill = escolar_tp_rede_local)) +
      geom_bar(stat = "identity", width = 1) +
      coord_polar("y", start = 0)
  })
  
  output$alunosPorEstado <- renderPlot({
    dbGetQuery(conn, "SELECT SUM(escolar_qtematriculas) as total, nm_estado from dados 
                  where nm_estado not null
                  group by nm_estado;") %>% 
  ggplot(aes(total, nm_estado)) +
  geom_col()
  })
  
  output$eletronicosPorEstado <- renderPlot({
    dbGetQuery(conn, "SELECT nm_estado, (sum(escolar_qt_desktop_aluno+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno) * 1.0 / sum(escolar_qtematriculas)) * 100 as total from dados
where escolar_qt_comp_portatil_aluno < 3000 AND escolar_qt_desktop_aluno < 3000 AND escolar_qt_tablet_aluno < 3000 AND escolar_qtematriculas < 3000 and nm_estado is not null
GROUP by nm_estado;") %>% 
      ggplot(aes(total, nm_estado)) +
      geom_col()
  })
  
  output$empresaFornecedoraPrimaria <- renderPlot({
    
    dbGetQuery(conn, "select empresa1, count(empresa1) total from dados 
           group by empresa1 order by total desc limit 10") %>% 
      ggplot(aes(total, empresa1)) +
        geom_col()
  })
  
  output$empresaFornecedoraSecundaria <- renderPlot({
    
    dbGetQuery(conn, "select empresa2, count(empresa2) total from dados 
           group by empresa2 order by total desc limit 10") %>% 
      ggplot(aes(total, empresa2)) +
      geom_col()
  })
  
  # output$downloadKbitsAluno <- renderPlot({
  #   dbGetQuery(conn, 'select "Download por aluno (Kbit/s)" as nome, "Download por aluno (Kbit/s)" as total  from dados') %>% 
  #     ggplot(aes(x = "", y = total, fill = nome)) +
  #     geom_bar(stat = "identity", width = 1) +
  #     coord_polar("y", start = 0)
  # })
  
  output$mapaTotal <- renderPlot({
    mapa_brasil_df <- map_data("world", region = "Brazil")
    
    # 2.2 - Dataframe das escolas, com a query corrigida
    #      Note os parênteses na cláusula WHERE para garantir a lógica correta.
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
    
    
    # --- PASSO 3: CRIAR O GRÁFICO (AGORA COM OS DADOS PRONTOS) ---
    
    ggplot() +
      # Camada 1: O contorno do Brasil
      # Usa os dados de 'mapa_brasil_df' e suas colunas 'long' e 'lat'
      geom_polygon(
        data = mapa_brasil_df, 
        aes(x = long, y = lat, group = group), 
        fill = "gray85",
        color = "white"
      ) +
      
      # Camada 2: Os pontos das escolas
      # Usa os dados de 'temp' e suas colunas 'longitude' e 'latitude'
      geom_point( 
        data = temp,
        aes(x = longitude, y = latitude), # Corrigido de 'templongitude'
        color = "#4b9e4b",
        size = 0.1,
        alpha = 0.7
      ) +
      
      # Ajustes finais para deixar o mapa limpo
      labs(
        x = "", 
        y = ""
      ) +
      theme_void() +
      coord_fixed(ratio = 1)
  })
  

# AUDITORIA ---------------------------------------------------------------
  #+escolar_qt_comp_portatil_aluno+escolar_qt_tablet_aluno
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
  
  output$mapa <- renderPlot({
    mapa_brasil_df <- map_data("world", region = "Brazil")
    
    # 2.2 - Dataframe das escolas, com a query corrigida
    #      Note os parênteses na cláusula WHERE para garantir a lógica correta.
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
    # Execute a query e salve no dataframe 'temp'
    temp <- dbGetQuery(conn, query_corrigida)
    
    
    # --- PASSO 3: CRIAR O GRÁFICO (AGORA COM OS DADOS PRONTOS) ---
    
    ggplot() +
      # Camada 1: O contorno do Brasil
      # Usa os dados de 'mapa_brasil_df' e suas colunas 'long' e 'lat'
      geom_polygon(
        data = mapa_brasil_df, 
        aes(x = long, y = lat, group = group), 
        fill = "gray85",
        color = "white"
      ) +
      
      # Camada 2: Os pontos das escolas
      # Usa os dados de 'temp' e suas colunas 'longitude' e 'latitude'
      geom_point( 
        data = temp,
        aes(x = longitude, y = latitude), # Corrigido de 'templongitude'
        color = "#4b9e4b",
        size = 2,
        alpha = 0.7
      ) +
      
      # Ajustes finais para deixar o mapa limpo
      labs(
        title = "Localização de Escolas com Mais de 8.000 Dispositivos",
        x = "", 
        y = ""
      ) +
      theme_void() +
      coord_fixed(ratio = 1.1)
  })
  
  output$mapaSemMatricula <- renderPlot({
    mapa_brasil_df <- map_data("world", region = "Brazil")
    
    # 2.2 - Dataframe das escolas, com a query corrigida
    #      Note os parênteses na cláusula WHERE para garantir a lógica correta.
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
                          AND latitude IS NOT NULL;
                      "
    # Execute a query e salve no dataframe 'temp'
    temp <- dbGetQuery(conn, query_corrigida)
    
    
    # --- PASSO 3: CRIAR O GRÁFICO (AGORA COM OS DADOS PRONTOS) ---
    
    ggplot() +
      # Camada 1: O contorno do Brasil
      # Usa os dados de 'mapa_brasil_df' e suas colunas 'long' e 'lat'
      geom_polygon(
        data = mapa_brasil_df, 
        aes(x = long, y = lat, group = group), 
        fill = "gray85",
        color = "white"
      ) +
      
      # Camada 2: Os pontos das escolas
      # Usa os dados de 'temp' e suas colunas 'longitude' e 'latitude'
      geom_point( 
        data = temp,
        aes(x = longitude, y = latitude), # Corrigido de 'templongitude'
        color = "#4b9e4b",
        size = 2,
        alpha = 0.7
      ) +
      
      # Ajustes finais para deixar o mapa limpo
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
  
}


shinyApp(ui, server)