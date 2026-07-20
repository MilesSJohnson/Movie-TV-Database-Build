
-- List all platform names and average viewer rating per platform for their shows
-- Order by viewer rating

SELECT p.PlatformName, AVG(vw.ViewerRatingStars) as avgShowRating
FROM Platform p
LEFT JOIN Viewing vw
ON p.PlatformID = vw.PlatformID
GROUP BY p.PlatformName
Order BY avgShowRating desc


-- How many platforms are internet based
SELECT COUNT(IsInternetBased) AS NumInternetBased
FROM Platform
WHERE IsInternetBased = 1


-- List box office earnings of each genre that have a total from largest to smallest
SELECT g.GenreDescription, SUM(s.BoxOfficeEarnings) as TotalBoxOfficeEarnings
FROM Genre g
INNER JOIN Show s
ON g.GenreID = s.GenreID
GROUP BY g.GenreDescription
ORDER BY SUM(s.BoxOfficeEarnings) DESC


-- Which Platform is used by each viewer
-- List First and Last Name
SELECT v.FirstName, v.Lastname, p.PlatformName
FROM Viewer v
INNER JOIN Viewing vw
ON v.ViewerID = vw.ViewerID
INNER JOIN Platform p
ON vw.PlatformID = p.PlatformID


-- List the salary of the first and last name of each actor in descending order
SELECT a.FirstName, a.LastName, SUM(r.Salary) AS TotalSalary
FROM Actor a
LEFT JOIN Role r
ON a.ActorID = r.ActorID
GROUP BY a.FirstName, a.LastName
ORDER BY SUM(r.Salary) DESC
