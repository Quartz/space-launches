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

launches$year <- as.integer(str_sub(launches$tag, 1,4)) 
launches$launch_type <- str_sub(launches$launch_code, 1,2) 
launches$launch_status <- str_sub(launches$launch_code, 2) 

top_launchers = c('US','SU','RU','J','UK','IN','F','CA','D','AU')
launches %>%
  select(year, agency) %>%
  mutate(ucode = agency) %>%
  left_join(orgs) %>%
  group_by(year, state_code) %>%
  count() %>%
  filter(!is.na(state_code)) %>%
  filter(state_code %in% top_launchers) %>%
  # group_by(state_code) %>%
  # summarise(launch_count = sum(n, na.rm=T)) %>%
  # arrange(desc(launch_count))
  ggplot()+
  geom_line(aes(x=year, y=n, group=state_code, color=state_code))


launches %>%
  select(year, agency) %>%
  mutate(ucode = agency) %>%
  left_join(orgs) %>%
  group_by(year, class) %>%
  count() %>%
  filter(!is.na(class)) %>%
  # filter(state_code %in% top_launchers) %>%
  # group_by(class) %>%
  # summarise(launch_count = sum(n, na.rm=T)) %>%
  # arrange(desc(launch_count)) %>%
  ggplot()+
  # geom_bar(aes(x=class,y=launch_count),stat='identity') %>%
  
  geom_line(aes(x=year, y=n, group=class, color=class))



double_names <- (orgs %>%
  group_by(ucode, state_code) %>%
  count() %>%
  group_by(ucode) %>%
  summarise(count = n()) %>%
  filter(count >1))$ucode

orgs %>%
  group_by(ucode, state_code) %>%
  count() %>%
  filter(ucode %in% double_names) %>%
  View()
