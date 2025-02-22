select * from blinkit_sales;
select count(*) from blinkit_sales;

              # make the data in a proper format by updating the column Itam_fat_column

UPDATE blinkit_sales
SET item_fat_contant = 
    CASE 
        WHEN item_fat_contant IN ('LF', 'low fat') THEN 'Low Fat'
        WHEN item_fat_contant = 'reg' THEN 'Regular'
        ELSE item_fat_contant
    END;


			  # (Q1) Kpi - Total sales -  The overall revenue generated from all items sold.
select cast(sum(Total_sales)/1000000 as decimal(10,2)) as 
total_sales_milions from blinkit_sales ;

			  # (Q2) Kpi - Average Sales: The average revenue per sale.

select cast(avg(Total_sales) as decimal(10,0)) as 
avg_sales_rs from blinkit_sales ;
 
			    #(Q3) Kpi - Number of Items: The total count of different items sold
             
select count(*) from blinkit_sales ;

			   #(Q4) Kpi - Average Rating: The average customer rating for items sold

select cast(avg(Rating) as decimal(10,0)) as avg_rating from blinkit_sales ;

## (Q1) Total Sales by Fat Content
  #Objective: Analyze the impact of fat content on total sales.

select item_fat_contant,sum(Total_Sales),
	avg(Total_Sales),count(Item_Identifier),
	avg(Rating) from blinkit_sales
group by item_fat_contant ;

## (Q2) Total Sales by Item Type
  #Objective: Identify the performance of different item types in terms of total sales

select* from blinkit_sales;
select Item_Type,sum(Total_Sales) as sum_total_sale,
	cast(avg(Total_Sales) as decimal(10,2)) as avg_sales,
    count(Item_Identifier)
	from blinkit_sales
group by Item_Type order by sum_total_sale asc;

	## (Q3) Total Sales by Outlet Establishment:
	##Objective: Evaluate how the age or type of outlet establishment influences total sales.
   
select* from blinkit_sales;
select Outlet_Establishment_Year,sum(Total_Sales) as sum_total_sale,
	cast(avg(Total_Sales) as decimal(10,2)) as avg_sales,
    count(Item_Identifier)
	from blinkit_sales
group by Outlet_Establishment_Year order by Outlet_Establishment_Year;

## (Q4) Percentage of Sales by Outlet Size:
	## Objective: Analyze the correlation between outlet size and total sales.
    
select* from blinkit_sales;
select Outlet_Size,cast(avg(Total_Sales) as decimal(10,2)) as avg_sales,
    count(Item_Identifier),sum(Total_Sales) as sum_total_sale,
    concat(cast(sum(Total_Sales)*100/sum(sum(Total_Sales)) over() as decimal(10,2)),'%')  as sales_percentage
	from blinkit_sales
group by Outlet_Size ;

# (Q5) Sales by Outlet Location:
	#Objective: Assess the geographic distribution of sales across different locations.
    
select* from blinkit_sales;
select Outlet_Location_Type,
	sum(Total_Sales) as total_sales,
    concat(cast(sum(Total_Sales)*100/sum(sum(Total_Sales)) over() as Decimal(10,2)),'%') as percentage_sales
    from blinkit_sales
group by Outlet_Location_Type;

## (Q6) All Metrics by Outlet Type:
	## Objective: Provide a comprehensive view of all key metrics (Total Sales, Average Sales, Number of Items, Average Rating) broken down by different outlet types.

select* from blinkit_sales;
select Outlet_Type,sum(Total_Sales)  as total_sales,
	avg(Total_Sales) as avg_sales,count(Item_Type),cast(avg(Rating) as decimal(10,2)) avg_rating
    from blinkit_sales
    group by Outlet_Type;

###--------------------------------------------------Completed---------------------------------------------------------------------------------

















