library(dplyr)
library(ggplot2)
#dplyr, ggplot2 package를 불러옴

market<- read.csv("../Data/seoul_necessaries.csv",fileEncoding = "EUC-KR") #market data(csv) 읽어옴
head(market) #data 상위 6개 row 출력


colnames(market) #data 컬럼명 출력

str(market) #data 변수 속성 확인
market2 <- select(market,M_NAME,A_NAME,A_PRICE,A_UNIT,M_TYPE_NAME,M_GU_NAME) #변수 선택
head(market2)

market2 %>% group_by(M_TYPE_NAME) %>% summarise(n = n()) #전통시장, 대형마트의 수 확인

market2 %>% group_by(M_GU_NAME, M_TYPE_NAME) %>% summarise(n = n()) %>% arrange(-n) #지역별 전통시장과 대형마트 수 확인

market2 %>% filter(M_GU_NAME == "강북구") %>% group_by(M_TYPE_NAME) %>% summarise(MEAN_PRICE = mean(A_PRICE)) #강북구에서 대형마트와 전통시장의 평균 판매금액 비교

market2 %>% filter(M_GU_NAME == "강북구" & M_TYPE_NAME == "대형마트") %>% group_by(A_NAME) %>% summarise(MEAN_PRICE = mean(A_PRICE)) %>% arrange(-MEAN_PRICE) #강북구 대형마트에서 평균가격이 비싼 순으로 품명과 평균가격 확인 

#지역구별 대형마트와 전통시장의 평균가격 분포를 그래프로 확인
market_result<- market2 %>% group_by(M_GU_NAME, M_TYPE_NAME) %>% summarise(MEAN_PRICE = mean(A_PRICE)) 
head(market_result,5)
ggplot(market_result,aes(M_TYPE_NAME, MEAN_PRICE, col = M_TYPE_NAME)) + geom_boxplot()
