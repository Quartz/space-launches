# library(RSQLite)
# 
# sqlite.driver <- dbDriver("SQLite")
# db <- DBI::dbConnect(sqlite.driver, dbname = "launches.db")
# 
# tables <- dbListTables(db)
# 
# launches <- dbReadTable(db,tables[1])
# orgs <- dbReadTable(db,tables[2])
# 

launches <- read_csv('results/launches.csv')
orgs <- read_csv('results/orgs.csv')
sites <- read_csv('results/sites.csv')


launches$year <- as.integer(str_sub(launches$tag, 1,4)) 
launches$launch_type <- str_sub(launches$launch_code, 1,2) 
launches$launch_status <- str_sub(launches$launch_code, 2) 
sites %>%
  filter(tstart == '-') %>%
  View()

# process SITES to get unique ID for siteID <> location
sites$start_year = as.integer(str_sub(sites$tstart, 1,4))

sites_tomatch <- sites %>%
  filter(site!='#') %>%
  filter(!is.na(longitude)) %>%
  group_by(site) %>%
  mutate(latest_start_date = max(start_year, na.rm = T)) %>%
  filter(start_year == latest_start_date | is.na(start_year)) %>% # only take the site of the latest phase
  mutate(longitude = as.numeric(longitude), latitude = as.numeric(latitude)) %>%
  filter(!is.na(longitude)) %>% # take out 25 sites -- minor sites related to Zubov Expedition
  group_by(site, parent, location) %>%
  summarise(longitude = mean(longitude, na.rm=T), 
            latitude = mean(latitude, na.rm=T)
            ) %>%
  ungroup() %>%
  mutate(launch_site = site) %>%
  select(-site)


tomap <- launches %>%
  left_join(sites_tomatch) %>%
  select(year, launch_site, location, longitude, latitude, parent) %>%
  filter(!is.na(location))
  

library(mapdata)
world <- map_data('world')

sample_map <- ggplot()+ 
  geom_map(data=world, map=world,
           aes(x=long, y=lat, group=group, map_id=region),
           fill="white", colour="#7f7f7f", size=0.3)+
  geom_point(data = tomap,
           aes(x=longitude, y=latitude), color = 'red', alpha = 0.1)+
  coord_fixed(1.3)+
  theme_minimal()

ggsave('sample_map.pdf', width=12, height = 12/1.3)
  

# top_launchers = c('US','SU','RU','J','UK','IN','F','CA','D','AU')
# launches %>%
#   select(year, agency) %>%
#   mutate(ucode = agency) %>%
#   left_join(orgs) %>%
#   group_by(name) %>%
#   count() %>%
#   arrange(desc(n))
#   filter(!is.na(state_code)) %>%
#   filter(state_code %in% top_launchers) %>%
#   # group_by(state_code) %>%
#   # summarise(launch_count = sum(n, na.rm=T)) %>%
#   # arrange(desc(launch_count))
#   ggplot()+
#   geom_line(aes(x=year, y=n, group=state_code, color=state_code))
# 
# 
# launches %>%
#   select(year, agency) %>%
#   mutate(ucode = agency) %>%
#   left_join(orgs) %>%
#   group_by(year, class) %>%
#   count() %>%
#   filter(!is.na(class)) %>%
#   # filter(state_code %in% top_launchers) %>%
#   # group_by(class) %>%
#   # summarise(launch_count = sum(n, na.rm=T)) %>%
#   # arrange(desc(launch_count)) %>%
#   ggplot()+
#   # geom_bar(aes(x=class,y=launch_count),stat='identity') %>%
#   
#   geom_line(aes(x=year, y=n, group=class, color=class))
# 
# 
# 
# double_names <- (orgs %>%
#   group_by(ucode, state_code) %>%
#   count() %>%
#   group_by(ucode) %>%
#   summarise(count = n()) %>%
#   filter(count >1))$ucode
# 
# orgs %>%
#   group_by(ucode, state_code) %>%
#   count() %>%
#   filter(ucode %in% double_names) %>%
#   View()
