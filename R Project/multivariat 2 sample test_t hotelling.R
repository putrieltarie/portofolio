library(readxl)

#IMPORT DATA
mydata <- read_excel("D:/WORK/04 REMOTE/portofolio/R Project/data/02 consumer_producer goods.xlsx",
                     sheet = "data_new format")

# membagi data ke dalam x1 consumer goods dan x2 producer goods
x = mydata
x1 = x[which(x$jenis =="consumer goods"), ]
x2 = x[which(x$jenis=="producer goods"), ]
