raw <- read.csv("DownloadedMODISLAI/HidegvizLAI4days-MCD15A3H-006-results.csv")
names(raw)
library(xts)
## 8th variable is LAI, 3rd is Date with name is better
LAI.x <- xts(raw[,"MCD15A3H_006_Lai_500m"], as.Date(as.character(raw[,"Date"])))
