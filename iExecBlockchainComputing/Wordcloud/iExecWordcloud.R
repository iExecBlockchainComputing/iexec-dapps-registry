library(tm)
library(pdftools)
library(wordcloud)
library(RColorBrewer)
library(RCurl)
library(dqmagic)
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args) != 1) {
  stop("At least one argument : pdf file url must be supplied.n", call.=FALSE)
}

if (! url.exists(args[1])){
    stop(c("wrong url:", args[1]), call.=FALSE)
}


download.file(url=args[1], destfile='wordcloudInput.pdf', method='curl')

file_type("./wordcloudInput.pdf", mime_type = TRUE)

if (file_type("./wordcloudInput.pdf", mime_type = TRUE) != "application/pdf"){
   stop("mime_type file must be application/pdf", call.=FALSE)
}

#pdf location
file_location ="./wordcloudInput.pdf"

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

write.table(number_occurances, "/iexec/consensus.iexec", append = FALSE, sep = " ", dec = ".",row.names = TRUE, col.names = TRUE)

#plot
png("iexec/wordcloudResult.png", width=1280,height=800)
wordcloud(names(number_occurances),number_occurances,scale=c(8,.2),min.freq=3,max.words=Inf, random.order=FALSE, rot.per=.15, colors=brewer.pal(8, "Dark2"))
dev.off()
