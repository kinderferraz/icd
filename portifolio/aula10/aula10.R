library(naivebayes)
library(dplyr)
library(ggplot2)
library(psych)

heart <- read.csv("./input/heart.csv")
head(heart)


#age - age in years
#sex - sex (1 = male; 0 = female)
#cp - chest pain type (1 = typical angina; 2 = atypical angina; 3 = non-anginal pain; 4 = asymptomatic)
#trestbps - resting blood pressure (in mm Hg on admission to the hospital)
#chol - serum cholestoral in mg/dl
#fbs - fasting blood sugar > 120 mg/dl (1 = true; 0 = false)
#restecg - resting electrocardiographic results (0 = normal; 1 = having ST-T; 2 = hypertrophy)
#thalach - maximum heart rate achieved
#exang - exercise induced angina (1 = yes; 0 = no)
#oldpeak - ST depression induced by exercise relative to rest
#slope - the slope of the peak exercise ST segment (1 = upsloping; 2 = flat; 3 = downsloping)
#ca - number of major vessels (0-3) colored by flourosopy
#thal - 3 = normal; 6 = fixed defect; 7 = reversable defect
##num - the predicted attribute - diagnosis of heart disease (angiographic disease status) (Value 0 = < 50% diameter narrowing; Value 1 = > 50% diameter narrowing)

heart$age <- cut(heart$age, c(0, 20, 40, 50, 60, 70, 80))
heart$sex <- as.factor(heart$sex)
heart$thal <- as.factor(heart$thal)
heart$cp <- as.factor(heart$cp)
heart$fbs <- as.factor(heart$fbs)
heart$exang <- as.factor(heart$exang)
heart$ca <- as.factor(heart$ca)
heart$restecg <- as.factor(heart$restecg)

xtabs(~age+target, data=heart)

pairs.panels(heart[-1], cex.cor=1)
