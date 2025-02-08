#### **COVID-19 Twitter Data Analysis**  

##### **Overview**  
This project analyzes a dataset of COVID-19-related tweets using R. The analysis involves data cleaning, transformation, and visualization of tweet patterns over time. We explore user activity based on timestamps, text processing, and sentiment analysis to understand public discourse.

##### **Technologies Used**  
- **R Programming**  
- **Libraries:** `jsonlite`, `dplyr`, `ggplot2`, `lubridate`, `stringr`, `tidytext`, `textdata`, `sentimentr`  
- **Data Visualization:** ggplot2  
- **Text Processing:** tidytext, stringr  
- **Sentiment Analysis:** sentimentr  

##### **Key Features**  
1. **Data Cleaning & Preprocessing**  
   - Imported a CSV file containing COVID-19 tweets  
   - Reformatted date-time columns (`created_at`, `user_created_at`)  
   - Extracted time-based features (year, month, day, hour, minute, second, weekday)  
   - Removed URLs and common stopwords  
   - Filtered out profanity from tweets  

2. **Text Analysis & Sentiment Processing**  
   - Tokenized tweet text into individual words  
   - Counted word frequencies and visualized the top 20 words  
   - Applied sentiment analysis to understand tweet emotions  

3. **Data Visualization**  
   - Created bar plots to analyze tweet frequency by hour, minute, day, month, and year  
   - Used jitter plots to explore trends in tweet activity across different time intervals  

##### **Setup Instructions**  
1. Install R and RStudio  
2. Install required libraries:  
   ```r
   install.packages(c("jsonlite", "dplyr", "ggplot2", "lubridate", "stringr", "tidytext", "textdata", "sentimentr"))
   ```
3. Run `DateTimeAnalysis.R` in RStudio  
4. Load the dataset (`covidtweets.csv`) and execute the script  

##### **Results & Insights**  
- Most tweets were posted at specific hours, revealing peak engagement times.  
- Text analysis showed common words used in COVID-related tweets.  
- Sentiment analysis identified positive and negative trends in public discussions.  
