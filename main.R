file = "~/Downloads/train.csv"
dat = read.csv(file, header = TRUE)
library('grid')

for(i in 10:100){
  vectir = as.numeric(dat[i,])[2:785]
  mat = matrix(vectir, 28, 28, TRUE)/256
  x <- seq(0, 1, length = nrow(mat))
  y <- seq(0, 1, length = ncol(mat))
  print(mat)
  grid.raster(mat)
  Sys.sleep(2)
}