Create database ins;
use ins;

select * from brokerage;
select * from fees;
select * from `individual budgets`;
select * from invoice;
select * from meeting;
select * from opportunity;

#--------------------Q1 No of Invoice by Account Executive--------------------
select `Account Executive`, if(income_class = "", "Null", income_class)income_class, count(income_class)  from invoice
group by `Account Executive`, income_class
order by `Account Executive`;

#---------------------Q2 Yearly Meeting Count----------------------------
select * from meeting;
select right(meeting_date,4)`year`,count(`Account Executive`)meeting_no from meeting
group by `year`;

#--------------------Q3 Target Achieve Invoice  ------------------------
# Cross Sell
select sum(amount)Target from brokerage
where income_class = 'Cross Sell';
select sum(`Cross sell bugdet`)Achieved from `individual budgets`;
select sum(amount)Invoice from invoice
where income_class = 'Cross Sell';

# Renewal
select sum(amount)Target from brokerage
where income_class = 'Renewal';
select sum(`Renewal Budget`)Achieved from `individual budgets`;
select sum(amount)Invoice from invoice
where income_class = 'Renewal';

# New
select sum(amount)Target from brokerage
where income_class = 'New';
select sum(`New Budget`)Achieved from `individual budgets`;
select sum(amount) from invoice
where income_class = 'New';

#-------------Q4 Stage Funnel by Revenue---------------
select * from opportunity;
select stage, sum(revenue_amount) from opportunity
group by stage;

#--------------------------Q5 No of meeting By Account Exe----------------------------
select `Account Executive`, count(`Account Executive`) from meeting
group by `Account Executive`;

#-------------------------Q6 Top Open Opportunity-------------------------------
select distinct(stage) from opportunity;
select opportunity_name, sum(revenue_amount),stage, dense_rank() over(order by sum(revenue_amount)desc)`Rank` from opportunity
where stage  in ('Qualify Opportunity','Propose Solution')
group by opportunity_name,stage;

#-------------------------Q7 Top opportunity------------------------------
select distinct(stage) from opportunity;
select opportunity_name, sum(revenue_amount),stage, dense_rank() over(order by sum(revenue_amount)desc)`Rank` from opportunity
group by opportunity_name,stage;

