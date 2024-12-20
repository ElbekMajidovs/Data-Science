
#descriptive statistics
  Summarize(Result ~ Subject + Student, data=Data, digits=3)
  Summarize(Result ~ Student, data=Data, digits=3)
  Summarize(Result ~ Subject, data=Data, digits=3)
  
  ### ANOVA with blocks  - we put blocks directly into model in order separate its influence
  
  #linear model  
    model = lm(Result ~ Subject+factor(Student), data = Data)
    summary(model)   ### Will show overall p-value and r-squared
  
  #histogram of 1st-3rd Subject
    histogram(~ Result | Subject, data=Data, layout=c(3,2))
  
  
  #anova analysis 
    Anova(model, type = "II")   
    ### Type II sum of squares (A|B) & (B|A)
  
  #diagnostics
    #normality
    res<- residuals(model)
    plotNormalHistogram(res)
    shapiro.test(res)

      # With unreplicated study design
      bartlett.test(Result ~ Subject, data = Data) #assuming normality


  #post-hoc analysis
      
    # We are not interesed in blocks so we only compare means for Subject
    leastsquare = lsmeans::lsmeans(model, pairwise ~ Subject, adjust = "tukey")

    leastsquare$lsmeans
    leastsquare$contrasts

    # Results are averaged over the levels of: Student 

  #plot  
    CLD = cld(leastsquare[[1]], alpha   = 0.05, Letters = letters, adjust  = "tukey")
    CLD

    ### Order the levels for printing
    CLD$Subject = factor(CLD$Subject, levels=c("Math", "Biology", "English"))

    ###  Remove spaces in .group  
    CLD$.group=gsub(" ", "", CLD$.group)
    
    
    ### Plot
    
    ggplot(CLD,
           aes(x     = Subject, y     = lsmean, label = .group)) +
      geom_point(shape  = 15, size   = 4) +
      geom_errorbar(aes(ymin  =  lower.CL, ymax  =  upper.CL), width =  0.2, size  =  0.7) +
      theme_bw() +
      theme(axis.title   = element_text(face = "bold"), axis.text    = element_text(face = "bold"),  plot.caption = element_text(hjust = 0)) +
      ylab("Least square mean\n Result cost") +
      geom_text(nudge_x = c(0, 0, 0),
                nudge_y = c(150, 150, 150),
                color   = "black")
  

########################################################


# ANOVA with random blocks   
    

########################################################### 

  #MIxed-effect model
    
  model = lmer(Result ~ Subject + (1|Student), data=Data, REML=TRUE)
  # (1|Student) - random intercept for each Student
  # REML - restricted maximum likelihood estimator

  anova(model)

  
  #Diagnostics
      #are residuals normal?
      
      res<- residuals(model)
      plotNormalHistogram(res)
      shapiro.test(res)
      
      #are variances equal to each other?
      # equality of variance tests for more then 2 samples
      # H0:all samples have the same variance
      # H1:variance is not the same for all samples
      bartlett.test(Result ~ Subject, data = Data) #assuming normality
      # bartlett.test(len ~ interaction(supp,dose), data=ToothGrowth)
      leveneTest(Result ~ Subject, data = Data)
      fligner.test(Result ~ Subject, data = Data)
      
      # comaprsion of a model with null modell
      # null model including random effect
      Data<-cbind(Data,dummy(Data$Subject))
      model.null = lmer(Result ~ English + (1|Student), data=Data, REML=TRUE)

      #2 models comparisons
      #H0: General model is statistitcally indifferent to specific model
      #H1: Genereal model is better than specific model
      anova(model,model.null)
      
      #R2
      nagelkerke(fit  = model, null = model.null)
      
      # null model not including random effects
      model.null.2 = lm(Result ~ Subject, data = Data)
      anova(model, model.null.2)
      nagelkerke(fit  = model, null = model.null.2)


    #POST_HOC
    leastsquare = lsmeans::lsmeans(model, pairwise ~ Subject,   adjust="tukey")         ###  Tukey-adjusted comparisons
    CLD = cld(leastsquare[[1]], alpha=0.05,  Letters=letters,  adjust="tukey")         
    leastsquare$contrasts



##########################################################


# Friedman & Quade tests
    
    
###########################################################

  #variable creation for unreplicated complete block design
    #in each block every subject only once
    
  #Group Averages Over Level Combinations of Factors
  #Here function is not mean but simply sequnce of integers

  Data$num <- ave(Data$Result,Data$Subject, FUN = seq_along)

    # x - Data$Result numeric variable to which function should be applied (in this case any numeric)
    # among subset of x where Data$Subject on the same level
    # sequence genereation FUN = seq_along

    # The test is based on the differences between paired data
    # The function pairwiseDifferences will create a new data frame of differences for all pairs of differences.  
    # Note that the data must be ordered by the blocking variable so that the first observation 
    # for 1st Subject will be paired with the first observation for 2nd Subject, and so on.



 
  #descriptive statistics, are distirbutions similar in spread and shape?
  Summarize(Result ~ Subject, data=Data, digits=3)
  describeBy(Data$Result, group=Data$Subject)

  leveneTest(Result ~ Subject, data = Data)
  fligner.test(Result ~ Subject, data = Data)


  #friedman test
  #H0:Same medians/same distributions
  
  friedman.test(Result ~ Subject | Student, data = Data)
  
  # install.packages('PMCMRplus')
  library(PMCMRplus)
  
 
  ## Global Friedman test
  friedmanTest(y=Data$Result,groups=Data$Subject,blocks=Data$Student)
  ## Demsar's many-one test
  frdManyOneDemsarTest(y=Data$Result,groups=Data$Subject,blocks=Data$Student, p.adjust = "bonferroni")
  ## Exact many-one test
  frdManyOneExactTest(y=Data$Result,groups=Data$Subject,blocks=Data$Student, p.adjust = "bonferroni")
  ## Nemenyi's many-one test

  FR<-frdAllPairsExactTest(y=Data$Result,groups=Data$Subject,blocks=Data$Student, p.adjust = "bonferroni")

  FR1 = fullPTable(FR[[3]])
  FR1
  
  ### Compact letter display
  multcompLetters(FR1,  compare="<", threshold=0.05, Letters=letters)


  #Quade test
  #H0:Same medians/same distributions
  
  quade.test(Result ~ Subject | Student, data = Data)
  
  #CLD
  
  PT = pairwise.wilcox.test(Data$Result, Data$Subject,  p.adjust.method="fdr",  paired=TRUE)$p.value
  PT
  
  #Convert a lower triangle matrix to a full matrix
  PT1 = fullPTable(PT)
  PT1

  #Letter summary of similarities and differences
  multcompLetters(PT1,  compare="<", threshold=0.05, Letters=letters)

  # X symmetric matrix with p-values
  # comapre - function for comapre if "<" then threshold than different
  # Letters=letters - Vector of distinct characters (or character strings) 
  # used to connect levels that are not significantly different. 


