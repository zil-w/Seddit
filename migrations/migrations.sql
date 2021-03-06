-- Create database

DROP SCHEMA IF EXISTS seddit;
CREATE SCHEMA seddit;
USE seddit;


-- Users

CREATE TABLE users
(
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    username char(255) NOT NULL,
    password char(255),
    firstname char(255),
    lastname char(255),
    email char(255),
    membership char(255)
);


-- Posts

CREATE TABLE posts
(
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title char(255),
    content char(255),
    from_user_id int,
    create_timestamp Date NOT NULL,
    modified_timestamp Date,
    visibility char(255),

    FOREIGN KEY (from_user_id) REFERENCES users (id)
);


-- Hastags linked to Posts

CREATE TABLE hashtags
(
    id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tag char(255),
    to_post_id int,
    FOREIGN KEY (to_post_id) REFERENCES posts (id)
);


-- Uploads lined to Posts

CREATE TABLE uploads
(
    id INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    description CHAR(50),
    data LONGBLOB,
    filename CHAR(50),
    filesize CHAR(50),
    filetype CHAR(50),
    to_post_id int,
    FOREIGN KEY (to_post_id) REFERENCES posts (id)
);




-- =============== DUMMY DATA ===============

-- Dummy users

INSERT INTO users (username, password, firstname, lastname, email, membership)
VALUES ('a', 'a', 'John', 'Smith', 'a@a.com', 'admin');

INSERT INTO users (username, password, firstname, lastname, email, membership)
VALUES ('b', 'b', 'Mark', 'Cuban', 'b@b.com', 'encs');



-- Dummy Posts for testing

delimiter $$
create procedure load_foo_test_data()
begin

    declare v_max int unsigned default 150;
    declare v_counter int unsigned default 0;

    while v_counter < v_max do
            INSERT INTO posts (title, content, from_user_id, create_timestamp, modified_timestamp, visibility) VALUES ('Hello World!', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. #Curabitur #aliquam', 1, CURDATE(), CURDATE(), 'encs');
            set v_counter=v_counter+1;
        end while;
    commit;
end $$

delimiter ;

call load_foo_test_data();

-- Dummy hashtags

INSERT INTO hashtags (tag, to_post_id)
VALUES ('#Curabitur', 1);

INSERT INTO hashtags (tag, to_post_id)
VALUES ('#aliquam', 1);






