Uber India Rides Analytics 

End-to-end data analytics project on 100,000 Uber ride requests across 10 Indian cities, using MySQL, Python (pandas) and Power BI.

Objective

Understand where revenue comes from, how surge pricing and demand behave across the day, where rides are lost, and how customers pay, rate and tip.

Tools
Stage	Tool	Purpose
Clean and query	MySQL	Fix bad dates, remove invalid fares, fill missing ratings, run 5 business queries
Explore	Python (pandas, SQLAlchemy, PyMySQL)	Load the cleaned table and answer 5 further questions
Visualise	Power BI	Two-page dashboard: Revenue and Driver
Dataset

uber_rides_india_v2.csv: 100,000 rows, 20 columns, calendar year 2024.

Key columns: city, ride_type, status, distance_km, fare_amount, surge_multiplier, payment_method, rating, driver_id, hour, day_of_week, gender, Ubers Commission, Tips, is_complaint.

Of the 100,000 requests, 86,113 were completed, 10,020 cancelled and 3,867 had no driver found.

Data cleaning (SQL)
Issue	Rows	Treatment
Placeholder date 01-01-9999	3	Deleted; text date converted to DATETIME (pickup_ts)
Completed rides with fare = 0	2	Deleted
Completed rides with blank rating	1,500	Filled with the rounded average rating
Analysis

SQL: overall KPIs, city performance, ride type performance, hourly demand, cancellation rate by city.

Python: rides by payment method, average fare by ride type, normal vs surge fares, weekday vs weekend rides, top 10 drivers.

Power BI: revenue, commission, rating counts, gender split, ride type revenue, day-of-week revenue, ride status, tips and monthly revenue.

Key findings
Revenue: ₹11.26M from completed rides; Uber commission ₹1.41M (12.5% of fares); average fare ₹130.77.
Ride types: UberGo and UberXL generate 59% of revenue. UberXL earns ₹47 per km against ₹15 for UberMoto.
Cities: Mumbai, Delhi and Bangalore generate 49% of revenue. Average fares are nearly identical across cities (₹128 to ₹132), so volume drives the differences.
Surge: Applied only at 8 to 9 AM and 5 to 7 PM. Those hours hold 33% of rides but 39% of revenue, and surge rides pay about 41% more (₹169 vs ₹120).
Missed opportunity: 7 AM and 4 PM are among the busiest hours but run with no surge.
Lost demand: 10.0% of requests are cancelled and 3.9% find no driver, about ₹1.8M of potential revenue.
Payments and tips: UPI is used in 40% of rides; 35% of rides are tipped (₹1.29M in total).
Ratings: Average rating is 4.14 out of 5; 8% of ratings are 1 or 2 stars.
Demand pattern: Weekdays carry 71.5% of rides, which matches 5 of 7 days, so daily and monthly revenue is flat.
Recommendations
Reduce failed requests, starting with Mumbai, Kolkata and Hyderabad.
Test 1.2x surge at 7 AM and 4 PM, watching cancellations.
Promote UberXL and Premier on longer trips.
Build offers around UPI.
Study the 1 and 2 star ratings by driver and city.
Notes
The Power BI Average Rating card shows 3.50 because blank ratings were loaded as 0. The true average of rated rides is 4.14.
"Profit" in the dashboard is Uber's commission, not net profit.
The data looks synthetic and very regular, so seasonality and weekend conclusions should not be generalised.
Repository structure
├── data/        uber_rides_india_v2.csv
├── sql/         uber_analysiss.sql
├── notebooks/   uber projects.ipynb
├── powerbi/     Uber Analytics Power BI Dashboard.pbix, screenshots
├── report/      Uber_Analytics_Project_Report.docx, presentation
└── README.md
How to run
Create the MySQL database and import the CSV into a table named uber_rides_india.
Run sql/uber_analysiss.sql to clean the data and run the queries.
In the notebook, set your own MySQL password in the connection string (do not commit it), then run the cells.
Open the .pbix file in Power BI Desktop.

Author
Yuthika
