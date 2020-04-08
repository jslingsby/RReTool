library(sf)
library(dplyr)

# Get remnants
rem <- st_read("/home/jasper/Documents/Datasets/CapeRemnants2016/BSP_nat_rems_ETS2016.shp")

# Get Alana and Petra's points
pts <- st_read("/home/jasper/Dropbox/SAEON/Projects/RReTool/Data/RebeloHolden/BB_FinalTrainingData/BB_FinalTrainingData.shp")

# Fix coordinate reference system for points
st_crs(pts) <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0" #add a crs to the points (geographic)
pts <- st_transform(pts, st_crs(rem)) #transform to same crs as the remnants

# Intersect points and remnants
out <- st_intersects(pts, rem)

# Extract only points that fall within remnants
rpts <- pts[apply(out, 1, any),]

# Lets see what that leaves us with
summary(rpts$LULC) # Lots of these are categories we don't want, 

#Let's trim to the ones we do want
rpts <- rpts %>% filter(LULC %in% c("Alien Tree Other", "Bare Ground", 
                            "Black Wattle", "Fynbos High Density",
                            "Fynbos Low Density", "Gum", 
                            "Indigenous Forest", "Pine",
                            "Renosterveld", "Rock", "Wetland"))

nrow(rpts) #How many we're left with

st_write(rpts, "/home/jasper/Dropbox/SAEON/Projects/RReTool/Data/RebeloHolden/FilteredTrainingData.shp")
