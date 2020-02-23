
library(pacman)
p_load(tidyverse,tmap,countrycode)

data("World")

tm_shape(World) +
  tm_polygons("HPI")

data = read_csv("DATA/Wuhan-2019-nCoV.csv")
data %>% 
  group_by(countryCode) %>% 
  summarise_at(vars(confirmed:dead),sum) %>% 
  mutate(iso_a3 = countrycode(countryCode,
                              origin = "genc2c",
                              destination = "iso3c")) %>% 
  left_join(World,.) -> new_world

type = c("confirmed","suspected","cured","dead")
tm_shape(new_world) +
  tm_polygons(type,
              breaks = c(seq(0,400,100),Inf),
              #n = 5,
              palette = "viridis")

# p_load(sf,hrbrthemes,worldtilegrid)
# install.packages("worldtilegrid", repos = "https://cinc.rud.is")
# df <- read_sf('DATA/world.geo.json')
# ggplot(df) + 
#   geom_sf(aes(fill = name), color = "white", size = 0.08) + 
#   scale_fill_viridis_d() + 
#   theme_modern_rc(base_family = "Times New Roman") + 
#   worldtilegrid::theme_enhance_wtg() +
#   theme(legend.position = "none") + 
#   labs(title = "World Map")


