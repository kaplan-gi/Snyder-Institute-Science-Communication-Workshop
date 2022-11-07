# Contributor: Lindsay Hracs (lindsay.hracs@ucalgary.ca)
# Date: 02-Nov-22
# R version 4.1.0
# Running on macOS Monterey 12.1
# Snyder Institute Science Communciation Workshop Data Visualization

##########

# to run code, highlight the desired code with your mouse and click "run" in the top right corner of the script window
# you can run a single line by highlighting and running just that line, or you can run multiple lines at a time if you highlight more than one line before running
# any line that starts with a "#" has been "commented out" meaning that R will ignore it if you highlight and run it

##########

# if you have not installed the ggplot2 or ggpubr packages, please do so by removing the # and running the install.packages() function for each of the packages
# the RColorBrewer package will be nice to have, but is not necessary for creating the plots
# once you have installed a package, you do not need to re-install before the next time you use R
# you load packages in using the library() function (see below)


# install.packages("ggplot2")
# install.packages("ggpubr")
# install.packages("RColorBrewer")

###########

# load packages

library(ggplot2)
library(ggpubr)
library(RColorBrewer)

###########

# take data from the online repository and put it into an object called "dataset"; this will be your data frame
# if you have a file stored locally (i.e., on your computer), you can remove the link and put the file path and file name inside the quotation marks

# load data

dataset <- read.csv("https://raw.githubusercontent.com/kaplan-gi/Snyder-Institute-Science-Communication-Workshop/main/workshop_dataset.csv", header = TRUE)

##########

# inspect data to ensure it has loaded as intended

View(dataset)

##########

# to operate on a variable/column in your data frame you must call the data frame followed by a "$" and the column name
# e.g., data_frame_name$column_name

# the hist(), qqnorm(), and qqline() functions are built in to R and do not need to have the above packages installed and loaded to run
# run each line separately and view the output in the file browser window at the bottom right of RStudio or in the pop-up window if you are running R without RStudio

# visually inspect variable distribution

hist(dataset$antibody_level)
qqnorm(dataset$antibody_level)
qqline(dataset$antibody_level, col = "purple", lwd = 2)