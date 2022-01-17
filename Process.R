LAI.loe <- lowess(index(LAI.x),as.numeric(LAI.x),f=0.01)
LAI.lt <- xts(LAI.loe$y, index(LAI.x))

LAI.x1 <- LAI.x
LAI.x1[LAI.x < LAI.lt-2] <- NA
LAI.x1[LAI.x > LAI.lt+2] <- NA
LAI.x1 <- na.approx(LAI.x1)

monthly.max <- round(apply.monthly(LAI.x1,max),1)
monthly.min=as.numeric(apply.monthly(LAI.x1,min))
monthly.mean=round(as.numeric(apply.monthly(LAI.x1,mean)),1)

month.num <- as.numeric(format(index(monthly.max),"%m"))
month.recod <- ifelse(month.num < 5,13,month.num)
month.ws <- ifelse(month.recod >= 10,"winter","summer")
month.wsc <- ifelse(month.num == 4 | month.num == 10,"change",NA)
month.wsc <- ifelse(is.na(month.wsc),month.ws,month.wsc)

LAI.df <- data.frame(month=month.wsc,max=as.numeric(monthly.max),
                     min=monthly.min,
                     mean=monthly.mean)
LAI.df[LAI.df$month == "change",c(2,3)] <- NA
LAI.df[LAI.df$month == "summer",3:4] <- NA
LAI.df[LAI.df$month == "winter",c(2,4)] <- NA

LAI.monthraw <- ifelse(is.na(LAI.df[,2]),LAI.df[,3],LAI.df[,2])
LAI.monthraw <- ifelse(is.na(LAI.monthraw),LAI.df[,4],LAI.monthraw)

date.new <- seq(as.Date("2002-07-15"),as.Date("2021-12-15"),by="months")
LAI.maxmin <- xts(LAI.monthraw,date.new)

## Daily
date.new <- seq(as.Date("2002-07-15"),as.Date("2021-12-15"),by="days")
LAI.d <- xts(rep(NA,length(date.new)),date.new)
LAI.d <- round(na.approx(merge.xts(LAI.d,LAI.maxmin)[,2]),1)

LAI.spline <- smooth.spline(index(LAI.d), coredata(LAI.d))
LAI.spline.xts <- xts(LAI.spline$y, index(LAI.d))
