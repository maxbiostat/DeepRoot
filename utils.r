#################
#---SCRAPBOOK---#
#################

#   dots = data.frame(seed = data$seed, simulatedRootHeight = data$simulatedRootHeight, rootHeight.mean = data$rootHeight.mean)
#   dots = melt(dots, id.var = "seed")

p <- ggplot(data)
p <- p + aes(x = seq(min(rootHeight.mean), max(rootHeight.mean), length.out = 100) )
p <- p + geom_errorbarh(  aes(xmin = rootHeight.hpdLower, xmax = rootHeight.hpdUpper, y = seed), size = .5, width = .75) 
#   p <- p + geom_point(aes(x = value, y = seed, fill = variable), color = "black", size = 2, pch = 21, data = dots)
p <- p + geom_point(aes(x =  simulatedRootHeight, y = seed), color = "black", fill = "red", size = 2, pch = 21)
p <- p + scale_y_continuous('Seed')
p <- p + scale_x_continuous('rootHeight')
p <- p + theme_bw()
#   p <- p + scale_fill_discrete(name = "Variable",
#                                 breaks = c("simulatedRootHeight", "rootHeight.mean"),
#                                 labels = c( "Simulated value", "Estimated value"))
p <- p + facet_wrap( ~ simulatedPopSize)
p

p <- ggplot(data)
#   p <- p + aes(x = seq(min(rootHeight.mean), max(rootHeight.mean), length.out = 100) )
p <- p + geom_errorbar(  aes(ymin = rootHeight.hpdLower, ymax = rootHeight.hpdUpper, x = seed), size = .5, width = .75) 
# p <- p + geom_point(aes(y = rootHeight.mean, x = seed), size = .3)
p <- p + geom_point(aes(y = value, x = seed, color = variable), size = 2, pch = 21, data = dots)
p <- p + scale_x_continuous('Seed')
p <- p + scale_y_continuous('rootHeight')
p <- p + coord_flip()
p <- p + theme_bw()
p



setwd("~/Dropbox/BeagleSequenceSimulator/deep_root")

################
#---PACKAGES---#
################
require("ggplot2")
require("reshape2")
require("grid")

#################
#---FUNCTIONS---#
#################
producePlot <- function(data) {
  
#   data = dataList[[5]]
  
  p <- ggplot(data)
#   p <- p + aes(x = seq(min(rootHeight.mean), max(rootHeight.mean), length.out = 100) )
  p <- p + aes(x = seq(min(simulatedRootHeight), max(simulatedRootHeight), length.out = 100) )
  p <- p + geom_errorbarh(aes(xmin = rootHeight.hpdLower, xmax = rootHeight.hpdUpper, y = seed), size = .5, width = .75) 
  p <- p + geom_point(aes(x =  simulatedRootHeight, y = seed), color = "black", fill = "red", size = 2, pch = 21)
  p <- p + scale_y_continuous('Seed')
  p <- p + scale_x_continuous('rootHeight')
  p <- p + theme_bw()
  p <- p + facet_wrap( ~ simulatedPopSize)
  
#   p
  
  return(p)
} # END: producePlot

layOut <- function (...) {
  
  x = list(...)
  n = max(sapply(x, function(x) max(x[[2]])))
  p = max(sapply(x, function(x) max(x[[3]])))
  pushViewport(viewport(layout = grid.layout(n, p)))
  for (i in seq_len(length(x))) {
    print(x[[i]][[1]], vp = viewport(layout.pos.row = x[[i]][[2]], 
                                     layout.pos.col = x[[i]][[3]]))
  }
} # END: layOut

#################################
#---POPULATION SIZE HPD PLOTS---#
#################################
p1 <- producePlot(dataList[[1]])
p2 <- producePlot(dataList[[2]])
p3 <- producePlot(dataList[[3]])
p4 <- producePlot(dataList[[4]])
p5 <- producePlot(dataList[[5]])
p6 <- producePlot(dataList[[6]])
p7 <- producePlot(dataList[[7]])

layOut(list(p1, 1, 1), # takes first row and first two coulmns
       list(p2, 1, 2),   # next two are on separate rows
       list(p3, 1, 3),
       list(p4, 1, 4), 
       list(p5, 2, 1),
       list(p6, 2, 2),
       list(p7, 2, 3:4)
)

############
#---DATA---#
############
k = 1
dataList = list()
for(i in c(1, 5, 10, 50, 100, 500, 1000
#            , 5000
           )) {
  
  filename = paste("resultsPopSize", i, sep = "")
  if(file.exists(filename)) {
    
    data = read.table(filename, head = TRUE)    
    data = data[with(data, order(simulation)), ]
    dataList[[k]] = data
    
    k = k + 1
  }
  
}
         
##################
#---TREND PLOT---#
##################      
allData <- do.call("rbind", dataList)      
allData$simulatedPopSize <- as.factor(allData$simulatedPopSize)       

p <- ggplot(allData)    
p <- p + geom_point(aes(x =  simulatedRootHeight, y = rootHeight.mean), color = "black", fill = "grey40", size = 3, pch = 21)   
p <- p + geom_smooth(aes(x =  simulatedRootHeight, y = rootHeight.mean), method = "loess", color = "black", se = FALSE)
p <- p + scale_x_continuous('Simulated root height')
p <- p + scale_y_continuous('Estimated root height')
p <- p + theme_bw()

print(p)         
         
         






