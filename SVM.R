DONNEE=read.table("C:/Users/farid/Desktop/Cours M2 semestre 1/SVM/creditcard.csv",sep=";" ,header=T) 
saveRDS(DONNEE,"DONNEE.rds")

#input

N=10000
V=ceiling(0.3*N)  

#les input de la performance 



OBS=1:nrow(DONNEE)   
Time=scale(as.numeric(DONNEE$Time),center=T,scale=T) 
DONNEE$Time=Time 
data_base=data.frame(OBS,DONNEE)


#mes donnees avec tirage alealtoire de N observation pour lechantillon test
train=sample(1:nrow(data_base),N)  

#pour lechantillon de validation
valid=sample(1:nrow(data_base),V) 

# les 2 echantillons
test=data_base[valid,-1]
data=data_base[train,-1] 
y=test$Class 


attach(data)   
attach(test) 

install.packages("kernlab")
install.packages("ggplot")
install.packages("lattice")
install.packages("caret")
install.packages("plotROC")
install.packages("tidyverse")
install.packages("shinythemes")


library(kernlab)  
library(lattice)
library(ggplot2)
library(caret) 
library(plotROC) 
library(tidyverse) 
library(shinythemes)
library(plotly)

  2+2


#=========================================================GRAPH=========================================================== 


par(mfrow=c(3,3)) 
#input
d=6
for( i in 1:9){ 
  
   hist(data[,i+d-1],prob=T,main=paste("Histogramme de", c(names(data)[i+d-1]) ), ylab="Frequence", xlab=names(data)[i+d-1] ,col=c(1:i))
  
  
} 
#tableoutpot
corr=cor(data);corr  
summary(data)

#  dataselected  tableoutput 

data_select=data[,d:(d+8)] 
 

for ( j in 1:9){  
  names(data_select)[j]=paste("select",names(data)[d+j-1] ) 
    
       }  

data_select[1:20,]  


#==============================SVM=================================================================================== 
library(e1071)

data_pred=data[1:N,-31]  
table(test$Class)

#Lineaire
par(mfrow=c(1,1))
txe_lin=vector()
for (i in 1:5){
    
model_lin=svm(data$Class~.,data=data,scale = F,type="C",kernel="linear",cost=i)
pred_lin=predict(model_lin,test[,-31],decision.values = TRUE)
attr(pred_lin,"decision.values")

table(y,pred_lin) 
txe_lin[i]=mean(y!=pred_lin) 
txe_lin[i]

}
barplot(txe_lin,type="p",main="taux erreur kernel lineaire", ylab="taux erreur",col="red")

#polynomial =============  coef0 , degree,cost 
txe_pol=vector()
for(i in 1:5){
    
model_pol=svm(data$Class~.,data=data,scale = F,type="C",kernel="polynomial",degree=2,coef0=1,cost=i)
pred_pol=predict(model_pol,test[,-31],decision.values = TRUE)

table(y,pred_pol) 
txe_pol[i]=mean(y!=pred_pol) 
}
barplot(txe_pol, type="p",main="taux erreur kernel polynomial", ylab="taux erreur",col="red")

#sigmoid 
txe_sig=vector()
for(i in 1:5){ 
  
model_sig=svm(data$Class~.,data=data,scale = F,type="C",kernel="sigmoid",coefO=2)
pred_sig=predict(model_sig,test[,-31],decision.values = TRUE)
table(y,pred_sig) 
txe_sig[i]=mean(y!=pred_sig) 

}
barplot(txe_sig, type="p",main="taux erreur kernel sigmoid" , ylab="taux erreur",col="red")

#Radial

model_rad=svm(data$Class~.,data=data,scale = F,type="C",kernel="radial",gamma=0.05)
pred_rad=predict(model_sig,data=data_pred,decision.values = TRUE)

table(y,pred_rad) 
txe_rad=mean(y!=pred_rad)
plot(txe_rad, type="p",main="taux erreur kernel radial" , ylab="taux erreur",col="red")


#-------------Construction de graphe comme TROC Gini ou tableau illustrant la perf du svm


#---------------comparaison des performances du svm avec la reg logistique
names(data)
dim(data)
install.packages("gbm") 
library(gbm)

gbm.fit=gbm(Class~.,data=data,distribution="bernoulli",n.trees=5000,interaction=4)
summary(gbm.fit)

gbm.pred=predict(gbm.fit,data=test,n.trees=5000)
gbm.pred=rep("1",dim(data))
gbm.pred[1:10]
gbm.pred[gbm.probs<.5]="0"
gbm.pred[1:10]
table(gbm.pred,y)
erreur=mean(gbm.pred!=Class)
erreur
yhat.boost=predict(boost.boston,newdata=Boston[-train,],n.trees=5000)
mean((yhat.boost-boston.test)^2)

install.packages("ISLR")

glm.fit=glm(Class~.,data,family=binomial)
summary(glm.fit)

glm.pred=predict(glm.fit,data=test,type="response")
glm.probs=rep("1",dim(test))

glm.pred[glm.probs<.5]="0"

table(glm.pred,y)

#taux erreur gardient boosting et la reg logistique,tracer leur auc et comparer par rapport au radial
#################La Regression Logistique 
y=test$Class
library(ISLR)
dim(test)
glm.fit = glm(data$Class~.,data=data,family=binomial)
glm.probs=predict(glm.fit, test[,-31])
glm.pred=rep("0",3000)
glm.pred[glm.probs>0.5]="1"

table(glm.pred,y)
erreur_log=mean(glm.pred!=y)
erreur_log
plot(erreur_log,type="p",col="red")  

#######gradient boosting
library(gbm)
set.seed(1)
boost.fit=gbm(data$Class~.,data=data,distribution="gaussian",n.trees=5000,interaction=4)
#garphique de dpendance
par(mfrow=c(1,2))
plot(boost.fit,i="rm")
plot(boost.fit,i="lstat")
#########"""prédiction
yhat.boost=predict(boost.boston,newdata=Boston[-train,],n.trees=5000)
mean((yhat.boost-boston.test)^2)




 B <- 8000
#model <- gbm(Y~.,data=dapp,distribution="adaboost",interaction.depth=1,shrinkage=1,n.trees=B) 
 
boost.fit <- gbm(data$Class~.,data=data,distribution="adaboost",interaction.depth=1,shrinkage=1, n.trees=B)

 boucle<- seq(1,B,by=50)
 errapp <- rep(0,length(boucle))
 errtest <- errapp 
 k <- 0
 
 for (i in boucle){
   k <- k+1
   prev_app <- predict(boost.fit,newdata=data,n.trees=i) 
   errapp[k] <- sum(as.numeric(prev_app>0)!=data$Class/nrow(data) )
   prev_test<- predict(boost.fit,newdata=test,n.trees=i) 
   errtest[k] <- sum(as.numeric(prev_test>0)!=test$Y)/nrow(test) 
 }
 
plot(boucle,errapp,type="l",col="blue",ylim=c(0,0.5),xlab="nombre d’iterations", ylab="erreur") 
 lines(boucle,errtest,col="red")
