

install.packages("tidyverse")
library(tidyverse)
library(readr)
library(dplyr)
library(ggplot2)

 data<- read_csv("C:/Users/Polle/Downloads/agricultural_data (1).csv")
 print(data)
 
 # Check for missing values
 missing_values <- colSums(is.na(data))
 print("Missing values in each column:")
 print(missing_values)
 
 #removing column 7 and 8
 data <- data[, -c(7, 8)]
 # Display modified data
 print("Modified Data:")
 print(data)
 
 # Remove rows with missing values
 data_cleaned <- na.omit(data)
 
 #Check the structure of the data to ensure 
 print("Structure of data")
 print(data_cleaned)
 
 #Summary statistics of the dataset 
 print("Summary Statistics of the Dataset:")
 summary(data_cleaned)
 
 #Summary of production quantities and price 
 print("Summary of Production Quantity and Price:")
 summary(data_cleaned[c("Production_Quantity", "Price_Per_Unit")])
 
 #Group data by Crop_Name and summarize production quantity 
 production_summary <- data_cleaned %>%
   group_by(Crop_Name) %>%
   summarize(Total_Production_Quantity = sum(Production_Quantity, na.rm = TRUE))
 print("Production Quantity Summary by Crop:")
 print(production_summary)
 
 
 #Display the most productive crops 
 most_productive_crops <- production_summary %>%
   arrange(desc(Total_Production_Quantity))
 print("Most Productive Crops:")
 print(most_productive_crops)
 
# Group data by Region to find the most productive region 
 region_summary <- data_cleaned %>%
   group_by(Region) %>%
   summarize(Total_Production_Quantity = sum(Production_Quantity, na.rm = TRUE))
 most_productive_region <- region_summary %>%
   arrange(desc(Total_Production_Quantity))
 print("Most Productive Regions:")
 print(most_productive_region)
 
 #Display the most productive region 
 most_productive_region <- region_summary %>%
   arrange(desc(Total_Production_Quantity)) %>%
   slice(1)  # Selects the first row
 print("Most Productive Region:")
 print(most_productive_region)
 
 library(ggplot2)
 #Plot Production Quantity by Crop 
ggplot(most_productive_crops, aes(x = reorder(Crop_Name, -Total_Production_Quantity),
                                   y = Total_Production_Quantity, fill = Crop_Name)) +
   geom_bar(stat = "identity") +
   labs(title = "Total Production Quantity by Crop",
        x = "Crop Name",
        y = "Total Production Quantity") +
   theme_minimal() +
   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
   scale_fill_manual(values = rainbow(n = nrow(most_productive_crops)))
 
 #Plot Price vs. Production Quantity 
ggplot(data_cleaned, aes(x = Production_Quantity, y = Price_Per_Unit, color = Crop_Name)) +
   geom_point(size = 3, alpha = 0.7) +
   geom_smooth(method = "lm", se = FALSE, color = "black") +  # Straight correlation line
   labs(title = "Price vs. Production Quantity by Crop",
        x = "Production Quantity",
        y = "Price Per Unit") +
   theme_minimal() +
   scale_color_discrete(name = "Crop Name")

 
 
 
 #Plot Production by Region 
  ggplot(region_summary, aes(x = reorder(Region, -Total_Production_Quantity), y = Total_Production_Quantity, fill = Region)) +
   geom_bar(stat = "identity") +
   labs(title = "Total Production Quantity by Region",
        x = "Region",
        y = "Total Production Quantity") +
   theme_minimal() +
   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
   scale_fill_manual(values = rainbow(n = nrow(region_summary)))

 
 #Linear regression model
 linear_model <- lm(Price_Per_Unit ~ Production_Quantity, data = data_cleaned)
 
 #Summary of the model 
 model_summary <- summary(linear_model)
 print("Summary of the Linear Regression Model:")
 print(model_summary)
 
 #Print predicted prices 
 new_data <- data.frame(Production_Quantity = c(3000, 5000, 7000, 9000, 11000))
 library(dplyr)
 predicted_prices <- predict(linear_model, newdata = new_data)
 predictions <- new_data %>%
   mutate(Predicted_Price = predicted_prices)
 
 #Print predicted prices 
 print("Predicted Prices based on Future Production Quantities:")
 print(predictions)
 
 # Group by Harvest_Season and summarize production and price 
 harvest_summary <- data_cleaned %>%
   group_by(Harvest_Season) %>%
   summarize(
     Total_Production_Quantity = sum(Production_Quantity, na.rm = TRUE),
     Average_Price_Per_Unit = mean(Price_Per_Unit, na.rm = TRUE)
   )
 
 # Display summary by season 
 print("Harvest Season Summary:")
 print(harvest_summary)
 
 # Visualize production and price trends by season 
 ggplot(harvest_summary, aes(x = Harvest_Season)) +
   geom_line(aes(y = Total_Production_Quantity, color = "Total Production Quantity", group = 1), linewidth = 1) +
   geom_line(aes(y = Average_Price_Per_Unit * 100, color = "Average Price Per Unit", group = 1), linewidth = 1) +  # Scale price for visibility
   scale_y_continuous(
     name = "Total Production Quantity",
     sec.axis = sec_axis(~./100, name = "Average Price Per Unit")  # Create a second axis for price
   ) +
   labs(
     title = "Production and Price Trends by Season",
     x = "Harvest Season",
     color = "Legend"
   ) +
   theme_minimal() +
   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
   scale_color_manual(values = c("Total Production Quantity" = "blue", "Average Price Per Unit" = "red"))
 
 