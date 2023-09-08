# Supplemental Code for “Coupling of Coastal Activity with Tidal Cycles 
# is Stronger in Tool-using Capuchins (Cebus capucinus imitator)"

# Zoë Goldsborough, Margaret Crofoot, Shauhin Alavi, 
# Evelyn Del Rosario, Sylvia Garza, Kate Tiedeman, & Brendan Barrett
# 2023

## Calculating distance to coast 
## NOTE: GPS locations of camera traps have not been shared for conservation purposes
## Planet Labs satellite data and its products are also not included

# Script author: K Tiedeman

# Convert tiff of coastal vegetation boundary to shapefile
# Tiff created by use of Google Earth Engine (see script)
library(raster)
library(terra)
r <- rast("shoreline-data/jicaron-ndvi-clip3.tif")
##pts redacted  
pts <- vect("xx.shp")

r2 <- r
#anything below 0.7 has already been masked in earth engine
r2[r2>0.6] <- 1 
plot(r2)

r3 <- as.polygons(r2, dissolve = T, na.rm=T)

plot(r3)

# fill holes to remove rocks  
r4 <-fillHoles(r3, inverse=FALSE) 
writeVector(r4,"shoreline-data/jicaron-ndvi-shoreline-noholes.shp" )

# Get the distance from vegetation edge to each camera trap location 
r4 <- shapefile("shoreline-data/jicaron-ndvi-shoreline-noholes.shp")
rt <- gDistance(pts, as(r4, "SpatialLines"), byid = TRUE) # dist to line
