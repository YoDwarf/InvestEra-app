library(shiny)
library(shinyMobile)
library(magrittr)

#загрузка аналитики
analytics <- read.csv("analytics_USA.csv")

analytics$Дата.поста <- as.Date(analytics$Дата.поста)
analytics <- subset(analytics[order(analytics$Дата.поста),])

#загрузка компаний
companies <- read.csv("companies.csv")

companies$Дата <- as.Date(companies$Дата)
companies$Дата.идеи <- as.Date(companies$Дата.идеи)
companies$Дата.новинки <- as.Date(companies$Дата.новинки)
sheet_companies <- subset(companies[order(companies$Название), c("Название", "Тикер", "Разбор", "Страна", "Сектор", "Индустрия", "Оценка", "Дата")])

WL <- subset(companies, complete.cases(companies$Инвест.идея))
sheet_WL <- subset(WL[order(WL$Дата.идеи), c("Название", "Тикер", "Инвест.идея", "Страна", "Сектор", "Индустрия", "Оценка", "Дата.идеи")])

new <- subset(companies, complete.cases(companies$Новинка))
sheet_new <- subset(new[order(new$Название), c("Название", "Тикер", "Новинка", "Страна", "Сектор", "Индустрия", "Оценка", "Дата.новинки")])

shinyApp(
    ui = f7Page(
        options = list(theme = "aurora", dark = FALSE, filled = TRUE, color = "#1d3557"),
        f7TabLayout(
            navbar = f7Navbar(
                title = tagList(f7Icon("paperplane"), "USA Markets App")
            ),
            f7Tabs(
                f7Tab(
                    tabName = "Компании",
                    icon = f7Icon("square_list"),
                    active = TRUE,
                    f7Searchbar(id = "searchbar1", placeholder = "Поиск", options = list(searchContainer = ".shiny-html-output", searchIn = c(".item-title", ".item-subtitle"))),
                    f7Select(
                        inputId = "Страна",
                        label = "Страна",
                        choices = c("Все", "США", "Россия", "Китай", "Германия", "Прочие страны"),
                        selected = "Все"
                    ),
                    f7Select(
                        inputId = "Сектор",
                        label = "Сектор",
                        choices = c("Все", sort(unique(sheet_companies$Сектор))),
                        selected = "Все"
                    ),
                    uiOutput("table") %>% f7Found(),
                    f7Block(
                        f7Card("Ничего не найдено")
                    ) %>% f7NotFound()
                ), #страница с Компаниями
                f7Tab(
                    tabName = "Инвест-идеи",
                    icon = f7Icon("lightbulb"),
                    f7Searchbar(id = "searchbar2", placeholder = "Поиск", options = list(searchContainer = ".list", searchIn = c(".item-title", ".item-subtitle"))),
                    f7List(mode = "media",
                           lapply(1:nrow(sheet_WL), function(i) {
                               f7ListItem(
                                   title = sheet_WL$Название[i],
                                   subtitle =  sheet_WL$Тикер[i],
                                   header = tagList(f7Badge(sheet_WL$Оценка[i], color =
                                                                if(sheet_WL$Оценка[i] == 1) {
                                                                    "red"
                                                                } else if(sheet_WL$Оценка[i] == 2) {
                                                                    "orange"
                                                                } else if(sheet_WL$Оценка[i] == 3) {
                                                                    "yellow"
                                                                } else if(sheet_WL$Оценка[i] == 4) {
                                                                    "lime"
                                                                } else if(sheet_WL$Оценка[i] == 5) {
                                                                    "green"
                                                                } else {
                                                                    "purple"
                                                                }
                                   ), f7Badge(sheet_WL$Страна[i], color = "blue")),
                                   paste0(sheet_WL$Сектор[i], ", ", sheet_WL$Индустрия[i]),
                                   right = sheet_WL$Дата.идеи[i],
                                   href = sheet_WL$Инвест.идея[i]
                               )
                           })
                    ) %>% f7Found(),
                    f7Block(
                        f7Card("Ничего не найдено")
                    ) %>% f7NotFound()
                ), #страница с Инвест-идеями
                f7Tab(
                    tabName = "Новинки",
                    icon = f7Icon("square_list", f7Badge("NEW", color = "red")),
                    f7Searchbar(id = "searchbar3", placeholder = "Поиск", options = list(searchContainer = ".list", searchIn = c(".item-title", ".item-subtitle"))),
                    f7List(mode = "media",
                           lapply(1:nrow(sheet_new), function(i) {
                               f7ListItem(
                                   title = sheet_new$Название[i],
                                   subtitle =  sheet_new$Тикер[i],
                                   header = f7Badge(sheet_new$Страна[i], color = "blue"),
                                   paste0(sheet_new$Сектор[i], ", ", sheet_new$Индустрия[i]),
                                   right = sheet_new$Дата.новинки[i],
                                   href = sheet_new$Новинка[i]
                               )
                           })
                    ) %>% f7Found(),
                    f7Block(
                        f7Card("Ничего не найдено")
                    ) %>% f7NotFound()
                ), #страница с Новинками
                f7Tab(
                    tabName = "Аналитика",
                    icon = f7Icon("graph_circle"),
                    f7Searchbar(id = "searchbar4", placeholder = "Поиск", options = list(searchContainer = ".shiny-html-output", searchIn = ".item-title")),
                    f7Select(
                        inputId = "Тип",
                        label = "Тип",
                        choices = c("Все", sort(unique(analytics$Тип))),
                        selected = "Все"
                        ),
                    uiOutput("analytics") %>% f7Found(),
                    f7Block(
                        f7Card("Ничего не найдено")
                    ) %>% f7NotFound()
                )  #страница с Аналитикой
            )
        )
    ),
    server = function(input, output) {
        #фильтр Аналитики
        analytics_filter <- reactive({
            analytic <- analytics
            
            if(input$Тип == "Все") {
                analytic <- analytic
            } else {
                analytic <- analytic %>%
                    subset(
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
                    subset(
                        !grepl(paste(c("США", "Россия", "Китай", "Германия"), collapse = "|"), x = Страна)
                    )
            } else {
                company <- company %>%
                    subset(
                        grepl(input$Страна, x = Страна)
                    )
            }
            if(input$Сектор == "Все") {
                company <- company
            } else {
                company <- company %>%
                    subset(
                        grepl(input$Сектор, x = Сектор)
                    )
            }
            if(input$Сектор == "Все") {
                company <- company
            } else {
                company <- company %>%
                    subset(
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

