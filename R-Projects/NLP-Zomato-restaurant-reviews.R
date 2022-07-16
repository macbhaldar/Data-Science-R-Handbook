library(tm)
library(ggpubr)
library(sentimentr)
library(tidyverse)
library(wordcloud2)
library(repr)
library(ggridges)
library(ggthemes)
library(cowplot)
library(irlba)
library(randomForest)

rest_names=read.csv("data/Restaurant-names-and-Metadata.csv")
rest_reviews=read.csv("data/Restaurant-reviews.csv")

str(rest_reviews)
head(rest_names)

head(rest_reviews)

sentiment <- with(
  rest_reviews, 
  sentiment_by(
    get_sentences(as.character(Review)), 
    list(Restaurant,Reviewer,Rating)
  )
)

sentiment=sentiment%>%arrange(desc(ave_sentiment))%>%filter(word_count>=4)

senti <- with(
  rest_reviews, 
  sentiment_by(
    get_sentences(as.character(Review)), 
    
  )
)

options(repr.plot.width=8,repr.plot.height=6)
plot(uncombine(sentiment))

tema = theme(plot.background = element_rect(fill="#FFDAB9"),
             plot.title = element_text(size=25, hjust=.5),
             axis.title.x = element_text(size=22, color = "black"),
             axis.title.y = element_text(size=22, color = "black"),
             axis.text.x = element_text(size=20),
             axis.text.y = element_text(size=20))

options(repr.plot.width=17,repr.plot.height=15)
p1=sentiment%>%ggplot(aes(x=ave_sentiment,fill=(Rating)))+geom_histogram(bins=85)+xlab("Average Sentiment")+ggtitle("Average Sentiment distribution")+theme_wsj()+tema
p2=sentiment%>%ggplot(aes(y=ave_sentiment,x=Rating,fill=(Rating)))+geom_boxplot()+ylab("Average Sentiment")+ggtitle("Average Sentiment vs Rating")+theme_wsj()+tema
plot_grid(p1,p2,ncol=2,nrow=2)

# Top 10 reviews
sentiment[1:10,]

# worse 10 reviews
sentiment[8830:8821,]

tema1=theme(plot.background = element_rect(fill="#EECCBB"),
            plot.title = element_text(size=25, hjust=.5),
            axis.title.x = element_text(size=22, color = "black"),
            axis.title.y = element_text(size=22, color = "black"),
            axis.text.x = element_text(size=20),
            axis.text.y = element_text(size=20))

options(repr.plot.width=19,repr.plot.height=15)
p3=ggplot(sentiment[1:20,],aes(x=reorder(Restaurant,ave_sentiment),y=ave_sentiment,fill=Rating))+geom_bar(stat="identity")+theme(axis.text.x=element_text(angle=0))+coord_flip()+ggtitle("Best 20 Reviews")+ylab("Average Sentiment")+xlab("Restaurant")+theme_wsj()+tema1
p4=ggplot(sentiment[8811:8830,],aes(x=reorder(Restaurant,ave_sentiment),y=ave_sentiment,fill=Rating))+geom_bar(stat="identity")+theme(axis.text.x=element_text(angle=0))+coord_flip()+ggtitle("Worst 20 Reviews")+ylab("Average Sentiment")+xlab("")+theme_wsj()+tema1
plot_grid(p3,p4,ncol=2,nrow=2)

rest_sentiment=sentiment%>%group_by(Restaurant)%>%summarise(avg_word_count=mean(word_count),mean_sentiment=mean(ave_sentiment))%>%arrange(desc(mean_sentiment))

# top 10 best restaurant
rest_sentiment[1:10,]

# top 10 worse restaurant
rest_sentiment[100:91,]

options(repr.plot.width=19,repr.plot.height=15)
p5=ggplot(rest_sentiment[1:20,],aes(x=reorder(Restaurant,mean_sentiment),y=mean_sentiment,fill=avg_word_count))+geom_bar(stat="identity")+theme(axis.text.x=element_text(angle=90))+coord_flip()+ggtitle("Best 20 Restaurant")+ylab("Average Sentiment")+xlab("Restaurant")+theme_gdocs()+tema
p6=ggplot(rest_sentiment[81:100,],aes(x=reorder(Restaurant,-mean_sentiment),y=mean_sentiment,fill=avg_word_count))+geom_bar(stat="identity")+theme(axis.text.x=element_text(angle=90))+coord_flip()+ggtitle("Worst 20 Restaurant")+ylab("Average Sentiment")+xlab("")+theme_gdocs()+tema
plot_grid(p5,p6,nrow=2,ncol=2)

# most frequent words used by reviewers
Reviews=(rest_reviews$Review)

Rev=tolower(Reviews)%>%removePunctuation()%>%removeNumbers()%>%stripWhitespace()
Rev=removeWords(Rev,stopwords("en"))
Rev=removePunctuation(Rev)
rm_comment=c("one","really","also","just","will","can","must","really","can","also","read","last","will","date","never")
Rev=removeWords(Rev,rm_comment)

Rev_corpus=Corpus(VectorSource(Rev))
Rev_dtm=DocumentTermMatrix(Rev_corpus)
Rev_matrix=as.matrix(Rev_dtm)
Rev_freq=colSums(Rev_matrix)
Rev_df=data.frame(name=names(Rev_freq),occur=Rev_freq)
Rev_df=Rev_df%>%arrange(desc(occur))

Rev_df[1:10,]

options(repr.plot.width=15,repr.plot.height=15)
Rev_df%>%filter(occur>500)%>%ggplot(aes(reorder(name,occur),occur,fill=name))+geom_bar(stat="identity",show.legend=FALSE)+coord_flip()+ylab("Frequency")+xlab("Words")+theme_calc()+tema

Rev_df%>%filter(occur>300)%>%wordcloud2(backgroundColor="darkgrey",shape="star",size=1)


str(rest_names)

rest_names$Cost=gsub(",","",rest_names$Cost)

rest_names$Cost=as.numeric(as.character(rest_names$Cost))

options(repr.plot.width=8,repr.plot.height=6)
hist(rest_names$Cost,col="lightblue",main="Cost distribution for 1 dinner in different restaurants",xlab="Cost")
abline(v=mean(rest_names$Cost),col="red")

# Restaurants cost more than and less than 900 per dinner.
options(repr.plot.width=12,repr.plot.height=19)
p5=rest_names%>%filter(Cost>=900)%>%ggplot(aes(y=Cost,x=reorder(Name,Cost),fill=Collections))+geom_bar(stat="identity",show.legend=FALSE)+theme(axis.text.x=element_text(angle=0))+coord_flip()+ggtitle("Cost>=900/Dinner")+xlab("Name")+theme_economist()
p6=rest_names%>%filter(Cost<900)%>%ggplot(aes(y=Cost,x=reorder(Name,Cost),fill=Collections))+geom_bar(stat="identity",show.legend=FALSE)+theme(axis.text.x=element_text(angle=0))+coord_flip()+ggtitle("Cost<900/Dinner")+xlab("")+theme_economist()
plot_grid(p5,p6,nrow=2,ncol=2)

# Availability of cuisines
options(repr.plot.width=10,repr.plot.height=17)
ggplot(rest_names,aes(Cuisines,fill=Name))+geom_bar(show.legend=FALSE)+theme(axis.text.x=element_text(angle=0))+coord_flip()+theme_bw()+xlab("Frequency")+theme_wsj()

# Collection 
options(repr.plot.width=8,repr.plot.height=6)
plot(rest_names$Collections,col="darkblue",main="Collections ")
