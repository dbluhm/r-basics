library(tidyverse)
library(tidytext)
library(zoomGroupStats)

batchOut = batchProcessZoomOutput(batchInput="myMeetingsBatch.xlsx")

transcript <- batchOut$transcript %>% 
  as_tibble()

mean_utterance_duration_and_n_utterances <- transcript %>% 
  mutate(utterance_duration = utteranceEndTime-utteranceStartTime) %>% 
  group_by(userName) %>%
  summarize(mean_utterance_duration = mean(utterance_duration),
            n_utterances = n()) %>%
  arrange(desc(mean_utterance_duration))

mean_utterance_duration_and_n_utterances %>% 
  ggplot(aes(x = userName, y = mean_utterance_duration, fill = n_utterances)) +
  geom_col(color = "blue", fill = "blue") +
  labs(x = "Username", y = "Mean Utterance Duration") +
  theme(axis.text.x = element_text(angle = -45, vjust = 1, hjust=0)) +
  theme(plot.margin = margin(t = 0, r = 35, b = 0, l = 0, unit = "pt"))
