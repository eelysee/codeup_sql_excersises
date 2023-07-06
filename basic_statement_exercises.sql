-- Create a new file called basic_statement_exercises.sql and save your work there. You should be testing your code in MySQL Workbench as you go.

-- 1. Use the albums_db database.

USE albums_db
;

-- 2. What is the primary key for the albums table?

albums_db.id

-- 3. What does the column named 'name' represent?

The Title of the album.

-- 4. What do you think the sales column represents?

# of salaes in millions of units

-- 5. Find the name of all albums by Pink Floyd.

-- The Dark Side of the Moon
-- The Wall
SELECT *
FROM albums
WHERE artist = 'Pink Floyd'
;


-- 6. What is the year Sgt. Pepper's Lonely Hearts Club Band was released?

-- 1967
SELECT *
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band"
;

-- 7. What is the genre for the album Nevermind?

-- Grunge, Alternative rock
SELECT *
FROM albums
WHERE name = "Nevermind"
;

-- 8. Which albums were released in the 1990s?

SELECT *
FROM albums
WHERE SUBSTR(release_date, 1, 3) = 199
;

-- 9. Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.

SELECT name AS low_selling_albums
FROM albums
WHERE sales < 20
;
