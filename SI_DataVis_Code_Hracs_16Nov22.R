# Contributor: Lindsay Hracs
# Date: 16-Nov-22
# R version 4.1.2
# Running on macOS Monterey 12.1
# Snyder Institute Science Communciation Workshop Data Visualization

#install.packages("package_name_goes_here") # install packages, package name must be in quotation marks

# load necessary packages

library(ggplot2) # for plotting
library(ggpubr) # for ggarange
library(RColorBrewer) # for colourblind friendly palette
#library(ggsignif) # a good package to be familiar with if you want to plot and annotate differences between groups

# load in data

dataset <- read.csv("https://raw.githubusercontent.com/kaplan-gi/Snyder-Institute-Science-Communication-Workshop/main/workshop_dataset.csv", header = TRUE)
View(dataset) # inspect 

# all plots in ggplot minimally needs a geometric object and an aesthetic mapping
# geom_* = geometric object such as point, line, bar, label, text, etc.
# aes() # aesthetic mapping; how variables are mapped to aesthetic properties of the plot such as color, fill, shape, size, etc.


# create a basic plot
# plot should show up in the bottom right-hand corner of RStudio; click on 'Zoom' to view bigger and 'Export' to export your plot to desired size and type

vac_plot <- ggplot(data = dataset, aes(x = days_from_vac, y = antibody_level)) + # aesthetic with dataset, x axis, and y axix specified
    geom_point() # make a basic scatterplot with the above aesthetics using geom_point()
vac_plot # call plot; because we put our plot into an object called vac_plot, we need to tell R to do something with that object

# NOTE: there are multiple ways of doing the same things

# create a basic plot

also_plot <- ggplot(data = dataset) # make a plot with some data; if you run this code, nothing will happen because you have not specified an aesthetic
also_plot <- also_plot +
    geom_point(aes(x = days_from_vac, y = antibody_level)) # add aesthetic inside of geom_point() function; this is helpful if you want to add multiple laters to the same plot (e.g., points and lines)
also_plot

# view plots side-by-side to show they are the same

ggarrange(vac_plot, also_plot) # ggarrange is a useful function if you want to include more than one plot in a single figure 

######################### SCATTER PLOT ################################


# create a basic plot (same code as above)

vac_plot <- ggplot(data = dataset, aes(x = days_from_vac, y = antibody_level)) +
    geom_point()

# NOTE: the following warning message is stating that R has not plotted missing/NA values that are in our data set
# since the values do not exist, they can not be added to the plot
# Warning message:
# Removed 35 rows containing missing values (geom_point). 


# subset our data to only plot data from one level of vaccine status

vac_plot <- ggplot(data = dataset, aes(x = days_from_vac, y = antibody_level)) +
    geom_point(data = subset(dataset, vaccine_status == "booster1")) 


# add colour corresponding to your desired breakdown
# we added a color argument to our aes() and then we are adding a scale_color_manual() function to tell R we want to manually color each level of our variable
# the number of colours should match the number of levels
# this will add a legend to your plot

vac_plot <- ggplot(data = dataset, aes(x = days_from_vac, y = antibody_level, color = age_group)) + # you can add a shape argument if you want too, e.g., shape = sex
    geom_point(data = subset(dataset, vaccine_status == "booster1")) +
    scale_color_manual(values = c("green", "purple", "orange"))


# you can use a colour palette to add colour to you plot as well; RColorBrewer has a bunch of visually-impaired-friendly palettes

vac_plot <- ggplot(data = dataset, aes(x = days_from_vac, y = antibody_level, color = age_group)) + 
    geom_point(data = subset(dataset, vaccine_status == "booster1")) +
    scale_color_brewer(palette = "Dark2")


# the labels argument in the colour function will update your legend

vac_plot <- ggplot(data = dataset, aes(x = days_from_vac, y = antibody_level, color = age_group)) +
    geom_point(data = subset(dataset, vaccine_status == "booster1")) +
    scale_color_brewer(palette = "Dark2", labels = c("Adults", "Seniors", "Children")) # + scale_shape_discrete() if you add a shape aesthetic and want to adjust labels, etc.


# guides() is used for some of the legend formatting, i.e., legend title, whether the legend is visible or not

vac_plot <- ggplot(data = dataset, aes(x = days_from_vac, y = antibody_level, color = age_group, shape = sex)) +
    geom_point(data = subset(dataset, vaccine_status == "booster1")) +
    scale_color_brewer(palette = "Dark2", labels = c("Adults", "Seniors", "Children")) + 
    guides(color = guide_legend("Participant Age Group"), shape = guide_legend("Participant Sex")) 


# see below code for other things you can add to your plot

vac_plot <- ggplot(data = dataset, aes(x = days_from_vac, y = antibody_level, color = age_group, shape = sex)) +
    geom_point(data = subset(dataset, vaccine_status == "booster1")) +
    geom_smooth(method = "lm") + # add regression lines/line of best fit; add se = FALSE inside of geom_smooth() if you do not want confidence intervals
    scale_y_log10(breaks = c(1, 10, 100, 1000, 10000, 100000), labels = c('1', '10', '100', '1000', '10000' , '100000')) + # change the scale to a log scale, which is probably better for these data
    scale_color_brewer(palette = "Dark2", labels = c("Adults", "Seniors", "Children")) +
    guides(color = guide_legend("Participant Age Group"), shape = guide_legend("Participant Sex")) + 
    ggtitle("Antibody Level by Days from Vaccine Dose") + # add a title
    labs(x = "Days from Vaccine", y = "Anitbody Level") + # change labels (you can also use 'name =' when specifiying your scales)
    theme_light() + # change plot theme; remove grey background
    theme(legend.position = "bottom") + # move the legend to the bottom
    theme(plot.title = element_text(size = 20, face = "bold", hjust = 0.5), axis.title.x = element_text(size = 14), axis.text.x = element_text(size = 12, angle = 45, hjust = 1), axis.title.y = element_text(size = 14), axis.text.y = element_text(size = 12), legend.title = element_text(size = 10, hjust = 0.5)) # format title, x axis, y axis, and legend text; hjust and vjust are used for horizontal and vertical justification


######################### BAR PLOTS ################################

# since we have long data with multiple observations for a given subset or group of variables, we will need to aggregate data before it makes sense to use bar plots
# here we are aggregating antibody observations by med_class, and finding the mean for all of the aggregated observations
# you might have data in which it would make sense to find the sum, or min, or max, etc.

means <- aggregate(data = dataset, antibody_level~med_class, mean)


# similar syntax to our scatter plot, but we are using geom_col() to make a simple bar plot
# notice how here we use the aggregate data we created above

bar_plot <- ggplot(data = means, aes(x = med_class, y = antibody_level, fill = med_class)) +
    geom_col()
    # here you can format other plot attributes in a similar way to what you did with the scatter plot above
    # for the most part, functions and arguments will be the same, but in some cases what you do for a scatter plot does not make sense for a bar plot and vice versa


# use grouped, stacked, and proportion bar plots as it makes sense for your data
# here stacked and proportion might not be the best choices
# but we are building the plots to see how they work

# create a grouped bar plot
# you will need to reaggregate data for whatever you choose represent in your fill argument
# all varaibles in your aes() should be in the aggregate data

means2 <- aggregate(data = dataset, antibody_level~med_class+age_group, mean)

grouped <- ggplot(data = means2, aes(x = med_class, y = antibody_level, fill = age_group)) +
      geom_bar(position = "dodge", stat = "identity") 


# create a stacked bar plot

stacked <- ggplot(data = means2, aes(x = med_class, y = antibody_level, fill = age_group)) +
    geom_bar(position = "stack", stat = "identity") + # stat = identity is telling R to not aggregate data and that you will provide values that you have already aggregated
    scale_fill_brewer(palette = "Dark2", labels = c("Adults", "Seniors", "Children")) # change colour palette


# create percent/proportion bar plot

percent <- ggplot(data = means2, aes(x = med_class, y = antibody_level, fill = age_group)) +
    geom_bar(position = "fill", stat = "identity") + 
    scale_fill_brewer(palette = "Dark2", labels = c("Adults", "Seniors", "Children"))


######################### LINE PLOT ################################

# load in data

surgery <- read.csv("https://raw.githubusercontent.com/kaplan-gi/Snyder-Institute-Science-Communication-Workshop/main/workshop_dataset2.csv", header = TRUE)
View(surgery)

# subset data to view only one point per year
CD <- subset(surgery, IBD_type == "CD")


line_plot <- ggplot() +
    # since you are adding a line on top of the confidence intervals, add the geom_ribbon() layer first
    # your lower bound and upper bound values can be calculated ahead of time, but0 essentially, the best way to think about the values is that the top of your ribbon is ymax = yvalue + upperbound and the bottom of your ribbon is ymin = yvalue – lowerbound
    geom_ribbon(data = CD, aes(x = year, ymin = lower, ymax = upper, group = age_group), alpha = 0.1) + 
    geom_line(data = CD, aes(x = year, y = rate,  color = age_group), linetype = "solid") + # line types are dashed, solid, dotted, dotdash, etc.
    geom_point(data = CD, aes(x = year, y = rate,  color = age_group, shape = age_group), show.legend = FALSE) + # show.legend = FALSE if you do not want the legend
    scale_color_manual(name = "Age (years)", values = c("<18" = "#5107F2", "18 to 39" = "#F96D22", "40 to 59" = "#F2072E", "60 to 79" = "#30A2C1", "80+" = "#65F207")) +
    # create x axis title and tick marks
    scale_x_discrete(name = "Year", limits = unique(CD$year)) + # forcing discrete x axis so that all years are plotted; ignore warning
    # create y axes titles and tick marks; sec_axis() function used to include a second axis--must include scale value which corresponds to scale specified in geom_line
    scale_y_continuous(name ="Number of surgeries", limits = c(0, 50)) +
    # insert plot title
    ggtitle("Your plot title goes here") +
    # insert plot theme argument to change appearance
    theme_bw() +
    # format title and axes
    theme(plot.title = element_text(hjust = 0.5)) + # can add axis arguments here for size, colour, angle, etc., e.g., axis.text.x = element_text(vjust = 0.5, angle = 45))
    # re-position legend to bottom of plot
    theme(legend.position = "bottom", legend.box = "vertical")
