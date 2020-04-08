###########################################################
###Code to convert shapefile points to gpx format for upload to Garmin GPS
###Prepared by Jasper Slingsby
###February 2020
###########################################################

library(sf)
library(tidyverse)

# Get points
pts <- st_read("/home/jasper/Dropbox/SAEON/Projects/RReTool/Data/Blyde_training_points_Keletso_Feb2020/Merged_Veg/Merged_Veg_Classes.shp")

# Exclude z dimension and problematic points
pts <- st_zm(pts)
pts <- pts[-519,]

# Recode classes to shorter labels
# GPS waypoints can only take one column and it has to be called "name" 
pts$name <- recode(pts$layer,
`Acacia(AM&AD)-LDPoints` = "AC",            
`Bare Rock` = "Rock",
`Buildings-Points`  = "Bld",
`Combined_Wetlands_23Oct2019` = "Wet",
`Eucalyptus_HDPoints` = "EHD",
`Eucalyptus(EC,EG,EP,ES)-LDPoint (1)` = "ELD",
`Eucalyptus(EC,EG,EP,ES)-MDPoints` = "EMD",
`Forest-Points` = "For",
`Grasslands-Points` = "Grs", 
`Pinus (PE,PP,PT,PK,PC) - MD Points` = "PMD", 
`Pinus (PE,PP,PT,PK,PC)-HD Points` = "PHD",    
`Pinus (PE,PP,PT,PK,PC)-LD Points` = "PLD",   
`Plantation_Points` = "Plt",
`Recently_Cleared_Plantation` = "CPlt",       
`Savanna-Points` = "SV")

# Add numbers to codes
pts$num <- 1:nrow(pts)
pts$name <- paste0(pts$num,pts$name)

# Write out with only the "name" column
st_write(pts[8], "/home/jasper/Dropbox/SAEON/Projects/RReTool/Data/Blyde_training_points_Keletso_Feb2020/Merged_Veg/Merged_for_GPS.gpx", driver = "GPX")
