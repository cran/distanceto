## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----install, eval = FALSE----------------------------------------------------
#  # Enable the robitalec universe
#  options(repos = c(
#      robitalec = 'https://robitalec.r-universe.dev',
#      CRAN = 'https://cloud.r-project.org'))
#  
#  # Install distanceto
#  install.packages('distanceto')

## ----setup--------------------------------------------------------------------
library(distanceto)
library(sf)

## -----------------------------------------------------------------------------
# Load nc data
nc <- st_read(system.file("shapes/sids.shp", package="spData"))
st_crs(nc) <- "+proj=longlat +datum=NAD27"

# Set number of sampling points
npts <- 1e3

# Sample points in nc
ncpts <- st_sample(nc, npts)

# Select first 5 of nc
ncsub <- nc[1:5,]

# Measure distance from ncpts to first 5 of nc
dist <- distance_to(ncpts, ncsub, measure = 'geodesic')

# or add to ncpts
ncpts$dist <- dist

head(dist, 30)
hist(dist)

## -----------------------------------------------------------------------------
# Load seine data
data('seine', package = 'spData')

# Buffer seine by 1000 metres
bufseine <- st_buffer(seine, 1000)

# Set number of sampling points
npts <- 1e2

# Sample points within buffer seine
seinepts <- st_sample(bufseine, npts)

# Measure distance from seine points to seine
dist <- distance_to(seinepts, seine)

# or add to seine points
seinepts$dist <- dist

head(dist, 30)
hist(dist)

## -----------------------------------------------------------------------------
library(raster)

rdist <- distance_raster(seine, 1e4)

plot(rdist)

