https://github.com/mozilla/geckodriver/releases/tag/v0.17.0
https://sites.google.com/a/chromium.org/chromedriver/
https://www.seleniumhq.org/download/

cd C:\selenium
java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.141.59.jar -port 4445 ?„£ê??

install.packages("httr")
library(httr)
install.packages("rvest")
library(rvest)
install.packages("RSelenium")
library(RSelenium)

remD <- remoteDriver(port = 4445L, 
                     browserName = "chrome")

remD$open() 

title_you <- "³­¹Î"

remD$navigate(paste0("https://www.youtube.com/results?search_query=",title_you))

html <- remD$getPageSource()[[1]]
html <- read_html(html)

youtube_title <- html %>% html_nodes("#video-title") %>% html_text()

youtube_title[1:10]

youtube_title <- gsub("\n","", youtube_title)
youtube_title <- trimws(youtube_title)

youtube_title

write.table(youtube_title,
            file = "/search word_title.txt",
            sep=",",
            row.names = FALSE,
            quote = FALSE)

library(httr)
library(rvest)
library(RSelenium)

remD <- remoteDriver(remoteServerAddr = 'localhost', 
                     port = 4445L, # ???Š¸ë?ˆ?˜? ?ž…??? 
                     browserName = "chrome") 
remD$open()
remD$navigate("https://www.youtube.com/watch?v=aoCBKVPKJgk")


btn <- remD$findElement(using="css selector", value='.html5-main-video')
btn$clickElement()

remD$executeScript("window.scrollTo(0,500)")
remD$executeScript("window.scrollTo(500,1000)")
remD$executeScript("window.scrollTo(1000,1500)")

html <- remD$getPageSource()[[1]]
html <- read_html(html)

ytube_comments <- html %>% html_nodes("#content-text") %>% html_text()
ytube_comments <- ytube_comments[1:50]

head(ytube_comments)

ytube_comments <- gsub("\n","", ytube_comments)
ytube_comments <- trimws(ytube_comments)

write.table(ytube_comments,
            file = "C:/R/youtube_comments.txt",
            sep = ",",
            row.names = FALSE,
            quote = FALSE)
