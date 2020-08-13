###########
# Task 1. #
###########

# У вас есть социальная сеть, где пользователи (id, имя) могут ставить друг другу лайки.
# Создайте необходимые таблицы для хранения данной информации. Создайте запрос, который выведет информацию:

# id пользователя;
# имя;
# лайков получено;
# лайков поставлено;
# взаимные лайки.


CREATE SCHEMA `social_network` DEFAULT CHARACTER SET utf8 ;

# Createing table for users

CREATE TABLE `social_network`.`users` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(128) NOT NULL,
    `last_name` VARCHAR(128) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX id_UNIQUE (id ASC) VISIBLE
);

# Creating table for likes

CREATE TABLE `social_network`.`likes` (
    `from_user` INT NOT NULL,
    `to_user` INT NOT NULL,
    PRIMARY KEY (`from_user`, `to_user`),
    INDEX `fk_like_from_user_idx` (`from_user` ASC) VISIBLE,
    INDEX `fk_like_to_user_idx` (`to_user` ASC) VISIBLE,
    CONSTRAINT `fk_like_from_user`
        FOREIGN KEY (`from_user`)
            REFERENCES `social_network`.`users` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_like_to_user`
        FOREIGN KEY (`to_user`)
            REFERENCES `social_network`.`users` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

# Adding users

INSERT INTO
    `social_network`.`users` (`first_name`, `last_name`)
VALUES
    ('Andrey', 'Bondarev'),
    ('Svetlana', 'Phazina'),
    ('Alena', 'Kartugina'),
    ('Marina', 'Vasina'),
    ('Dmitriy', 'Pichugin'),
    ('Vladimir', 'Putin');

# Adding likes

INSERT INTO
    `social_network`.`likes` (`from_user`, `to_user`)
VALUES
(1, 3),
(1, 4),
(2, 3),
(3, 2),
(1, 6),
(2, 6),
(3, 6),
(4, 6),
(5, 6),
(5, 2);

# Getting information about all likes

SELECT
    first_name,
    last_name,
    (SELECT
         COUNT(*)
     FROM
         likes
     WHERE
             users.id = likes.from_user) AS likes_given,
    (SELECT
         COUNT(*)
     FROM
         likes
     WHERE
             users.id = likes.to_user) AS likes_received,
    (SELECT
         COUNT(*)
     FROM
         likes AS from_u
             JOIN
         likes AS to_u ON (from_u.from_user = to_u.to_user
             AND to_u.from_user = from_u.to_user)
     WHERE
             from_u.from_user = users.id) AS cross_likes
FROM
    users
ORDER BY users.id;

# Result:

# first_name last_name likes_given likes_received cross_likes
# 'Andrey', 'Bondarev',     '3',        '0',        '0'
# 'Svetlana','Phazina',     '2',        '2',        '1'
# 'Alena','Kartugina',      '2',        '2',        '1'
# 'Marina','Vasina',        '1',        '1',        '0'
# 'Dmitriy','Pichugin',     '2',        '0',        '0'
# 'Vladimir','Putin',       '0',        '5',        '0'


###########
# Task 2. #
###########

# Для структуры из задачи 1 выведите список всех пользователей, которые поставили лайк
# пользователям A и B (id задайте произвольно), но при этом не поставили лайк пользователю C.


SELECT
    users.id, users.first_name, users.last_name
FROM
    users
        JOIN
    (SELECT
         likes.to_user
     FROM
         likes
     WHERE
             likes.to_user = 6 OR likes.to_user = 5
     LIMIT 1) likes
WHERE
    NOT users.id = (SELECT
                        likes.from_user
                    FROM
                        likes
                    WHERE
                            likes.to_user = 4)
ORDER BY users.id