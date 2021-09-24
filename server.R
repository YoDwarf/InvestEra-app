shinyServer(
    function(input, output) {
        #фильтр Аналитики
        analytics_filter <- reactive({
            analytic <- analytics
            
            if(input$Тип == "Все") {
                analytic <- analytic
            } else {
                analytic <- analytic %>%
                    filter(
                        grepl(input$Тип, x = Тип)
                    )
            }
        })
        output$analytics <- renderUI({
            f7List(mode = "media",
                   lapply(1:nrow(analytics_filter()), function(i) {
                       f7ListItem(
                           title = analytics_filter()$Название[i],
                           analytics_filter()$Тип[i],
                           right = analytics_filter()$Дата.поста[i],
                           href = analytics_filter()$Ссылка[i]
                       )
                   })
            )
        })
        #фильтры Компаний
        country_filter <- reactive({
            company <- sheet_companies
            
            if(input$Страна == "Все") {
                company <- company
            } else if(input$Страна == "Прочие страны") {
                company <- company %>% 
                    filter(
                        !grepl(paste(c("США", "Россия", "Китай", "Германия"), collapse = "|"), x = Страна)
                    )
            } else {
                company <- company %>%
                    filter(
                        grepl(input$Страна, x = Страна)
                    )
            }
            if(input$Сектор == "Все") {
                company <- company
            } else {
                company <- company %>%
                    filter(
                        grepl(input$Сектор, x = Сектор)
                    )
            }
            if(input$Сектор == "Все") {
                company <- company
            } else {
                company <- company %>%
                    filter(
                        grepl(input$Сектор, x = Сектор)
                    )
            }
        })
        output$table <- renderUI({
            if(nrow(country_filter()) > 0) {
                f7List(mode = "media",
                       lapply(1:nrow(country_filter()), function(i) {
                           f7ListItem(
                               title = country_filter()$Название[i],
                               subtitle =  country_filter()$Тикер[i],
                               header = tagList(f7Badge(country_filter()$Оценка[i], color =
                                                            if(country_filter()$Оценка[i] == 1) {
                                                                "red"
                                                            } else if(country_filter()$Оценка[i] == 2) {
                                                                "orange"
                                                            } else if(country_filter()$Оценка[i] == 3) {
                                                                "yellow"
                                                            } else if(country_filter()$Оценка[i] == 4) {
                                                                "lime"
                                                            } else if(country_filter()$Оценка[i] == 5) {
                                                                "green"
                                                            } else {
                                                                "purple"
                                                            }
                               ), f7Badge(country_filter()$Страна[i], color = "blue")),
                               paste0(country_filter()$Сектор[i], ", ", country_filter()$Индустрия[i]),
                               right = country_filter()$Дата[i],
                               href = country_filter()$Разбор[i]
                           )
                       })
                ) 
            } else {
                f7Card("Компании с данными параметрами отсутствуют")
            }
        })
    }
)
