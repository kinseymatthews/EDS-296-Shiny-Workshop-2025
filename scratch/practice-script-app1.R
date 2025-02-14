# load packages ----
library(tidyverse)
library(palmerpenguins)
library(DT)
# filter penguin data frame where body_mass_g >=3000 and <=4000 ----
body_mass_df <-penguins %>%
  filter(body_mass_g %in% c(3000:4000))


# create scatterplot ----
ggplot(na.omit(body_mass_df), 
       aes(x = flipper_length_mm, y = bill_length_mm, 
           color = species, shape = species)) +
  geom_point() +
  scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" = "purple", "Gentoo" = "cyan4")) +
  scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
  labs(x = "Flipper length (mm)", y = "Bill length (mm)", 
       color = "Penguin species", shape = "Penguin species") +
  guides(color = guide_legend(position = "inside"),
         size = guide_legend(position = "inside")) +
  theme_minimal() +
  theme(legend.position.inside = c(0.85, 0.2), 
        legend.background = element_rect(color = "white"))

# create datatable ----

#practice with the entire dataframe
DT::datatable(penguins)

#filter fopr years 2007, 2008
penguins_0708 <- penguins %>%
  filter(year %in% c(2007:2008))

DT::datatable(penguins_0708)
