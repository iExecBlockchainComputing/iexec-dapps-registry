library(tm)
library(pdftools)
library(wordcloud)
library(RColorBrewer)


#pdf location
file_location ="./iExec-WPv2.0-English.pdf"

#load pdf file
txt = pdf_text(file_location)

#create corpus
txt_corpus = Corpus(VectorSource(txt))

#clean corpus
txt_corpus = tm_map(txt_corpus,tolower)
txt_corpus = tm_map(txt_corpus,removePunctuation)
txt_corpus = tm_map(txt_corpus,stripWhitespace)
txt_corpus = tm_map(txt_corpus,removeNumbers)
txt_corpus = tm_map(txt_corpus,PlainTextDocument)

for (j in seq(txt_corpus)) {
  txt_corpus[[j]] <- gsub("●", " ", txt_corpus[[j]])
}

#remove stop
head(stopwords("en"))
txt_corpus = tm_map(txt_corpus,removeWords,stopwords("en"))

# view content corpus
txt_corpus$content

dtm = DocumentTermMatrix(txt_corpus)
dtm = as.matrix(dtm)
dtm = t(dtm)

#sum number of occurence of each words
number_occurances = rowSums(dtm)
number_occurances = sort(number_occurances,decreasing = TRUE)

#plot
png("iExecWordcloud.png", width=1280,height=800)
wordcloud(names(number_occurances),number_occurances,scale=c(8,.2),min.freq=3,max.words=Inf, random.order=FALSE, rot.per=.15, colors=brewer.pal(8, "Dark2"))
dev.off()