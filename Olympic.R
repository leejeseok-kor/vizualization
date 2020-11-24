library(dplyr)
library(ggplot2)
#dplyr, ggplot2 library 불러오기

oly <- read.csv("./Data/Olympic.csv") #Olympic data(csv) 불러옴
head(oly) #data 상위 6개 row 출력

str(oly) #data 변수 속성 확인

oly %>% group_by(Year) %>% summarise(n = n()) %>% arrange(-n) #data의 Year별 Data 수 내림차순으로 출력

oly %>% filter(NOC == "KOR") %>% group_by(Name) %>% summarise(n = n()) %>% arrange(-n) %>% head(10) #Data KOR선수들의 출전횟수 상위 10개 출력 

oly %>% filter(Year == 2012 & NOC == "KOR" & Medal == "Gold") %>% select(Name, Age, Sex, Height, Weight, Medal) #Year 가 2012이고, NOC가 KOR이며 Medal이 Gold인 선수들의 정보 출력 

o_viz <- read.csv("./Data/Olympic_viz.csv") #csv data를 불러옴
head(o_viz) #data 상위 6개 row 출력

ggplot(o_viz, aes(NOC, fill = NOC)) + geom_bar() + theme(axis.text.x = element_text(angle = 45)) #Noc별 메달 수를 막대그래프로 시각화 

order <- o_viz %>% group_by(NOC) %>% summarise(count = n()) %>% arrange(count)
o_viz2 <- o_viz
o_viz2$NOC <- factor(o_viz2$NOC, levels = order$NOC)
ggplot(o_viz2, aes(NOC)) + geom_bar(fill = "steelblue") + coord_flip() #NOC별 메달 수가 높은 순으로 막대그래프 출력 

ggplot(o_viz, aes(NOC, fill = Medal)) + geom_bar(position = "fill") + coord_flip() #NOC별 메달 비율을 출력

ggplot(o_viz, aes(NOC, fill = Medal)) + geom_bar(position = "fill") + facet_grid(~Sex) + theme(axis.text.x = element_text(angle = 45)) #성별에 따른 NOC의 메달 비율 막대 그래프

ggplot(o_viz, aes(NOC, fill = Medal)) + geom_bar(position = "fill") + facet_grid(Year~Sex) #년도, 성별에 따른 NOC의 메달 비율에 대한 막대그래프
