library('grid')
library('foreach')

# Read data
train_file = "~/Downloads/train.csv"
test_file = "~/Downloads/test.csv"
train_data = read.csv(train_file, header = TRUE)
test_data = read.csv(test_file, header = TRUE)

# Useful functions
euc.dist <- function(x1, x2) sqrt(sum((x1 - x2) ^ 2))

draw_vector <- function(vector) {
  mat = matrix(vector, 28, 28, TRUE)/256
  print(label)
  grid.raster(mat)
}

# Useful constants

# Train Data
for(i in 1:1000){
  label = train_data[i,][1]
  vectir = as.numeric(train_data[i,])[2:785]
  draw_vector(vectir)
  Sys.sleep(2)
}