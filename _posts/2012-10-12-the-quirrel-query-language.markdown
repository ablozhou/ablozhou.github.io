---
author: abloz
comments: true
date: 2012-10-12 03:57:28+00:00
layout: post
link: http://abloz.com/index.php/2012/10/12/the-quirrel-query-language/
slug: the-quirrel-query-language
title: Quirrel查询语言
wordpress_id: 1901
categories:
- 技术
tags:
- quirrel
---


Quirrel语言是针对大数据的一种查询分析语言，同时他也是开放标准和规范。原生支持json，数据以集合的方式处理。目前貌似只有precog （http://precog.com/） 公司支持。





# getting started







# JSON


Quirrel has native support for JSON. You can create strings, numbers, booleans, arrays, and objects just like you do in JavaScript.




{name: "John", age: 29, gender: "male"}
[{name: "John", age: 29, gender: "male"}]

true
[true]

"hello world"
["hello world"]






# NUMBERS


Quirrel is designed for analytics, so it has very good support for math. In fact, you can use Quirrel as a calculator.




5 + 2
[7]

8 * 2
[16]




Quirrel has an extensive built-in library of mathematical functions. Check the reference guide to see them all.


# BOOLEANS


Quirrel supports equality and inequality operators, which result in boolean values. These operators are often used to filter sets of data (a topic covered later).




5 > 2
[true]

"foo" != "foo"
[false]




The full list of equality/inequality operators includes = (equal), != (not equal), < (less than), > (greater than), and variants like <= and >=.


# VARIABLES


You can store intermediate results in variables to make your queries more readable. The final expression determines what is returned by the query.




total := 2 + 1
total * 3
[9]

num := 4
square := num * num
square - 1
[15]






# LOADING DATA


The most basic query you can do is to retrieve raw data. To do this, use the _load_ function, and specify the path to load data from.




//conversions
[{"product": {"ID": "0232C378","price": 0.99}, "timeStamp": "2010-01-01T00:52:03", ...]




The load function returns all the data stored at the specified path, even if the values have differing types or schemas.


# FILTERED DESCENT


Quirrel has direct support for JavaScript's _object dereference_ and _array dereference_ operators. These operations implicitly filter the dataset to those items that are contained in the specified field or array index.




conversions := //conversions
conversions.product.price
[0.99, 7.99, 13.99, 0.99, 9.99, 12.99, ...]

arrayOfColors := ["red", "blue", "green", "purple"]
arrayOfColors[2]
["green"]






# REDUCTIONS


Quirrel can reduce sets of data into a single value. There are many built-in reductions.




count(//conversions)
[25406]

mean(//conversions.customer.income)
[90555.64]

sum(//conversions.product.price)
[218323.94]




See the Quirrel reference guide for documentation on all supported reductions.


# SETS OF EVENTS


In Quirrel, every expression is a set of events. Each event contains a globally unique identity and a JSON value. Every value you store gets its own unique identity. Identities are hidden (you'll never see them), but they are used internally by Quirrel.


# IDENTITY MATCHING


All functions and operators in Quirrel operate on sets of events, not values. When you add two sets (for example), Quirrel finds the events whose identities match, and adds their values, to produce a new set.




medals := //summer_games/london_medals
medals.G+ medals.S + medals.B
[0.5, 1, 1, 1.33 ,1 ,0.5, ...]




The set-oriented nature of Quirrel lets you perform bulk operations without having to iterate over elements. This property is also what makes it possible to efficiently distribute Quirrel queries across clusters of machines.


# VALUES


Quirrel implicitly converts values like "0.10" or "male" into sets containing a single event. These events have so-called _bottom identity_, which matches against all identities.




conversions := //conversions
conversions.product.price * 0.10
[0.099, 0.799, 1.399, 0.099, 0.999, 1.299, ...]




In this example, all values in the _conversions.product.price_ set are multiplied by 0.10, because the 0.10 event has bottom identity and therefore matches with all events in the "conversions.product.price" set.


# FILTERING


Quirrel has a "where" operator which allows you to filter one set by another set of boolean values.




conversions := //conversions
count( conversions where conversions.customer.income < 20000)
[619]

conversions := //conversions
segment := conversions.customer.age > 19 & conversions.customer.age < 30 & conversions.customer.income > 60000
count(conversions where segment)
[211]




The _where_ operator in Quirrel is not magical -- it's simply a function from two sets (one of which is a boolean set) to one set. You can store the boolean set in a variable if you want to use it multiple times.


# CHAINING


Quirrel lets you chain expressions together without any limitations. This lets you easily perform multi-step analytical queries.




conversions := //conversions
bound := 1.5 * stdDev(conversions.customer.age)
avg := mean(conversions.customer.age)
olderDemographic := conversions where conversions.customer.age > (avg + bound)
olderDemographic.customer.ID

["1F1DF1B4", "1D5E2800", "176934B8", ...]




This query identifies customers who are older than the normal age demographic.


# USER-DEFINED FUNCTIONS


Quirrel lets you create user-defined functions, which map from one or more values to sets. These functions are often used to perform analytical queries on a group of related values. They can also be used to factor out logic that's common across different queries.




billing := //billing
billsForCustomer(customerID) := billing where billing.customer.ID = customerID

billsForCustomer("1D7A8ACC")

[{"date": "2010-01-01","product": {"ID": "0232C378","price": 0.99},"customer":
{"isCasualGamer": false,"age": 41,"ID": "1D7A8ACC","state": "SC"}},...]




This function returns all the billing data for a given customer ID.


# SOLVE STATEMENTS, PART I


Instead of calling a function on a specific instance of a parameter, it is possible to evaluate a statement at all possible values of a parameter in Quirrel by using a solve statement. All possible values of a parameter in a solve statement are determined by the constraints. In the example below, there will be one value for 'age for each value in london.Age. Quirrel will then merge the results into a single set.




london := //summer_games/london_medals
solve 'age
{age: 'age, medalWinnersByAge: count(london where london.Age = 'age)}

[{"age": 15,"medalWinnersByAge": 4},{"age": 16,"medalWinnersByAge": 7},...]




This query results in a set with two columns. The first will be called "age" and contain each age; the second will be called "medalWinnersByAge" and contain the count of the medal winners for that age.


# SOLVE STATEMENTS, PART II


Sometimes it is useful to filter or otherwise reuse the results of a solve statement. When this is desired, the solve statement can be assigned to a variable.




london := //summer_games/london_medals
winnersByAge := solve 'age
{age: 'age, medalWinnersByAge: count(london where london.Age = 'age)}
winnersByAge where winnersByAge.age > mean(winnersByAge.age)

[{"age": 34,"medalWinnersByAge": 18},{"age": 35,"medalWinnersByAge": 13},...]




This query returns also returns the number of medal winners for each age, but this time the results are
filtered so that only the results where the age is above the average age are returned.


# SOLVE STATEMENTS, PART III


Solve statements also support solving for multiple tic variables by separating each tic variable with a comma.




import std::time::*
clicks := //clicks
clicks' := clicks with {week: weekOfYear(clicks.timeStamp)}

solve 'gender, 'week
{week: 'week,
gender: 'gender,
clicks: count(clicks' where clicks'.customer.gender = 'gender & clicks'.week = 'week)}

[{"gender": "female","clicks": 208,"week": 1},{"gender": "female","clicks": 177,"week": 2},...]




This query returns the number of clicks for each gender and week. So there is a an object for week 1, female and and object for week 1, male and so on.


# SOLVE STATEMENTS, PART IV


Solve statements can also have contraints specified in the declaration of the statement.




billing := //billing
billing' := billing where billing.date = "2010-03-17"
clicks := //clicks

solve 'ID = billing'.customer.ID
{customerID: 'ID, clicks: count(clicks where clicks.customer.ID = 'ID)}

[{"count": 1,"customerID": "1230D75C"},{"count": 1,"customerID": "12377350"},...]




This query counts the number of clicks for each customer ID that is in both billing'.customer.ID and in clicks.customer.ID.


# AUGMENTATION


You can easily add more fields to objects, or more elements to arrays, with the _with_ operator.




clicks := //clicks
clicksWithDays := clicks with {day: (std::time::dayOfYear(clicks.timeStamp)) }
clicksWithDays

[{"product": {"ID": "0169F53E", "price": 7.99}, "timeStamp": "2010-01-01T00:00:21", "marketing": {"bounceRate": 0.79,
"pageViews": 2602, "referral": "direct", "blogComments": 17, "uniqueVisitors": 850, "blogViews": 235},"day": 1}, ...]




In this query, a "day" field is added to the clicks objects.


# JOINS


The most complicated operator in Quirrel is the relate operator 'relate', which joins together sets that don't share identities, and allows you to perform operations on the joined sets.




billing := //billing
clicks := //clicks

billing ~ clicks
{ bounce: clicks.bounceRate, customer: billing.customer, product:billing.productID }
where clicks.product.ID = billing.product.ID




The above query relates the clicks and billing sets and then creates a set containing data from both clicks and billing. The relate operator is similar to SQL's JOIN operator, but more powerful.


# SELF-JOINS


Quirrel makes it easy to do self-joins by providing the 'new' operator, which conceptually creates a copy of a set, but with new identities. The new set is not related to the original set (but you can relate it with the relate operator).




conversions := //conversions
conversions' := new conversions
conversions~ conversions'
{location: conversions.customer.state, income: conversions.customer.income}

[{"location": "SC"}, {"income": 141982,"location": "CA"},{"location": "FL"}, ...]




The above query produces a cross-product of all states and income levels. The lack of an income field in some of the objects indicates there is some missing income data.


# THAT'S IT!


Quirrel has many built-in functions that help you do analytics. However, you now know everything you need to start writing queries.











参考：
http://quirrel-lang.org/tutorial.html
