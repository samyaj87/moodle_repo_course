# load packages
# CC ILYA Kashnitsky
library(tidyverse)
library(extrafont)
myfont <- 'Ubuntu Mono' 

# download data
df_swe <- read_csv("http://www.rostock-retreat.org/files/application2017/SWE.csv")
# copy at https://ikashnitsky.github.io/doc/misc/application-rostock-retreat/SWE.csv

# define the selection of years to visualize
years <- c(seq(1965, 2010, 5),2014)

df <- df_swe %>% select(Year, Sex, Age, Exposure, ex) %>% 
  filter(Year %in% years) %>% 
  mutate(old_c = Age >= 65, 
         old_p = ex <= 15) %>% 
  gather("type", "old", contains("old")) %>% 
  group_by(Year, Sex, type) %>% 
  mutate(share = Exposure / sum(Exposure)) %>% 
  ungroup() %>% 
  mutate(share = ifelse(Sex == 'f', share, -share))

names(df) <- names(df) %>% tolower()


df_old <- df %>% filter(old == T) %>% 
  group_by(year, sex, type, old) %>% 
  summarise(cum_old = sum(share)) %>% 
  ungroup() 


gg_three <- ggplot(df %>% filter(year %in% c(1965, 1990, 2014))) +
  geom_bar(aes(x = age, y = share, fill = sex, alpha = old), 
           stat = 'identity', width = 1)+
  geom_vline(xintercept = 64.5, size = .5, color = 'gold')+
  scale_y_continuous(breaks = c(-.01, 0, .01), labels = c(.01, 0, .01),
                     limits = c(-.02, .02), expand = c(0,0))+
  facet_grid(year~type) +
  theme_minimal(base_family = 'Ubuntu Mono') +
  theme(strip.text = element_blank(),
        legend.position = 'none',
        plot.title = element_text(hjust = 0.5, size = 20),
        plot.caption = element_text(hjust = 0, size = 10)) + 
  coord_flip() + 
  
  labs(y = NULL,
       x = 'Age') +
  
  geom_text(data = data_frame(type = c('old_c', 'old_p'),
                              label = c('CONVENTIONAL', 'PROSPECTIVE')),
            aes(label = label), 
            y = 0, x = 50, size = 5, vjust = 1, 
            family = 'Ubuntu Mono') +
  
  geom_text(data = df_old %>% filter(year %in% c(1965, 1990, 2014), sex == 'f'), 
            aes(label = year),
            y = 0, x = 30, vjust = 1, hjust = .5, size = 7, 
            family = 'Ubuntu Mono') +
  
  geom_text(data = df_old %>% filter(year %in% c(1965, 1990, 2014), sex == 'f'), 
            aes(label = paste('Elderly\nfemales\n', round(cum_old*100,1), '%')),
            y = .0125, x = 105, vjust = 1, hjust = .5, size = 4, 
            family = 'Ubuntu Mono') +
  
  geom_text(data = df_old %>% filter(year %in% c(1965, 1990, 2014), sex == 'm'), 
            aes(label = paste('Elderly\nmales\n', round(-cum_old*100,1), '%')),
            y = -.0125, x = 105, vjust = 1, hjust = .5, size = 4, 
            family = 'Ubuntu Mono')


#ggsave("figures/three-years.png", gg_three, width = 6, height = 8)