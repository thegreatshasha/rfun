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
  grid.raster(mat)
}

# Useful constants
min_distance <- 1000000
min_label <- -1
num_train_cases = length(train_data[,1])
num_test_cases = length(train_data[,1])
dat = data.frame(label=numeric(), dist=numeric())
k = 5
classifications = numeric(num_test_cases)

# Begin
for(j in 1:num_test_cases) {
  # j is the case to be detected
  print(num_test_cases - j)
  unknown_digit = as.numeric(test_data[j,])
  draw_vector(unknown_digit)
  
  # Training Data. We already know the labels
  for(i in 1:num_train_cases){
    percent_complete = (i/num_train_cases) * 100
    #print(i)
    
    label = as.numeric(train_data[i,])[1]
    
    digit_label = as.numeric(train_data[i,][1])
    known_digit = as.numeric(train_data[i,])[2:785]
    
    #draw_vector(known_digit)
    #Sys.sleep(2)
    
    distance_vec = abs(known_digit - unknown_digit);
    distance = sum(distance_vec);
    
    #if(distance < min_distance) {
    dat[i,] = c(digit_label, distance)
    #min_vector = known_digit
    #min_distance = distance
    #min_label = label
    #}
    #draw_vector(distance_vec)
    #Sys.sleep(2)
  }
  
  dat = dat[order(dat$dist),]
  k_smallest_rows = head(dat, k)
  k_nearest = aggregate(k_smallest_rows['dist'], k_smallest_rows['label'], sum)
  classified_label = k_nearest[which.min(k_nearest[,2]), 1]
  print(classified_label)
  
  classifications[j] = classified_label
  #sprintf("dis: %f, min_d: %f, label: %f, min_label: %f", distance, min_distance, label, min_label)
  
  # Based on distance array, classify
}