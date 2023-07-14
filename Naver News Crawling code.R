library(rvest)
library(dplyr)

QUERY <- "�˹��ҳ�" # �˻�Ű����
DATE  <- as.Date(as.character(20140101),format="%Y%m%d") # �˻����۳�¥ & �˻����ᳯ¥
DATE <- format(DATE, "%Y.%m.%d")
PAGE  <- 1

naver_url_1 <- "https://search.naver.com/search.naver?&where=news&query="
naver_url_2 <- "&pd=3&ds="
naver_url_3 <- "&de="
naver_url_4 <- "&start="

naver_url <- paste0(naver_url_1,QUERY,naver_url_2,DATE,naver_url_3,DATE,naver_url_4,PAGE)
naver_url

DATE_START <- as.Date(as.character(20140101),format="%Y%m%d") # ��������
DATE_END   <- as.Date(as.character(20141231),  format="%Y%m%d") # ��������
DATE <- DATE_START:DATE_END
DATE <- as.Date(DATE,origin="1970-01-01")
DATE

PAGE <- seq(from=1,to=171,by=10) # ���۰��� ���ᰪ�� �������� �� �ֽ��ϴ�.

naver_url_list <- c()

for (date_i in DATE){
  for (page_i in PAGE){
    dt <- format(as.Date(date_i,origin="1970-01-01"), "%Y.%m.%d")
    naver_url <- paste0(naver_url_1,QUERY,naver_url_2,dt,naver_url_3,dt,naver_url_4,page_i)
    naver_url_list <- c(naver_url_list, naver_url)
  }
}
head(naver_url_list,5)

news_url <- c()
news_date <-c() 

for (date_i in DATE){
  for (page_i in PAGE){
    dt <- format(as.Date(date_i,origin="1970-01-01"), "%Y.%m.%d")
    naver_url <- paste0(naver_url_1,QUERY,naver_url_2,dt,naver_url_3,dt,naver_url_4,page_i)
    html <- read_html(naver_url)
    temp <- unique(html_nodes(html,'#main_pack')%>% # id= �� # �� ���δ�
                     html_nodes(css='.news ')%>%    # class= �� css= �� ���δ� 
                     html_nodes(css='.type01')%>%
                     html_nodes('a')%>%
                     html_attr('href'))
    news_url <- c(news_url,temp)
    news_date <- c(news_date,rep(dt,length(temp)))
  }
  print(dt) # �����Ȳ�� �˱� �����̴� �ӵ��� �������� ����
}

NEWS0 <- as.data.frame(cbind(date=news_date, url=news_url, query=QUERY))
NEWS1 <- NEWS0[which(grepl("news.naver.com",NEWS0$url)),]         # ���̹�����(news.naver.com)�� ������� �Ѵ�   
NEWS1 <- NEWS1[which(!grepl("sports.news.naver.com",NEWS1$url)),] # ����������(sports.news.naver.com)�� �����Ѵ�  
NEWS2 <- NEWS0[!duplicated(NEWS1), ] # �ߺ��� ��ũ ���� 

NEWS2$news_title   <- ""
NEWS2$news_content <- ""

for (i in 1:dim(NEWS2)[1]){
  html <- read_html(as.character(NEWS2$url[i]))
  temp_news_title   <- repair_encoding(html_text(html_nodes(html,'#articleTitle')),from = 'utf-8')
  temp_news_content <- repair_encoding(html_text(html_nodes(html,'#articleBodyContents')),from = 'utf-8')
  if (length(temp_news_title)>0){
    NEWS2$news_title[i]   <- temp_news_title
    NEWS2$news_content[i] <- temp_news_content
  }
}

NEWS2$news_content <- gsub("// flash ������ ��ȸ�ϱ� ���� �Լ� �߰�\nfunction _flash_removeCallback()", "", NEWS2$news_content)
NEWS <- NEWS2 # ���� ��� ����

save(NEWS, file="./DATA0/NEWS.RData")