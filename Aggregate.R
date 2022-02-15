## Yearly average LAI
LAI.spl <- data.frame(dat=index(LAI.spline.xts),LAI=coredata(LAI.spline.xts))
LAI.ordered <- LAI.spl[order(substr(LAI.spl[,1],6,10)),]
LAI.aggr <- aggregate(LAI.ordered[,2], list(monthday=substr(LAI.ordered[,1],6,10)), mean)
LAI.aggr[60,2] <- mean(LAI.aggr[c(59,61),2])
LAI.aggr.xts <- xts(LAI.aggr[,2],as.Date(paste0("2016-",LAI.aggr[,1])))
