library(quantmod)
library(xts)
library(rvest)
library(tidyverse)
library(stringr)
library(forcats)
library(lubridate)
library(plotly)
library(dplyr)
library(PerformanceAnalytics)

getSymbols("AMZN",from="2012-07-01",to="2022-07-01")
AMZN_log_returns<-AMZN%>%Ad()%>%dailyReturn(type='log')

AMZN%>%Ad()%>%chartSeries()
AMZN%>%chartSeries(TA='addBBands();addVo();addMACD()',subset='2022')

library(PerformanceAnalytics)
data<-cbind(diff(log(Cl(AMZN))),diff(log(Cl(GOOGL))),diff(log(Cl(AAPL))),diff(log(Cl(FB))))
chart.Correlation(data)

mu<-AMZN_mean_log
sig<-AMZN_sd_log
price<-rep(NA,252*4)
#start simulating prices
for(i in 2:length(testsim)){
  price[i]<-price[i-1]*exp(rnorm(1,mu,sig))
}
random_data<-cbind(price,1:(252*4))
colnames(random_data)<-c("Price","Day")
random_data<-as.data.frame(random_data)
random_data%>%ggplot(aes(Day,Price))+geom_line()+labs(title="Amazon (AMZN) price simulation for 4 years")+theme_bw()

N<-500
mc_matrix<-matrix(nrow=252*4,ncol=N)
mc_matrix[1,1]<-as.numeric(AMZN$AMZN.Adjusted[length(AMZN$AMZN.Adjusted),])
for(j in 1:ncol(mc_matrix)){
  mc_matrix[1,j]<-as.numeric(AMZN$AMZN.Adjusted[length(AMZN$AMZN.Adjusted),])
  for(i in 2:nrow(mc_matrix)){
    mc_matrix[i,j]<-mc_matrix[i-1,j]*exp(rnorm(1,mu,sig))
  }
}
name<-str_c("Sim ",seq(1,500))
name<-c("Day",name)
final_mat<-cbind(1:(252*4),mc_matrix)
final_mat<-as.tibble(final_mat)
colnames(final_mat)<-name
dim(final_mat)
final_mat%>%gather("Simulation","Price",2:501)%>%ggplot(aes(x=Day,y=Price,Group=Simulation))+geom_line(alpha=0.2)+labs(title="Amazon Stock (AMZN): 500 Monte Carlo Simulations for 4 Years")+theme_bw()

final_mat[500,-1]%>%as.numeric()%>%quantile(probs=probs)

