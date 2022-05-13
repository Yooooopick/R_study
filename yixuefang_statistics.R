#R统计入门
#描述性统计

#table函数，生成四格表
library(reshape2)
View(head(tips))
str(tips)
summary(tips)
table(tips$sex, tips$smoker)#第一个是行，第二个是列
table(tips$sex, tips$day)#列联表
#addmargins函数，计算行列和
View(esoph)
#addmargins() 
tt <- table(esoph$agegp,esoph$ncases)
addmargins(tt,margin = c(1,2))#margin里面有1和2，表示既对行操作，也对列操作，2表示列
#xtabs函数表示在数据里面取子集进行分析
hightip <- tips[,"tip"] > mean(tips[,"tip"])
as.data.frame(xtabs(~tips$sex+hightip,subset = tips$smoker==
                      "Yes"))
as.data.frame(xtabs(~tips$sex+hightip,
                    subset = tips$day %in% c("Sun","Sat")))
#注意,对ncontrols的频率进行统计，而不是计算数值加和
xtabs(ncontrols~agegp+alcgp,data=esoph)
#汇总
addmargins(xtabs(ncontrols~agegp+alcgp,data=esoph),margin=c(1,2))
#如果需要同时汇总ncontrol和ncases
xtabs(ncases+ncontrols~agegp+alcgp,data=esoph)#这个是把ncases和ncontrols合并当做一个变量计算频数
xtabs(c(ncases,ncontrols)~agegp+alcgp,data=esoph)#错误
xtabs(cbind(ncases,ncontrols)~agegp+alcgp,data=esoph)#这个是分类统计

#ftable函数,里面必须先生成xtabs，然后再运行ftable,汇总后得到一个长数据，常用
x1 <- ftable(xtabs(cbind(ncases,ncontrols)~agegp+alcgp,data = esoph))

library(psych)
#describe函数，标准差，方差，均值，离散程度
describe(iris)#里面有四分位数，缺失值，最小和最大

#t检验，方差齐，正态分布两个都必须满足
#方差不齐使用t'检验
mydata1 <- sample(1:100,50)   

#正态分布检验
shapiro.test(mydata1)#p>0.05服从正态分布
#nortest包,有多种不同的函数算法取进行正态检验,真正做的时候酌情选
install.packages("nortest")
library(nortest)
lillie.test(mydata1) 
ad.test(mydata1) 
cvm.test(mydata1) 
pearson.test(mydata1) 
sf.test(mydata1) 

# 方差齐性检验 var.test
#rnorm生成正态分布数据
data3 <- rnorm(100,3,5)
data4 <- rnorm(200,3.4,8)
#检查方差是否齐,p小于0.05方差不齐
var.test(data3,data4)
#如果方差不齐，这里equal为F
t.test(data3,data4,equal=F)

#和总体比较，总体均数为3.2
t.test(data3, mu = 3.2)
#配对数据的t检验
data6 <- rnorm(200,3,5)
data7 <- rnorm(200,3.4,8)
t.test(data6,data7,paired=T)


#数据转换
#runif平均分布函数
mydata <- runif(100,min = 1,max = 2)
shapiro.test(mydata)
# 1/X,sqrt,log()
shapiro.test(1/mydata)#如果1/，sqrt，log()都起不到作用

#boxCox转换
#MASS包
library(MASS)
head(trees)
#我们对trees的volume进行操作
shapiro.test(trees$Volume)
#注意到lambda取值范围需要根据数据的具体情况进行调整，一开始可以设置range大一点

bc <- boxcox(Volume ~ log(Height) + log(Girth), data = trees,
             lambda = seq(-0.25, 0.25, length = 10))#lambda是迭代系数，找到最佳转换的幂指数点
#找到ymax对应的x
lambda <- bc$x[which.max(bc$y)]
#最后一步，公式转换
Volume_bc <- (trees$Volume^lambda-1)/lambda
shapiro.test(Volume_bc)
#qq散点图，注意对比Volume_bc和trees$Volume的散点图和直线的区别，越靠近直线，说明正态性越好
qqnorm(trees$Volume)
qqline(trees$Volume)
qqnorm(Volume_bc)
qqline(Volume_bc)
#如果上述boxcox函数还是不能找到合适的lambda，那么可以采用forecast包
library(forecast)
#BoxCox.lambda函数
lambda1 <- BoxCox.lambda(trees$Volume)
lambda1
#lambda在-1附近 1/x
#如果在-0.5 1/sqrt(x)
#0  ln
#0.5 sqrt()
#1 不变化

new_volum <- 1/sqrt(trees$Volume)
shapiro.test(new_volum)#服从正态分布了！
#第三种方法，car函数包里面的powerTransform得到指数
library(car)
powerTransform(trees$Volume)

new_volum2 <- trees$Volume^-0.07476608 
shapiro.test(new_volum2)
#在真实数据中三种函数都需要尝试！

#方差分析——多组均数的比较
#正态分布，方差齐性，独立性
#multcomp包进行多组数据的方差齐性的检验
library(multcomp)
#cholesterol数据集
data("cholesterol")
head(cholesterol)
str(cholesterol)
#方差齐性检验bartlett.test
bartlett.test(response~trt,data = cholesterol)#p大于0.05方差齐
#方差齐性检验第二函数fligner.test，最好两个都做一下
fligner.test(response~trt,data = cholesterol)
#另外两个
ncvTest(lm(response~trt,data=cholesterol))#注意变量中间用的是~而不是别的
leveneTest(response~trt,data = cholesterol)
#正态分布检验
shapiro.test(cholesterol$response)

#单因素方差分析
#aov函数
fit <- aov()

attach(cholesterol)#attach让data.frame中的变量成为全局变量
table(trt)
aggregate(response,by=list(trt),FUN=mean)#注意到response是应变量,by=list()是固定格式
aggregate(response,by=list(trt),FUN=sd)
fit <- aov(response~trt)
summary(fit)
#可视化gplots
library(gplots)
#plotmeans函数,r如果在前面没有使用attach函数，那么这里需要data=
plotmeans(response~trt,data = cholesterol)

#第二种方差分析,var.equal表示方差是齐的
oneway.test(response~trt,data = cholesterol,var.equal = T)

#单因素方差分析 多组之间的两两比较
#第一，TukeyHSD
TukeyHSD(fit)
plot(TukeyHSD(fit))#可视化，跨越0表明差异不显著

#多因素方差分析
data('ToothGrowth')
head(ToothGrowth)
str(ToothGrowth)
#注意到dose是数值变量，这个地方将其转变为因子型变量，并观察其水平levels函数
#进一步整理数据
table(ToothGrowth$dose,ToothGrowth$supp)

# 那么多个因素之间会不会存在交互作用？这是多因素分析必须考虑的
#怎么表示交互
#~	分隔符号，左边为响应变量，右边为解释变量
#eg：y~A+B+C
#+	分隔解释变量
#：	表示变量的交互项,协变量分析中
#eg：y~A+B+A:B
#*	表示所有可能交互项
# eg：y~A*B*C可展开为：y~A+B+C+A:B+A:C+B:C+A:B:C
# #^	表示交互项达到次数
# eg：y~(A+B+C)^2展开为：y~A+B+C+A:B+A:C+B:C
# .	表示包含除因变量外的所有变量
# eg：若一个数据框包括变量y,A、B和C，代码y~.可展开为y~A+B+C

fangcha <- aov(len~supp * dose,data = ToothGrowth)
summary(fangcha)#也就是说相互作用不可忽视


#协方差分析
data("litter")#gesttime怀孕时间，我们怀疑该变量也可能影响weight，因此将其作为协变量
head(litter)
facn <- aov(weight~gesttime + dose + gesttime : dose, data = litter)
summary(facn)
#注意到协变量的p显著，不能忽略
#怎么消除协变量影响？effects包
library(effects)
effect('dose',facn)#可以得到在没有协变量影响的情况下的dose对weight作用


#卡方检验
#拟合优度检验
men <- c(11,120,60,45)
women <- c(20,102,39,30)
df <- as.data.frame(rbind(men,women))
colnames(df) <- c('AB','O','A','B')

#chisq.test函数
chisq.test(men)#看men的内部分布
#含是否和总体分布相同
chisq.test(men,p= c(0.1,0.5,0.2,0.2))

#卡方齐性检验 卡方独立性检验
chisq.test(df)#卡方齐性检验表示比较不同分组中不同类型的数据是否一致
#卡方独立性检验表示行变量和列变量之间有没有关系，但是计算方法完全一样

#CMH检验，分层卡方检验
#问题，如何通过CMH检验知道不同Penicillin.Level处理的水平是否是混杂因素？
Rabbits <-
  array(c(0, 0, 6, 5,
          3, 0, 3, 6,
          6, 2, 0, 4,
          5, 6, 1, 0,
          2, 5, 0, 0),
        dim = c(2, 2, 5),#2行2列5层，一共20个元素
        dimnames = list(
          Delay = c("None", "1.5h"),#行
          Response = c("Cured", "Died"),#列
          Penicillin.Level = c("1/8", "1/4", "1/2", "1", "4")))#不同的层
Rabbits
#现在需要知道不同药物水平和是否延迟注射对结局是否有影响,mantelhean.test函数
mantelhaen.test(Rabbits)
# 如果p<0.05，说明Penicillin.Level的确是一个混杂因素，影响了Delay和Response之间的关系

#  有序分类的分层检验
satis_1 <- array(c(1, 2, 0, 0, 3, 3, 1, 2,
        11, 17, 8, 4, 2, 3, 5, 2,
        1, 0, 0, 0, 1, 3, 0, 1,
        2, 5, 7, 9, 1, 1, 3, 6),
      dim = c(4, 4, 2),
      dimnames =
        list(Income =
               c("<5000", "5000-15000",
                 "15000-25000", ">25000"),
             "Job Satisfaction" =
               c("V_D", "L_S", "M_S", "V_S"),
             Gender = c("Female", "Male")))
mantelhaen.test(satis_1)



#配对卡方检验,比如病例对照研究，某种检验方法和金标准的比较，mcnemar.test，注意到
paired_1 <- as.table(matrix(c(157,62,39,18),nrow=2,ncol=2,dimnames=list(case=c('A','B'),control=c('A','B'))))
paired_1
mcnemar.test(paired_1)

#回归分析
x <- seq(1,5,len = 100);x
nosie <- rnorm(n = 100, mean = 0, sd = 1)
beta0 = 1
beta1 <- 2
y <- beta0 + beta1*x + nosie
plot(y~x)
#lm函数，linearmodel，公式法~左边是因变量
model <- lm(y~x)
summary(model)

#coeffecients里面(x,Pr)的小于0.05，有统计学意义的相关
#R-squared是决定系数, adjusted.R-squared绝对值越接近1，y用x的可解释度越大
#最后的F-statistic对应的p是整体模型的p值，小于0.05说明模型优
#但是如果出现很多自变量x1 x2 x3……，p显著不一，但是F对应的不显著
#必须考虑多个x之间共线性的问题，或者需要逐步回归法来计算p值

#x是因子变量
x <- factor(rep(c(0,1,2),each = 20))
x
y <- c(rnorm(20,0,1),rnorm(20,1,1),rnorm(20,2,1))
y
model2 <- lm(y~x)
summary(model2)#x只剩下两层，另外一个即为哑变量，默认第一个0
# 如何设置哑变量见yixuefang_datascience.R
#注意，在上面的summary model之中，x对应的estimate就是指x增大一个单位，y改变多少
#而在这里，y改变的值需要对estimate进行exp转化,比如
exp(1.7743)
# 所谓 estimate就是斜率


#模型诊断，重中之重
#1.非正态性,正态性检验，shapiro.test(),要么x和y都是正态分布，要么它们的残差呈现正态分布
#所谓模型诊断大多数情况下都是针对残差进行的
data(LMdata,package = 'rinds')
View(LMdata)
model <- lm(y~x,data = LMdata$NonL)
#计算残差
res1 <- residuals(model)
shapiro.test(res1)#不服从正态分布!

#2.非线性
model2 <- lm(y~x, data = LMdata$NonL)
res2 <- residuals(model2)
plot(res2)
#注意，残差在某个确定值附近摆动，x和y才可能线性！,这里显然是非线性
model2 <- lm(y~x + I(x^2),data = LMdata$NonL)
summary(model2)#注意到x和y没有线性关系，但是x^2（x的平方）是有的
#剔除x
model3 <- update(model2,y~.-x)#有一个.别忘
summary(model3)
#再来看看新的residual的情况
plot(model3$residuals~LMdata$NonL$x)
#这个图才是正常的线性

#3.异方差，方差不齐,往往是因为噪声，
model4 <- lm(y~x,data = LMdata$Hetero)
plot(model4$residuals~LMdata$Hetero$x)#喇叭状提示异方差，也就是x越大噪声越大

#解决方法，加权最小二乘,weights就是给予不同的样本不同的权重
model5 <- lm(y~x,weights = 1/x^2,data = LMdata$Hetero)# x越小，权重越大
#虽然上面的处理完之后model5的R值优于model4，但是实际情况中很难知道wieghts的函数形式
summary(model5)
summary(model4)
#解决，迭代重复加权最小二乘法,nlme包,gls函数中的varFixed参数
library(nlme)
glsmodel <- gls(y~x,weights = varFixed(~x),data = LMdata$Hetero)
summary(glsmodel)#得到了x的系数是value的1.83,但是没有得到R-square


#4.自相关，就是说不同观测的x之间出现了相关,但是我们希望不同观测是相互独立的
model6 <- lm(y~x,data = LMdata$AC)
#判断方式，lmtest包的DW检验
library(lmtest)
dwtest(model6)#说明残差出现自相关现象
#gls函数针对这种情况进行广义最小二乘法，参数corAR1,中间不需要添加元素
glsmodel2 <- gls(y~x,correlation = corAR1(),data = LMdata$AC)
summary(glsmodel2)

#5.异常值,离群，杠杆和高影响点
model7 <- lm(y~x,data = LMdata$Outlier)
plot(y~x,data=LMdata$Outlier)
#abline函数画回归线
abline(model7)
library(car)
#infuencePlot函数
infl <- influencePlot(model7)#圆圈大小代表点对回归模型的影响大小，可见32号点必须剔除
#剔除函数,subset参数去除32
model8 <- update(model7,y~x,subset = -32,data = LMdata$Outlier)
plot(y~x,data=LMdata$Outlier)
abline(model7,col='red')#注意col不能写作color！！！
abline(model8,col='blue')#注意到32号点就是高影响点，但离群点左上角只有一个不影响结果，如果有一群则必须小心

#6.多重共线性，自变量之间的共线性
#vif函数
model9 <- lm(y~x1+x2+x3,data = LMdata$Mult)
summary(model9)
#注意到在x和y之间的Pr并不显著，但是R平方却接近1，考虑多重共线性
vif(model9)#计算方差膨胀因子，如果大于10，则存在共线性
#这个时候应该怎么处理？
#分步回归，stepwise回归,step函数
model10 <- step(model9)#注意到step对应的AIC小于上面的start，而且去除x1或者x3以后的AIC分别为80和507,所以最终模型为y=x1+x3
summary(model10)#注意到x2去掉明显好转


#logistic回归,glm函数
install.packages("HSAUR2")
library(HSAUR2)
data("plasma")
#glmh函数，family参数注意选择binomial
fit1 <- glm(ESR~fibrinogen + globulin,data = plasma, family = binomial())
summary(fit1)#并没有出现OR值
#exp和coef函数，提取OR值,coef提取estimate在前面的统计结果提取中也适用
exp(coef(fit1)['fibrinogen'])



#### 生存分析
install.packages("coin")
library(coin)
data(glioma)
library(survival)
# 提取数据框的子数据框
g3 <- subset(glioma, histology =='Grade3')
fit <- survfit(Surv(time, event)~group,data = g3)
class(fit)
plot(fit, lty = c(2,1), col = c(2,1))
legend('bottomright', legend = c('Control','Treatment'), lty = c(2,1), col = c(2,1))
survdiff(Surv(time, event)~group,data = g3)
# 考察多个自变量的p值,联合不区分，区分开看用cox
logrank_test(Surv(time, event)~group|histology,data = glioma, distribution = approximate(B = 1000))

# 用cox回归看每个自变量的情况
data('GBSG2',package = 'TH.data')
head(GBSG2)
plot(survfit(Surv(time, cens)~horTh,data = GBSG2),lty = c(2,1), col = c(2,1), mark.time = T)
legend('bottomright', legend = c('yes','no'), lty = c(2,1), col = c(2,1))

coxreg <- coxph(Surv(time,cens)~.,data = GBSG2);coxreg
# 进一步看谁是主要矛盾！
install.packages("party")
library(party)
tree <- ctree(Surv(time,cens)~.,data = GBSG2)
plot(tree)# 疑问尚未解决，为什么只选择了三个，上面有p值的不只三个













































