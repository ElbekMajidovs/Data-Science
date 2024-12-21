
  # 2-way ANOVA     
  
  
  ##################################################################
  #Specification as A+B+A*B

Input = ("
         Year        Avg  Wrkday
         '1st year'   A           1200
         '1st year'   A           1100
         '1st year'   A           1150
         '1st year'   A            950
         '1st year'   A           1300
         '1st year'   B           1150
         '1st year'   B           1300
         '1st year'   B           1325
         '1st year'   B           1425
         '1st year'   B           1500
         '1st year'   C           1150
         '1st year'   C           1150
         '1st year'   C            950
         '1st year'   C           1150
         '1st year'   C           1100
         '1st year'   D           1300
         '1st year'   D           1050
         '1st year'   D           1300
         '1st year'   D           1700
         '1st year'   D           1300
         '2nd year'   A           1100
         '2nd year'   A           1200
         '2nd year'   A           1250
         '2nd year'   A           1050
         '2nd year'   A           1200
         '2nd year'   B           1250
         '2nd year'   B           1350
         '2nd year'   B           1350
         '2nd year'   B           1325
         '2nd year'   B           1525
         '2nd year'   C           1225
         '2nd year'   C           1125
         '2nd year'   C           1000
         '2nd year'   C           1125
         '2nd year'   C           1400
         '2nd year'   D           1200
         '2nd year'   D           1150
         '2nd year'   D           1400
         '2nd year'   D           1500
         '2nd year'   D           1200
         '3rd year'  A            900
         '3rd year'  A           1100
         '3rd year'  A           1150
         '3rd year'  A            950
         '3rd year'  A           1100
         '3rd year'  B           1150
         '3rd year'  B           1250
         '3rd year'  B           1250
         '3rd year'  B           1225
         '3rd year'  B           1325
         '3rd year'  C           1125
         '3rd year'  C           1025
         '3rd year'  C            950
         '3rd year'  C            925
         '3rd year'  C           1200
         '3rd year'  D           1100
         '3rd year'  D            950
         '3rd year'  D           1300
         '3rd year'  D           1400
         '3rd year'  D           1100
         ")


Data <- read.table(textConnection(Input),header=TRUE)
# Data$Wrkday<-ifelse(Data$Year=="3rd year"&Data$Avg=="A",Data$Wrkday+700,Data$Wrkday)

  #Preanalysis
    #descriptive stats
    Summarize(Wrkday ~ Year+Avg, data=Data, digits=3)
    
  #2-way ANOVA
    #define a model Year:Avg is interaction

      model <- lm(Wrkday ~ Year + Avg + Year:Avg, data = Data)
    summary(model)
    str(model)
    
    #anova analysis type 3 - why? B/c
    Anova(model,type = "III")
    #interactions are significant
    
  
  #Diagnostics
    res<- residuals(model)
    plotNormalHistogram(res)
    shapiro.test(res)
    
    # equality of variance tests for more then 2 samples
    # H0:all samples have the same variance
    # H1:variance is not the same for all samples
    
    bartlett.test(Wrkday ~ interaction(Year,Avg), data=Data)
    leveneTest(Wrkday ~ interaction(Year,Avg), data = Data)
    fligner.test(Wrkday ~ interaction(Year,Avg), data = Data)
    


  #### POST-HOC LS MEANS
  # detach("package:lmerTest", unload=TRUE) #we need to unload lmerTest package as it's changing lsmeans function for mixed models
  library(lsmeans)
  
  #means for years
  lsYear <- lsmeans::lsmeans(model, pairwise ~ Year, adjust = "tukey")
  lsYear$contrasts
  CLDYear = cld(lsYear[[1]], alpha   = 0.05,   Letters = letters,   adjust  = "tukey")         
  CLDYear
  CLDYear$.group=gsub(" ", "", CLDYear$.group)
  
  ggplot(CLDYear,
         aes(x     = Year, y     = lsmean, label = .group)) +
        geom_point(shape  = 15,   size   = 4) +
        geom_errorbar(aes(ymin  =  lower.CL,     ymax  =  upper.CL),  width =  0.2,  size  =  0.7) +
        theme_bw() +
        theme(axis.title   = element_text(face = "bold"),  axis.text    = element_text(face = "bold"),  plot.caption = element_text(hjust = 0)) +
        ylab("Least square means Years") +
        geom_text(nudge_x = c(0, 0, 0), nudge_y = c(120, 120, 120),   color   = "black")
  
  
  #means for AVG  
  lsAvg <- lsmeans(model, pairwise ~ Avg, adjust = "tukey")
  lsAvg$contrasts
  CLDAvg = cld(lsAvg[[1]],  alpha   = 0.05,    Letters = letters,  adjust  = "tukey")   
  CLDAvg
  CLDAvg$.group=gsub(" ", "", CLDAvg$.group)  
    
  ggplot(CLDAvg,
           aes(x     = Avg, y     = lsmean, label = .group)) +
           geom_point(shape  = 15,   size   = 4) +
           geom_errorbar(aes(ymin  =  lower.CL,     ymax  =  upper.CL),  width =  0.2,  size  =  0.7) +
           theme_bw() +
           theme(axis.title   = element_text(face = "bold"),  axis.text    = element_text(face = "bold"),  plot.caption = element_text(hjust = 0)) +
            ylab("Least square means AVG") +
            geom_text(nudge_x = c(0, 0, 0), nudge_y = c(120, 120, 120),   color   = "black")
    
