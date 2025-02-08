install.packages("jsonlite")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("lubridate")
install.packages("stringr")
install.packages("tidytext")
install.packages("textdata")
install.packages("sentimentr")


library(jsonlite)
library(dplyr)
library(ggplot2)
library(lubridate)
library(stringr)
library(tidytext)
library(textdata)
library(sentimentr)

getwd()



  
#import the data into a data frame
  
covid_tweet_df <- read.csv("covidtweets.csv")



custom_covid_df <- data.frame(id = covid_tweet_df$id_str, 
                              created_at = covid_tweet_df$created_at,
                              lang = covid_tweet_df$lang,
                              text = covid_tweet_df$text,
                              screen_name = covid_tweet_df$screen_name,
                              name = covid_tweet_df$name,
                              favourites = covid_tweet_df$favourites_count,
                              statuses = covid_tweet_df$statuses_count,
                              followers = covid_tweet_df$followers_count,
                              friends = covid_tweet_df$friends_count,
                              user_created_at = covid_tweet_df$user_created_at)


#Reformat the created_at ANd user_created_at column as a data and time object
#and assign to a new data frame 
  


clean_covid_tweets_df <- custom_covid_df %>% 
  mutate(created_at = as.POSIXct(created_at, format = "%a %b %d %H:%m:%S + 0000 %Y")) %>%
  mutate(user_created_at = as.POSIXct(user_created_at, format = "%a %b %d %H:%m:%S + 0000 %Y"))

#Add columns for user_created_at details (year, month, day, hour, minute, second, wday)
  
clean_covid_tweets_df <- clean_covid_tweets_df %>%
  mutate(user_year= year(user_created_at),
        user_month= month(user_created_at),
        user_day= day(user_created_at),
        user_hour= hour(user_created_at),
        user_minute= minute(user_created_at),
        user_second= second(user_created_at),
        user_wday= wday(user_created_at))


# Remove URLS from the "text" colums in clean_



clean_covid_tweets_df <- clean_covid_tweets_df %>% mutate(text = str_remove(text, "http://*|https://*")) %>%
  mutate(text = str_remove(text, "RT"))                                                   


profanity_list <- unique(tolower(lexicon::profanity_alvarez))

covid_words_df <- clean_covid_tweets_df %>% 
    dplyr::select(text) %>% 
    unnest_tokens(word, text) %>% 
    anti_join(stop_words) %>%
    #anti_join(data.frame(profanity_list)) %>% 
    filter(!word %in% c("rt", "t.co", profanity_list))

covid_words_df %>% 
  count(word, sort = T) %>% 
  top_n(20) %>% 
  mutate(word = reorder(word,n)) %>% 
  ggplot(aes(x = word, y = n)) +
  geom_col()+
  xlab(NULL)+
  coord_flip()+
  labs(x="count", y= "Words",
       title = "Top 20 Words tweeted in covid_words_df  ")

#Number of tweets by hours user was created
ggplot(clean_covid_tweets_df, aes(x = user_hour))+
  geom_bar(aes(fill = ..count..))+
  theme(legend.position = "none") +
  xlab("Hour")+
  ylab("Number of Tweets")+
  scale_fill_gradient(high = "navy", low = "blue")



ggplot(clean_covid_tweets_df, aes(x = user_hour))+
  geom_bar(aes(fill = ..count..))+
  theme(legend.position = "none") +
  xlab("Hour")+
  ylab("Number of Tweets")+
  scale_fill_gradient(high = "orange", low = "chartreuse")

#Number of tweets by Minute
ggplot(clean_covid_tweets_df, aes(x = user_minute))+
  geom_bar(aes(fill = ..count..))+
  theme(legend.position = "none") +
  xlab("Minute")+
  ylab("Number of Tweets")+
  scale_fill_gradient(high = "orange", low = "chartreuse")

#Number of tweets by year
ggplot(clean_covid_tweets_df, aes(x = user_year))+
  geom_bar(aes(fill = ..count..))+
  theme(legend.position = "none") +
  xlab("Year")+
  ylab("Number of Tweets")+
  scale_fill_gradient(high = "skyblue", low = "turquoise4")

#Number of tweets by month
ggplot(clean_covid_tweets_df, aes(x = user_month))+
  geom_bar(aes(fill = ..count..))+
  theme(legend.position = "none") +
  xlab("Month")+
  ylab("Number of Tweets")+
  scale_fill_gradient(high = "maroon", low = "maroon1")

#Number of tweets by Year and month
ggplot(clean_covid_tweets_df)+
  geom_jitter(aes(x = user_year, y = user_month))


#Number of tweets by Hour and Minute
ggplot(clean_covid_tweets_df)+
  geom_jitter(aes(x = user_hour, y = user_minute))


ggplot(clean_covid_tweets_df, aes(x = user_wday))+
  geom_bar(aes(fill = ..count..))+
  theme(legend.position = "none") +
  xlab("Day of the Week")+
  ylab("Number of Tweets")+
  scale_fill_gradient(high = "gold3", low = "yellow")


#Number of tweets by Day of the week and hour
ggplot(clean_covid_tweets_df)+
  geom_jitter(aes(x = user_wday, y = user_hour))

























