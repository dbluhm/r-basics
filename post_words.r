IGdata<- read.csv("posts_processed.csv")

IG_topwords <- IGdata %>%
  unnest_tokens(word, title) %>%
  count(word) %>%
  arrange(desc(n)) %>%
  anti_join(stop_words)

IG_topwords %>%
  filter(n > 50) %>%
  ggplot(aes(x = reorder(word,n), y = n)) +
  geom_col(color = "blue", fill = "blue" ) +
  labs(x = "word", y = "n")