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
nc <- st_read(system.file("shape/nc.shp", package="sf"))

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
# Transform nc data to local projected coordinates (UTM 18N)
nc_utm <- st_transform(nc, 32618)

# Set number of sampling points
npts <- 1e2

# Sample points within nc data
nc_utm_pts <- st_sample(nc_utm, npts)

# Select one polygon within nc data
nc_utm_select <- nc_utm[1, ]

# Measure distance from seine points to seine
dist <- distance_to(nc_utm_pts, nc_utm_select)

# or add to seine points
nc_utm_pts$dist <- dist

head(dist, 30)
hist(dist)

## ---- fig.width=8-------------------------------------------------------------
library(raster)

rdist <- distance_raster(nc_utm_select, 1e4, extent = st_bbox(nc_utm))

plot(rdist)

