 -- find all products 
  SELECT * FROM Products;
 
 -- find all products that cost $1400
  SELECT * FROM Products
  WHERE Price = 1400;
 
 -- find all products that cost 11.99 or 13.99
  SELECT * FROM Products
  WHERE Price = 11.99 OR Price = 13.99;
 
-- find all products that do NOT cost 11.99 - using NOT
 SELECT * FROM Products
 WHERE NOT Price = 11.99;
 
-- find all products and sort them by price from greatest to least
 SELECT * FROM Products
 ORDER BY Price DESC;
 
-- find all employees who don't have a middle initial
 SELECT LastName, FirstName, MiddleInitial FROM Employees
 WHERE MiddleInitial IS null;
 
-- find distinct product prices
 SELECT DISTINCT Price FROM Products;
 
-- find all employees whose first name starts with the letter ‘j’
 SELECT * FROM Employees
 WHERE FirstName LIKE 'j%';
 
-- find all Macbooks --
 SELECT * FROM Products
 WHERE NAME = 'Macbook';

-- find all products that are on sale
 SELECT * FROM Products
 WHERE ONSALE = 1;
 
-- find the average price of all products --
 SELECT AVG (Price) FROM Products;
 
-- find all Geek Squad employees who don't have a middle initial --
 SELECT LastName, Firstname, Title, MiddleInitial FROM Employees
 WHERE MiddleInitial IS NULL AND Title = 'Geek Squad';
 
-- find all products from the products table whose stock level is in the range of 500 to 1200. Order by Price from least to greatest. **Try this with the between keyword**
 SELECT * FROM Products
 WHERE Stocklevel BETWEEN 500 AND 1200
 ORDER BY Price ASC, StockLevel DESC;
 
----------------------------------------------------------------------------------------------------
-- JOINS SECTION:
-- joins: select all the computers from the products table:
-- using the products table and the categories table, return the product name and the category name
SELECT products.name AS 'Product Name', categories.name AS 'Category Name'
FROM products
INNER JOIN categories
ON products.CategoryID = categories.CategoryID AND categories.name = 'computers';	
 
-- joins: find all product names, product prices, and products ratings that have a rating of 5
SELECT p.Name AS 'Product Name', p.Price, r.Rating
 FROM Products AS p
 INNER JOIN Reviews as r
ON p.ProductID = r.ProductID AND r.Rating = 5;
 
-- joins: find the employee with the most total quantity sold.  use the sum() function and group by
SELECT SUM(s.Quantity) AS 'Quantity', e.FirstName, e.LastName
FROM sales AS s
INNER join employees AS e
ON e.EmployeeID = s.EmployeeID
group by s.EmployeeID
order by sum(s.Quantity) DESC LIMIT 2;


-- joins: find the name of the department, and the name of the category for Appliances and Games

SELECT d.Name AS 'Department Name', c.Name 'Category Name'
FROM departments as d
INNER JOIN categories as c
ON d.DepartmentID = c.DepartmentID AND c.Name = 'appliances' OR c.name = 'games';

-- joins: find the product name, total # sold, and total price sold, for Eagles: Hotel California 
-- You may need to use SUM()
SELECT p.name as 'Product Name', SUM(s.Quantity) AS 'Total Sold', (p.Price * sum(s.Quantity)) AS 'Total Price Sold'
FROM Products AS p
INNER JOIN sales as s
ON p.ProductID = s.productID AND p.Name ='Eagles: Hotel California';

-- joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!)
SELECT * FROM products;
SELECT * FROM reviews;

SELECT P.NAME AS 'Product Name', r.Reviewer, r.rating, r.comment
FROM reviews as r
INNER JOIN products as p
ON p.ProductID = r.productID AND p.name = 'Visio TV'
order by r.rating LIMIT 1;

-- Extra - May be difficult
-- Your goal is to write a query that serves as an employee sales report.
-- This query should return the employeeID, the employee's first and last name, the name of each product, how many of that product they sold
SELECT e.employeeID, e.FirstName, e.LastName, p.name AS 'Product Name', s.Quantity
FROM sales AS s
INNER JOIN employees as e ON e.employeeID = s.employeeID
INNER JOIN products as p ON p.ProductID = s.ProductID
ORDER BY e.LastName, e.FirstName;