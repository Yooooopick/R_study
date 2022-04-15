Sys.setenv(lagnuage="en")
data(Indometh)
#install.packages("knitr")
library(knitr)
#install.packages("remotes")
library(remotes) # CRAN v2.1.1 
library(stringi) # CRAN v1.4.6 
library(stringr) # CRAN v1.4.0 
library(tidyverse)
#install.Rtools()
library(devtools)
library(installr)
library(rinds)
#install.packages('readxl')   
library(readxl)


#向量，具有方向的变量
#向左箭头："Alt+-"
#要查看某函数的参数，只需要打出函数，在括号内按一下tab
x <- 1
x
z <- 1:5
z
class(z)
a <- c(1,2,3,4,5)
a
class(a)
identical(a,z)#判断a和c是否一样
a[3]
a[1:3]
a[-c(1,3)]#删除特定位置
vector2 <- c(1,4,'abc','您好')
vector2

#几个生成数值的函数
#seq函数
seq(from=100,to=0,by=-10)
seq(1,12,length.out=11)#len参数表示取11个数，R自动均分
seq(200,10,-10)#自己熟悉以后，把函数名取消
#一个重要参数along.with
seq(1,5,along.with=1:3)
#它的意思是给定一个向量模板1:3，这里面有三个元素，所以前面1：5也就被分割为3个

#rep函数,times,len,each参数的运用
rep(c(1:7),times=2)
rep(c(1:3),len=10)
rep(c(4:9),each=2)

#逻辑性向量
logit <- rep(c(TRUE,FALSE),times=4)
logit
sum(logit)

#逻辑表达式，等于是==，不等于是!=,和是&
logit1 <- c(100==100,100!=1)
logit1
c(100==100 & 100!=100)
#或，删除键下面，shift+\
c(100==100 | 100<=30)

x <- seq(1,100,len=20)
x
index <- x>80
index#index返回的是逻辑值
x[index]

#which函数
which(x>80)
x[which(x>80)]
x[x>80] #which函数的目的是为了得到下标

#字符串，最终极的关键是必须有引号,且只能有一对引号
string <- c('abc',1,2,12)
string
#注意到1,2,12被强行变成了字符串

#内置向量letters
letters
LETTERS
LETTERS[21:28]
#NA是缺失值

#因子型向量，略等于分类变量
#factor函数
my_Fac <- factor(x=rep(c(1,2),times=5),levels=c(1,2),labels=c('Male','Female'))
my_Fac
class(my_Fac)
#一般来说levels就是x那边的c,故可省略

#gl函数
?gl
my_fac4 <- gl(n=2,k=5,labels=c('Control','treatment'))
my_fac4

#把字符串变成因子
#函数as.factor
temp_string <- c('a','b','1','3')
my_fac5 <- as.factor(temp_string)
my_fac5
#反过来就是as.character

#了解一个因子有多少个水平
#nlevels函数
nlevels(my_fac4)
#另外levels函数给你显示这两个水平到底是什么
levels(my_fac4)

#怎么样生成哑变量？
my_fac7 <- factor(c('A','B','AB','O'))#注意到我们这只是想得到一组分类变量，所以没有设置levels和labels
my_fac7
my_fac6 <- relevel(my_fac7,ref='B')# ref是谁，谁就会排到前面去
my_fac6
#注意观察6和7区别，R默认第一个是哑变量，通过relevel和参数ref改变default

#ordered参数
x <- c('Placebo','20mg','10mg','30mg')
my_order_fac <- factor(x,ordered=TRUE)
my_order_fac
#注意到Placebo被放到最后去了！显然不行


#解决方案一：把Placebo换成0mg
#解决方案二：扩展包DescTools
install.packages("DescTools")
library(DescTools)

#reorder.factor函数
my_order_fac2 <- reorder.factor(my_order_fac,new.order = x)
my_order_fac2
#注意到new.order的意思是根据x的顺序来重新组织my_order_fac的顺序，但是，它有一个致命缺陷，那就是x内部顺序必须是刚好你要的顺序

#列表，list函数，每个逗号后面是一层
my_list <- list(1,2,3,'R',TRUE,FALSE)
my_list
my_list2 <- list(1:10,letters[1:5])
my_list2
#怎么找到my_list2中的a？
my_list2[[2]][1]
my_list2[[1]][2]
class(my_list[1])
class(my_list[[1]][2])

# list嵌套
my_list3 <- list(1:10,letters[1:5],list(11:14,LETTERS[1:5]))
my_list3
my_list3[[3]][[2]][1]#怎么找到大写字母A
#如果是
my_list3[[3]]
class(my_list3[[3]])
#而前面的my_list2呢？
class(my_list2[[2]])
#如果是双层list，第一个[[]]提取的是list


#矩阵
#matrix函数
my_matrix2 <- matrix(data=1:10,nrow=5)
my_matrix2
my_matrix3 <- matrix(data=letters[1:3],nrow=2,ncol=4)
my_matrix3
#注意到abc只有三个!

#给行列命名，dimnames函数
my_matrix5 <- matrix(data=1:12,nrow=3,ncol=4,dimnames=list(c('A','B','C'),c('I','II','III','IV')))
my_matrix5

#矩阵转置t,非常常用！因为R的矩阵默认是竖过来排序的！
t(my_matrix5)

#一个包含字符串的矩阵
my_matrix6 <- matrix(c(1:5,letters[1:5]),nrow=2)
my_matrix6
#注意到1，2，3，4，5虽然是数值，但是矩阵会自己把它变成字符串

#数组和数据框
#array
my_array <- array(data=1:16,dim=c(2,4,2))#dim多了一个层的维度，最后一个2，就是2层，这一点和矩阵不同
my_array

#给数组命名
my_array2 <- array(data=1:16,dim=c(4,2,2),
                   dimnames=list(LETTERS[1:4],c('col1','col2'),c('first','second')))
# dimnames内顺序为行，列，数组分组名称，分别对应array定义时候的dim的三个数字的顺序

#提取矩阵中的元素
my_matrix2[2,1]
my_matrix2[,1]
my_array2[,1,]#注意到提取的是my_array2两层里面的第一列，因为行和层数都没有指定！
# array其实可以理解为比一般list更加规整的格式,但是是扁平的，而list是嵌套的，体现在提取元素方法的差异上
my_array2[,,2];my_list3[[3]][[2]][1]

#数据框
#函数data.frame,列名就是下面的变量名
my_df <- data.frame(name=c('Tom','Kus'),age=c('1','2'),height=c('156','123'))
my_df
#那么，哪些列名不合法？1age不可以，1不可以，就是说数字不在第一位，也不单独使用

#str函数，就是structure
#参数stringsAsFactors
my_df2 <- data.frame(one=c(1,2,3,4,5), two=LETTERS[1:5],three=c(T,F,T,F,T),stringsAsFactors = FALSE)
my_df2
str(my_df2)
#注意，str中看到two中已经变成了chr

#去除不想要的列
my_df2[,-2]
#另一方法，$,NULL
my_df2$two=NULL
my_df2
#如何新增一列
my_df2$four <- LETTERS[1:5]
my_df2


#修改一个元素
#edit函数,不改变原始数据框！
edit(my_df2)
my_df2# edit过后my_df2还是没有改变！
#怎么解决？重新赋值给my_df3
my_df3 <- edit(my_df2)
my_df3
#另一种方法,fix函数
fix(my_df3)
my_df3
#注意到原始数据框也随之发生了改变

#大数据框处理
#head函数
head(iris)
tail(iris)
#psych函数包

#install.packages('psych')
library(psych)
describe(iris)
#describe函数
#对describe的理解，其实就是统计学中的数据描述，mean是均值，sd标准差，trimmed去除头尾极值以后的均值，skew和kurtosis是偏度和丰度，是用来评价正态分布情况

#对变量重新命名
#names函数一方面可以查看变量名，另一方面就是重命名
names(iris) <- c('A1','A2','A3','A4','A5')

#重要代码，如何显示中文,将下面的english和chinese转换输入，可以实现语言的转换
# Sys.setlocale(locale="chinese")
# names(iris) <- c('A1','A2','A3','A4','方')
# head(iris)
#看到中文字符已经可以显示
# my_df2 <- data.frame(one=c(1,2,3,4,5), two=c('张三','李四','王五','赵六','田七'),three=c(T,F,T,F,T),stringsAsFactors = FALSE)
# my_df2
# str(my_df2)

#合并数据框的列，cbind，注意每一列个数一致
my_df2_1 <- my_df2
my_df4 <- cbind(my_df2,my_df2_1)
my_df4

#合并数据框的行，rbind，变量名必须一致
my_df5 <- rbind(my_df2,my_df2_1)
my_df5

#merge函数——根据某个变量合并两个数据框，by.x的意思是根据第一个数据框my_df2里面的变量来
my_df11 <- data.frame(one=c(2,3,4,1,5),two=c('张三','李四','王五','赵六','田七'),three=c(T,F,T,F,T),stringsAsFactors = FALSE)
my_df11
my_df6 <- merge(my_df2,my_df11)
my_df6 <- merge(my_df2,my_df11,by='one')#加上by='one'以后，比较一下两者的不同

#数据框切分
#粗暴型，乱来,比如产生随机数！
iris_sub <- iris[sample(1:nrow(iris),30),]
View(iris_sub)
#另外，如何固定相同随机数？种子！
#set.seed函数
#举例
sample(1:nrow(iris),30)
sample(1:nrow(iris),30)
#注意到两次运行不一样的结果
set.seed(00112)
x <- sample(1:nrow(iris),30)
# 通过set.seed函数使得x的值固定下来，这样借助x实现的代码也就具备了可重复性

#第二种切分，大刀阔斧
#split函数
iris2 <- iris
names(iris2) <- c('我','爱','医','学','方')
head(iris2)
iris_sub2 <- split(iris2,f=iris2$方)
class(iris_sub2)
head(iris_sub2)
#注意方是一个因子变量，里面有三个不同的水平
#注意iris_sub2是一个列表，因为只有列表能容纳三个数据框
#怎么从里面选择一个因子转变为数据框？
setosa <- as.data.frame(iris_sub2[1])
head(setosa)
class(setosa)
#注意到这时候提取的是setosa因子部分，且通过as.data.frame转化为数据框

#精准切割
#[]妙用，结合逻辑表达式==
iris_sub3 <- iris[iris2$方=='setosa',]
#结合&进行筛选
iris_sub3<- iris2[iris2$方=='setosa'&iris2$我>4.5,]
iris_sub3
#range函数
#range(iris_sub3$爱)
iris_sub3<- iris[iris$方=='setosa'&iris$我>4.5,1:2]
iris_sub3

#subset函数，重点函数,第一个参数是输入的数据框，第二参数是subset选取行，第三个select函数选举列
#subset函数媲美tidyverse系列
iris_sub4 <- subset(iris2,iris2$方=='virginica' & iris2$爱>3.2,select=1:3)
iris_sub4

#条件与循环
#{}用来承载函数集
# else绝对不可以在大括号下面一行，必须在大括号后面

if(x>2)
{
  y=2*x
  z=3*y
} else #注意大括号的位置和else必须紧跟在}的后面
{
  y=2+x
  z=3*y
}
x <- 6
y;z   
#注意每给x赋值一次，那么上面的函数必须重新运行一次

#循环repeat
#注意print函数前后的{}都是可以省略的
i <- -1
if(i>0 & i<2) {print('i=1')} else
{print("i don't know")}
#repeat函数,注意到退出循环的条件在if后面给出，else后面给出{}引导的条件命令，这样看起来美观
repeat {if(i>25)break else
{print(i)
  i <- i+5}
}
#while函数
i <- 5
i
while (i<25){
  print(i)
  i <- i+5
}
# for函数，k是一个用来遍历的“虚拟变量”
for (k in 1:10){
  print(k)
}
#利用set.seed和for循环语句筛选数据
set.seed(2021)
x <- sample(10:100,10)
y <- sample(1:100,10)
z <- NA
for(m in 1:10){
  z[m]=x[m]>y[m]
}
z
class(z)
#怎么样让z返回具体的数？append函数，这个结构很常用，是基本结构！
#如果下面的程序无法给出想要的结果，更改seed值，重新运行
set.seed(2011)
x <- sample(10:100,10)
y <- sample(1:100,10)
n <- NULL
for (m in 1:10){
  if(x[m]>y[m]){
    n=append(n,x[m])
  } else {n=append(n,y[m])#注意到第一个大括号跟在else后面，第二个换行
  }
}
n
#函数append()用于修改合并向量，可以把两个向量合并为一个,举例：
#append(1:5, 0:1, after = 3)
#这样一来，就取出了两个数据集每个位置的最大值

#双重循环,如果程序运行不出来，注意检查i和j的下标是否正确
matrix_10 <- matrix(NA,nrow=4,ncol=5)
for (i in 1:4)
  for (j in 1:5){
    matrix_10[i,j] <- 2
  }
matrix_10
# 不管是ifelse,while,repeat,for,还是其他函数和循环，重点是三个
# 第一，循环外设置输入，比如上面的空矩阵matrix_10
# 第二，循坏内设置输出，比如print,比如return，比如用下标（虚拟变量i)指定value放进去的地方
# 第三，哪些变量需要提前规定，那么是虚拟变量，一定要设置清楚且分清楚

#函数
#一个英文字符串加上一个小括号
#mean函数,trim和na.rm参数
mean(c(0.000004,1,2,3,4,5,6,7,NA,120000),na.rm=T,trim=0.2)


#自定义函数
my_fun1 <- function(x,y){#注意大括号位置
  x+y
}
my_fun1(2,3)
#设置默认值,y=2
my_fun2 <- function(x,y=2){
  x+y
}
my_fun2(2)
my_fun2(2,3)

# ... 缺省参数（我不知道你会传入什么，用...代替）
# sqrt是平方根，summary是返回参数，summary经常用来返回对统计的描述等等，如下所示：
values <- c(sqrt(1:100))
head(values)
my_fun4 <- function(x,...){
  print(x)
  summary(...)
}# 严格按照格式来，{}和函数主体换行写
my_fun4('here is the summary for values:',values,digits=2)
#digits=2就是小数点后1位，3就是小数点两位
# 注意这里的语法结构，digits=2中digits并非变量名称也是可以出现在my_fun4的函数描述里面的


#用缺省参数作求和,用...代替我们还不知道的用户可能输入的数值
addup1 <- function(x,...){
  args <- list(...)#列表形式自由，是最自由的数据格式,ggplot2图片也可以放在里面
  for (a in args) x <- x+a
  x # x是为了循环结束的时候把结果打印出来,print(x),return(x)也可以
}
#上面是一个累加的自定义函数
# 特别注意到...指代的可以不止一个变量而是一群变量！
addup1(1,5,6,7,8)

normalize <- function(x, ... , m = mean(x, ...), s = sd(x, ...)) {
  (x - m) / s # 对应下面的例子，x就是1，而...是其他数，...把这些数也传给了mean和sd函数
}
normalize(1:10)


#文件读取
#csv
OE <- read.csv(file="OE_count.csv",header=T,row.names=1,sep=',',encoding="UTF-8",
               na.strings=c(NA,NULL))# 注意，encoding和sep在excel导出为csv的时候指定的话这里就需要调整
#txt
OE_2 <- read.table()
# excel文件，使用readxl包的read_excel
example <- read_excel(path="example.xlsx",sheet=1,col_types = "text")

x <- scan()
#console输入数据，双击enter停止
#cat函数
cat(1:10,file='a.txt')
dir(pattern = ".*.txt$")
#注意，复制路径的时候，在R这边必须把斜杠换成/

#数据的局部读取
install.packages("XLConnect")
library(XLConnect)
example_2 <- XLConnect::readWorksheetFromFile("example.xlsx",
                                              sheet=1,
                                              startRow=1,
                                              endRow=5,
                                              startCol=2,
                                              endCol=6)# 注意start和end系列参数来自于readWorkSheet函数，并非其自有
# spss,sas,stata数据用foreign包读取

#stringi扩展包
library(stringi)
my_fasta <- stri_read_lines( 'example.fasta')     
head(my_fasta)
#内置函数
my_fasta2 <- readLines('example.fasta')
head(my_fasta2)

#导出数据
write.csv(my_fasta,file="fasta.csv")#如果是覆盖原来的文件，在后面加上append=TRUE

#排序函数
x <- sample(1:100,10)
#sort函数,decreasing参数
sort(x)
sort(x,decreasing=TRUE)
#给字符串排序，按照首字母
y <- c('python','R','ending')
sort(y,decreasing=TRUE)
#rank函数，秩次
#rank不仅排序，而且对应相应位置
#举例
z <- c(2,1,0,3)
rank(z)
w <- c(1,2,3,3)
rank(w)
# 1.0 2.0 3.5 3.5
#注意到两个c的秩次相加除以2
#order函数，最常用,返回原来x里面对应的下标
order(x);x
#注意到第一个返回的是数值最小的那个的下标！后面依次类推
#sort是单纯排序，rank依次返回原来的数对应的排名，而 order从左到右返回对应数的下标
#利用order函数结果，得到经过重新排序的向量
x[order(x)]
#注意到上面的函数从小到大取值！和sort函数一样，但是它们应用还是有区别
#因为order返回的是下标，因此它可以对数据框进行排序!
head(iris)
#针对sepa1.length进行排序
head(iris[order(iris$Sepal.Length),])
head(iris[order(-iris$Sepal.Length),])#注意到在iris前面添加-，改为从大到小排序,decreasing=T也可以
#对多个变量同时排序
head(iris[order(iris$Sepal.Length,iris$Sepal.Width),])
#注意到上面对length排序后对width排序，次第排序

#长宽型数据排序
# stack函数
freshmen <- c(178,180,182,180)
sophomores <- c(188,172,175,172)
juniors <- c(167,172,177,174)
height <- stack(list(fresh=freshmen,sopho=sophomores,jun=juniors))
height
with(height,tapply(values,ind,mean))
# reshape函数
data("Indometh")
View(Indometh)
wide <- reshape(Indometh, v.names = "conc", idvar = "Subject",
                timevar = "time",direction = "wide")
# v.names表示names of values我们想要把哪个变量当键值,idvar表示id of variable也就是标识变量
long <- reshape(wide, idvar = "Subject", varying = list(2:12),# varing表示我们需要把2-12列堆栈在一起
                v.names = "concentrtion", direction = "long")

#reshape2函数,重点函数
library(reshape2)
mew_iris <- melt(iris,id.vars='Species')# id.vars是标识变量，表示不把这个变量拿进去融化
View(mew_iris)
View(mew_iris)#变成长型数据以后，下一步我想知道不同花种的value的均值应该怎么？
#dcast函数,注意formula参数内是四格表的x y轴，value.var是需要被统计的变量
dcast(mew_iris,formula=Species~variable,fun.aggregate=mean,value.var='value')
# 看一下tips数据集
View(tips)
dcast(data = tips, formula = sex~., fun.aggregate = mean, value.var = 'tip')# 如果只关注一个分类变量，那么formula的右侧变量使用.代替
dcast(data = tips, formula = sex ~ smoker, fun.aggregate = mean, value.var = 'tip')
#只需要调整formula，就能得到不同的四格表

