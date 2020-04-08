###########################################################
###Code to extract exif format metadata from geotagged photos
###and generate labelled .kml file for visualization in Google Earth
###Prepared by Jasper Slingsby
###February 2020
###########################################################

library(exifr)
library(sf)

# Get photo names and extract exif data
fls <- list.files("/home/jasper/Desktop/CherryFarmPics", full.names = T)
dat <- read_exif(fls)

# Add photo names/numbers - note that the column must be "Name" to visualize in kml (otherwise "Description" for popup labels)
dat$Name <- list.files("/home/jasper/Desktop/CherryFarmPics", full.names = F)

# Make the data frame a simple feature (spatial)
sfdat <- st_as_sf(dat, coords = c("GPSLongitude", "GPSLatitude"), crs = 4326)

# Write to file
st_write(sfdat, "/home/jasper/Desktop/CherryFarmPics/pics.kml", driver = "KML")
