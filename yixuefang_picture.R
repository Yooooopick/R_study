# par
# bty:o,l,7,c,u,] 边框样式
# cex 放大或缩小倍数 cex.lab cex.main cex.sub.cex.axis
# col col.main col.sub col.axis col.lab
# family serif symbol mono sans
# font 1 2 3 4 正常 粗体 斜体 粗斜体
# las 坐标轴刻度和坐标轴的关系 0 1 2 3
# lty 0 1 2 3 4 5 6 无线 实线  虚线 点线 点划线 长划线 点长划线
# mgp mgp=c(x,y,z) 分别表示坐标轴标题、刻度、刻度线到画布边缘的距离
# pch 点形状 0-25
# srt 字符串旋转角度 -360-360
# usr 限定画布大小 usr=(x1,x2,y1,y2)
# xaxt,yaxt 需要自定义 坐标轴就让这两个 =n，刻度线和刻度会消失但是保留一条线
# fig 结合new=TRUE使用，在原先画布上新增图形
# https://blog.csdn.net/u012429555/article/details/78749503
# xpd 设置绘图区域大小 FALSE TRUE NA 分别为plotting figure device area

bty = c('o','l','7','c',']','u') 
par(mfrow=c(3,2))#切分画布，详见后文 
for (i in 1:6){#创建一个循环，使 R 一次作出 6 张图 
  par(bty=bty[i])#bty 设置，分别为'o','l','7','c',']','u' 
  plot(1:5, main = paste('the bty is', bty[i], sep = ':')) 
} 

par(mfrow=c(1,1),margin(1,1,1,1),lab=c(10,5))
plot(1:5,cex=1:5,col=1:5,bty="o")

# family="serif" 代表的就是Time New Roman
par(mfrow=c(1,1),family="serif",margin(1,1,1,1))
plot(1:5,cex=1:5,col=1:5,bty="o",main="I LOVE R")


par(mfrow=c(2,2)) 
for(i in 0:3){ 
  par(las=i) 
  plot(1:5,main = paste('the las is', i, sep = ':')) 
} 

par(mfrow=c(2,3)) 
for(i in 1:6){ 
  par(lty=i,lwd=i) 
  plot(1:5,type = 'l',main = paste('the lty is',i,sep = ':'),sub = paste('the lwd is',i,sep = ':'))} 


plot(rep(1:5,times =5),rep(1:5,each=5),pch= 1:25,cex=1.5,
     bty='l',xlim=c(1,5.4))
text(rep(1:5,times =5)+0.15,rep(1:5,each= 5),labels =1:25,col ='red')
dev.off()
dev.new()

par(xaxt="n",yaxt="n",xpd=NA)
plot(1:5)

n <- 1000 
x <- rnorm(n) #生成服从正态分布的 1000 个随机数 
qqnorm(x) #对这 1000 个随机数进行正态性检验 
qqline(x, col="red")#添加正态拟合线 
op <- par(fig=c(.02,.5,.5,.98), new=TRUE) 
#设置 par 函数参数，fig 参数定义了新图形的四个角的位置 
hist(x, probability=T, 
     col="light blue", xlab="", ylab="", main="", axes=F) 
par(op)# 释放参数，防止影响到后面作图

#开始画新图形 
lines(density(x), col="red", lwd=2)#绘制密度曲线 
box()#给新图形加上边框 
par(op)#释放参数 

#----------------------高级绘图函数------------------------------- 
### plot函数
### 大多数参数继承自par，但是par里面有一些参数是独有的
# type=c('p','b','1','s','o','n')
# 让axes=FALSE 可以在后面使用axis()设置坐标轴
type = c('p','b','l','s','o','n') 
par(mfrow=c(2,3)) 
for(i in 1:6){ 
  plot(1:10, type = type[i], main = paste('The plot type is: ', type[i]),xlab = 'x',ylab = 'y') 
}

#boxplot
y~x 
par(mfrow=c(1,3)) 
set.seed(100) 
data = rnorm(40) 
boxplot(data,range= 0.5,xlab= 'range is 0.5') 
boxplot(data,range= 1,xlab = 'range is 1') 
boxplot(data,range= 1.5,xlab= 'range is 1.5') 
data("ToothGrowth")
dev.off()
boxplot(len ~ dose, data = ToothGrowth, 
        boxwex = 0.25, at = 1:3 - 0.2, 
        #boxwex是盒子宽度，at 参数定义了盒形图中盒子的位置，传入一个向量
        #最终三个盒子横坐标就是0.8 1.8 2.8
        #标分别是 0.8，1.8，2.8 
        subset = supp == "VC", col = "yellow", 
        names = c('dose=0.5','dose=1.0','dose=2.0'), 
        main = "Guinea Pigs' Tooth Growth", 
        xlab = "Vitamin C dose mg", 
        ylab = "tooth length", 
        xlim = c(0.5,3.5), ylim = c(0,35), yaxs = "i") # yaxs 是 y轴线型
boxplot(len ~ dose, data = ToothGrowth, add = TRUE, 
        #add 在当前的图形上，添加一个新的盒形图 
        boxwex = 0.25, at = 1:3 + 0.2, 
        names = c('dose=0.5','dose=1.0','dose=2.0'), 
        subset = supp == "OJ", col = "orange") 

# 看到下面boxplot就知道为什么这里要加factor了
names=factor(c(rep("Maestro", 20) , rep("Presto", 20) , 
               rep("Nerak", 20), rep("Eskimo", 20), rep("Nairobi", 20), rep("Artiko", 20)))
value=c( sample(3:10, 20 , replace=T) , sample(2:5, 20 , replace=T) , 
         sample(6:10, 20 , replace=T), sample(6:10, 20 , replace=T) , 
         sample(1:7, 20 , replace=T), sample(3:10, 20 , replace=T) ) 
data=data.frame(names,value) 
dev.off()
dev.new()
?graphics::boxplot

# 突出显示自己想要突出的组别
boxplot(data$value ~ data$names , 
        col=ifelse(levels(data$names)=="Nairobi" , "#DF6020" , 
                   ifelse(levels(data$names)=="Eskimo","#2080DF","grey90" )) , 
        ylab="disease" , xlab="- variety -") 
legend("topright", legend = c("Positive control","Negative control") ,
       col = c("#DF6020","#2080DF"), 
       bty = "n", pch=20 , pt.cex = 3, cex = 1, 
       horiz = FALSE, inset = c(0.03, 0.1))
# legend
# 位置就是top和bottom以及left和right的组合
# bty=“n"就是图例无边框
# pch是点的类型，上面讲过
# pt.cex是标签的图标的大小,cex是标注大小
# horiz = T表示图例文字水平排布
# x.interssp和y.intersp是用来规定图例文字段之间的距离的


#根据value的mean重新定义data的顺序
#reorder函数的第三个参数mean，也可以是任意的function(x)对前面的value进行界定
order_names <- with(data,reorder(names, value, median, na.rm = TRUE)) 
boxplot(data$value ~ order_names , col = '#334CCC', ylab="disease" , xlab="- variety -") 

#barplot
data <- sample(c(50:80),5) 
barplot(data,col = heat.colors(5)) 

my_matrix <- 
  matrix(data = sample(10:40,9),nrow = 3,dimnames = 
           list(c('A','B','C'),paste('dose',1:3))) 
barplot(t(my_matrix),beside = T,col = rainbow(3)) # beside=T是平行放置，F是堆栈
# 两个颜色函数rainbow heat.colors
# barplot只能接受matrix，而不能接受dataframe，变量名作为矩阵的列名传入barplot
# 所以上面需要t

par(mfrow=c(2,2)) 
average_gdp <- c(6500,8000,13000,9200) 
country <- c('China','Korea','Japan','Singapore') 
barplot(average_gdp,names.arg = country) 
barplot(average_gdp,names.arg = country,horiz = TRUE) 
barplot(average_gdp,names.arg = country,horiz = FALSE,width = c(0.5,0.8,1.2,1.5))
barplot(average_gdp,names.arg = country,horiz = FALSE,space = 1.2) 


data(iris) 
data_mean <- apply(iris[,1:3],2,mean)
data_sd <- apply(iris[,1:3],2,sd) 
#将 barplot()存入一个对象中，这个对象保存的是条柱的中心位置的横坐标 
barcenters <- barplot(data_mean,names.arg = names(data_mean),ylim = c(0,8),main = 'ugly') 
# 添加errorbar
arrows(barcenters,data_mean-data_sd,barcenters,data_mean+data_sd,code = 3,angle = 90) 
# 前面两个是起始点的x y坐标，后面两个是终止点的，code=3表示做两个箭头，反过来再做一次
# angle=90的意思是：箭头张开的角度和柄成90度，调整为10试试看

# 附带学习segments函数
barcenters <- barplot(data_mean,names.arg = names(data_mean),ylim = c(0,8),main = 'ugly') 
segments(barcenters,data_mean-data_sd,barcenters,data_mean+data_sd,lty = 1.2) 

# dev.off()
# dev.new()
## 如何给barplot添加error bar
A=c(rep("drug A" , 10) , rep("drug B" , 10) ) 
B=rnorm(20,10,4) 
C=rnorm(20,8,3) 
D=rnorm(20,5,4) 
data=data.frame(A,B,C,D) 
colnames(data)=c("treatment","dose_1","dose_2","dose_3") 
bilan=aggregate(cbind(dose_1, dose_2, dose_3)~treatment , data=data , mean) 
rownames(bilan)=bilan[,1]
bilan=as.matrix(bilan[,-1]) 
lim=1.2*max(bilan) 
ze_barplot = barplot(bilan , beside=T , legend.text=T , col=c("blue" , "skyblue") , 
                     ylim=c(0,lim)) 
# 写一个eoor.bar的参数,...再次遇到缺省参数，表示可以在函数内导入其他参数，只要arrows能识别
error.bar <- function(x, y, upper, lower=upper, length=0.1,...){ 
  arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...) 
} 
stdev=aggregate(cbind(dose_1,dose_2,dose_3)~treatment , data=data , sd) 
rownames(stdev)=stdev[,1] 
stdev=as.matrix(stdev[,-1]) * 1.96 / 10 
ze_barplot = barplot(bilan , beside=T , legend.text=T,col=c("blue" , "skyblue") , ylim=c(0,lim) , 
                     ylab="height") 
error.bar(ze_barplot,bilan, stdev) 
