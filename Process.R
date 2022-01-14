LAI.week <- apply.weekly(LAI.x, max)
plot.zoo(LAI.x, col = "gray", lwd =2)
lines(as.zoo(LAI.week))

LAI.month <- apply.monthly(LAI.x, max)
LAI.month.min <- apply.monthly(LAI.x, min)
plot.zoo(LAI.week)
lines(as.zoo(LAI.x), col="lightgray")
lines(as.zoo(LAI.month.min),col=3)
