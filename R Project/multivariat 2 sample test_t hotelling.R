library(readxl)

#IMPORT DATA
mydata <- read_excel("D:/WORK/04 REMOTE/portofolio/R Project/data/02 consumer_producer goods.xlsx",
                     sheet = "data_new format")
#------
# membagi data ke dalam x1 consumer goods dan x2 producer goods
x = mydata
x1 = x[which(x$jenis =="consumer goods"), ]
x2 = x[which(x$jenis=="producer goods"), ]

#------
#uji normalitas multivariat
library(mvnTest)

#nullkan yang ga dibutuhin (jenis, item)
x1$jenis = NULL
x2$jenis = NULL
x1$Item = NULL
x2$Item = NULL

hasil_consumergoods =HZ.test(x1, qqplot = TRUE)
hasil_consumergoods


hasil_producergoods =HZ.test(x2, qqplot = TRUE)
hasil_producergoods
