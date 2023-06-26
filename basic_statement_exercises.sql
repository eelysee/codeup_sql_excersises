-- 1. Use the albums_db database.

-- 2. What is the primary key for the albums table?
-- id

-- 3. What does the column named 'name' represent?
-- Album name

-- 4. What do you think the sales column represents?
-- number of sales an album had multiplied by millions.

-- 5. Find the name of all albums by Pink Floyd.
-- The Wall, the Dark Side of the Moon
SELECT name from albums
Where artist = 'Pink Floyd'

-- 6. What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
-- 1967
SELECT * from albums
Where artist = 'The Beatles'

-- 7. What is the genre for the album Nevermind?
-- Grunge, Alternative rock
SELECT * from albums
Where name = 'Nevermind'

-- 8. Which albums were released in the 1990s?
SELECT * from albums
Where release_date BETWEEN 1990 AND 1999;

-- 9. Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT name as low_selling_albums from albums
Where sales < 20;