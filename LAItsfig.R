
year.lai <- as.Date(c("2002-07-04",paste0(2003:2023,"-01-01"),"2023-08-17"))

lines(as.zoo(LAI.lt));lines(as.zoo(LAI.x1), col = 2)

pdf("laits.pdf", width=2.9*7, height=3.5, pointsize=14)
par(mar=c(1.3,3.1,0.6,0.6), las=1, mgp=c(2,1,0))
plot.zoo(LAI.x, xaxs="i", yaxs="i", ylim=c(0,7.3), xlab="",ylab="LAI",main="",type="n",xaxt="n")
grid(nx=NA, ny=NULL, lwd=2)
axis(1, at=year.lai, lab=F, tck=1, col="lightgray", lty="dotted", lwd=2)
lines(as.zoo(LAI.x),lwd=3,col="darkgrey")
lines(as.zoo(LAI.spline.xts),lwd=3)
axis(1, at=year.lai, lab=F)
par(mgp=c(1,0.3,0))
axis.Date(1, at=c(year.lai[1]+85, year.lai[-1]+182), format="%Y", tcl=0)
legend("topleft",c("Raw","Pre-filtered", "Smoothed"),ncol=2,bg="white", lwd=3, col=c("darkgrey","2","black"))
box(lwd=2)
dev.off()
