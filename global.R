require(shiny)
require(shinydashboard)
require(shinyjs)
require(leaflet)
require(ggvis)
library(plyr)
require(dplyr)
library(RColorBrewer)
require(raster)
require(gstat)
require(rgdal)
require(Cairo)
library(sp)
library(htmltools)
# library(shinyauthr)
# dataframe that holds usernames, passwords and other user data
# user_base <- tibble::tibble(
#   user = c("user1", "user2"),
#   password = c("pass1", "pass2"),
#   permissions = c("reviewer", "standard"),
#   name = c("reviewer", "User Two")
# )


readfile <- read.csv("data/AraCLIM_FINAL_CLIMools_V2.csv",row.names = NULL)
readfile2 <- read.csv("data/datadescriptionc.csv",row.names = NULL)

FULL.val <-read.csv("data/AraCLIM_FINAL_CLIMools_V2.csv")
class(FULL.val)  
na.omit(FULL.val)

vlc <- read.delim("data/variable_label_categoryb.txt", header = FALSE, sep = "\t")
colnames(FULL.val) <- vlc[,2]
cats <- read.delim("data/categoriesb.txt", header = FALSE, sep = "\t")
vars <- vector("list",dim(cats)[1])
names(vars) <- cats$V1
n = dim(vlc)[1]
for(i in 1:n) {
	c <- vlc[i,3]
	l <- vlc[i,2]
	if (is.null(vars[[c]])) {
		vars[c] <- c(l)
	}
	else {
		vars[[c]] <- c(vars[[c]], l)
	}
}

# a data.frame

FULL <- SpatialPointsDataFrame(FULL.val[,c("Longitude (degrees)", "Latitude (degrees)")], FULL.val[,1:478])

#########

descriptiondataset <-read.csv("data/datadescriptionc.csv")


datasets <- list(
  'FULL'=  FULL,
	'cats'= vars,
  'descriptiondataset'
  
)

baselayers <- list(
  'FULL'='Esri.WorldImagery'
)

