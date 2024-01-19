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

year.num <- as.numeric(format(index(monthly.max),"%Y"))

LAI.df <- data.frame(year = year.num, month = month.wsc,max = as.numeric(monthly.max),
                     min=monthly.min,
                     mean=monthly.mean)
LAI.df[LAI.df$month == "change", c("max", "min")] <- NA
LAI.df[LAI.df$month == "summer", c("min", "mean")] <- NA
LAI.df[LAI.df$month == "winter", c("max", "mean")] <- NA

is.maxvalue <- !is.na(LAI.df$max)
for(curr.year in LAI.df[1, "year"]:LAI.df[nrow(LAI.df), "year"])
{
    akt.max.idx <- which(LAI.df$year == curr.year & is.maxvalue)
    akt.max <- LAI.df[akt.max.idx, "max"]
    akt.order <- order(akt.max, decreasing = TRUE)
    LAI.df[akt.max.idx, "max"] <- akt.max[akt.order]
}

LAI.monthraw <- ifelse(is.na(LAI.df[, "max"]),LAI.df[, "min"],LAI.df[, "max"])
LAI.monthraw <- ifelse(is.na(LAI.monthraw),LAI.df[, "mean"], LAI.monthraw)

date.new <- seq(as.Date("2002-07-15"),as.Date("2023-08-17"),by="months")
LAI.maxmin <- xts(LAI.monthraw,date.new)

## Daily
date.new <- seq(as.Date("2002-07-15"),as.Date("2023-08-17"),by="days")
LAI.d <- xts(rep(NA,length(date.new)),date.new)
LAI.d <- merge.xts(LAI.d,LAI.maxmin)[,2]
LAI.d.spline <- na.spline(LAI.d)
LAI.d.approx <- na.approx(LAI.d)

LAI.spline <- smooth.spline(index(LAI.d.approx), coredata(LAI.d.approx))
LAI.spline.xts <- xts(LAI.spline$y, index(LAI.d.approx))
