#2012~2021 10년간 촉법소년 관련 네이버 블로그 글

nblog2012 <- data.frame()


for(i in 1:12) {
  httr::GET(url = "https://section.blog.naver.com/ajax/SearchList.nhn",
            query = list("countPerPage" = "7",
                         "currentPage"  = i,
                         "endDate"      = "2012-12-31",
                         "keyword"      = "촉법소년",
                         "orderBy"      = "sim",
                         "startDate"    = "2012-01-01",
                         "type"         = "post"),
            add_headers("referer" = "https://section.blog.naver.com/Search/post.nh")) %>% print() %>%
    httr::content(as = "text") %>%
    str_remove(pattern = '\\)\\]\\}\',') %>%
    jsonlite::fromJSON() -> naverBlog
  data <- naverBlog$result$searchList
  nblog2012 <- rbind(nblog2012,data)
  cat(i, "번째 페이지 정리완료\n")
  Sys.sleep(time = 1)}

nblog2012 <- nblog2012 %>%
  select(1,2,4,6,9) %>%
  rename(id=blogId,
         no=logNo,
         posturl=postUrl,
         title=noTagTitle,
         name=blogName) %>%
  mutate(url = stringr::str_glue("http://blog.naver.com/PostView.nhn?blogId={id}&logNo={no}"),
         contents = NA)

for(i in 1:nrow(nblog2012)){
  tryCatch({
    nblog2012$contents[i] <- httr::GET(url = nblog2012$url[i]) %>%
      xml2::read_html() %>%
      rvest::html_nodes(css = "div.se-main-container") %>%
      html_text(trim=TRUE)
    cat(i, "번째 성공\n")
    sys.sleep(time=0.2)
  }, error = function(e) cat(' --> 에러\n'))
}

which(is.na(nblog2012$contents)) -> naData

for(i in naData){
  tryCatch({
    nblog2012$contents[i] <- httr::GET( url = nblog2012$url[i]) %>%
      xml2::read_html() %>%
      rvest::html_nodes( css = "div#postViewArea")%>%
      html_text(trim = TRUE)
    
    cat(i, "번째 블로그 글 내용 취합 완료\n")
    Sys.sleep(time=0.2)
  }, error = function(e) cat(' --> 에러\n'))
}

which(is.na(nblog2012$contents)) -> naData

for(i in naData){
  tryCatch({
    nblog2012$contents[i] <- httr::GET( url = nblog2012$url[i]) %>%
      xml2::read_html() %>%
      rvest::html_nodes( css = "div#postListBody")%>%
      html_text(trim = TRUE)
    
    cat(i, "번째 블로그 글 내용 취합 완료\n")
    Sys.sleep(time=0.2)
  }, error = function(e) cat(' --> 에러\n'))
}

which(is.na(nblog2012$contents)) -> naData

for(i in naData){
  tryCatch({
    nblog2012$contents[i] <- httr::GET( url = nblog2012$url[i]) %>%
      xml2::read_html() %>%
      rvest::html_nodes( css = "div.se_component_wrap.sect_dsc.__se_component_area")%>%
      html_text(trim = TRUE)
    
    cat(i, "번째 블로그 글 내용 취합 완료\n")
    Sys.sleep(time=0.2)
  }, error = function(e) cat(' --> 에러\n'))
}

naData

na.omit(nblog2012) -> nblog2012

data
write.csv(nblog2012,"C:/nblog2012.csv")

save(nblog2012, file="nblog2012.R")

nblog2017$contents[2]

nblog2012.txt <- nblog2012$contents
nblog2012.txt <- str_remove_all(nblog2012.txt, pattern='\n')
nblog2012.txt <- str_remove_all(nblog2012.txt, pattern='\t')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\r')
nblog2012.txt <- str_remove_all(nblog2012.txt, pattern='[A-z]')
nblog2012.txt <- gsub("\\s{2,}", "", nblog2012.txt)
nblog2012.txt <- str_remove_all(nblog2012.txt, pattern='<.*?>')
nblog2012.txt <- str_remove_all(nblog2012.txt, pattern='\U0001f538')
nblog2012.txt <- str_remove_all(nblog2012.txt, pattern='\u2b50')
nblog2012.txt <- str_remove_all(nblog2012.txt, pattern='\\U+200B')
nblog2012.txt <- gsub("[[:punct:]]", "", nblog2012.txt)
nblog2012.txt[2]

nblog2013.txt <- nblog2013$contents
nblog2013.txt <- str_remove_all(nblog2013.txt, pattern='\n')
nblog2013.txt <- str_remove_all(nblog2013.txt, pattern='\t')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\r')
nblog2013.txt <- str_remove_all(nblog2013.txt, pattern='[A-z]')
nblog2013.txt <- gsub("\\s{2,}", "", nblog2013.txt)
nblog2013.txt <- str_remove_all(nblog2013.txt, pattern='<.*?>')
nblog2013.txt <- str_remove_all(nblog2013.txt, pattern='\U0001f538')
nblog2013.txt <- str_remove_all(nblog2013.txt, pattern='\u2b50')
nblog2013.txt <- str_remove_all(nblog2013.txt, pattern='\\U+200B')
nblog2013.txt <- gsub("[[:punct:]]", "", nblog2013.txt)
nblog2013.txt[2]

nblog2014.txt <- nblog2014$contents
nblog2014.txt <- str_remove_all(nblog2014.txt, pattern='\n')
nblog2014.txt <- str_remove_all(nblog2014.txt, pattern='\t')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\r\r\r\r1')
nblog2014.txt <- str_remove_all(nblog2014.txt, pattern='[A-z]')
nblog2014.txt <- gsub("\\s{2,}", "", nblog2014.txt)
nblog2014.txt <- str_remove_all(nblog2014.txt, pattern='<.*?>')
nblog2014.txt <- str_remove_all(nblog2014.txt, pattern='\U0001f538')
nblog2014.txt <- str_remove_all(nblog2014.txt, pattern='\u2b50')
nblog2014.txt <- str_remove_all(nblog2014.txt, pattern='\\U+200B')
nblog2014.txt <- gsub("[[:punct:]]", "", nblog2014.txt)
nblog2014.txt[2]

nblog2015.txt <- nblog2015$contents
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\n')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\t')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\r')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='[A-z]')
nblog2015.txt <- gsub("\\s{2,}", "", nblog2015.txt)
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='<.*?>')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\U0001f538')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\u2b50')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\\U+200B')
nblog2015.txt <- gsub("[[:punct:]]", "", nblog2015.txt)
nblog2015.txt[2]

nblog2016.txt <- nblog2017$contents
nblog2016.txt <- str_remove_all(nblog2016.txt, pattern='\n')
nblog2016.txt <- str_remove_all(nblog2016.txt, pattern='\t')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\r')
nblog2016.txt <- str_remove_all(nblog2016.txt, pattern='[A-z]')
nblog2016.txt <- gsub("\\s{2,}", "", nblog2016.txt)
nblog2016.txt <- str_remove_all(nblog2016.txt, pattern='<.*?>')
nblog2016.txt <- str_remove_all(nblog2016.txt, pattern='\U0001f538')
nblog2016.txt <- str_remove_all(nblog2016.txt, pattern='\u2b50')
nblog2016.txt <- str_remove_all(nblog2016.txt, pattern='\\U+200B')
nblog2016.txt <- gsub("[[:punct:]]", "", nblog2016.txt)
nblog2016.txt[2]

nblog2017.txt <- nblog2017$contents
nblog2017.txt <- str_remove_all(nblog2017.txt, pattern='\n')
nblog2017.txt <- str_remove_all(nblog2017.txt, pattern='\t')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\r')
nblog2017.txt <- str_remove_all(nblog2017.txt, pattern='[A-z]')
nblog2017.txt <- gsub("\\s{2,}", "", nblog2017.txt)
nblog2017.txt <- str_remove_all(nblog2017.txt, pattern='<.*?>')
nblog2017.txt <- str_remove_all(nblog2017.txt, pattern='\U0001f538')
nblog2017.txt <- str_remove_all(nblog2017.txt, pattern='\u2b50')
nblog2017.txt <- str_remove_all(nblog2017.txt, pattern='\\U+200B')
nblog2017.txt <- gsub("[[:punct:]]", "", nblog2017.txt)
nblog2017.txt[2]

nblog2018.txt <- nblog2018$contents
nblog2018.txt <- str_remove_all(nblog2018.txt, pattern='\n')
nblog2018.txt <- str_remove_all(nblog2018.txt, pattern='\t')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\r')
nblog2018.txt <- str_remove_all(nblog2018.txt, pattern='[A-z]')
nblog2018.txt <- gsub("\\s{2,}", "", nblog2018.txt)
nblog2018.txt <- str_remove_all(nblog2018.txt, pattern='<.*?>')
nblog2018.txt <- str_remove_all(nblog2018.txt, pattern='\U0001f538')
nblog2018.txt <- str_remove_all(nblog2018.txt, pattern='\u2b50')
nblog2018.txt <- str_remove_all(nblog2018.txt, pattern='\\U+200B')
nblog2018.txt <- gsub("[[:punct:]]", "", nblog2018.txt)
nblog2018.txt[2]

nblog2019.txt <- nblog2019$contents
nblog2019.txt <- str_remove_all(nblog2019.txt, pattern='\n')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\r')
nblog2019.txt <- str_remove_all(nblog2019.txt, pattern='\t')
nblog2019.txt <- str_remove_all(nblog2019.txt, pattern='[A-z]')
nblog2019.txt <- gsub("\\s{2,}", "", nblog2019.txt)
nblog2019.txt <- str_remove_all(nblog2019.txt, pattern='<.*?>')
nblog2019.txt <- str_remove_all(nblog2019.txt, pattern='\U0001f538')
nblog2019.txt <- str_remove_all(nblog2019.txt, pattern='\u2b50')
nblog2019.txt <- str_remove_all(nblog2019.txt, pattern='\\U+200B')
nblog2019.txt <- gsub("[[:punct:]]", "", nblog2019.txt)
nblog2019.txt[2]

nblog2020.txt <- nblog2020$contents
nblog2020.txt <- str_remove_all(nblog2020.txt, pattern='\n')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\r')
nblog2020.txt <- str_remove_all(nblog2020.txt, pattern='\t')
nblog2020.txt <- str_remove_all(nblog2020.txt, pattern='[A-z]')
nblog2020.txt <- gsub("\\s{2,}", "", nblog2020.txt)
nblog2020.txt <- str_remove_all(nblog2020.txt, pattern='<.*?>')
nblog2020.txt <- str_remove_all(nblog2020.txt, pattern='\U0001f538')
nblog2020.txt <- str_remove_all(nblog2020.txt, pattern='\u2b50')
nblog2020.txt <- str_remove_all(nblog2020.txt, pattern='\\U+200B')
nblog2020.txt <- gsub("[[:punct:]]", "", nblog2020.txt)
nblog2020.txt[2]

nblog2021.txt <- nblog2021$contents
nblog2021.txt <- str_remove_all(nblog2021.txt, pattern='\n')
nblog2015.txt <- str_remove_all(nblog2015.txt, pattern='\r')
nblog2021.txt <- str_remove_all(nblog2021.txt, pattern='\t')
nblog2021.txt <- str_remove_all(nblog2021.txt, pattern='[A-z]')
nblog2021.txt <- gsub("\\s{2,}", "", nblog2021.txt)
nblog2021.txt <- str_remove_all(nblog2021.txt, pattern='<.*?>')
nblog2021.txt <- str_remove_all(nblog2021.txt, pattern='\U0001f538')
nblog2021.txt <- str_remove_all(nblog2021.txt, pattern='\u2b50')
nblog2021.txt <- str_remove_all(nblog2021.txt, pattern='\\U+200B')
nblog2021.txt <- gsub("[[:punct:]]", "", nblog2021.txt)
nblog2021.txt[2]

save(nblog2012.txt, file="nblog2012.txt.R")
save(nblog2013.txt, file="nblog2013.txt.R")
save(nblog2014.txt, file="nblog2014.txt.R")
save(nblog2015.txt, file="nblog2015.txt.R")
save(nblog2016.txt, file="nblog2016.txt.R")
save(nblog2017.txt, file="nblog2017.txt.R")
save(nblog2018.txt, file="nblog2018.txt.R")
save(nblog2019.txt, file="nblog2019.txt.R")
save(nblog2020.txt, file="nblog2020.txt.R")
save(nblog2021.txt, file="nblog2021.txt.R")

write.table(nblog2012.txt,"C:/nblog2012.txt")
write.table(nblog2012.txt,"C:/nblog2012.txt")
write.table(nblog2013.txt,"C:/nblog2013.txt")
write.table(nblog2014.txt,"C:/nblog2014.txt")
write.table(nblog2015.txt,"C:/nblog2015.txt")
write.table(nblog2016.txt,"C:/nblog2016.txt")
write.table(nblog2017.txt,"C:/nblog2017.txt")
write.table(nblog2018.txt,"C:/nblog2018.txt")
write.table(nblog2019.txt,"C:/nblog2019.txt")
write.table(nblog2020.txt,"C:/nblog2020.txt")
write.table(nblog2021.txt,"C:/nblog2021.txt"
