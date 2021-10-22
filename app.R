library(shiny)
library(shinyMobile)
library(magrittr)

image <- c(
    "https://lh3.googleusercontent.com/ZclHcYqOan02wB2E3JtdG3sBcAK0HHwGXbZS3fDfIlktpIBUO7Lko6pUHgNT5SIzLDhdJXfavd6BEjYhk7tYXjEadEhL50pIMQ4Wvl5awvykWMsLDHKR0I4hrfaxcSty39TNIjKG49WKh64CANB8kznqnsz2wIOPr8jqwQHUzDkKJ8wJEujxubhormhYpIbXGc0ZBa_JBwOFljc7Lat2I8j21d5uhVCtg3XnN4T6Jkl1Kh4VMJfqjY832R-ndrSKpL0aTpYfeIdaTzPGBH_M_-MqxqK-dWEfI9Uw7Aqa18-gD_LfxqXYoencw32yVGprRWQ5mda8U93A5WKhhS6q_Oai96DMDM6mN9VfhvagiO27QMRGsOQd14zELamU1DlF0DwEOpow6RBpVxKUmea7pBIY0SZxnyEB5PLCo0I3ANWEk-eppjRinwZmohWJBxajC3zA_N56p0YgLyKj6uqNh5cQpJYA-IQKlJW73JIl5N9MEGY___7koVbycErxcELbTEvr272lyQsDBUaP8lTTRNf_H5Q3ndSOt7kDAlL7gHZXkXOEIpgmCW9WaAIfTGhHHnQj0OzeN9TVLkp8eTEvFhh9kcUqwBmbnboCrtVLwqynKH1gT-cIGDq3WjI1eEClI1qf9EGVnV8T8_1AsgfgSlL5dqaPQStqSEIWiL-s9wxyAJrsj7jq-z4VbdHKEdNyGfabQ5QxY1VKj3fo=s640-no?authuser=1",
    "https://lh3.googleusercontent.com/TATO1D2BJiJjGKAXvGR_9JVNWVdKecT7PwikisvK-6vgU-PMGmH6S2j4xwTLXlm0yM67YSBnr-mAaWLNMqy9drE5YEtQwTSYvJmyJHoxm_28upIeUsQ1aOWfZi0Fsh0GNJGLI8iIDiJnL9oLQbWQwXsgA1mWwhfvI7w3AvhQy1dW82ze1rlEXmEqbD9Dw4p5OS72T8D-NkXHuj4c2zkP8G61FbMKMuVsN3PsDe-7aMGxdlySVq-2Z-yfvebtFmb3nU_rOuVvuPObWsszPhxm9X4TQfRCVHMRV2Hdg208FJ0ErR7j8fL9AguevEWiP9mPX6C6E5Hwrp_0xDZeDvhoN9-gnr3ZgcC2V7jgltphAkPUXytG4OqdkIK77fLFCtb_3nlg45VXvouOn8u0GCtNDVrIOIViW96pkEz-f4hLZJFHkg2UKCr3adhJaHrjW6AYr83XzQSi2ED4BMg3ITFoFcqwoZdySzRp8vU6Qqqbjq-sZYzfpwTjNJaWfmf8DHHYe-SewMPpkxssQcyEyrtTlHAybQVNDF28X0firACG1sIoRPIk2STAVmFBzZyqRhQ9oM80qORBDWfCNXcfHMfkIdC6XpLspWf0M9gyN-tM8DcyJykaNmch-R-hPOkl12Kjw66me-3-FwWYs_UxiaLrHL2c9Yd9pHZv5yz0Mp-iz-pDid-P0bkJNGuvcuqHZL7QqGVS7ZmT_HwMwaRs=s640-no?authuser=1",
    "https://lh3.googleusercontent.com/tk9PJG-WoZSiYgF6TZG7XTsuDgPQHLdB-3FmCQYnItFwXyANi3ySnICr6Q6hbu5G-3c_9ZAsaeu_t1k6W4PoBG7Zl4QfUcddEDjSxHhT6jwRNkilT5EcNzWR3vWZfXTFq2PbO7zpNMaYORAP9YUfKHf8KN1wAUPQhzbOUx5fbJXMCwlobwHSz3WvRqsqaUi38gZw2gUyCYH2KGAHg4q3wxWPYU5B_NURbFLSW3Q9ZkdEAqfsi35u6OYonsLBUuVH0uTNbbfKqjBGZeqTG9r_HAQ7pZsioJP5X7pyqcpQlakuBCqoIRnjyWSVfO2qHA0fOvWnwvnkRWmDO6xYBYuc4PbF9C1YqgMxnNpA8JvHwQVayoRlsgP1iBN3-umKPT4YpW1lMqS0ZU1yQ3Zrl80UxeTkx_aoFrdSvKdQL7Efnd3MQ32Jz5otSqqYYlLd6paDo6ViumObAbd9gV58dl6Dr23vxMTn23Z9gew7NrtJ4JPMCTyQXMqr-RBU_3_BdcesrQLWrjSc9gpBDulSh7TMvfbvC__AAkLZIx_TI_uyh9BjY2UC2qEV-4AHO-FhZYzQlDGlzq6O9_GkrugOCeVT9k202WGug2zkVkOq7u7aQ5h9MO5K9QJin4zxldLCWcleku7BPeuECPmiAdYAZgRbpnYyu2NJ2Xm2f2HMqBHxsv4YxsTSWFY1GRuSf_GkF0UJn70OjVjy2xEdYhZ4=s640-no?authuser=1",
    "https://lh3.googleusercontent.com/4A11MODOqtFPef1fg3XFmtZVB2gv1aVw-2hgBJDdz4XVsjA-TtPbWUB4wgpzG9MZQHUKogYZa-bqh14bc0lShX1Meshk0vuX6ki7cBRrLv4WaKH4GNiSkSb06l7aeNZDWBKrQgypJp-x4HaMgL2vyJPIwM3Y68YeI3nUjXrzVn8vlR87UfOa2zMxUU55e4p-TfFJhTFrXyy-tJUMRwLQqmT6BqW3Oe5QpwqrfXTKrI463UoeBCGwbAaXEuVvQu3w4rvUDmnisqDEfA07ceNHvVmXbigP22vZ4jbjSHyn1wuemTOO5Js7P5Ms5lJogFV1nKmyddkarHgfmq5oJlIVrSlaxEuoPCxNf2q3xYUqd8AQ7ytq9ISi9_Eqzc4-7TlQfQuFi-0nwjxTuLngN38YTzQXOwPGfkrnTN3HOYxsjd6zmgZwTu0xc-bOlNv28bsoY_xKMMUuL3Ucvz8A7PHMXZ0jRpcMXJq3DrpP_TmyTVrnWo-NOxeR3wQAE5huHTv437fsy9cGgF001mFGcHv25N4vWZqMVD8WG5jEJ9grMyj2fWqwPqi4W2tkoKm-nR67vQJdHjU6Gs54Lh0fz4zIMFhl8G0BxnjD8QSENHILVVMGGqoLWGC-3ZRBjpa7IL2zvzZdYueSJQ_Bbg8p7IW8t0htBKMeKC4X2gh0Li4HQvR5ruIaww8no2Eqvx-Q_G6_MsbPNF9Mjxbv5qqz=s640-no?authuser=1"
)

ad <- data.frame(
    name = c(
        "Инвестиции USA Market",
        "Аналитика USA Market",
        "Инфографика USA Market",
        "YouTube: Инвестиции USA Market"
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

#загрузка аналитики
analytics <- read.csv("analytics_USA.csv")

analytics$Дата.поста <- as.Date(analytics$Дата.поста)
analytics <- subset(analytics[rev(order(analytics$Дата.поста)),])

#загрузка компаний
companies <- read.csv("companies.csv")

companies$Дата <- as.Date(companies$Дата)
companies$Дата.идеи <- as.Date(companies$Дата.идеи)
companies$Дата.новинки <- as.Date(companies$Дата.новинки)
sheet_companies <- subset(companies[order(companies$Название), c("Название", "Тикер", "Разбор", "Страна", "Сектор", "Индустрия", "Оценка", "Дата")])

WL <- subset(companies, complete.cases(companies$Инвест.идея))
sheet_WL <- subset(WL[rev(order(WL$Дата.идеи)), c("Название", "Тикер", "Инвест.идея", "Страна", "Сектор", "Индустрия", "Оценка", "Дата.идеи")])

new <- subset(companies, complete.cases(companies$Новинка))
sheet_new <- subset(new[order(new$Название), c("Название", "Тикер", "Новинка", "Страна", "Сектор", "Индустрия", "Оценка", "Дата.новинки")])

shinyApp(
    ui = f7Page(
        options = list(theme = "auto", dark = FALSE, filled = TRUE, color = "#1d3557"),
        allowPWA = TRUE,
        f7TabLayout(
            navbar = f7Navbar(
                title = tagList(f7Icon("paperplane"), "USA Market App")
            ),
            f7Tabs(
                f7Tab(
                    tabName = "Компании",
                    icon = f7Icon("square_list"),
                    active = TRUE,
                    f7Searchbar(id = "searchbar1", placeholder = "Поиск", options = list(searchContainer = ".shiny-html-output", searchIn = c(".item-title", ".item-subtitle"), backdrop = FALSE)),
                    f7Card(
                        f7Button("ads", "Наши каналы", color = "blue", fill = TRUE)
                    ),
                    f7Popup(
                        id = "popup",
                        title = "Наши каналы",
                        swipeToClose = TRUE,
                        closeButton = FALSE,
                        f7List(
                            mode = "media",
                            lapply(1:4, function(img) {
                                f7ListItem(
                                    title = ad$name[img],
                                    ad$text[img],
                                    media = tags$img(src = image[img]),
                                    href = ad$link[img]
                                )
                            })
                        ),
                        f7Block(
                            "смахните страницу вверх / вниз, чтобы ее закрыть"
                        )
                    ),
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
                    f7Searchbar(id = "searchbar2", placeholder = "Поиск", options = list(searchContainer = ".list", searchIn = c(".item-title", ".item-subtitle"), backdrop = FALSE)),
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
                    f7Searchbar(id = "searchbar3", placeholder = "Поиск", options = list(searchContainer = ".list", searchIn = c(".item-title", ".item-subtitle"), backdrop = FALSE)),
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
                    f7Searchbar(id = "searchbar4", placeholder = "Поиск", options = list(searchContainer = ".shiny-html-output", searchIn = ".item-title", backdrop = FALSE)),
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
        observeEvent(input$ads, {
            updateF7Popup(id = "popup")
        })
        session$allowReconnect(TRUE)
    }
)

