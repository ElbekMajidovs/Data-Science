
    # Preanalysis of data

    # Descriptive statistics
    
      Summarize(Wrkday ~ Year, data=Data, digits=3)
    
    # Skewness & Kurtosis?
      psych::describe(Data[Data$Year=='1st year',"Wrkday"])
      psych::describe(Data[Data$Year=='2nd year',"Wrkday"])
      psych::describe(Data[Data$Year=='3rd year',"Wrkday"])
    
    #Boxplot
      boxplot(Wrkday ~ Year, data=Data)
    
    #Mean with CI
      Sum <- groupwiseMean(Wrkday ~ Year, data   = Data, conf   = 0.95, digits = 3, traditional = FALSE, percentile  = TRUE)
      # traditional=T - traditional confidence intervals for the group means, using the t-distribution
      # percentile  = TRUE -  percentile confidence intervals for the group means by bootstrap
      
      #plot 
      ggplot(Sum, aes(x = Year, y = Mean)) +
        geom_errorbar(aes(ymin = Percentile.lower, ymax = Percentile.upper), width = 0.05, size  = 0.5) +
        geom_point(shape = 15, size  = 4) +
        theme_bw() +
        theme(axis.title   = element_text(face  = "bold")) +
        ylab("Mean Wrkday, mg")
   
      
      
       
    #### ONE-WAY ANOVA analysis
    
      #Estimating a linear model
      model <- lm(Wrkday ~ Year, data = Data)
    
      # F test for all betas=0
      # Rejecting H0 indicates that there is significant difference betwee averages
      summary(model) 
      
      #ANOVA analysis results
      Anova(model)   
      ### In this case F test from summary is the same F test as for Anova
      # Because we have only one indepent variables --> all betas for different Years levels
      # Conclusions? There is difference in means? In which particurarlly? Whe don't know.

      #Diagnostics
        #are residuals normal?
      
        res<- residuals(model)
        plotNormalHistogram(res)
        shapiro.test(res)

        #are variances equal to each other?
          # equality of variance tests for more then 2 samples
          # H0:all samples have the same variance
          # H1:variance is not the same for all samples
          bartlett.test(Wrkday ~ Year, data = Data) #assuming normality
          # bartlett.test(len ~ interaction(supp,dose), data=ToothGrowth)
          leveneTest(Wrkday ~ Year, data = Data)
          fligner.test(Wrkday ~ Year, data = Data)
      
          
      #POST-HOC analysis
        #pairwise comparsion of means after ANOVA
        ls = lsmeans::lsmeans(model, pairwise ~ Year, adjust = "holm")
        # it calculates averages for each group & contrasts (differences)
        # the same as sample beacuse only one variable

        #different methods for p-values adjustments wrt multpiple comparsions
        lsmeans::lsmeans(model, pairwise ~ Year, adjust = "hochberg")
        lsmeans::lsmeans(model, pairwise ~ Year, adjust = "holm")
        lsmeans::lsmeans(model, pairwise ~ Year, adjust = "bonferroni")


      # Compact letter display of pairwise comparisons
        # preparation for plot with letters informing which means are not different
        cld = cld(ls[[1]], alpha   = 0.05, Letters = letters,    adjust  = "holm")    
        ### Letters = letters - Use lower-case letters for .group
        cld
      
        ### Order the levels for printing
        cld$Year = factor(cld$Year, levels=c("1st year", "2nd year", "3rd year"))
        
        ###  Remove spaces in .group  
        cld$.group=gsub(" ", "", cld$.group)
      
      
        ### Plot
        
        ggplot(cld,
               aes(x     = Year, y     = lsmean, label = .group)) +
          geom_point(shape  = 15, size   = 4) +
          geom_errorbar(aes(ymin  =  lower.CL, ymax  =  upper.CL), width =  0.2, size  =  0.7) +
          theme_bw() +
          theme(axis.title   = element_text(face = "bold"), axis.text    = element_text(face = "bold"),  plot.caption = element_text(hjust = 0)) +
          ylab("Least square mean\n Wrkday cost") +
          geom_text(nudge_x = c(0, 0, 0),
                    nudge_y = c(120, 120, 120),
                    color   = "black")


 
        
        
        
               
        
      ####################################
      
      
      # Kruskall - Wallis test
      
      
      ####################################
      # Alternative for ANOVA when assumptions about normality are not met
            
          
        #In order to be a test of medians, the distributions of values for each group need to be of similar shape and
        # spread. Otherwise the test is a test of distributions.
        #Equal variances? - this time bartlet test is not appropriate
          leveneTest(Wrkday ~ Year, data = Data)
          fligner.test(Wrkday ~ Year, data = Data)
      
        # Kruskall - Wallis test
          kruskal.test(Wrkday ~ Year, data = Data)
      
        ### POST-HOC analysis - pairwise comparison
          #Dunn test
          dunn.test(x=Data$Wrkday, g=Data$Year, method=c("hs"))
          DT <- dunn.test(x=Data$Wrkday, g=Data$Year, method=c("by"))     
          # Adjusts p-values for multiple comparisons;
          
          #Another function, to get table prepared for Compact letter display
          DT<-dunnTest(x=Data$Wrkday, g=Data$Year, method=c("by"))
          DT$res
        
          ### Conover-Iman test
          conover.test(x=Data$Wrkday, g=Data$Year, method=c("bonferroni"))
          CI <- conover.test(x=Data$Wrkday, g=Data$Year, method=c("bonferroni"))     
          # Adjusts p-values for multiple comparisons;
          CI
        
          ### Mann-Whitney/Wicoxon test
          PT = pairwise.wilcox.test(x=Data$Wrkday, g=Data$Year, p.adjust.method="BH")
          PT
