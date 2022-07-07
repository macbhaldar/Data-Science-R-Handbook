library(quanteda)
library(quanteda.textplots)
library(quanteda.textstats)
library(corpustools)
corp <- corpus(sotu_texts, docid_field = 'id', text_field = 'text')

dtm <- corp |>
  tokens() |>
  tokens_tolower() |>
  dfm()
dtm

textplot_wordcloud(dtm, max_words=100)

library(SentimentAnalysis)
?DictionaryGI
names(DictionaryGI)
head(DictionaryGI$negative, 27)

library(qdapDictionaries)
?weak.words
head(weak.words, 27)

library(tidyverse)
url <- "https://raw.githubusercontent.com/cjhutto/vaderSentiment/master/vaderSentiment/vader_lexicon.txt"
# note: the command below gives warning messages due to the details column, these can be safely ignored
vader <- read_delim(url, col_names=c("word","sentiment", "details"),  col_types="cdc",  delim="\t")
head(vader)

GI_dict <- dictionary(DictionaryGI)

HL_dict <- dictionary(list(positive=positive.words, negative=negation.words))

result <- dtm |>
  dfm_lookup(GI_dict) |> 
  convert(to = "data.frame") |>
  as_tibble()
result

result <- result |> 
  mutate(length = ntoken(dtm))

result <- result |> 
  mutate(sentiment1=(positive - negative) / (positive + negative),
         sentiment2=(positive - negative) / length,
         subjectivity=(positive + negative) / length)
result


sample_ids <- sample(docnames(dtm), size=50)

## convert quanteda corpus to data.frame
docs <- docvars(corp)
docs$doc_id = docnames(corp)
docs$text = as.character(corp)

docs |> 
  filter(doc_id %in% sample_ids) |> 
  mutate(manual_sentiment="") |>
  write_csv("to_code.csv")

validation = read_csv("to_code.csv") |>
  mutate(doc_id=as.character(doc_id)) |>
  inner_join(result)

cor.test(validation$manual_sentiment, validation$sentiment1)

validation <- validation |> 
  mutate(sent_nom = cut(sentiment1, breaks=c(-1, -0.1, 0.1, 1), labels=c("-", "0", "+")))
cm <- table(manual = validation$manual_sentiment, dictionary = validation$sent_nom)
cm

sum(diag(cm)) / sum(cm)

freqs <- textstat_frequency(dtm)
freqs |> 
  as_tibble() |> 
  filter(feature %in% HL_dict$positive)

head(kwic(tokens(corp), "like"))

positive.cleaned <- setdiff(positive.words, c("like", "work"))
HL_dict2 <- dictionary(list(positive = positive.cleaned, negative = negation.words))

freqs |> 
  filter(feature %in% HL_dict2$positive) |>
  as_tibble()

sent.words <- c(HL_dict$positive, HL_dict$negative)
freqs |>
  filter(!feature %in% sent.words) |> 
  View

# install.packages("corpustools")

library(corpustools)
t <- create_tcorpus(sotu_texts, doc_column="id")

t$code_dictionary(GI_dict, column = 'lsd15')
t$set('sentiment', 1, subset = lsd15 %in% c('positive','neg_negative'))
t$set('sentiment', -1, subset = lsd15 %in% c('negative','neg_positive'))

browse_texts(t, scale='sentiment')

war <- subset_query(t, "war", window=10)

dtm_war <- get_dfm(war, feature='token') |>
  dfm_trim(min_docfreq=5) |>
  dfm_remove(stopwords('english')) |> 
  dfm_tolower() |>
  dfm_remove("[^a-z]", valuetype="regex")

head(textstat_frequency(dtm_war))
