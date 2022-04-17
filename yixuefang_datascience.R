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



#变量的因子化
#比如，对数值型变量年龄进行分段，变成少年/中年等因子
age <- sample(20:80,20)
age
#公式法
age1 <-1 +(age>30)+(age>=40)+(age>=50)
age1
age1 <- factor(age1,labels=c('young','middle','mid-old','old'))
#如果需要切分分段呢?
age2 <- 1*(age<30)+2*(age>=30 & age<40)+3*(age>=40 & age<50)+4*(age>=50)
age2
#cut函数，用breaks均分,include.lowest为真，意味着左闭，right同理
age3 <- cut(age,breaks=4,labels=c('young','middle','old','veryold'),
            include.lowest=TRUE,right=TRUE)
age4 <- cut(age, breaks = seq(20,80,length = 4), labels = c('young','middle','old'));age4

# 常用且经典，ifelse函数，ifelse的嵌套
ifelse(age>50,'old','young')
ifelse(age>60,'old',ifelse(age<30,'young','middle'))
#car包，recode函数,重点
library(car)
recode(var=age,recodes='lo:29=1;30:39=2;40:49=3;50:hi=4')
#两个细节，注意到lo和hi分别表示极小值和极大值，不可使用low和high
#另外，lo和29之间是：,而区间之间是;

# 数据清洗与整理
#数据汇总函数之apply函数:apply,lapply,sapply,tapply,mapply；五朵金花
#apply函数
mat_1 <- matrix(1:12,nrow=4,ncol=3)
apply(mat_1,1,sum)#1表示行，sum表示求和
apply(mat_1,2,mean)#2表示列，mean表示均值

apply(iris[,1:4],2,mean)
head(iris)#对比一下，发现第五列是species是不参与运算的，所以上面把它剔除

#lapply常用，重点，不仅汇总，而且可以遍历，可以嵌套各种函数，也可以对行列分别操作
#lapply函数，比如对X取对数
lapply(X=c(1:5),FUN=log)
#lapply函数是得到线性回归的最好选择，因为返回的是且只能是列表
lapply(iris[,1:3],function(x)lm(x~iris$Petal.Width,data=iris[,1:3]))
#注意上面的函数，线性回归参数lm里面x后面是~，不是=
# lapply威力就在这，它只能返回list，list数据维度多了一个，因此能承担更多的结果丰富度

#remotes::install_github("anthonynorth/rscodeio")
# sapply函数
sapply(1:5,function(x)x+3)
sapply(1:5, FUN=log)
#分别对x进行加3，并且返回一个向量
#对比lapply,返回的是一个列表:
# lapply()中的 “l” 代表 list，它接受 list 作为输入，
# 并将指定的操作应用于列表中的所有元素。
# 在 list 上逐个元素调用 FUN。可以用于 dataframe 上，
# 因为 dataframe 是一种特殊形式的 list
lapply(c(1:5),FUN=log)

#tapply适用于dataframe,array等等，注意和dcast函数对比,tapply很常用，是重点
#注意到INDEX是选择的因子,tapply函数的作用就是根据分类变量去统计数值变量
tapply(iris$Sepal.Length,INDEX=iris$Species,FUN=mean)
tapply(iris[,1:4], iris$Species, mean)# 报错，tapply的缺陷用dcast可以解决

#mapply函数
#首先看一个例子，if函数不能进行向量化操作！
myfun <- function(x,y){
  if(x>4)return(y)
  else return(x+y)
}
myfun(2,3)
#但是，如果：
myfun(1:3,2:4)
#注意到报错！因为函数不能向量化操作（真的吗？其实可以借助缺省...）
#mapply
mapply(myfun,1:5,2:6)
#mapply赋予了函数对向量进行操作的功能

#生成一个生存数据
survival <- data.frame(id = 1:10, 
                       cancer = sample(c('lung','liver','colon'), 10, replace = TRUE), 
                       treatment = sample(c('Surg','Chemo'), 10, replace = TRUE), 
                       sur_days = sample(100:1000, 10))
survival
#ave也是根据分类变量计算均值，注意到ave里面输出的只有三个绝对值，用table统计
#其实这个函数有缺点，因为根本看不到是针对谁在统计均值
table(ave(survival$sur_days,survival$cancer))
#by函数的
#INDICES不仅可以传入单个因子还可以传入一个list
by(data=survival$sur_days,INDICES=list(survival$cancer,survival$treatment),FUN=sd)
#观察上述函数，注意到INDICES没有返回重复值，而是自动做了归纳！
#dcast函数其实也可以
table(mtcars$cyl)
by(mtcars, mtcars$cyl, function(x)lm(mpg~disp + hp, data = x))

#重点函数aggregate
View(head(mtcars))
#一个极其重要的函数aggregate,by参数里面传入的是list！
#list中的VS和high都是我们自己设置的新变量
#设置新变量是为了数值因子化，然后根据分类变量进行函数运算,这是一个非常重要的点！
aggregate(x=mtcars,by=list(VS=mtcars$vs==1,high=mtcars$mpg>22),mean)
#假如数据框中出现了iris最后一列一样的因子这样的字符串变量，aggregate函数会报错
#aggregate函数另外一种写法
aggregate(.~Species,data=iris,mean)
#注意到.表示.是缺省，表示Mean不去计算species, ~在species前面

#sweep理解
#sweep函数对array进行每个元素操作
# sweep 函数和 apply 函数相似，但是 sweep 主要用于 array 的一些分类计算
# 而 apply 更多的是矩阵计算，data.frame 也行
my_array3 <- array(1:24,dim=c(3,4,2));my_array3
class(my_array3)#可见my_array3是一个列表
sweep(my_array3,MARGIN=1,5)
#如果在sweep内加上一个FUN='+',则运算由默认的-变成了+
sweep(my_array3,MARGIN=1,STATS=2,FUN = '+')

#plyr,dplyr,data.table，三足鼎立，绝对重点
##plyr
library(plyr)

#aaply
my_matrix7 <- matrix(1:24,nrow=3,ncol=8)
my_matrix7
aaply1 <- aaply(my_matrix7,.margins=2,.fun=mean)
class(aaply1)
#上面的函数有三个特殊点，第一，margin和fun前面有.，第二，是aaply不是apply，第三，.margins是选择列或者行，2就是列
#当然，.margin和.fun都可以不写
#aaply和apply基本一样，但是输出格式不一样
#adply
adply1 <- adply(my_matrix7,.margins=2,.fun=mean)
class(adply1)#注意到adply是变成data.frame!上面的aaply得到的是numeric（也就是特殊的array）
#laply
my_list9 <- list(1:10,rep(c(T,F),times=5))
my_list9
laply(my_list9,.fun = mean)
my_df <- data.frame(name=c('T','A','B','M','L'),
                    height=c(123,124,127,128,120),
                    gender=c('M','F','M','F','M'))

#ddply,重点
ddply(.data = my_df,.variables=.(gender),summarize,mean_h=mean(height))
#注意data前面，gender前面，都有点！！！忘了用tab提示一下。summarize只是放在这，必不可少，但是作用不大
tapply(my_df$height,my_df$gender,mean)
#这里表明，在求均值方面，tapply更简洁，但是！
ddply(.data = my_df,.variables=.(gender),summarize,mean_h=mean(height),sd_h=sd(height))
#注意，可以同时对均值和mean都进行了汇总分析！！这是tapply做不到的,ddply可以不停地往后面加各种函数进行不同运算
# ddply还可以 对多个分类变量同时进行操作!!!
my_df4 <- data.frame(name = c('Tony', 'Andy', 'Bob','Mary','Leo'),
                     height = c(178,176,175,167,190),
                     gender = c('M','F','F','M','M'),
                     age = c('old','young','young','old','young'))

ddply(.data = my_df4, .variables = .(gender, age), .fun = summarize, mean_h = mean(height),sd_h=sd(height))
#ddply的另外一种语法结构
#x传入的就是tips，不同性别，是否抽烟，给的tip占总金额的比例是否相同
ddply(tips, .(sex, smoker), function(x) sum(x$tip)/sum(x$total_bill))
ddply(tips, ~sex + smoker, function(x) sum(x$tip)/sum(x$total_bill))# 等价写法

#回归分析——dlply,在因子分出来的亚组里面进行分别观察线性关系，类似于lapply
my_model1 <- function(x)lm(Sepal.Length~Sepal.Width,data=x)
dlply(iris,~Species,my_model1)

#each函数,用一组算法去看一个变量（第一个括号内也可以有function(x)自定义函数
each(mean,sd,median)(iris$Sepal.Length)
colwise(mean)(iris)
numcolwise(mean)(iris)# 忽略掉因子，就没有warning了
#numcolwise函数是对数据框中的数值型变量进行均值操作，比colwise更智能
#注意到colwise和numcolwise中的col的意思是column
#ddply函数和colwise函数配合使用
ddply(iris,~Species,colwise(mean,~Sepal.Length+Sepal.Width))
#写法2,用.来写
ddply(iris,~Species,colwise(mean,.(Sepal.Length,Sepal.Width)))
#点评，上面提到的很多函数都能起到这个作用，因此ddply和colwise的连联用并非重点

# dplyr函数
library(dplyr)
library(reshape2)
head(tips)
# filter根据列变量，提取行
sub1 <- filter(tips, tips$smoker=='No',tips$day=='Sun');sub1
#slice函数,操作行，把我想要的行切出来！
sub2 <- slice(tips, 1:5)
# select函数，操作列，更加灵活地切分列
sub3 <- select(tips,tip,sex,smoker)# 甚至不需要加""就能把变量切出来
head(sub3)
#select进行列操作,把我想要的列切出来！如果我只想要中间几列，怎么办？
sub4.1 <- select(tips, 2:5)
sub4 <- select(tips,tip:time)
head(sub4)
#排序函数arrange
tips6 <- arrange(tips,total_bill,tip)
head(tips6)
#desc函数
new_tips <- arrange(tips, desc(total_bill), tip)# desc函数和order函数里面的decreasing=T异曲同工
View(new_tips)
#rename函数,是可以对很多列重新命名的，这样更加简洁
tips7 <- rename(tips,bill=total_bill)
head(tips7)

#distinct函数
levels(tips$sex)
distinct(tips,sex)#但是实际上在某一列重复元素很多的时候，根据distinct也可以在[]内进行变量提取
distinct(tips,day)

#mutate函数，新建
#mutate函数,注意到，即使rat在此时还没有生成，但是new_rat可以同步生成
mutate(tips, rat=tip/total_bill,new_rat=rat*100)

# sample_n和sample_frac函数
sample_n(iris,size=10)# 随机抽取十行
sample_frac(iris,0.05)#从iris内部随机抽取1/20的行/观察值

#group_by和summarize函数
#group_by函数,单独使用并没有意义，但是和summarize函数一起使用将会发生巨大作用
group <- group_by(tips,smoker)
summarise(group,count=n(),mean_tips=mean(tip),sd_bill=sd(total_bill))
#管道符，%>%,快捷键为ctrl+shift+m
# %>% 可以理解为一种将已知变量不断导入未知变量的一种嵌套函数操作！！
result <- tips %>% group_by(smoker,sex) %>% 
  summarise(count=n(),mean_tips=mean(tip),sd_bill=sd(total_bill))
result
# transform函数，比较弱，了解,注意new_rate这里报错了，因此不如summarize
transform(tips, rate = tip/total_bill, new_rate = rate * 100)
transform(tips, rate = tip/total_bill)

#data.table
library(data.table)
# data.table函数是建立在特殊数据结构data.table基础上的
#rnorm生成正态分布数据,rnorm(n, mean = 0, sd = 1)
# If mean or sd are not specified they assume the default values of 0 and 1, respectively
dt <- data.table(v1=c(1,2),v2=LETTERS[1:3],v3=round(rnorm(12,2,2)),v4=sample(1:20,12))
dt
class(dt)
#round函数是除去小数部分，如果是round(rnorm(12,2,2),2)
round(rnorm(12,2,2),2)


dt[v2=='B']
#%n%使用
dt[v2%in%c('A','B')]
dt[3:6,]
dt[,1:2]
dt[,v3]
#对列进行操作，注意，使用list函数，同时v1不需要加‘’
dt[,list(v1,v3)]
#利用dt[]直接在list内返回求和，均数等等
dt[,list(sum_4=sum(v4),mean_4=mean(v4))]
#注意到上面对两个变量进行了操作
#生成新变量,list或者{},注意第二种情况中间的；
dt[,list(print(v2),plot(1:12,v3,col='red'))]
dt[,{print(v2);plot(1:12,v3,col='red')}]

#by参数,根据因子来对其他变量进行操作
dt[,.(sum_v3=sum(v3),mean_v4=mean(v4)),by=v2]
#注意到上面用.代替了list，也是正确的语法
#根据两个变量来进行操作,注意到.的灵活运用
dt[,.(sum_v3=sum(v3),mean_v4=mean(v4)),by=.(v2,v1)]
#频数统计，注意到N前面的.,.N专门就用于频数统计
dt[,.N,by=list(v1,v2)]
#生成新变量,符号:=
#注意:=符号生成的新变量是直接写入dt的,但是前面的各种统计都不会把结果直接写进去
dt2 <- dt[,v5:=v4/v1]
#生成多个新变量，非常常用
#data.frame的体系里面，新出现的需要引号，本来就有的不需要
dt3 <- dt[,c('v6','v7'):=.(v3*v1,v4/v1)]

#setkey函数,使得我们 可以直接对dt的v2进行操作，而不需要引用和指定任何东西
setkey(dt,v2)
dt[c('A','B')]
#nomatch函数让NA消失，本来下面的函数会遇到D没有的情况,会呈现NA
dt[c('A','D')]
#nomatch=0让NA也消失，这样数据更clean
dt[c('A','D'),nomatch=0]
# 在不了解数据的具体结构的时候，nomatch就非常常用
#by=.EACHI分别对两个不同因子进行求和，注意打印出来的V1实际上代表V4
dt[c('A','B'),sum(v4),by=.EACHI]
#对比一下上面的函数
dt[,.(sum_v4=sum(v4)),by=v2]
# 连续的[]构成先后顺序，而不需要 %>% 
dt[,.(sum_v4=sum(v4)),by=v2][sum_v4>36]
#根本不需要管道符！！

#join系列函数,常用，重点
#透彻讲解：https://www.jianshu.com/p/1f4c7bfed3d4
df_a <- data.frame(x = c('a','b','c','a','c','b','c'), y = 1:7);df_a
df_b <- data.frame(x = c('a','b','a'), z  = 10:12);df_b
inner_join(df_a,df_b,by='x')
#inner_join函数只认识自己人，只有同时出现在df_a和b的元素a和b，才会被它保留
semi_join(df_a,df_b,by='x')
#注意，semi也是根据df_a，x是观测，只保留在df_b中出现的观测也就是a b，返回df_a
#换句话说，如果第一个数据框中有东西出现在第二个数据框，那么它把第一个中的返回！
left_join(df_a,df_b,by='x')#注意到把所有元素全部都返回，但是c因为在b中不存在，所以z那一列是NA
#right_join函数是根据df_b来观测
right_join(df_a,df_b,by='x')
#left_join是最实用的
anti_join(df_a,df_b,by='x')#丢弃df_a中与df_b表中的观测相匹配的所有观测。

#缺失值处理
#NA缺失值避免
#na.rm参数，remove缺失值
x <- c(1,2,3,NA,NA,90)
x
mean(x) #全部变成NA！NA是可以传染的
mean(x,na.rm=TRUE)
#判断是否有NA
is.na(x)
sum(is.na(x))
#利用否定的逻辑符号！去除NA！！非常常用
x[!is.na(x)]
#如何找到数据框内到底是哪些下标存在NA，以及，每个变量含有多少个NA？
iris_na <- iris
View(iris_na)
for (i in 1:4){
  iris_na[sample(1:nrow(iris_na),5),i]=NA
}
# which函数，查找函数，返回下标
sapply(iris_na[,1:4],function(x)which(is.na(x)))
sapply(iris_na[,1:4],function(x)sum(is.na(x)))

#install.packages("psych")
library(psych)
describe(iris_na)# 根据n这一列发现NA占据5个位子
#计算缺失值比例
sapply(iris_na[,1:4],function(x)sum(is.na(x))/nrow(iris_na))
#回归分析
head(iris_na)
lm(Sepal.Length~Sepa1.Width,data=iris_na)# 报错
#对iris进行变量重命名，也就是names函数
names(iris_na) <- c('Sepa1.Length','Sepa1.Width','Lema1.Length','Lema1.Width','Type')
head(iris_na)
#在回归函数lm中，参数na;action默认就是na.omit,也就是忽略
lm(Sepa1.Length~Sepa1.Width,data=iris_na)
lm(Sepa1.Length~Sepa1.Width,data=iris_na,na.action=na.omit)

#如何填补缺失值?循环后均值填补
mean_value <- sapply(iris_na[,1:4],mean,na.rm=TRUE)
mean_value
for (i in 1:4){
  iris_na[is.na(iris_na[,i]),i]=mean_value[i]
}
describe(iris_na)
#注意到这个时候n已经变成了150！！！

cancer <- data.frame(id=1:1000,sur_days=sample(100:1000,1000,replace=TRUE),type=sample(c('lung',
                                                                                         'liver','kidney'),1000,replace=TRUE),treatment=sample(c('chemo','surgr'),1000,replace
                                                                                                                                               =TRUE))

cancer[sample(1:1000,90),2] <- NA
mean_value <- tapply(cancer$sur_days,list(cancer$type,cancer$treatment),mean,na.rm=TRUE)
mean_value
describe(cancer)

#注意下面这个极其高明的for循环，因为提取对象是矩阵，所以先用i,j两层嵌套循环
#然后，我们提取缺失值有三个条件，第一，指定必须出现NA，所以使用is.na
#第二、三层实际上是在缩小第一层的范围，指定type，指定treatment,然后从tapply计算的mean_value里取填充，实际上
#这样一来就实现了针对type和treatment进行精准填补NA
str(cancer)
for(i in 1:4){
  for(j in 1:2){
    cancer$sur_days[is.na(cancer$sur_days) & 
                      cancer$type == rownames(mean_value)[i] &
                      cancer$treatment == colnames(mean_value)[j]] = mean_value[i,j]
  }
}

describe(cancer)
#填补缺失值必须结合数据实际情况
#缺失填补的高级函数
#mlbench函数
install.packages('mlbench')
library(mlbench)
data('BostonHousing')
View(BostonHousing)
original_data <- BostonHousing
set.seed(2022)
BostonHousing[sample(1:nrow(BostonHousing), 80),"rad"] <- NA
BostonHousing[sample(1:nrow(BostonHousing), 80), "ptratio"] <- NA

#mice函数
install.packages('mice')
library(mice)
#md.pattern函数,对NA的分布情况进行描述
md.pattern(BostonHousing)
#注意到有2个变量两者都缺失，分别有71个两者各缺失一个
#Hmisc函数,其中的imppute函数，可以代替for循环
library(Hmisc)
lm_mean <- impute(BostonHousing$ptratio,mean)
head(lm_mean)
anyNA(BostonHousing)#这个时候rad变量还是有缺失值的
#impute函数不仅仅可以插入mean，还可以插入20这种特定数，以及中位数等等
#mice函数，用一群没有缺失值的变量去预测有缺失值的变量
#把medv变量排除出去，目的只是为了演示一下怎么把不想回归的剔除，计算模型是rf随机森林
mice_mod <- mice(BostonHousing[,!names(BostonHousing)%in%'medv'],method='rf')
mice_output <- complete(mice_mod)#complete函数将上述计算结果整理到mice_output内
anyNA(mice_output)#这个时候BostonHousing内没有NA
#anyNA表示里面没有缺失值

#现在， 我们来看看rf方法到底准不准，注意到刚刚original_data内存放了原始BostonHousing
actuals <- original_data$rad[is.na(BostonHousing$rad)]
predicts1 <- mice_output$rad[is.na(BostonHousing$rad)]
mean(actuals!=predicts1)#正确率高达75%

#VIM函数,缺失值可视化
install.packages("VIM")
library(VIM)
data('airquality')
head(airquality)
md.pattern(airquality)
#基础绘图aggr函数实现可视化
aggr_plot <- aggr(airquality,col=c('red','green'),
                  numbers=TRUE,sortVars=TRUE,
                  labels=names(airquality),cex.axis=0.7,gap=3)

#marginplot可视化函数,很实用，重点
#蓝色空心点是非NA，红色实心是缺失，棕色的是双NA
#红色直方图是有NA情况下的均值分布，而蓝色是去掉NA后的均值分布
marginplot(airquality[1:2])
#VIM利用线性回归进行NA的插补,用sleep数据集举例
data('sleep')
#regressionImp函数利用不缺失变量对缺失变量进行插补，Imp实际是import简写
#当然还有别的插补算法，都在VIM包里面，自行探索
md.pattern(sleep)
sleepLM <- regressionImp(NonD+Dream+Sleep+Span+Gest~BodyWgt+BrainWgt,data=sleep)
head(sleepLM)
#会发现多了很多行，这些行是对前面的注释，可以理解为镜像，凡是TRUE的地方表示被插补了！

sleepLM <- regressionImp(NonD+Dream+Sleep+Span+Gest~BodyWgt+BrainWgt,data=sleep,
                         family='auto')
#family='auto'的作用，因为因变量里有数值也有分类，auto可以自动选择合适的回归方程，
#注意到,''里面可以填指定的计算模型，比如Poisson，Logistic,等等，这里不做展开

#异常值和重复的处理
#异常值不能武断判断
set.seed(2022)
mhg <- sample(60:250,1000,replace=TRUE)
range(mhg)
mean(mhg)
#观察四分位数的函数
quantile(mhg)
fivenum(mhg)

#在介绍离群值处理自定义函数之前，来学习一下几个陌生函数
#evalparse函数
s<- "print('hello world')"
eval(parse(text = s))#两者联用将字符串转化为可执行对象
2 ^ 2 ^ 3
eval(2 ^ 2 ^ 3)
mEx <- expression(2^2^3); mEx; 1 + eval(mEx)
eval({ xx <- pi; xx^2}) 

df <- data.frame(bp = c(sample(80:250, 20, replace = TRUE), NA, 390, 100))
eval(substitute(bp),eval(dt))
var_name <- eval(substitute(bp),dt)

#一个非常好用的离群值识别的自定义函数
outlierKD <- function(dt, var) {
  var_name <- eval(substitute(var),eval(dt))# eval和substitute函数调查过后还是不太懂，后面再学习
  tot <- sum(!is.na(var_name)) 
  na1 <- sum(is.na(var_name))
  m1 <- mean(var_name, na.rm = T)
  par(mfrow=c(2, 2), oma=c(0,0,3,0))# help 一下par函数就会发现oma是用来设定边界的，学习医学方R高级绘图
  boxplot(var_name, main="With outliers")
  hist(var_name, main="With outliers", xlab=NA, ylab=NA)
  outlier <- var_name[var_name > 230]#对离群值的定义，自己做的时候更改这里就行
  mo <- mean(outlier)
  var_name <- ifelse(var_name %in% outlier, NA, var_name)
  boxplot(var_name, main="Without outliers")
  hist(var_name, main="Without outliers", xlab=NA, ylab=NA)
  title("Outlier Check", outer=TRUE)
  na2 <- sum(is.na(var_name))
  cat("Outliers identified:", na2 - na1, "\n")
  cat("Propotion (%) of outliers:", round((na2 - na1) / tot*100, 1), "\n")
  cat("Mean of the outliers:", round(mo, 2), "\n")
  m2 <- mean(var_name, na.rm = T)
  cat("Mean without removing outliers:", round(m1, 2), "\n")
  cat("Mean if we remove outliers:", round(m2, 2), "\n")
  response <- readline(prompt="Do you want to remove outliers 
                       and to replace with NA? [yes/no]: ")
  if(response == "y" | response == "yes"){
    dt[as.character(substitute(var))] <- invisible(var_name)
    assign(as.character(as.list(match.call())$dt), dt, envir = .GlobalEnv)
    cat("Outliers successfully removed", "\n")
    return(invisible(dt))
  } else{
    cat("Nothing changed", "\n")
    return(invisible(var_name))
  }
}


set.seed(2022)
df <- data.frame(bp = c(sample(80:250, 1000, replace = TRUE), NA, 390, 100))
outlierKD(df, bp)
#注意操作前把画板调节大一些

#重复值处理，unique函数,duplicated函数
x <- c(1,2,3,3,4,4,5,5,5,6,6)
x
unique(x)
duplicated(x)
#提取duplicated里面的FALSE，其实也就是提取非重复值
x[!duplicated(x)]
anyDuplicated(x)#看看第一个重复值出现在哪里

#根据多个变量去除重复值，第一个读取excel表格，第二个是利用！和dupicated从name和birthday两个变量角度排除重复值
library(readxl)
mydata <- read_excel('example.xlsx')
#colnames(mydata)
mydata[!(duplicated(mydata$`gene id`) & duplicated(mydata$gene_type)),]
#如果需要组合起来成为筛选条件的变量太多，那么，可以利用paste函数将它们粘贴在一起
mydata$test <- paste(mydata$`gene id`, mydata$gene_type)
newdata <- mydata[!duplicated(mydata$test),]


#函数read.csv()写入csv格式数据，read.table写入txt格式数据

#字符串处理,重点!重点！重点！
#学不好正则表达式，不要说自己会写代码！！！
x <- c('fudan','jiaoda')
#nchar函数,length函数
nchar(x)
length(x)
#大小写转换
toupper('yinyang')
#tolower同理
# Changing to Upper case.
result <- toupper("Changing To Upper")
print(result)
# Changing to lower case.
result <- tolower("Changing To Lower")
print(result)
#paste函数
one <- LETTERS[1:5]
two <- 1:5
paste(one,two)
#sep参数,collapse,组合之间的分割参数
paste(one,two,sep='~')
paste(one,two,sep='~',collapse='!')
#paste0函数,中间没有任何分隔符！！
paste0(one,two)
paste0(one,two,sep="`")# 会发现插不进去，后面stringr会提供方法
paste0(one,two,collapse="_")# 注意到在paste0和paste函数中sep函数的不同结果
#拆分函数：strsplit
stringC <- paste(one,two,sep='/')
strsplit(stringC,split='/')
#注意到最后得到的是一个列表!列表！！列表！！！
#从字符串中得到我想要的字符,substr函数
stringd <- c('python','java','ruby','yixuefang')
sub_str <- substr(stringd,start=2,stop=4)
sub_str
#substr第二种用法,替换
#stringd中间的元素批量替换为我想要的字符串
substr(stringd,start=2,stop=4) <- 'aaa'
stringd
#结构复杂的字符串，如何提取含有FRA的序列
seq_names <- c('EU_FRA02_C1_S2008','AF_COM12_B0_2004','AF_COM17_F0_S2008',
               'AS_CHN11_C3_2004','EU-FRA-C3-S2007','NAUSA02E02005',
               'AS_CHN12_N0_05','NA_USA03_C2_S2007','NA USA04 A3 2004',
               'EU_UK01_A0_2009','eu_fra_a2_s98', 'SA/BRA08/B0/1996')
seq_names

#grep函数
fra_seq<- grep(pattern='FRA|fra',x=seq_names)
fra_seq
seq_names[fra_seq]
#上述函数和下面等价,value=FALSE不返回值，返回下标，而TRUE则返回值
fra_seq<- grep(pattern='FRA|fra',x=seq_names,value=TRUE)
fra_seq
?grep
#如何避免使用管道符|？，并返回逻辑值，函数grepl
grepl(pattern='FRA',x=seq_names,ignore.case = T)
# ignore.case=T意味着大小写不敏感
#提取不带有S的纯年份，正则表达式运用
grepl(pattern='[s|S][0-9]{2,4}\\b',x=seq_names,ignore.case = T)
#第一个中括号里面的|表示可以是s也可以是S
#第二个中括号表示之后从0-9之中取值
#第三个大括号表示取2-4次
#\\b表示字符串边界，在这里等价$
seq_name2 <- seq_names[!grepl(pattern='[s|S][0-9]{2,4}\\b',x=seq_names,ignore.case = T)]
seq_name2
#boundary函数，前面的\\b
#\\b边界标志
my_string <- c('above','about','abrotion','cab')

grep('ab\\b',my_string,value = T)#x取ab结尾的
grep('\\bab',my_string,value = T)#这个时候选择ab开头的

#gsub
#gsub函数,\\去除字符串内的一些符号
money <- c('$1888','$2888','$3888')
gsub('\\$',replacement='',money)#R里面的转义字符和其他语言不一样，是\\


#regexpr函数
test_string <- c('haaaaaappy','aqpppple','aplication','xpolitippc')
test_string1 <- regexpr('pp',test_string)
# 可以提取找到的pp分别在第i个字符串内出现的位置的下标
# [1]  8  3 -1  8 # 找到的Pp出现的位置，-1是不存在
# attr(,"match.length") 
# [1]  2  2 -1  2 # 找到的包含pp的长度
# attr(,"index.type")
# [1] "chars" # 变量类型
# attr(,"useBytes")
# [1] TRUE #是否找到了至少一个

#agrep函数，类似于中文中的通假字，它不关心英美式写法
string1 <- c('I need a favour', 'my favorite sport', 'you made an error')
agrep('favor',string1)

#正则表达式是处理字符串的关键武器
#原义表达式,返回它自己
mystring1 <- c('apple','orange')
grep('p',mystring1)
#转义表达式,比如.作为一个pattern，它作为所有字符的代表
mystring2 <- c('shuda','.dfs','-dsfd')
grep('.',mystring2)#注意到返回了所有
#[]，注意到中括号内的数字之间不是:而是-
mystring3 <- c('9anv','fss7','1000','ss7')
grep('[7-9]',mystring3)
#^符号，表示去找到以xxx开头的字符串
mystring4 <- c('apple','application','abb')  
grep('^ap', mystring4)
mystring3 <- c('9anv','fss7','5000','ss7')
#^和[]的组合，表示非
grep('[0-1]',mystring3)
grep('[^0-9]',mystring3)# 意思是至少包含一个非数字字符！！！
#{}表示重复几次
mystring6 <- c('1220','2289','2228','10002')
grep('2{2,3}',mystring6)#2重复2-3次
grep('2{3,}',mystring6)#3次及以上
#+表示o后面匹配1次及以上
mystring7 <- c('food','foot','foul','fans')  
grep('fo+',mystring7)
#如果不加()，那么大括号只对紧跟在它前面的起作用
#加上以后，就意味着参考前面括号内的整体进行处理
my_string7_1 <- c('fowd','food','foot','moul','fans')  
grep('fo{1,}',my_string7_1)
grep('(foo){1,}',my_string7_1)

#管道符，|,连接前后两个正则表达式
mystring8 <- c('kobe','messi','neymar')  
grep('^k|^m',mystring8)
#￥,用来表示匹配字符串的结束位置，这个时候等价于\\b
mystring9 <- c('active','positive','neagtive','ivention')  
grep('ive$', mystring9)
#\\保义字符，这个时候就告诉R，我们是在匹配^这个符号，而不是在找开头
mysting10 <- c('abb','^df')
grep('\\^', mysting10)

#\\d = [0-9]注意是取并集，就是说只要含有数字，就返回
#\\D = [^0-9]#反过来，^表示非，注意只要含有非数字，就返回，并不是只能有非数字，一定要区分清楚
#\\s 找到空格制表符等等，不包括非空字符
#\\S 非空字符，注意了，空格也是字符的一种,所以实际上只能匹配“”
#\\w [a-zA-Z0-9]
#\\W [^a-zA-Z0-9]#反过来
#\\b 匹配边界，是^和$的结合
#\\B 匹配非边界，基本没用
#\\< #空白字符开始
#\\> #匹配空白字符结尾的文本

mystring12 <- c('', '     able', '   moth  er','happy')
grep('\\s', mystring12)# 注意字符串1没有 返回
mystrinf13 <- c('theory', 'the republic', '  they')  
#下面的形式表示只能返回the单独单词形式的字符串，其他都不返回
grep('\\<the\\>',mystrinf13)


#stringi和stringr扩展包
library(stringi)
library(stringr)
#str_c函数
str_c('a','b')
str_c('a','b',sep = '-')
#str_length函数,相当于基础包的nchar

#类似于substr函数的函数str_sub
yxf <- 'yi xue fang'
str_sub(yxf, c(1,4,8), c(2,6,11))#后面分别是三个字符串的起始和终止向量
#替换
str_sub(yxf, 1,1) <-  'Y'
yxf
#str_dup函数
fruit <- c("apple", "pear", "banana")
str_dup(fruit, 2)
str_dup(fruit, 2:4)#对三个字符串进行向量化操作,重复次数不同！
#str_trim去除两侧空格
string <- ' Eternal love for YanQ '
str_trim(string, side = 'both')
#str_extract函数，利用正则表达式
phones <- c(" 219 733 8965", "329-293-8753 ", "banana", "595 794 7569",
            "387 287 6718", "apple", "233.398.9187  ", "482 952 3315",
            "239 923 8115 and 842 566 4692", "Work: 579-499-7527", "$1000",
            "Home: 543.355.3679")
str_extract(phones, "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})")
#{2}是上面的重复两次，[- .]用来匹配中间连接符

#str_replace函数只替换遇到的第一个， 而其他_all则替换遇到的所有
fruits <- c("one apple", "two pears", "three bananas")
str_replace_all(fruits, "[aeiou]", "-")

#stringi系列都是stri开头，和上面不同
#stri_join函数
stri_join(1:7, letters[1:7], sep='-')
stri_join(1:7, letters[1:7], collapse='-')
#第一个str_cmp_eq表示匹配两个字符串必须完全一样才返回TRUE
stri_cmp_eq() & stri_cmp_neq()
stri_cmp_neq('AB','aB')

#lt表示小于，gt表示大于stri_cmp_lt() & stri_cmp_gt(),注意到针对字母就表示针对字母表排序
#注意，函数默认首先根据a和b大小来了
stri_cmp_gt('a221','b121')

#计数函数str_count
language <- c('Python','R', 'PHP', 'Ruby', 'Java', 
              'JavaScript', 'C', 'Oracle', 'C++', 'C#', 'Spark', 'Go',
              'Room', 'Good', 'Pathon', 'ScriptJava', 'R2R', 'C+','C*')
stri_count(language, fixed = 'R')
stri_count(language, regex = '^J')

#stri_count_boundaties函数，表示以某种类型为边界的函数
test <- 'The\u00a0above-mentioned    features are very useful. 
Warm thanks to their developers. Tomorrow is a, new$% day###'
stri_count_boundaries(test, type="word")#一共45个单词，
stri_count_boundaries(test, type="sentence")#多少个句子
stri_count_boundaries(test, type="character")#多少个字母


#stri_dup制造重复字符串
stri_dup(c("abc", "pqrst"), c(4, 2))
#寻找重复字符串位置
stri_duplicated(c("a", "b", "a", NA, "a", NA))
stri_duplicated(c("a", "b", "a", NA, "a", NA), fromLast=TRUE)
stri_duplicated_any(c("a", "b", "a", NA, "a", NA))# 是否有重复，有的话，最多多少次

stri_detect_fixed(c("stringi R", "REXAMINE", "123"), c('i', 'R', '0'))#在前面的里面依次去找后面的

stri_detect_regex(c("above", "abort", "about", "abnormal", 'abandon'), '^ab')#detect用来发现
stri_detect_regex(c("above", "abort", "about", "abnormal", 'abandon'), 't\\b')
stri_detect_regex(c('ABOUT','abort','AboVE'), '^ab', case_insensitive = TRUE)#是否忽略大小写，TRUE是忽视

stri_startswith_fixed(c("a1", "a2", "b3", "a4", "c5"), "a")#匹配是否以某个开始的
stri_startswith_fixed(c("abaDc", "aabadc",'ababa'), "ba", from=2)#from参数表示从什么位置开始匹配

stri_endswith_fixed(c("abaDc", "aabadc",'ababa'),'ba')#以什么结尾
stri_endswith_fixed(c("abaDc", "aabadc",'ababa','qcytr','qcbgf'),'ba', to = 3)#to表示只匹配到第几位

tEmp_text <- c('EU_FRA02_C1_S2008','AF_COM12_B0_2004','AF_COM17_F0_S2008',
               'AS_CHN11_C3_2004','EU-FRA-C3-S2007','NAUSA02E02005',
               'AS_CHN12_N0_05','NA_USA03_C2_S2007','NA USA04_A3 2004',
               'EU_UK01_A0_2009','eu_fra_a2_s98', 'SA_BRA08_B0_1996')
#Generate a strings composed by several sequence names.
stri_extract_all(tEmp_text, regex = '[0-9]{2,4}\\b')#注意只返回匹配到的部分，而且是一个List

stri_extract_all_fixed("abaBAba", "Aba", case_insensitive=TRUE, overlap=TRUE)#overlap表示可以重复寻找Aba
stri_extract_all_boundaries("stringi: THE string processing package 123.48...")#同时返回空格
stri_extract_all_words("stringi: THE string processing package 123.48...")#不返回空格

stri_isempty(c(',', '', 'abc', '123', '\u0105\u0104',' '))#空格不属于空字符
#stri_locate_all找到fixed里面规定的内容，返回具体定位位置
m1 <- stri_locate_all('I want to learn R to promote my statistical skills and my Ruby', fixed=c('to','my'))
class(m1)
#注意到m1是list
View(m1[[2]])
m1[[1]][,2][2]
#得到遇到的第二个to的结束位置！
#思考如何得到第二个my的开始位置


