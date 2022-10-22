
library(tidyverse)
library(tidytext)
library(zoomGroupStats)

batchOut = batchProcessZoomOutput(batchInput="myMeetingsBatch.xlsx")

transcript <- batchOut$transcript %>% 
  as_tibble()

top_words <-transcript %>% 
  unnest_tokens(word, utteranceMessage) %>% 
  count(word) %>% 
  arrange(desc(n)) %>% 
  anti_join(stop_words)

top_words %>%
  filter(n > 25) %>%
  ggplot(aes(x = reorder(word,n), y = n)) +
  geom_col(color = "blue", fill = "blue" ) +
  labs(x = "word", y = "n")