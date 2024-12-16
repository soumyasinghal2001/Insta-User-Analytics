use ig_clone;
-- A) Marketing Analysis:


-- Identify the five oldest users on Instagram from the provided database.
select username, created_at 
from users
order by created_at asc
limit 5;


I-- Identify users who have never posted a single photo on Instagram.
select username from users
left join photos
on users.id = photos.user_id
where photos.image_url is null
order by users.username asc;


/*
Contest Winner Declaration: The team has organized a contest where the user with the most likes on a single photo wins.
Your Task: Determine the winner of the contest and provide their details to the team.
*/
SELECT u.id AS user_id, u.username, p.id AS photo_id, p.image_url, COUNT(l.user_id) AS like_count
FROM photos p
JOIN likes l ON p.id = l.photo_id
JOIN users u ON p.user_id = u.id
GROUP BY p.id
ORDER BY like_count DESC
LIMIT 1;


-- Identify and suggest the top five most commonly used hashtags on the platform.

select t.tag_name, count(photo_id) as total 
from photo_tags pt
left join tags t
on pt.tag_id = t.id
group by tag_id
order by total desc
limit 5;

-- Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.

select dayname(created_at) as registeration_day, count(id) as count_registerd
from users
group by registeration_day
limit 1;






-- B) Investor Metrics:


/*Calculate the average number of posts per user on Instagram. 
Also, provide the total number of photos on Instagram divided by the total number of users.*/

-- Average posts per user
SELECT AVG(photo_count) AS avg_posts_per_user
FROM (
    SELECT user_id, COUNT(id) AS photo_count
    FROM photos
    GROUP BY user_id
) AS user_photos;

-- Ratio of total photos to total users
SELECT 
    (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) AS photos_per_user_ratio;

-- Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.

select l.user_id ,u.username
from likes l
join users u
on l.user_id = u.id
group by user_id
having count(distinct l.photo_id) = (select count(*) from photos)
order by u.username;






