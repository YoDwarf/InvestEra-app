library(shiny)
library(shinyMobile)
library(magrittr)

## Подпишись

ad <- data.frame(
    logos = c(
        "icons/logo1.png",
        "icons/analytics.png",
        "icons/info.png",
        "icons/yt.png"
    ),
    name = c(
        "Invest Era",
        "Invest Era: Аналитика",
        "Invest Era: Инфо",
        "YouTube: Invest Era"
    ),
    link = c(
        "https://t.me/usamarke1",
        "https://t.me/AnalyticsUSARussiaMarkets",
        "https://t.me/infousamarket",
        "https://www.youtube.com/channel/UCYtrhHbdHpCuYvVuf7CRXlw/featured"
    ),
    text = c(
        "- разборы компаний из России, США, Китая, Германии и не только.",
        "- анализ секторов, трендов мировой экономики и 5 публичных портфелей.",
        "- фондовый рынок в диаграммах и графиках.",
        "- качественные и проработанные видео с глубокой аналитикой."
    )
)

## Загрузка Компаний
companies <- read.csv("companies.csv")

companies$Дата <- as.Date(companies$Дата)
companies$Дата.идеи <- as.Date(companies$Дата.идеи)
companies$Дата.новинки <- as.Date(companies$Дата.новинки)
companies_list <- subset(
    companies[
        order(companies$Название),
        c(
            "Название",
            "Тикер",
            "Разбор",
            "Страна",
            "Сектор",
            "Индустрия",
            "Оценка",
            "Дата"
        )
    ]
)

## Формирование Инвест-Идей

wl <- subset(companies, complete.cases(companies$Инвест.идея))
wl_list <- subset(
    wl[
        order(wl$Дата.идеи, decreasing = TRUE), 
        c(
            "Название",
            "Тикер",
            "Инвест.идея",
            "Страна",
            "Сектор",
            "Индустрия",
            "Оценка",
            "Дата.идеи"
        )
    ]
)

## Формирование Новинок

new <- subset(companies, complete.cases(companies$Новинка))
new_list <- subset(
    new[
        order(new$Название),
        c(
            "Название",
            "Тикер",
            "Новинка",
            "Страна",
            "Сектор",
            "Индустрия",
            "Оценка",
            "Дата.новинки"
        )
    ]
)

## Загрузка Аналитики
analytics <- read.csv("analytics_USA.csv")

analytics$Дата.поста <- as.Date(analytics$Дата.поста)
analytics <- subset(analytics[order(analytics$Дата.поста, decreasing = TRUE),])

## Color Alias
color_alias <- c(
    "1" = "red",
    "2" = "orange",
    "3" = "yellow",
    "4" = "lime",
    "5" = "green",
    "New" = "purple"
)

## Invest Era App

shinyApp(
    ui = f7Page(
        options = list(theme = "auto", dark = FALSE, filled = TRUE, color = "#172339"),
        allowPWA = TRUE,
        f7TabLayout(
            navbar = f7Navbar(
                title = tagList(img(src = "icons/logo1.png", width = "36px", height = "36px", align = "center"), "Invest Era")
            ),
            f7Tabs(
                f7Tab(
                    tabName = "Компании",
                    icon = f7Icon("square_list_fill"),
                    active = TRUE,
                    f7Searchbar(id = "searchbar1", placeholder = "Поиск", options = list(searchContainer = ".shiny-html-output", searchIn = c(".item-title", ".item-subtitle"), backdrop = FALSE)),
                    f7Card(f7Button("ads", list(f7Icon("checkmark_alt"), "Подпишись"), color = "#172339", fill = TRUE)),
                    f7Popup(
                        id = "popup",
                        title = "Наши каналы:",
                        swipeToClose = TRUE,
                        closeButton = TRUE,
                        animate = FALSE,
                        fullsize = TRUE,
                        f7List(
                            mode = "media",
                            lapply(1:4, function(img) {
                                f7ListItem(
                                    title = ad$name[img],
                                    ad$text[img],
                                    media = tags$img(src = ad$logos[img]),
                                    href = ad$link[img]
                                )
                            })
                        )
                    ),
                    f7Select(
                        inputId = "Страна",
                        label = "Страна:",
                        choices = c("Все", "США", "Россия", "Китай", "Германия", "Прочие страны"),
                        selected = "Все"
                    ),
                    f7Select(
                        inputId = "Сектор",
                        label = "Сектор:",
                        choices = c("Все", sort(unique(companies_list$Сектор))),
                        selected = "Все"
                    ),
                    uiOutput("table") %>% f7Found(),
                    f7Card("Ничего не найдено") %>% f7NotFound()
                ), # Страница с Компаниями
                f7Tab(
                    tabName = "Инвест-идеи",
                    icon = f7Icon("lightbulb_fill"),
                    f7Searchbar(id = "searchbar2", placeholder = "Поиск", options = list(searchContainer = ".list", searchIn = c(".item-title", ".item-subtitle"), backdrop = FALSE)),
                    f7List(mode = "media",
                           lapply(1:nrow(wl_list), function(i) {
                               f7ListItem(
                                   title = wl_list$Название[i],
                                   subtitle =  wl_list$Тикер[i],
                                   header = tagList(
                                       f7Chip(wl_list$Страна[i], outline = TRUE, status = "grey")
                                   ),
                                   paste0(wl_list$Сектор[i], ", ", wl_list$Индустрия[i]),
                                   right = format(wl_list$Дата.идеи[i], "%d.%m.%Y"),
                                   href = wl_list$Инвест.идея[i]
                               )
                           })
                    ) %>% f7Found(),
                    f7Card("Ничего не найдено") %>% f7NotFound()
                ), # Страница с Инвест-Идеями
                f7Tab(
                    tabName = "Новинки",
                    icon = f7Icon("square_list_fill", f7Badge("NEW", color = "red")),
                    f7Searchbar(id = "searchbar3", placeholder = "Поиск", options = list(searchContainer = ".list", searchIn = c(".item-title", ".item-subtitle"), backdrop = FALSE)),
                    f7List(mode = "media",
                           lapply(1:nrow(new_list), function(i) {
                               f7ListItem(
                                   title = new_list$Название[i],
                                   subtitle =  new_list$Тикер[i],
                                   header = f7Chip(new_list$Страна[i], outline = TRUE, status = "grey"),
                                   paste0(new_list$Сектор[i], ", ", new_list$Индустрия[i]),
                                   right = format(new_list$Дата.новинки[i], "%d.%m.%Y"),
                                   href = new_list$Новинка[i]
                               )
                           })
                    ) %>% f7Found(),
                    f7Card("Ничего не найдено") %>% f7NotFound()
                ), # Страница с Новинками
                f7Tab(
                    tabName = "Аналитика",
                    icon = f7Icon("graph_circle_fill"),
                    f7Searchbar(id = "searchbar4", placeholder = "Поиск", options = list(searchContainer = ".shiny-html-output", searchIn = ".item-title", backdrop = FALSE)),
                    f7Select(
                        inputId = "Тип",
                        label = "Тип",
                        choices = c("Все", sort(unique(analytics$Тип))),
                        selected = "Все"
                        ),
                    uiOutput("analytics") %>% f7Found(),
                    f7Card("Ничего не найдено") %>% f7NotFound()
                )  # Страница с Аналитикой
            )
        )
    ),
    server = function(input, output, session) {
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
        }) # Фильтр Аналитики
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
        country_filter <- reactive({
            company <- companies_list
            
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
        }) # Фильтры Компаний
        output$table <- renderUI({
            if(nrow(country_filter()) > 0) {
                f7List(mode = "media",
                       lapply(1:nrow(country_filter()), function(i) {
                           f7ListItem(
                               title = country_filter()$Название[i],
                               subtitle = country_filter()$Тикер[i],
                               header = tagList(
                                   f7Badge(
                                       country_filter()$Оценка[i],
                                       color = color_alias[[country_filter()$Оценка[i]]]
                                   ),
                                   f7Chip(country_filter()$Страна[i], outline = TRUE, status = "grey")
                               ),
                               paste0(country_filter()$Сектор[i], ", ", country_filter()$Индустрия[i]),
                               right = tagList(format(country_filter()$Дата[i], "%d.%m.%Y")),
                               href = country_filter()$Разбор[i]
                           )
                       })
                ) 
            } else {
                f7Card("Компании с данными параметрами отсутствуют")
            }
        })
        observeEvent(input$ads, {
            updateF7Popup(id = "popup")
        }) # Subscribe Sheet
    }
)

