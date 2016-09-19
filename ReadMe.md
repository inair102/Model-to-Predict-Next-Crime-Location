#Model to Predict Next Crime Location

This R model has been developed on the idea of Geographic Profiling of criminals.<br>
The program is fed with data in csv format and it creates a density fucntion which is used to make predictions.<br>
In order to use this, first of all few R packages are to be installed and R-3.1.2 or lower versions are to be used.(I used R-3.1.2)<br>
Dataset used : <strong>yorkshire.csv</strong><br>

<strong> List of packages to be installed : </strong><br>
install.packages("devtools")<br>
spatial.pkgs <- c("geoR", "mapdata", "maps", "maptools", "RandomFields", "plotKML", "rgdal", "rgeos", "shapefiles", "sp", "spatstat", "raster", "rts")<br>
lapply(spatial.pkgs, install.packages)<br>
install.packages("ggplot2")<br>
