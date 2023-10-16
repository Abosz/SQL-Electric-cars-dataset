-- electric_vehicle_population_data definition

CREATE TABLE electric_vehicle_population_data (
	"VIN (1-10)" VARCHAR(50),
	County VARCHAR(50),
	City VARCHAR(50),
	State VARCHAR(50),
	"Postal Code" INTEGER,
	"Model Year" INTEGER,
	Make VARCHAR(50),
	Model VARCHAR(50),
	"Electric Vehicle Type" VARCHAR(50),
	"Clean Alternative Fuel Vehicle (CAFV) Eligibility" VARCHAR(64),
	"Electric Range" INTEGER,
	"Base MSRP" INTEGER,
	"Legislative District" INTEGER,
	"DOL Vehicle ID" INTEGER,
	"Vehicle Location" VARCHAR(50),
	"Electric Utility" VARCHAR(50),
	"2020 Census Tract" INTEGER
);

SELECT * FROM electric_vehicle_population_data evpd;

-- Checking for NULL values
SELECT * FROM electric_vehicle_population_data evpd WHERE City IS NULL;
SELECT * FROM electric_vehicle_population_data evpd WHERE State IS NULL;
SELECT * FROM electric_vehicle_population_data evpd WHERE Make IS NULL;

-- SOME EDA SCRIPTS

-- Which maker has the most cars?
SELECT Make, COUNT(Model) AS Quantity
FROM electric_vehicle_population_data evpd 
GROUP BY Make
ORDER BY Quantity DESC
LIMIT 10;

-- What kind of vehicle type there is the most?
SELECT "Electric Vehicle Type" , COUNT(Model) AS Quantity
FROM electric_vehicle_population_data evpd 
GROUP BY "Electric Vehicle Type"
ORDER BY Quantity DESC;

SELECT DISTINCT "Clean Alternative Fuel Vehicle (CAFV) Eligibility" 
FROM electric_vehicle_population_data evpd;

-- How many CAFV electric cars there are?
SELECT "Clean Alternative Fuel Vehicle (CAFV) Eligibility" AS CAFV_Eligibility, COUNT(Model) AS Quantity
FROM electric_vehicle_population_data evpd 
GROUP BY CAFV_Eligibility
ORDER BY Quantity DESC;

-- Which maker has the most Clean Alternative Fuel Vehicle Eligible cars?
SELECT Make, Count("Clean Alternative Fuel Vehicle (CAFV) Eligibility") AS Quantity
FROM electric_vehicle_population_data evpd 
WHERE "Clean Alternative Fuel Vehicle (CAFV) Eligibility" = "Clean Alternative Fuel Vehicle Eligible"
GROUP BY Make
ORDER BY Quantity DESC;

-- What are max, min and avg driving ranges for CAFV vehicles?
SELECT "Clean Alternative Fuel Vehicle (CAFV) Eligibility" AS CAFV_Eligibility, 
MAX("Electric Range") AS Max_range,
MIN("Electric Range") AS Min_Range,
AVG("Electric Range") AS Avg_Range
FROM electric_vehicle_population_data evpd
GROUP BY CAFV_Eligibility
ORDER BY Avg_Range DESC;

-- Which maker has max driving range and what are min and avg ranges of that maker?
SELECT Make, 
MAX("Electric Range") AS Max_range,
MIN("Electric Range") AS Min_Range,
AVG("Electric Range") AS Avg_Range
FROM electric_vehicle_population_data evpd
GROUP BY Make
ORDER BY Max_Range DESC
LIMIT 10;

-- Which model is most popular among each maker?
SELECT Make, Model, Count(Model) AS Quantity_of_each_model
FROM electric_vehicle_population_data evpd
GROUP BY Model
ORDER BY Quantity_of_each_model DESC;

-- What are MSRP bases for each model?
SELECT Make, MAX("Base MSRP") AS Max_MSRP, MIN("Base MSRP") AS Min_MSRP, AVG("Base MSRP") AS Avg_MSRP
FROM electric_vehicle_population_data evpd 
GROUP BY Make
ORDER BY Max_MSRP DESC;

SELECT Model, Count("Base MSRP") Values_0
FROM electric_vehicle_population_data evpd 
WHERE "Base MSRP" = 0
GROUP BY Model
ORDER BY Values_0 DESC;

-- CONCLUCIONS

/* Most cars has Tesla and later Nissan, Chevrolet, Ford and BMW.
 * The most popular electric cars are Battery Eletric Vehicles (BEV).
 * We have over 62 thousands CAFV cars, but almost 70k models needs to be researched.
 * The maker with the most CAFV cars is again Tesla.
 * Max range for CAFV car is 337km, min and avg ranges are as follows 30km and 156km.
 * The first 5 most popular car models are: Tesla MODEL Y and MODEL 3, Nissan Leaf, Tesla MODEL S and Chevrolet Bolt EV.
 * It is hard to calculate right MSRP prices, beacuse there are many 0 in dataset.
 */

