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

#--------

#Uji kovarians
library(biotools)
y = x[, c(-1,-6)] #tempat dimana variabel pembeda kelompok disimpan
f = as.factor(x$jenis)
boxM(y,f)

#---------
# Uji 2 sampel saling bebas multivariat : t hotelling

#x1 and x2 are multivariate samples
#a is the significance level

x1 = as.matrix(x1) #data consumer goods
x2 = as.matrix(x2) # data producer goods

p = ncol(x1)
n1 = nrow(x1) 
n2 = nrow(x2)

n = n1+n2
n

xbar1 = colMeans(x1) #rata-rata tiap variabel consumer goods 
xbar2 = colMeans(x2) #rata-rata tiap variabel producer goods

dbar = xbar2 - xbar1
v = ((n1-1)*var(x1)+(n2-1)*var(x2))/(n-2)
v
a = 0.05

# rumus t hotelling
t2 = (n1*n2*t(dbar)%*%solve(v)%*%dbar)/n

# f statistik
test = as.vector(((n-p-1)*t2)/((n-2)*p))

#kriteria uji
crit = qf(1-a, p, n-p-1)

# p-value
pvalue = 1-pf(test,p, n-p-1)

# hasil
result = list(test = test, critical = crit, p.value = pvalue, df1 = p, df2 = n-p-1)
result #hasil
