---------------------------
-- DROP EXISTING TABLES (in dependency order)
---------------------------
DROP TABLE IF EXISTS comments CASCADE;
DROP TABLE IF EXISTS answers CASCADE;
DROP TABLE IF EXISTS questions CASCADE;
DROP TABLE IF EXISTS users CASCADE;

---------------------------
-- Q&A SCHEMA SETUP
---------------------------
-- Users Table
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL
);

-- Questions Table
CREATE TABLE questions(
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    creation_date INTEGER NOT NULL,
    score INTEGER NOT NULL,
    "userId" INTEGER REFERENCES users(id) ON DELETE CASCADE,
    accepted_answer_id INTEGER  -- will be set via ALTER TABLE if needed
);

-- Answers Table
CREATE TABLE answers(
    id SERIAL PRIMARY KEY,
    body TEXT NOT NULL,
    creation_date INTEGER NOT NULL,
    score INTEGER NOT NULL,
    accepted BOOLEAN NOT NULL DEFAULT FALSE,
    "userId" INTEGER REFERENCES users(id) ON DELETE CASCADE,
    "questionId" INTEGER REFERENCES questions(id) ON DELETE CASCADE
);

-- Comments Table
CREATE TABLE comments(
    id SERIAL PRIMARY KEY,
    body TEXT NOT NULL,
    "userId" INTEGER REFERENCES users(id) ON DELETE CASCADE,
    "questionId" INTEGER,   -- optional
    "answerId" INTEGER      -- optional
);

---------------------------
-- INSERT Q&A DATA FROM JSON
---------------------------

-- Insert Users (dummy emails/passwords provided)
INSERT INTO users(id, name, email, password) VALUES (12941336, 'Catogram', 'catogram@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (16427935, 'Dafydd', 'dafydd@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (16491742, 'Jonathan Almengot', 'jonathan@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (399508, 'software is fun', 'softwareisfun@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (9745257, 'PeterD', 'peterd@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (13888590, 'Dexterians', 'dexterians@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (6436191, 'The Impaler', 'theimpaler@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (2164365, 'Abra', 'abra@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (1377002, 'Andy', 'andy@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (6057915, 'Daniel Resch', 'daniel@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (1175966, 'charlietfl', 'charlietfl@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (16491792, 'patha', 'patha@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (1505939, 'M.M', 'mm@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (16491668, 'lizzy', 'lizzy@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (11003927, 'Facundo Villa', 'facundovilla@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (1707385, 'NemoPS', 'nemops@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (283366, 'Phil', 'phil@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (4475908, 'Zlatan Omerović', 'zlatan@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (13840401, 'junglekim', 'junglekim@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (15497888, 'Henry Ecker', 'henryecker@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (6890628, 'GOPS', 'gops@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (14860, 'paxdiablo', 'paxdiablo@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (421195, 'paulsm4', 'paulsm4@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (3807729, 'Galik', 'galik@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (6752050, 'S.M.', 'sm@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (16436471, 'hugo hg', 'hugo_hg@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (13132728, 'bismo', 'bismo@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (440558, 'Some programmer dude', 'someprogrammer@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (2410359, 'chux - Reinstate Monica', 'chux@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (7175713, 'sammywemmy', 'sammywemmy@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (11392290, 'Serge', 'serge@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (14703882, 'xtryingx', 'xtryingx@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (14868997, 'Charlieface', 'charlieface@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (2536611, 'C Sharper', 'c_sharper@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (16215251, 'TahaHaza00', 'tahahaza00@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (4364635, 'Jacob Smit', 'jacob_smit@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (11452288, 'loveubae', 'loveubae@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (9515207, 'CertainPerformance', 'certainperformance@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (10684332, 'ShuYU', 'shuyu@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (8742428, 'rgbk21', 'rgbk21@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (2310289, 'Scary Wombat', 'scarywombat@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (10082297, 'Henry Twist', 'henrytwist@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (10339394, 'frustratedProgrammer', 'frustrated@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (1610174, 'daemacles', 'daemacles@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (4706785, 'Peter', 'peter@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (3943312, 'Sam Varshavchik', 'sam@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (4641116, 'Eljay', 'eljay@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (8550160, 'jman', 'jman@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (62576, 'Ken White', 'kenwhite@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (225186, 'alfC', 'alfc@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (16295664, 'Bashfu', 'bashfu@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (6890912, 'blhsing', 'blhsing@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (14492001, 'Omar AlSuwaidi', 'omar@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (68587, 'John Kugelman', 'john@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (16490359, 'SwishitySwoosh', 'swish@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (438992, 'Dave Newton', 'davenewton@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (2487517, 'Tibrogargan', 'tibrogargan@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (15954539, 'nay', 'nay@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (13628883, 'sharathnatraj', 'sharathnatraj@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (9274732, 'Ben.T', 'bent@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (4249805, 'Linnan DU', 'linnandu@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (8978442, 'Jerry', 'jerry@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (14853083, 'Tangentially Perpendicular', 'tangential@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (248567, 'Kirk Beard', 'kirkbeard@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (6361531, 'Scott Boston', 'scottboston@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (3794812, 'Nicholas Tower', 'nicholas.tower@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (16403602, 'akmal hazim', 'akmal.hazim@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (16389635, 'Nương Đàm Thị', 'nuong.damthi@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (1902010, 'ceejayoz', 'ceejayoz@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (2930038, 'vanowm', 'vanowm@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (4505446, 'A-Sharabiani', 'a-sharabiani@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (7921161, 'virat', 'virat@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (989920, 'evolutionxbox', 'evolutionxbox@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (1772933, 'Kinglish', 'kinglish@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (1353011, 'Musa', 'musa@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (14471249, 'mad', 'mad@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (920069, 'Retired Ninja', 'retired.ninja@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (1413244, 'jwezorek', 'jwezorek@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (12526570, 'Panda', 'panda@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (4525932, 'dmedine', 'dmedine@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (12513900, 'Anubhav Gupta', 'anubhav.gupta@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (16139854, 'TheCodeMan', 'thecodeman@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (355230, 'martineau', 'martineau@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (14531062, 'Matiiss', 'matiiss@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');
INSERT INTO users(id, name, email, password) VALUES (8589793, 'secuman', 'secuman@example.com', '$argon2id$v=19$m=65536,t=3,p=4$QZ/CzR+MKa04aD6AuWFwvQ$9KbqTPBCjwQWlw');

-- Insert Questions
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68462879, $$How to force a compile error in C++(17) if a function return value isn''t checked? Ideally through the type system$$, $$<p>We are writing safety critical code and I''d like a stronger way than [[nodiscard]] to ensure that <em>checking of</em> function return values is caught by the compiler.</p>\n<p>Constraints:</p>\n<ul>\n<li>MSVC++ 2019</li>\n<li>Something that <em>doesn''t</em> rely on warnings</li>\n<li>Warnings-as-Errors also doesn''t work</li>\n<li>It''s not feasible to constantly run static analysis</li>\n<li>Macros are OK</li>\n<li>Not a runtime check, but caught by the compiler</li>\n<li>Not exception based</li>\n</ul>\n<p>I''ve been trying to think how to create a type(s) that, if it''s not assigned to a variable from a function return, the compiler flags an error.</p>\n<p>Example:</p>\n<pre><code>struct MustCheck\n{\n  bool success;\n  ...???... \n};\n\nMustCheck DoSomething( args )\n{\n  ...\n  return MustCheck{true};\n}\n\nint main(void) {\n  MustCheck res = DoSomething(blah);\n  if( !res.success ) { exit(-1); }\n\n  DoSomething( bloop ); // <------- compiler error\n}\n  \n</code></pre>\n<p>If such a thing is provably impossible through the type system, I''ll also accept that answer ;)</p>$$, 1626829337, 3, 1610174);
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68463022, $$How to add strings to a list and print the list?$$, $$<p>I want to create a program where it works like a simple bag. You can add items to the bag (in this case is strings) into a list. Here''s my code:</p>\n<pre><code>class Items:\n    def __init__(self, name):\n        self.name = name\n        \nclass Bag:\n    def __init__(self, items, max_items):\n        # max_items is the maximum capacity of the Bag\n        self.items = items\n        self.max_items = max_items\n        \n    def add_items(self):\n        if len(self.items) < self.max_items:\n           self.items.append(i.name)\n        \n    def read_items(self):\n        for item in self.items:\n            print(item.name)\n\ni = Items("Item1")\nb = Bag([], 10) # I''m just going to put example 10 strings for the max_items\nb.read_items()\n</code></pre>\n<p>From this code there is no output (just to be clear, I mean there''s no input whatsoever, not the input "None").</p>\n<p>My goal is to make the code run whatever is inside the list. In any conditions, even if there''s items being added to the list.</p>$$, 1626831122, 0, 16295664);
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68462964, $$Need help returning an array with two arrays: borrowed books and returned books$$, $$<p>I am trying to return an array with two arrays the first being borrowed books and the other being returned books. The prompt that I have to use is:</p>\n<p>The <code>partitionBooksByBorrowedStatus()</code> function in <code>public/src/books.js</code> has a single parameter:</p>\n<ul>\n<li>An array of books.</li>\n</ul>\n<p>It returns an array with two arrays inside of it. All of the inputted books are present in either the first or second array.</p>\n<p>The first array contains books <em>that have been loaned out, and are not yet returned</em> while the second array contains books <em>that have been returned.</em> You can check for the return status by looking at the first transaction in the <code>borrows</code> array.</p>\n<p>Here is a portion of the data provided:</p>\n<pre><code>const books = [{\nid: "5f447132d487bd81da01e25e",\ntitle: "sit eiusmod occaecat eu magna",\ngenre: "Science",\nauthorId: 8,\nborrows: [\n  {\n    id: "5f446f2e2f35653fa80bf490",\n    returned: false,\n  },\n  {\n    id: "5f446f2ed3609b719568a415",\n    returned: true,\n  },\n  ...\n$$, 1626830342, 0, 16490359);
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68462918, $$Setting javascript tabs$$, $$<p>Good day. I write tabs on javascript. The idea behind these tabs is soundly common, but there is a slight difference from the standard ones. When I click on the "+" button, all tabs should be closed and only the one that was clicked should open. Everything works well, but I just can not implement the closing of the tab on the second click of the button</p>\n<p><a href="https://i.stack.imgur.com/Vl52Z.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/Vl52Z.png" alt="enter image description here" /></a></p>\n<p>HTML</p>\n<pre><code>        &lt;div class="faq__tab"&gt;\n          &lt;div class="faq__tab__question"&gt;\n            Какие вложения необходимы для того, чтобы&lt;br&gt;\n            начать торговать на Wildberries?\n            &lt;div class="faq__tab__qeustion-btn" data-tab=''0''&gt;&lt;/div&gt;\n          &lt;/div&gt;\n          &lt;div class="faq__tab__answer"&gt;\n            &lt;span class="tab-answer"&gt;\n              Какие вложения необходимы для того, чтобы&lt;br&gt;\n              начать торговать на Wildberries?\n            &lt;/span&gt;\n          &lt;/div&gt;\n        &lt;/div&gt;\n</code></pre>\n<p>JS</p>\n<pre><code>const tabButtons = document.querySelectorAll(''.faq__tab__qeustion-btn'');\nconst tabAnswers = document.querySelectorAll(''.faq__tab__answer'');\nconst answer = document.querySelectorAll(''tab-answer'');\n\nlet tabClicked = false;\n\ntabButtons.forEach((btn, index) =&gt; {\n  btn.addEventListener(''click'', selectTab)\n});\n\nfunction selectTab() {\n  tabButtons.forEach((button) =&gt; {\n    button.classList.remove(''faq__tab__qeustion-btn--active'');\n  });\n  tabAnswers.forEach((answer) =&gt; {\n    answer.classList.remove(''faq__tab__answer--active'');\n  });\n  this.classList.add(''faq__tab__qeustion-btn--active'');\n  tabAnswers[this.getAttribute(''data-tab'')].classList.add(''faq__tab__answer--active'');\n}\n</code></pre>$$, 1626829875, 0, 11452288);
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68463043, $$Generics in Java does not compile$$, $$<p>I am stuck trying to understand what exactly is going on over here. The two ways that the copy_v1 method is being used are shown below. The first way (1) produces a compile error. But the second way (2) does not produce any compile error (nor does it produce any runtime error when I try to execute the program once I comment out (1)). When I replace (2) with <code>copy_v1(new Wrapper&lt;String&gt;("Hello"), new Wrapper&lt;Object&gt;(new Object()));</code>, I end up getting a compile error on (2) as well. Not sure what is happening. How is the code on (1) any different from (2)? Can someone shed some light on this please.</p>\n<p>Thanks.</p>\n<pre><code>public class SOQuestion {\n\n    public static &lt;T&gt; void copy_v1(Wrapper&lt;T&gt; source, Wrapper&lt;T&gt; dest) {\n        T srcObj = source.getRef();\n        dest.setRef(srcObj);\n    }\n\n    public static void main(String[] args) {\n        Wrapper&lt;Object&gt; objectWrapper = new Wrapper&lt;&gt;(new Object());\n        Wrapper&lt;String&gt; stringWrapper = new Wrapper&lt;&gt;(''Hello'');\n        copy_v1(stringWrapper, objectWrapper); // Compile error on this line (1)\n        copy_v1(new Wrapper&lt;&gt;(''Hello''), new Wrapper&lt;&gt;(new Object())); // But no error on this line (2)\n    }\n\n}\n\nclass Wrapper&lt;T&gt; {\n\n    private T ref;\n\n    Wrapper(T ref) { this.ref = ref; }\n\n    public T getRef() { return this.ref; }\n\n    public void setRef(T ref) { this.ref = ref; }\n}\n</code></pre>$$, 1626831371, 0, 8742428);
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68462903, $$Is it reasonable to use .map inside a form?$$, $$<p>I am trying to iterate n food products that all will have the same inputs, so whether or not the user will want X, Y, or Z elements to it.</p>\n<p>I thought the idea was pretty good at the beginning, but I realized that the idea went to downhill when I couldn''t control the inputs by id (validations) as the id is repeating itself in every iteration.</p>\n<p>Here is my code of render()</p>\n<pre><code>&lt;div className="modal-body modalFood" style={{ maxHeight: ''400'', overflowy: ''auto'' }}&gt;\n  &lt;div className="container"&gt;\n    &lt;form onSubmit={this.handleSubmit} id="form"&gt;\n      &lt;ul className="list-group list-group-flush"&gt;\n        {food.map((product, index) =&gt; (\n          &lt;li className="list-group-item2" key={product.idFood}&gt;\n            //information about the food\n            Amount:\n            &lt;/label&gt;\n            &lt;input\n              value={amount}\n              type="number"\n              min="0"\n              max="999"\n              name="amount"\n              style={{ borderColor: ''#001689'' }}\n              autoComplete="off"\n              required\n            /&gt;\n        ))}\n        &lt;div className="modal-footer"&gt;\n          &lt;button type="submit" className="btn btn-primary"&gt;Save&lt;/button&gt;\n        &lt;/div&gt;\n      &lt;/ul&gt;\n    &lt;/form&gt;\n  &lt;/div&gt;\n</code></pre>\n<p>Is there a better way to do this? Or am I on the right track.</p>$$, 1626829621, 0, 10339394);
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68462917, $$pandas set value if dates are the same in two diffrent df according to dates range$$, $$<p>I have df:\nwhile disease is binary column ( 0 or 1)</p>\n<pre><code>diagnosis_date    id  disease\n2013-05-03         1     0\n2013-05-08         1     0\n2013-06-08         1     1\n2013-01-01         2     0 \n.....\n</code></pre>\n<p>and I have range of dates- 2013-01-01 until 2013-12-31:</p>\n<pre><code>date_index=pd.date_range(start=''1/1/2013'', end=''31/12/2013'')\ndates=pd.DataFrame(date_index,columns=[''date''])\n</code></pre>\n<p>I want for each id in df, to set the date range as date_index, and if the date is the same as diagnosis date, to set the value like it in the disease column, otherwise the value will be set to zero.\n<strong>the desire df:</strong></p>\n<pre><code>date    id    disease\n01-01    1       0\n02-01     1      0\n03-01     1      0\n...\n05-03     1      0\n05-04     1      0\n...\n06-08    1      1\n ....\n12-31     1      0\n01-01     2      1\n01-02     2      0 \n...  \n</code></pre>\n<p>Thanks</p>$$, 1626829874, 0, 15954539);
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68462883, $$Filter an array where obj[array[@]] is nil or empty$$, $$<p>Practising Ramda again.</p>\n<p>So the situation is I have an obj:</p>\n<pre><code>const originalObj = {\n  foo: "bar",\n  std: "min",\n  baz: "",\n  key1: undefined,\n  key2: "exit",\n  key3: "val3",\n  key4: "",\n};\n</code></pre>\n<p>And I have an array that I know beforehand:</p>\n<pre><code>const toCheckArray = ["baz", "key1", "key2", "key3", "key4", "key5"];\n</code></pre>\n<p>For every element in the array, I need to check whether such element (as key) exists in the obj, and whether the corresponding value is nil/empty. If such key exists, and the value is non-zero/empty, then I make an HTTP call like this to update the value:</p>\n<pre><code>const findKey2AndUpdateObj = async (originalObj) =&gt; {\n  const originalKey2 = originalObj.key2;\n  const key2 = await remoteHttpCall(originalKey2);\n  return { ...originalObj, key2: key2 };\n};\n</code></pre>\n<p>For all the elements in the array, the remote HTTP call would be exactly the same, apart from the payload, of course.</p>\n<p>My way of thing is to filter the list first, by doing the following steps:</p>\n<ol>\n  <li><code>const hasArray = filter(has(__, originalObj), toCheckArray);</code> – this I believe will check whether the element as a prop exists in the target obj;</li>\n  <li>I am trying to apply <code>complement(anyPass([isNil, isEmpty]))</code> to all the values of the obj and then somehow filter the corresponding key in the array;</li>\n  <li>Iterate the array? to make API calls and then update the obj.</li>\n</ol>\n<p>I guess what I am thinking is not the best way of doing it. Would love to hear your ideas!\nAlso memorising the API call would be amazing too!</p>\n<hr>\n<p>Or maybe I should flip step 1 and step 2? Filter out all the nil/empty ones from the obj and then do the <code>has</code> check.</p>\n<hr>\n<p>I ended up doing this: <code> filter(has(__, reject(anyPass([isEmpty, isNil]))(obj)), __)(arr)</code>. But surely there is better way.</p>\n<p>Cheers!</p>$$, 1626829394, 1, 4249805);
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68462972, $$my second AJAX script wont work after I call the first one$$, $$<p>I''m having problem with <code>ajax</code> call,</p>\n<p>my <code>ajax</code> statement works on the first call, but when I call another <code>ajax</code> after the first one it just wont work</p>\n<p>I''m calling both ajax script through combo box 1 and combo box 2</p>\n<p><a href="https://i.stack.imgur.com/ZDrYj.png" rel="nofollow noreferrer">AJAX Script</a></p>\n<p><a href="https://i.stack.imgur.com/i1ovb.png" rel="nofollow noreferrer">ComboBox 1</a></p>\n<p><a href="https://i.stack.imgur.com/OlrPh.png" rel="nofollow noreferrer">ComboBox 2</a></p>$$, 1626830452, -4, 8978442);
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68462910, $$Pointer to function instead if in c$$, $$<p>Hey stackoveflow community ! <br />\nI''m making a little calculator in C with only "+, -, /, *, %" parameters, and honestly, this is working fine ; But I would try to make it with pointer to function I think I will use a better syntax but I don''t know where I may start and how can I do/can I use it? I would like improve myself.. Someone can explain me please.. Thank''s in advance !</p>\n<pre><code>#include <unistd.h>\n#include <stdio.h>\n\nint     ft_atoi(char *str);\nvoid    ft_putnbr(int nb);\n\nint check_by_zero(int a, int b, char oper)\n{\n    int res;\n\n    if (oper == \'/')\n    {\n        if (b == 0)\n        {\n            write(1, "Stop : division by zero\\n", 24);\n            res = -1;\n        }\n        else\n            res = a / b;\n    }\n    if (oper == ''%'')\n    {\n        if (b == 0)\n        {\n            write(1, "Stop : modulo by zero\\n", 22);\n            res = -1;\n        }\n        else\n            res = a % b;\n    }\n    return (res);\n}\n\nint do_result(int a, int b, char oper)\n{\n    int res;\n\n    if (oper == ''-'')\n        res = a - b;\n    if (oper == ''+'')\n        res = a + b;\n    if (oper == ''/'' || oper == ''%'')\n        res = check_by_zero(a, b, oper);\n    if (oper == ''*'')\n        res = a * b;\n    return (res);\n}\n\nint main(int ac, char **av)\n{\n    int     value1;\n    int     value2;\n    int     res;\n    char    c;\n\n    if (ac != 4)\n        return (0);\n    value1 = ft_atoi(av[1]);\n    value2 = ft_atoi(av[3]);\n    c = av[2][0];\n    if ((!(c == ''+'' || c == ''-'' || c == ''*'' \n        || c == ''/'' || c == ''%'')) || av[2][1] != 0)\n        res = 0;\n    else\n        res = do_result(value1, value2, c);\n    if (res != -1)\n    {\n        ft_putnbr(res);\n        write(1, "\\n", 1);\n    }\n    return (0);\n}\n</code></pre>\n<p>EDIT: Can''t use standard function. Only mine. This is the reason why I use write instead printf</p>$$, 1626829750, 0, 16436471);
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68462912, $$How to explode a list into new columns pandas$$, $$<p>Let''s say I have the following df</p>\n<pre><code>  x\n1 [''abc'',''bac'',''cab'']\n2 [''bac'']\n3 [''abc'',''cab'']\n</code></pre>\n<p>And I would like to take each element of each list and put it into a new row, like so</p>\n<pre><code>  abc bac cab\n1  1    1  1\n2  0    1  0\n3  1    0  1\n</code></pre>\n<p>I have referred to multiple links but can''t seem to get this correctly.</p>\n<p>Thanks!</p>$$, 1626829786, 0, 13132728);
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68462872, $$Json Deserialization | Cannot Deserialize Current Json$$, $$<p>I have below Json -</p>\n<pre><code>{&quot;property_id&quot;:&quot;53863730&quot;,&quot;name&quot;:&quot;Hayat Elhamra&quot;,&quot;address&quot;:{&quot;line_1&quot;:&quot;Jeddah&quot;,&quot;city&quot;:&quot;Jeddah&quot;,&quot;state_province_name&quot;:&quot;Jeddah&quot;,&quot;postal_code&quot;:&quot;23212&quot;,&quot;country_code&quot;:&quot;SA&quot;,&quot;obfuscation_required&quot;:false,&quot;localized&quot;:{&quot;links&quot;:{&quot;ar-SA&quot;:{&quot;method&quot;:&quot;GET&quot;,&quot;href&quot;:&quot;https://api.ean.com/2.4/properties/content?language=ar-SA&amp;property_id=53863730&amp;include=address&quot;}}}},&quot;location&quot;:{&quot;coordinates&quot;:{&quot;latitude&quot;:21.520902,&quot;longitude&quot;:39.158265}},&quot;phone&quot;:&quot;20-01145772035&quot;,&quot;category&quot;:{&quot;id&quot;:&quot;16&quot;,&quot;name&quot;:&quot;Apartment&quot;},&quot;rank&quot;:99999999,&quot;business_model&quot;:{&quot;expedia_collect&quot;:true,&quot;property_collect&quot;:true},&quot;dates&quot;:{&quot;added&quot;:&quot;2020-06-10T23:03:21.345Z&quot;,&quot;updated&quot;:&quot;2020-06-10T23:03:23.701Z&quot;},&quot;chain&quot;:{&quot;id&quot;:&quot;0&quot;,&quot;name&quot;:&quot;Independent&quot;},&quot;brand&quot;:{&quot;id&quot;:&quot;0&quot;,&quot;name&quot;:&quot;Independent&quot;}}
{&quot;property_id&quot;:&quot;53183065&quot;,&quot;name&quot;:&quot;Carefully Furnished Bungalow With 2 Bathrooms, 7km From Pula&quot;,&quot;address&quot;:{&quot;line_1&quot;:&quot;1 x M 90,3&quot;,&quot;line_2&quot;:&quot;PRIVATE_VACATION_HOME 3&quot;,&quot;city&quot;:&quot;Fazana&quot;,&quot;state_province_name&quot;:&quot;Istria (county)&quot;,&quot;postal_code&quot;:&quot;52212&quot;,&quot;country_code&quot;:&quot;HR&quot;,&quot;obfuscation_required&quot;:true,&quot;localized&quot;:{&quot;links&quot;:{&quot;hr-HR&quot;:{&quot;method&quot;:&quot;GET&quot;,&quot;href&quot;:&quot;https://api.ean.com/2.4/properties/content?language=hr-HR&amp;property_id=53183065&amp;include=address&quot;}}}},&quot;ratings&quot;:{&quot;property&quot;:{&quot;rating&quot;:&quot;3.0&quot;,&quot;type&quot;:&quot;Star&quot;}},&quot;location&quot;:{&quot;coordinates&quot;:{&quot;latitude&quot;:44.93,&quot;longitude&quot;:13.8}},&quot;phone&quot;:&quot;410442743080&quot;,&quot;category&quot;:{&quot;id&quot;:&quot;17&quot;,&quot;name&quot;:&quot;Private vacation home&quot;},&quot;rank&quot;:99999999,&quot;business_model&quot;:{&quot;expedia_collect&quot;:true,&quot;property_collect&quot;:false},&quot;dates&quot;:{&quot;added&quot;:&quot;2020-05-13T21:06:42.861Z&quot;,&quot;updated&quot;:&quot;2020-05-18T21:57:39.242Z&quot;},&quot;statistics&quot;:{&quot;1073743378&quot;:{&quot;id&quot;:&quot;1073743378&quot;,&quot;name&quot;:&quot;Number of bedrooms - 2&quot;,&quot;value&quot;:&quot;2&quot;},&quot;1073743380&quot;:{&quot;id&quot;:&quot;1073743380&quot;,&quot;name&quot;:&quot;Max occupancy - 4&quot;,&quot;value&quot;:&quot;4&quot;},&quot;1073743379&quot;:{&quot;id&quot;:&quot;1073743379&quot;,&quot;name&quot;:&quot;Number of bathrooms - 2&quot;,&quot;value&quot;:&quot;2&quot;}}},&quot;chain&quot;:{&quot;id&quot;:&quot;7278&quot;,&quot;name&quot;:&quot;Belvilla&quot;},&quot;brand&quot;:{&quot;id&quot;:&quot;7353&quot;,&quot;name&quot;:&quot;Belvilla&quot;}}
{&quot;property_id&quot;:&quot;53182898&quot;,&quot;name&quot;:&quot;Snug Cottage in Pašman With Roofed Terrace&quot;,&quot;address&quot;:{&quot;line_1&quot;:&quot;Pasman&quot;,&quot;city&quot;:&quot;Pasman&quot;,&quot;state_province_name&quot;:&quot;Zadar&quot;,&quot;postal_code&quot;:&quot;23260&quot;,&quot;country_code&quot;:&quot;HR&quot;,&quot;obfuscation_required&quot;:true,&quot;localized&quot;:{&quot;links&quot;:{&quot;hr-HR&quot;:{&quot;method&quot;:&quot;GET&quot;,&quot;href&quot;:&quot;https://api.ean.com/2.4/properties/content?language=hr-HR&amp;property_id=53182898&amp;include=address&quot;}}}},&quot;ratings&quot;:{&quot;property&quot;:{&quot;rating&quot;:&quot;1.0&quot;,&quot;type&quot;:&quot;Star&quot;}},&quot;location&quot;:{&quot;coordinates&quot;:{&quot;latitude&quot;:43.891571,&quot;longitude&quot;:15.423619}},&quot;phone&quot;:&quot;410442743080&quot;,&quot;category&quot;:{&quot;id&quot;:&quot;11&quot;,&quot;name&quot;:&quot;Cottage&quot;},&quot;rank&quot;:99999999,&quot;business_model&quot;:{&quot;expedia_collect&quot;:true,&quot;property_collect&quot;:false},&quot;dates&quot;:{&quot;added&quot;:&quot;2020-05-13T21:13:49.155Z&quot;,&quot;updated&quot;:&quot;2020-05-27T21:02:31.808Z&quot;},&quot;statistics&quot;:{&quot;1073743378&quot;:{&quot;id&quot;:&quot;1073743378&quot;,&quot;name&quot;:&quot;Number of bedrooms - 2&quot;,&quot;value&quot;:&quot;2&quot;},&quot;1073743380&quot;:{&quot;id&quot;:&quot;1073743380&quot;,&quot;name&quot;:&quot;Max occupancy - 5&quot;,&quot;value&quot;:&quot;5&quot;},&quot;1073743379&quot;:{&quot;id&quot;:&quot;1073743379&quot;,&quot;name&quot;:&quot;Number of bathrooms - 1&quot;,&quot;value&quot;:&quot;1&quot;}}},&quot;chain&quot;:{&quot;id&quot;:&quot;7278&quot;,&quot;name&quot;:&quot;Belvilla&quot;},&quot;brand&quot;:{&quot;id&quot;:&quot;7353&quot;,&quot;name&quot;:&quot;Belvilla&quot;}}$$, 1626829215, 0, 2536611);
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68462891, $$Two Components Connected to Each-other$$, $$<p>Two of my React components are connected together. You might be thinking, if they are both separate components then they shouldn''t be connected, right. WRONG.</p>\n<p>What I want to do is this. I want to create a footer but the footer is apparently linked to another component. I think this is a react bug but I have decided not to go there in case it''s just my fault. I want to change the width of the footer to be max width with the screen but it doesn''t work, it changes both of the components width.</p>\n<pre><code>.footer {\n   width: 100%;\n}\n</code></pre>\n<p><div class="snippet" data-lang="js" data-hide="false" data-console="true" data-babel="false">\r\n<div class="snippet-code">\r\n<pre class="snippet-code-css lang-css prettyprint-override"><code>.footer {\n    background-color: gray;\n    border: 1px solid gray;\n    border-radius: 1px;\n    height: 100px;\n    width: 10000px; /*Or 100%*/\n}\n\n.otherComponent {\n  /*For some reason it copies the same attributes as the css one above (there in different files by the way*/\n  width: 10000px; /*Or 100%*/ /*The one that got copied by react.*/\n  background-color: gray;\n  border: 1px solid gray;\n  border-radius: 1px;\n  height: 100px;\n}</code></pre>\r\n<pre class="snippet-code-html lang-html prettyprint-override"><code>&lt;div class="otherComponent"&gt;\n\n&lt;/div&gt;\n&lt;br /&gt;\n&lt;p&gt;This is to demonstrate the bug/error that is happening with my program. And what it looks like&lt;/p&gt;\n&lt;div class="footer"&gt;\n            \n&lt;/div&gt;</code></pre>\r\n</div>\r\n</div>\n</p>$$, 1626829468, 0, 16215251);
INSERT INTO questions(id, title, body, creation_date, score, "userId") VALUES (68463051, $$How can I make a 2-D array in C using user inputs$$, $$<p>I tried to make a 2-D array given the numbers of rows and columns as the user input.</p>\n<pre><code>int main(void)\n{\n   int nx, ny;\n   scanf_s("%d", &nx);\n   scanf_s("%d", &ny);\n   int array[nx][ny];\n   return 0;\n}\n</code></pre>\n<p>But VSC is telling me that I must have constants in the parenthesis [].</p>\n<p>Is there any way I can convert ''nx'' and ''ny'' as constant?</p>\n<p>Or is there any other way to declare 2-D or N-D arrays without converting their dtype?</p>$$, 1626831485, 0, 16491792);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462871, $$plotting variables from 2 different df together$$, $$<pre><code>Data1 <- data.frame(AGE=c(20,30,15,22,80),\n                               CAR = c(1,1,3,9,1),\n                               BIKE = c(2,NA,4,NA,9),\n                               PLANE = c(8,NA,6,7,9),\n                               BOAT = c(1,2,NA,4,NA),\n                               WALKING=c(3,5,5,9,1),\n                               SCOOTER = c(2,NA,6,9,NA))\n\nData2 <- data.frame(AGE=c(20,30,15,22,80),\n                               CAR = c(1,1,3,9,1),\n                               BIKE = c(2,NA,4,NA,9),\n                               PLANE = c(8,NA,6,7,9),\n                               BOAT = c(1,2,NA,4,NA),\n                               WALKING=c(3,5,5,9,1),\n                               SCOOTER = c(2,4,6,9,3))\n</code></pre>\n<p>I have a data frame <code>Data1</code> where I imputed the missing values in the variable “SCOOTER” to get Data2.</p>\n<p>I want to do a density plot for the variable <code>SCOOTER</code> using both <code>Data1</code> and <code>Data2</code>. I can do this separately;</p>\n<pre><code>Plot <- ggplot(data=Data1, aes(x=SCOTTER)) +\n        geom_histogram(aes(y=..density..), colour="black", fill="white")+ \n        geom_density(alpha=.2, fill="Blue")+ \n        xlab(''Data1 table'')+ \n        ylab(''Probability Density Function'')\n\nPlot <- ggplot(data=Data2, aes(x=SCOTTER)) +\n        geom_histogram(aes(y=..density..), colour="black", fill="white")+ \n        geom_density(alpha=.2, fill="pink")+ \n        xlab(''Data2 table'')+ \n        ylab(''Probability Density Function'')\n</code></pre>\n<p>Is there a way to combine these plots together - so I have the plots on the same frame like this:</p>\n<p><a href="https://i.stack.imgur.com/lb3Z7.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/lb3Z7.png" alt="enter image description here" /></a></p>$$, 1626829209, 0, 16491668);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68463071, $$Why can''t I call other functions inside a friend function?$$, $$<p>I have a <code>Vector</code> class that for which I''m trying to implement a friend <code>Insert</code> function.</p>\n<pre><code>template<typename T, class ALLOCATOR>\nclass Vector {\npublic:\n    void Insert() { ... }\n    uint32_t GetLength() { ... }\n\n    friend void Insert(const Vector& vector, auto& buffer) {\n        Insert(vector.GetLength(), buffer); //this line gets the error\n        for (const auto& e : vector) { Insert(e, buffer); }\n    }\n}\n</code></pre>\n<p>But when I do so the compiler says that I can''t call a non static function without an object as if I was trying to call <code>Vector::Insert</code> instead of a free function.</p>\n<p>And when I tried to move the definition outside of the class.</p>\n<pre><code>template<typename T, class ALLOCATOR>\nvoid Insert(const Vector<T, ALLOCATOR>& vector, auto& buffer) {\n        Insert(vector.GetLength(), buffer); //this line gets the error\n        for (const auto& e : vector) { Insert(e, buffer); }\n}\n</code></pre>\n<p>Then I got an undefined symbol linker error saying that no code was found for some of the <code>Vector</code> instantiations in my code.\nI tried using <code>::Insert</code> but that still didn''t work.\nAll necessary <code>Insert</code> overloads are defined.\nAll code is in an <code>.hpp</code> file so it''s not that the overloads were defined in a <code>.cpp</code> file.</p>$$, 1626831783, -1, 11003927);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462966, $$Very weird $_GET behavior (parameters getting mixed)$$, $$<p>I just came across a really strange issue while debugging some PHP.\nHere is the querystring</p>\n<pre><code>https://example.com/password-recovery?token=2328chsd790slo7jsal&amp;id_customer=40\n</code></pre>\n<p>For some reason, when using $_GET, it returns:</p>\n<pre><code>[token] => 2328chsd790slo7jsal&amp;id_customer\n[id_customer] => 40\n</code></pre>\n<p>Thus, token is always containing a bad value. It''s the first time I see this in over 16 years. Is it some wrong server setting? Everything else on the site works correctly, only this specific page is broken</p>\n<p>As requested, here is the htaccess (changed the URL of the site to example.com)</p>\n<pre><code>modpagespeed off\nphp_value auto_prepend_file /home/example/public_html/astra/astra-inc.php\n# ~~start~~ Do not remove this comment, Prestashop will keep automatically the code outside this comment when .htaccess will be generated again\n... (htaccess content) ...\n</code></pre>$$, 1626830390, 0, 1707385);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462992, $$How to make new variables using exec() in imported method (python)$$, $$<p>get_data.py</p>\n<pre><code>import pandas as pd\n\ndef get_data(names):\n    print(''Loading data...'')\n\n    for name in names:\n        exec(f''''{name} = pd.read_csv(\\'\\'{name}.csv\\\\'')'''', globals())\n\n    print(''Data successfully loaded.)\n</code></pre>\n<p>main.py</p>\n<pre><code>from get_data import *\n\nnames = [''apple'', ''banana'', ''tomato'']\nget_data(names)\n\napple.head()\n</code></pre>\n<p>I want to do this.</p>\n<p>But it is not working T.T</p>\n<p>What should I do</p>\n<p>Please help me...</p>$$, 1626830709, 0, 13840401);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462993, $$python print format, read indentation value from a variable$$, $$<pre><code>print(''{:&gt;85} ''.format("PASS"))\n</code></pre>\n<p>This is working fine,\nI want to read that 85 from a variable</p>\n<pre><code>indent = 85\nprint(''{:&gt;indent} ''.format("PASS"))\n</code></pre>$$, 1626830723, 0, 6890628);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462897, $$Force Bootstrap Columns to Stay Within Container$$, $$<p>I am trying to have a two row hierarchy display for some photos using bootstrap 5. However, rather than staying within the container the images overflow out. How can I make them dynamically resize to fit the container?</p>\n<pre class="lang-html prettyprint-override"><code>&lt;link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" /&gt;\n\n&lt;div class="container" style="height: 100vh; background-color: yellow;"&gt;\n    &lt;div class="row justify-content-center"&gt;\n        &lt;div class="col col-12 col-md-4"&gt;\n            &lt;img class="w-100 p-5" src="https://via.placeholder.com/1080" style="border-radius: 80px;"&gt;\n        &lt;/div&gt;\n    &lt;/div&gt;\n    &lt;div class="row"&gt;\n        &lt;div class="col col-12 col-md-4"&gt;\n            &lt;img class="w-100 p-5" src="https://via.placeholder.com/1080" style="border-radius: 80px;"&gt;\n        &lt;/div&gt;\n        &lt;div class="col col-12 col-md-4"&gt;\n            &lt;img class="w-100 p-5" src="https://via.placeholder.com/1080" style="border-radius: 80px;"&gt;\n        &lt;/div&gt;\n        &lt;div class="col col-12 col-md-4"&gt;\n            &lt;img class="w-100 p-5" src="https://via.placeholder.com/1080" style="border-radius: 80px;"&gt;\n        &lt;/div&gt;\n    &lt;/div&gt;\n&lt;/div&gt;\n</code></pre>\n<p>The elements are overflowing like this:\n<a href="https://i.stack.imgur.com/bABWX.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/bABWX.png" alt="Overflowing images" /></a></p>\n<p>I want it to instead scale down the images to look like this:\n<a href="https://i.stack.imgur.com/sKkWU.png" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/sKkWU.png" alt="Images fitting" /></a></p>\n<p>I tried setting a fixed height on the container but then the images fill the entire screen. Is there another method so that the images dynamically resize?</p>$$, 1626829520, 1, 12941336);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462977, $$How to change windows resolution programmatically java$$, $$<p>I want to change the resolution of windows, similar to the NVIDIA Control Panel, and have it persist even when other applications are loaded. Can this be done? If not, know any alternatives?</p>$$, 1626830546, -3, 16427935);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462981, $$Problems with load() on JQuery$$, $$<p>I''m now working with AJAX and I noticed that I cannot use the <code>load()</code> function with JQuery,</p>\n<pre><code>$(\'#content\').load(\\'http://localhost/HTML/acerca_de.html\\' , \\'#content\\'); \n</code></pre>\n<p>I loaded a file on my local host and tried to display it in the element with id "content". This is basic AJAX as described in Jon Duckett''s Javascript book, but it doesn''t work.</p>$$, 1626830605, -1, 16491742);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462955, $$SQL detecting changes in a column$$, $$<p>I have a table in my database</p>\n<p>Events</p>\n<pre><code>Date,Time,EventCode\n1/1/2020, 7AM, F\n1/2/2020, 8AM, N\n1/3/2020, 9AM, S\n1/4/2020, 9AM, L\n1/6/2020, 9AM, Z\n</code></pre>\n<p>I am learning how to write a query that can detect when the EventCode changes from N to any value after N. We don''t care about values prior to N.</p>\n<p>If I search between 1/3/2020 and 1/6/2020 there would be no data reported because no initial N exists. However, if I search from 1/2/2020 to 1/3/2020, I would get two rows: the row containing N and the row immediately after.</p>\n<p>Using SQL Server 2016/2019.</p>$$, 1626830249, 0, 399508);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462957, $$Django Invalid Filter$$, $$<p>I''m getting the following error message from my API request:</p>\n<pre><code>{\n    "errors": [\n        {\n            "detail": "Select a valid choice. That choice is not one of the available choices.",\n            "status": "400",\n            "source": {\n                "pointer": "/data/attributes/branch"\n            },\n            "code": "invalid_choice"\n        }\n    ]\n}\n</code></pre>\n<p>I''m struggling with this because I have other ViewSets with the same structure that work fine when filtering by an FK.</p>\n<p>Endpoint:</p>\n<pre><code>http://localhost:8000/templates/?page[number]=1&filter[branch]=7KzZ5vLWlydlNbG&filter[name]=Client%20Portal%20Invitation\n</code></pre>\n<p>For context, my backend uses Django DRF JsonAPI. (Model, Serializer, ViewSet, and Filterset details omitted for brevity.)</p>$$, 1626830266, 0, 9745257);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462965, $$javascript &#39;this &#39;keyword in nested object return undefined$$, $$<p>This return undefined</p>\n<pre><code> cat = {\n  category: &quot;Great dane&quot;,\n  object: {\n  type: &quot;ccc&quot;,\n  getType() {\n    alert(this.category); //why this cannot access category\n  }\n  }\n}\n\ncat.object.getType();\n</code></pre>\n<p>this retun the value &#39;great dane&#39;</p>\n<pre><code> dog = {\n  type: &quot;Great dane&quot;,\n  getType() {\n    // this = dog\n    alert(this.type); //why this can access type\n  }\n}\n\ndog.getType();\n</code></pre>\n<p>can anybody explain what is the different between the two ?</p>\n$$, 1626830376, 0, 16403602);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68463019, $$How can i put my searchbox and navbar at the same line?$$, $$<p>I&#39;m trying to make my search box in the same line with the &quot;home, about, contact...&quot; stuff but it doesn&#39;t seem to worrk, i guess my CSS just not enough to make that, can anyone help me to make them stand in the same line? Thank you so much!</p>\n<p>This is css:</p>\n<pre><code>.container{\n\n    background-color: #A3318A;\n}\n\n.container ul{\n    display: inline block;\n\n}\n\n.container ul li {\n    \n    display: inline;\n    padding:15px;\n    font-size: 1.5rem;\n    color: white;\n\n}\n</code></pre>\n<p>This is my html:</p>\n<pre><code>&lt;!DOCTYPE html&gt;\n&lt;html&gt;\n&lt;head&gt;\n    &lt;title&gt;&lt;/title&gt;\n    &lt;link rel=&quot;stylesheet&quot;  href=&quot;style.css&quot;&gt;\n    &lt;script src=&quot;https://kit.fontawesome.com/48a972c999.js&quot; crossorigin=&quot;anonymous&quot;&gt;&lt;/script&gt;\n&lt;/head&gt;\n&lt;body&gt;\n\n    &lt;div class=&quot;container&quot;&gt;\n        &lt;ul&gt;\n            &lt;li&gt;Home&lt;/li&gt;\n            &lt;li&gt;About&lt;/li&gt;\n            &lt;li&gt;News&lt;/li&gt;\n            &lt;li&gt;Contact&lt;/li&gt;\n        &lt;/ul&gt;\n        &lt;form&gt;\n            &lt;input class=&quot;input&quot; type=&quot;text&quot; placeholder=&quot;Search here...&quot;&gt;\n            &lt;i class=&quot;fas fa-search&quot;&gt;&lt;/i&gt;\n        &lt;/form&gt;\n    &lt;/div&gt;\n\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p><a href=\"https://i.stack.imgur.com/zFiCk.png\" rel=\"nofollow noreferrer\"><img src=\"https://i.stack.imgur.com/zFiCk.png\" alt=\"my image\" /></a></p>\n$$, 1626831097, 0, 16389635);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462907, $$Communication between components in layout$$, $$<p>I have a <code>Layout.jsx</code> to define a layout for the whole website. It consists of:</p>\n<ul>\n<li>Navigation bar (always same content for all pages)</li>\n<li>Sub Header (changes based on each page)</li>\n<li>Content (actual content of the page)</li>\n<li>Aside, Footer, ... for simplicity we ignore these in this example.</li>\n</ul>\n<p>On one of the page&#39;s Sub Header, (report page sub header) I want to have a <code>&lt;Tab&gt;</code>: &quot;Chart View&quot; and &quot;Table View&quot;.</p>\n<ul>\n<li>When user clicks on Chart, the content of the layout displays <code>&lt;ChartView /&gt;</code> and if clicks on &quot;Table View&quot; the content of the main page displays <code>&lt;TableView /&gt;</code></li>\n</ul>\n<p>Layout.jsx</p>\n<pre><code>function Layout() {\n  // Define all the pages and their routes/content/subheader ...\n  const pages = [\n    {\n      path: &#39;/user&#39;,\n      content: &lt;UserPage /&gt;,\n      subheader: &lt;UserSubHeader /&gt;\n    },\n    {\n      path: &#39;/report&#39;,\n      content: &lt;ReportPage /&gt;,\n      subHeader: &lt;ReportSubHeader /&gt;\n    }\n  ];\n  return(\n    &lt;&gt;\n      &lt;div class=&quot;Navbar&quot;&gt;&lt;Navbar /&gt;&lt;/div&gt;\n      &lt;Sidebar /&gt;\n      {pages.map(page =&gt; (  // &lt;-------- Loop thought the pages array and render using a Switch and Router.\n        &lt;Route path={page.path}&gt;\n          &lt;div class=&quot;subheader&quot;&gt;\n            {page.subheader}\n          &lt;/div&gt;\n          &lt;div class=&quot;main&quot;&gt;\n          {page.content}\n          &lt;/div&gt;\n        &lt;/Route&gt;\n      ))}\n    &lt;/&gt;\n  );\n}\n</code></pre>\n<p>ReportSubHeader.jsx</p>\n<pre><code>function ReportSubHeader() {\n  return(\n    &lt;Tabs value={value} onChange={handleChange} &gt;\n          &lt;Tab label=&quot;Chart View&quot;  /&gt;\n          &lt;Tab label=&quot;Table View&quot;  /&gt;\n    &lt;/Tabs&gt;\n  )\n}\n</code></pre>\n<p>ReportPage.jsx</p>\n<pre><code>function ReportPage() {\n  // if first Tab is selected display Chart View,\n  // otherwise display TableView\n  return (\n    &lt;&gt;\n    &lt;TabPanel&gt;\n      &lt;ChartView /&gt;\n    &lt;/TabPanel&gt;\n    &lt;TabPanel&gt;\n      &lt;TableView /&gt;\n    &lt;/TabPanel&gt;\n  &lt;/&gt;);\n}\n</code></pre>\n<p><strong>Questions</strong></p>\n<ol>\n<li><p>How to implement this so that the two components can communicate (clicking on ReportSubHeader, causes change in the ReportPage selected tab)?</p>\n</li>\n<li><p>Is this a good way of defining the layout? (when I might have communication parts in the layout)</p>\n</li>\n</ol>\n<p><strong>Notes</strong></p>\n<ul>\n<li>One thing I can think of is using Application Context.</li>\n<li>Apparently Material UI <code>&lt;Tab&gt;</code> and its <code>&lt;TabPanel&gt;</code> cannot be in separate components (as far as I know.) I&#39;m ok to create a custom Tab component for this purpose.</li>\n</ul>\n$$, 1626829676, 0, 4505446);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462597, $$Convert an string to object with duplicate keys to an array$$, $$<p>I have a string that needs to be converted to an object. But the string has the duplicated items. Since JSON Objects cannot contain 2 items with the same key. The second item is overwriting the first item.\nHow to merge the duplicate items and push to an array?</p>\n<pre><code>var string = &quot;test-1=owner&amp;test-1=driver&amp;test-2=Yes&amp;test-3=2&amp;test-4=sun&amp;test-4=moon&amp;test-5=not-agree&amp;test-6=dogs&amp;test-6=testing+js+object&amp;test-7=Testing+js+function&amp;test-7=Testing+js+array&quot;\n\nvar stringMod = string.split(&quot;&amp;&quot;);\n\n\nvar stringObj = {};\n\nstringMod.forEach(function(json) {\n  var jsonSplit = json.split(&quot;=&quot;);\n\n  stringObj[jsonSplit[0]] = [jsonSplit[1]];\n});\n\nconsole.log(stringObj,&#39;stringObj&#39;);\n</code></pre>\n<p>Desired output:</p>\n<pre><code>{\n  &quot;test-1&quot;: [&quot;owner&quot;,&quot;driver&quot;],\n  &quot;test-2&quot;: [&quot;Yes&quot;],\n  &quot;test-3&quot;: [&quot;2&quot;],\n  &quot;test-4&quot;: [&quot;sun&quot;,&quot;moon&quot;],\n  &quot;test-5&quot;: [&quot;not-agree&quot;],\n  &quot;test-6&quot;: [&quot;dogs&quot;,&quot;testing+js+object&quot;],\n  &quot;test-7&quot;: [&quot;Testing+js+function&quot;,&quot;Testing+js+array&quot;]\n}\n</code></pre>\n<p>Here is the link to working fiddle: <a href=\"https://jsfiddle.net/sjoh9rqp/\" rel=\"nofollow noreferrer\">https://jsfiddle.net/sjoh9rqp/</a></p>\n<p>Can you help me how to accomplish this ?</p>\n$$, 1626825806, 0, 7921161);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462861, $$Vector declared in header file isn&#39;t being recognized C++$$, $$<p>I have been having a lot of issues with header files, and now it seems that the vector that is declared in my header file, Polynomial.hpp, is not being recognized in Polynomial.cpp. I have already included std:: which seems to be a common mistake, so I don&#39;t know where to go from here.</p>\n<p>Header file:</p>\n<pre><code>#ifndef POLYNOMIAL_HPP\n#define POLYNOMIAL_HPP\n\n#include&lt;vector&gt;\n#include&quot;term.hpp&quot;\n\nclass Polynomial {\n    \nprivate:\n    std::vector&lt;Term&gt; vect;\n    \npublic:\n    Polynomial();\n    ~Polynomial();\n    void add(Term t);\n    void print();\n    Polynomial combineLikeTerms();\n    \n};\n\n#endif\n</code></pre>\n<p>cpp File:</p>\n<pre><code>#include &quot;term.hpp&quot;\n#include &quot;Polynomial.hpp&quot;\n#include&lt;iostream&gt;\n#include&lt;map&gt;\n\nusing namespace std;\n\nvoid add(Term t) {\n    vect.push_back(t);\n}\n\nvoid print() {\n    for(int i = 0; i &lt; vect.size(); i++) {\n        cout &lt;&lt; vect[i].toString();\n    }\n}\n    \nPolynomial combineLikeTerms() {\n    Polynomial poly;\n    map&lt;int, int&gt; combinedPoly;\n    \n    for(int j = 0; j &lt; vect.size(); j++)\n    {\n        combinedPoly.insert(pair&lt;int, int&gt;(vect[j].getExponent(), vect[j].getCoefficient());\n    }\n                            \n    for(map&lt;int,int&gt;::iterator itr = combinedPoly.begin(); itr != combinedPoly.end(); itr++) {\n            Term newTerm(itr-&gt;second, &quot;x&quot;, itr-&gt;first);\n            poly.add(newTerm);\n        }\n        \n    return poly;\n                    \n}\n</code></pre>\n<p>Error (1/6):</p>\n<blockquote>\n<p>Polynomial.cpp:9:5: error: use of undeclared identifier &#39;vect&#39;\nvect.push_back(t);</p>\n</blockquote>\n$$, 1626829098, 0, 14471249);
INSERT INTO questions (id, title, body, creation_date, score, "userId") VALUES (68462550, $$I need help on comparing using operators in a guessing game - tkinter$$, $$<p>So basically, I am making a guessing game in Tkinter. I am comparing numbers to check if the number the user has guessed is greater, lesser, or the same compared to the randomly generated number. I am getting an error about my operator so please provide the correct code, thanks. Here is my code:</p>\n<pre class=\"lang-py prettyprint-override\"><code>from tkinter import messagebox\nimport random\nfrom tkinter import *\nroot = Tk()\nr = random.randint(1,100)\nroot.title(&quot;Game thing&quot;)\ndef clear():\n    number_entry1.delete(0,END)\ndef quit():\n    exit()\ndef Guessnumber():\n    if number_entry1.get() &gt; int(r):\n        m1 = messagebox.showinfo(&quot;Sorry&quot;,&quot;Lower&quot;)\n    elif number_entry1.get() &lt; int(r):\n        m2 = messagebox.showinfo(&quot;Sorry&quot;,&quot;Higher&quot;)\n    else:\n        m3 = messagebox.showinfo(&quot;Congratulations&quot;,&quot;You Got It!&quot;)\n\nmessage_label = Label(root,text = &quot;Guess the number form (1 - 100)&quot;)\nmessage_label.grid(row = 0, column = 0)\nnumber_entry1 = Entry(root)\nnumber_entry1.grid(row = 0, column = 1,columnspan = 2)\nguess_button = Button(root,text = &quot;Guess Number&quot;,fg = &quot;green&quot;,command = Guessnumber)\nguess_button.grid(row = 1, column = 0, sticky = W)\nclear_button = Button(root,text = &quot;Clear&quot;,fg = &quot;blue&quot;,command = clear)\nclear_button.grid(row = 1, column = 1, sticky = W)\nquit_button = Button(root,text = &quot;Quit&quot;,fg = &quot;red&quot;,command = exit)\nquit_button.grid(row = 1, column = 2, sticky = E)\n</code></pre>\n<p>Thanks!!! Also if you could I would like an explanation on why I am getting an error.\nAgain thanks for all the help everyone</p>\n$$, 1626825353, 0, 16139854);


-- Insert Answers
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68462942,
   $$<p>As mentioned in the comments you can use [[nodiscard]] as per:</p>
<p><a href="https://docs.microsoft.com/en-us/cpp/cpp/attributes?view=msvc-160" rel="nofollow noreferrer">https://docs.microsoft.com/en-us/cpp/cpp/attributes?view=msvc-160</a></p>
<p>And modify to use this warning as compile error:</p>
<p><a href="https://docs.microsoft.com/en-us/cpp/preprocessor/warning?view=msvc-160" rel="nofollow noreferrer">https://docs.microsoft.com/en-us/cpp/preprocessor/warning?view=msvc-160</a></p>
<p>That should cover your use case.</p>$$,
   1626830114,
   -1,
   8550160,
   68462879,
   false
  ),
  (68463003,
   $$<p>For doing this at runtime there are recipes online about "exploding" types (they assert on destruction if they where not checked).</p>
<p>For compile-time it is more tricky, returning (for example a <code>bool</code>) with <code>[[nodiscard]]</code> is not enough because there are ways of no discarding without checking for example assigning to a (bool) variable.</p>
<p>I think the next layer is to active <code>-Wunused-variable -Wunused-expression</code> (and treat it like an error).
Then it is much harder to not check the bool because that is pretty much to only operation you can really do with a bool.
(You can assign to another bool but then you will have to use that variable).</p>
<p>I guess that&apos;s quite enough.</p>
<p>There are still Machiavelian ways to mark a variable as used.
For that you can invent a <code>bool</code>-like type (class) that is 1) <code>[[nodiscard]]</code> itself (classes can be marked <code>nodiscard</code>), 2) the only supported operation is <code>==(bool)</code> or <code>!=(bool)</code> (maybe not even copyable) and return that from your function. (as a bonus you don&apos;t need to mark your function as <code>[[nodiscard]]</code> because it is automatic.)</p>
<p>I guess it is impossible to avoid something like <code>(void)b;</code> but that in itself becomes a flag.</p>$$,
   1626830859,
   1,
   225186,
   68462879,
    false
  );

INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68463046,
   $$<p>There are no calls to <code>add_items()</code>, and thus no items in the list.</p>$$,
   1626831438,
   0,
   68587,
   68463022,
   false
  );
  
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68463097,
   $$<p>Thank you to @ Dave Newton who mentioned that my returned arrays appeared to be backwards I was able to swap the return values so the correct code is now:</p>
<pre><code>function partitionBooksByBorrowedStatus(books) {
let available = [];
let unavailable = [];
const bookStatuses = [];
books.forEach((book) => {
  const isBookReturned = book.borrows[0].returned;

  if (isBookReturned) { // if book is not returned
    unavailable.push(book);
  } else { // if book is returned
    available.push(book);
  }
});
bookStatuses.push(available);
bookStatuses.push(unavailable);
return bookStatuses;
}
</code></pre>$$,
   1626832031,
   0,
   16490359,
   68462964,
    true
  );

INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68463102,
   $$<p>This can be done fairly easily with JavaScript&apos;s Array reduce method.  You need to provide the initial accumulator with an object that maps the expected output and then populate one of the two arrays depending on whether the book has at least one occurrence of the book not being returned.  (Could also be done by testing the number of "returned == true" is odd)</p>\n<p>Assumption: A book that&apos;s never been borrowed should count as "being returned"</p>\n<p>[snipped code snippet]</p>\n$$,
   1626832073,
   0,
   2487517,
   68462964, 
   true
  );
  
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68462946,
   $$<p>Save the original state of the tab in a variable, then <a href="https://developer.mozilla.org/en-US/docs/Web/API/DOMTokenList/toggle" rel="nofollow noreferrer">toggle</a> the opposite of the original state on the clicked tab after closing all.</p>
<pre><code>tabButtons.forEach((btn) =&gt; {
    btn.addEventListener(\'click\', selectTab)
});
function selectTab() {
    const tab = tabAnswers[this.dataset.tab];
    const makeThisActive = !tab.classList.contains(\'faq__tab__answer--active\');
    tabButtons.forEach((button) =&gt; {
        button.classList.remove(\'faq__tab__qeustion-btn--active\');
    });
    tabAnswers.forEach((answer) =&gt; {
        answer.classList.remove(\'faq__tab__answer--active\');
    });
    this.classList.toggle(\'faq__tab__qeustion-btn--active\', makeThisActive);
    tab.classList.toggle(\'faq__tab__answer--active\', makeThisActive);
}
</code></pre>
<p>I\'d also recommend fixing the <code>qeustion</code> - looks like a typo, and typos are frequent causes of bugs in programming.</p>$$,
   1626830137,
   0,
   9515207,
   68462918, true);
     
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68462998,
   $$<p>Why you remove tabAnswers class from itself,</p>
<pre><code>tabAnswers.forEach(answer =&gt; {
  answer.classList.remove(\'faq__tab__answer--active\');
})
</code></pre>
<p>but add tabAnswers class on \'data-tab\'?</p>
<p><code>tabAnswers[this.getAttribute(\'data-tab\')].classList.add(\'faq__tab__answer--active\');</code></p>
<hr />
<p>Can you <strong>show more your code</strong> or post your code in any live demo web site, like Codepen?</p>$$,
   1626830792,
   0,
   10684332,
   68462918, false);

INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68463072,
   $$<p>When using <code>new Wrapper&lt;String&gt;(\'Hello\')</code> as an argument to <code>copy_v1</code>, the inferred type is <code>Wrapper<Object></code>, whereas with your first example, the type of <code>objectWrapper</code> is <code>Wrapper<String></code>.</p>\n<p>Essentially:</p>\n<pre><code>copy_v1(new Wrapper<>(\'Hello\'), new Wrapper<>(new Object()));\n</code></pre>\n<p>is equivalent to:</p>\n<pre><code>Wrapper<Object> objectWrapper = new Wrapper<>(new Object());\nWrapper<Object> stringWrapper = new Wrapper<>(\'Hello\');\ncopy_v1(stringWrapper, objectWrapper);\n</code></pre>\n<p>which isn''t quite what you have in your first case.</p>$$,
   1626831800,
   1,
   10082297,
   68463043, false);

INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68463077,
   $$<p>Here you go:</p>
<pre><code>date_index=pd.date_range(start=''1/1/2013'', end=''31/12/2013'')
for i in df.id.unique():
    dates=pd.concat([dates,pd.DataFrame({''date'':date_index, ''id'' : np.full(len(date_index),i)})])
df.diagnosis_date = pd.to_datetime(df[''diagnosis_date''])
df1 = pd.merge(dates,df, left_on=[''id'',''date''], right_on=[''id'',''diagnosis_date''], how=''left'')[[''date'',''id'',''disease'']].fillna(0)
df1[''disease''] = df1.disease.astype(int)
</code></pre>
<p>Tested and prints correctly.</p>$$,
   1626831851,
   0,
   13628883,
   68462917, false);

INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68463107,
   $$<p>Try this..</p>
<pre><code>df = pd.read_clipboard() #read in your dataframe from clipboard

dfp = df.pivot(''diagnosis_date'', ''id'', ''disease'') #reshape dataframe
dfp.index = pd.to_datetime(dfp.index) #cast index to datetime

dfp.reindex(pd.date_range(''1/1/2013'',''12/31/2013''))\\  #add rows with reindex and pd.date_range
   .rename_axis(''date'').fillna(0)\\  #fill with zeroes
   .stack().rename(''disease'')\\  #Reshape back to original shape
   .reset_index()\\
   .sort_values([''id'', ''date''])  #and sort
</code></pre>$$,
   1626832137,
   0,
   6361531,
   68462917, false);

INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68462930,
   $$<p>One approach with <a href="https://pandas.pydata.org/docs/reference/api/pandas.Series.str.join.html" rel="nofollow noreferrer"><code>str.join</code></a> + <a href="https://pandas.pydata.org/docs/reference/api/pandas.Series.str.get_dummies.html" rel="nofollow noreferrer"><code>str.get_dummies</code></a>:</p>
<pre><code>out = df[''x''].str.join('','').str.get_dummies('','')
</code></pre>
<p><code>out</code>:</p>
<pre><code>   abc  bac  cab
0    1    1    1
1    0    1    0
2    1    0    1
</code></pre>
<p>Or with <a href="https://pandas.pydata.org/docs/reference/api/pandas.Series.explode.html" rel="nofollow noreferrer"><code>explode</code></a> + <a href="https://pandas.pydata.org/docs/reference/api/pandas.get_dummies.html" rel="nofollow noreferrer"><code>pd.get_dummies</code></a> then <a href="https://pandas.pydata.org/docs/reference/api/pandas.core.groupby.GroupBy.max.html" rel="nofollow noreferrer"><code>groupby max</code></a>:</p>
<pre><code>out = pd.get_dummies(df[''x''].explode()).groupby(level=0).max()
</code></pre>
<p><code>out</code>:</p>
<pre><code>   abc  bac  cab
0    1    1    1
1    0    1    0
2    1    0    1
</code></pre>
<hr />
<p>Can also do <a href="https://pandas.pydata.org/docs/reference/api/pandas.crosstab.html" rel="nofollow noreferrer"><code>pd.crosstab</code></a> after <code>explode</code> if want counts instead of dummies:</p>
<pre><code>s = df[''x''].explode()
out = pd.crosstab(s.index, s)
</code></pre>
<p><code>out</code>:</p>
<pre><code>x      abc  bac  cab
row_0               
0        1    1    1
1        0    1    0
2        1    0    1
</code></pre>
<p>*Note output is the same here, but will be count if there are duplicates.</p>
<hr />
<p>DataFrame:</p>
<pre><code>import pandas as pd

df = pd.DataFrame({
    ''x'': [[''abc'', ''bac'', ''cab''], [''bac''], [''abc'', ''cab'']]
})
</code></pre>$$,
   1626829981, 1, 15497888, 68462912, false);

INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68462974,
   $$<p>try this, you will have to install NewtonsoftJson</p>
<pre><code>var jsonOrig= ...your json
var json = JsonConvert.SerializeObject(jsonOrig);
var jsonObj = JsonConvert.DeserializeObject&lt;DataRoot&gt;(json);
</code></pre>
<p>classes</p>
<pre><code>public class DataRoot
    {
        public string property_id { get; set; }
        public string name { get; set; }
        public Address address { get; set; }
        public Location location { get; set; }
        public string phone { get; set; }
        public Category category { get; set; }
        public int rank { get; set; }
        public BusinessModel business_model { get; set; }
        public Dates dates { get; set; }
        public Chain chain { get; set; }
        public Brand brand { get; set; }
    }
public class ArSA
    {
        public string method { get; set; }
        public string href { get; set; }
    }

    public class Links
    {
        [JsonProperty(&quot;ar-SA&quot;)]
        public ArSA ArSA { get; set; }
    }

    public class Localized
    {
        public Links links { get; set; }
    }

    public class Address
    {
        public string line_1 { get; set; }
        public string city { get; set; }
        public string state_province_name { get; set; }
        public string postal_code { get; set; }
        public string country_code { get; set; }
        public bool obfuscation_required { get; set; }
        public Localized localized { get; set; }
    }

    public class Coordinates
    {
        public double latitude { get; set; }
        public double longitude { get; set; }
    }

    public class Location
    {
        public Coordinates coordinates { get; set; }
    }

    public class Category
    {
        public string id { get; set; }
        public string name { get; set; }
    }

    public class BusinessModel
    {
        public bool expedia_collect { get; set; }
        public bool property_collect { get; set; }
    }

    public class Dates
    {
        public DateTime added { get; set; }
        public DateTime updated { get; set; }
    }

    public class Chain
    {
        public string id { get; set; }
        public string name { get; set; }
    }

    public class Brand
    {
        public string id { get; set; }
        public string name { get; set; }
    }
$$,
   1626830497, 1, 11392290, 68462872, false);

INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68463091,
   $$<p>It is not deserializing because it is not valid json. To make it valid, and to make it a <code>List&lt;Property&gt;</code> add <code>{[</code> to the beginning of the json and <code>]}</code> to the end of the json. Just enclose the json in <code>{[ ... ]}</code> to make it valid and it will deserialize assuming the rest of it is valid and is not missing any commas or brackets.</p>$$,
   1626831997, 0, 14703882, 68462872, false);

INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68463082,
   $$<p>C99 introduced "Variable Length Arrays" (<a href="https://en.wikipedia.org/wiki/Variable-length_array" rel="nofollow noreferrer">"VLAs"</a>), but I would strongly discourage their use.
Your best bet is to use good old <a href="https://man7.org/linux/man-pages/man3/malloc.3.html" rel="nofollow noreferrer">malloc()</a></p>
<blockquote>
<p>EXAMPLE:</p>
<p><a href="https://www.geeksforgeeks.org/dynamically-allocate-2d-array-c/" rel="nofollow noreferrer">https://www.geeksforgeeks.org/dynamically-allocate-2d-array-c/</a></p>
<pre><code>#include <stdio.h>
#include <stdlib.h>
 
int main()
{
    int r = 3, c = 4; //Taking number of Rows and Columns
    int *ptr, count = 0, i;
    ptr = (int *)malloc((r * c) * sizeof(int)); //Dynamically Allocating Memory
    for (i = 0; i < r * c; i++)
    {
        ptr[i] = i + 1; //Giving value to the pointer and simultaneously printing it.
        printf("%d ", ptr[i]);
        if ((i + 1) % c == 0)
        {
            printf("\n");
        }
    }
    free(ptr);
}
</code></pre>
</blockquote>$$,
   1626831925,
   1,
   421195,
   68463051, false);

INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68462987,
   $$<p>The only thing I can think of regarding your issue is that you have <code>height: 100vh</code> set on your container. Remove it.</p>
<p>For example, when I removed the fixed height, the container scaled dynamically. (See the provided snippet for details.)</p>$$,
   1626830670,
   1,
   13888590,
   68462897, false);

-- (For Question 68462955)
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted)
VALUES
  (68462989,
   $$<p>You can use <code>LEAD()</code> and <code>LAG()</code> to peek at the next and previous rows respectively. For example:</p>
<pre><code>select
  date, time, eventcode
from (
  select *,
    lead(eventcode) over(order by date) as next_code,
    lag(eventcode) over(order by date) as prev_code
  from events
  where date between ''2020-01-03'' and ''2020-01-06''
) x
where eventcode = ''N'' and next_code <> ''N''
   or eventcode <> ''N'' and prev_code = ''N''
</code></pre>$$,
   1626830684,
   0,
   6436191,
   68462955, false);
-- (For Question 68463019)
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted) VALUES (68463058, $$<p>Make <code>form</code> with <code>display: inline-block</code>:</p>\n<pre><code>form, /* added */\n.container ul{\n  display: inline-block; /* fixed */\n}\n</code></pre>\n$$, 1626831564, 0, 2930038, 68463019, FALSE);
-- (For Question 68462597)
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted) VALUES (68462654, $$<p>For variety, here&#39;s the answer solved with reduce(), though I have to admit URLSearchParams is more elegant</p>\n<p><div class=\"snippet\" data-lang=\"js\" data-hide=\"false\" data-console=\"true\" data-babel=\"false\">\r\n<div class=\"snippet-code\">\r\n<pre class=\"snippet-code-js lang-js prettyprint-override\"><code>var string = &quot;test-1=owner&amp;test-1=driver&amp;test-2=Yes&amp;test-3=2&amp;test-4=sun&amp;test-4=moon&amp;test-5=not-agree&amp;test-6=dogs&amp;test-6=testing+js+object&amp;test-7=Testing+js+function&amp;test-7=Testing+js+array&quot;\n\nlet obj = string.split(&#39;&amp;&#39;).reduce((b,a) =&gt; {\n  let t = a.split(&#39;=&#39;);\n  if (b.hasOwnProperty(t[0])) b[t[0]].push(t[1]);\n  else  b[t[0]] =[t[1]];\n  return b;\n},{});\nconsole.log(obj)</code></pre>\r\n</div>\r\n</div>\r\n</p>\n$$, 1626826470, 0, 1772933, 68462597, FALSE);
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted) VALUES (68462672, $$<p>You can use a URLSearchParams to accomplish this, since it treats the string as url parameters it does do decoding though.</p>\n<p><div class=\"snippet\" data-lang=\"js\" data-hide=\"false\" data-console=\"true\" data-babel=\"false\">\r\n<div class=\"snippet-code\">\r\n<pre class=\"snippet-code-js lang-js prettyprint-override\"><code>var string = &quot;test-1=owner&amp;test-1=driver&amp;test-2=Yes&amp;test-3=2&amp;test-4=sun&amp;test-4=moon&amp;test-5=not-agree&amp;test-6=dogs&amp;test-6=testing+js+object&amp;test-7=Testing+js+function&amp;test-7=Testing+js+array&quot;\n\nvar data = new URLSearchParams(string);\nvar obj = {};\nfor (let x of data.keys()){\n  obj[x] = data.getAll(x);\n}\nconsole.log(obj);</code></pre>\r\n</div>\r\n</div>\r\n</p>\n$$, 1626826610, 3, 1353011, 68462597, FALSE);
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted) VALUES (68462682, $$<p>Using URLSearchParams to parse the query string helps simplify this</p>\n<p><div class=\"snippet\" data-lang=\"js\" data-hide=\"false\" data-console=\"true\" data-babel=\"false\">\r\n<div class=\"snippet-code\">\r\n<pre class=\"snippet-code-js lang-js prettyprint-override\"><code>var string = &quot;test-1=owner&amp;test-1=driver&amp;test-2=Yes&amp;test-3=2&amp;test-4=sun&amp;test-4=moon&amp;test-5=not-agree&amp;test-6=dogs&amp;test-6=testing+js+object&amp;test-7=Testing+js+function&amp;test-7=Testing+js+array&quot;\n\nconst params = new URLSearchParams(string),\n      res = {};\n\n\nparams.forEach((v,k)=&gt; { \n  res[k] = res[k] || []\n  res[k].push(v);  \n})\n\nconsole.log(res)</code></pre>\r\n</div>\r\n</div>\r\n</p>\n$$, 1626826773, 3, 1175966, 68462597, FALSE);
-- (For Question 68462861)
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted) VALUES (68462887, $$<p>In Polynomial.cpp you are defining new functions instead of member functions. Change the definitions to use the class name like</p>\n<pre><code>void Polynomial::add(Term t) {\n    vect.push_back(t);\n}\n</code></pre>\n$$, 1626829438, 1, 1413244, 68462861, FALSE);
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted) VALUES (68462904, $$<p>Your void add(Term T) in Polynomial.cpp is not the member function of the Polynomial.\nYou must implement this function as member of Polynomial like this</p>\n<pre><code>void Polynomial::add(Term T){\n...\n}\n</code></pre>\n$$, 1626829629, 1, 8589793, 68462861, FALSE);
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted) VALUES (68462932, $$<p>I think this is a syntax error. First, you defined the add method in the Polynomial class of the header file, but the CPP file did not add the class scope, which caused this problem. So you should adjust your code like this:</p>\n<pre class=\"lang-cpp prettyprint-override\"><code>void Polynomial::add(Term t) {\n    vect.push_back(t);\n}\n</code></pre>\n<p>The root cause of this problem is that the methods of the class only work within the scope of the class, and if there is a function with the same name inside the class, it will lead to a naming conflict. Therefore, the root cause of this problem is not the reference error of the vector file.</p>\n$$, 1626829997, 1, 12526570, 68462861, FALSE);
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted) VALUES (68462954, $$<p>The issue is that instead of defining the members <code>add</code> and <code>print</code> of the class <code>Polynomial</code>, you are defining functions in global scope completely unrelated to the class <code>Polynomial</code></p>\n<p>Make changes in the function definition of <code>void add(Term)</code> and <code>void print()</code> to <code>void Polynomial::add(Term)</code> and <code>void Polynomial::print()</code>.</p>\n<pre class=\"lang-cpp prettyprint-override\"><code>#include &quot;term.hpp&quot;\n#include &quot;Polynomial.hpp&quot;\n#include&lt;iostream&gt;\n#include&lt;map&gt;\n\nusing namespace std;\n\nvoid Polynomial::add(Term t) { // change here\n    vect.push_back(t);\n}\n\nvoid Polynomial::print() { //change here\n    for(int i = 0; i &lt; vect.size(); i++) {\n        cout &lt;&lt; vect[i].toString();\n    }\n}\n    \nPolynomial combineLikeTerms() {\n    Polynomial poly;\n    map&lt;int, int&gt; combinedPoly;\n    \n    for(int j = 0; j &lt; vect.size(); j++)\n    {\n        combinedPoly.insert(pair&lt;int, int&gt;(vect[j].getExponent(), vect[j].getCoefficient());\n    }\n                            \n    for(map&lt;int,int&gt;::iterator itr = combinedPoly.begin(); itr != combinedPoly.end(); itr++) {\n            Term newTerm(itr-&gt;second, &quot;x&quot;, itr-&gt;first);\n            poly.add(newTerm);\n        }\n        \n    return poly;\n                    \n}\n</code></pre>\n$$, 1626830242, 0, 12513900, 68462861, FALSE);
-- (For Question 68462550)
INSERT INTO answers (id, body, creation_date, score, "userId", "questionId", accepted) VALUES (68462591, $$<p>The error (which you should have provided in the question but I already detected it) is caused because You compare a string with an integer here:</p>\n<pre class=\"lang-py prettyprint-override\"><code>def Guessnumber():\n    if number_entry1.get() &gt; int(r):\n        m1 = messagebox.showinfo(&quot;Sorry&quot;,&quot;Lower&quot;)\n    elif number_entry1.get() &lt; int(r):\n        m2 = messagebox.showinfo(&quot;Sorry&quot;,&quot;Higher&quot;)\n    else:\n        m3 = messagebox.showinfo(&quot;Congratulations&quot;,&quot;You Got It!&quot;)\n</code></pre>\n<p>Why? because using the <code>.get()</code> method of <code>Entry</code> widgets returns the value of what was entered in the widget as a string, so the simple solution would be this:</p>\n<pre class=\"lang-py prettyprint-override\"><code>def Guessnumber():\n    if int(number_entry1.get()) &gt; int(r):\n        m1 = messagebox.showinfo(&quot;Sorry&quot;,&quot;Lower&quot;)\n    elif int(number_entry1.get()) &lt; int(r):\n        m2 = messagebox.showinfo(&quot;Sorry&quot;,&quot;Higher&quot;)\n    else:\n        m3 = messagebox.showinfo(&quot;Congratulations&quot;,&quot;You Got It!&quot;)\n</code></pre>\n<p>Oh, and also to mention, this is not necessary: <code>int(r)</code>, because the function <code>random.randint(1,100)</code> already returns an integer so converting it again is redundant.</p>\n<p>And also the function <code>quit()</code> is quite useless since the only thing defined there is the built-in <code>exit()</code> which actually is the same length as in characters so kinda pointless without other functionality</p>\n<p>The &quot;final version&quot; of how that function &quot;should&quot; (to the best practices I know) look is this (also includes some <a href=\"https://www.python.org/dev/peps/pep-0008/\" rel=\"nofollow noreferrer\">PEP 8 - Style Guide for Python Code</a> suggestions and also that there is now only one <code>.get()</code> call which theoretically improves performance since now the method in all cases has to be called only once):</p>\n<pre class=\"lang-py prettyprint-override\"><code>def guess_number():\n    user_input = int(number_entry1.get())\n    if user_input &gt; r:\n        messagebox.showinfo(&quot;Sorry&quot;, &quot;Lower&quot;)\n    elif user_input &lt; r:\n        messagebox.showinfo(&quot;Sorry&quot;, &quot;Higher&quot;)\n    else:\n        messagebox.showinfo(&quot;Congratulations&quot;, &quot;You Got It!&quot;)\n</code></pre>\n$$, 1626825759, 3, 14531062, 68462550, FALSE);


-- Insert Comments
-- (For Question 68462879)
INSERT INTO comments(id, body, "userId", "questionId", "answerId")
VALUES
  (120995277, $$If checking the return value is so important, why don''t you throw an exception?$$, 4706785, 68462879, NULL),
  (120995290, $$Although compilers are "encouraged" to issue a warning with [[nodiscard]] if the return value is discarded, most compilers can be configured to treat warnings as errors, and cease compilation.   Microsoft compilers and IDEs support such an option.$$, 4706785, 68462879, NULL),
  (120995303, $$C++ just doesn''t work this way. The native way to do this in C++ is to throw an exception upon failure, so a successful return from a function indicates that it succeeded.$$, 3943312, 68462879, NULL),
  (120995354, $$@Peter I understand about warnings-as-errors, but that is still based on warnings$$, 1610174, 68462879, NULL),
  (120995367, $$Also, bear in mind, that any approach that (attempts at) forcing the caller to check a return value can be explicitly circumvented by the caller.   For example, if the compiler issues warnings/errors because of [[nodiscard]], the caller can still beat the compiler into submission with a simple cast i.e. (void)DoSomething(bloop).   There is a point where you have to rely on other programmers reading documentation and doing what is needed.$$, 4706785, 68462879, NULL),
  (120995392, $$@SamVarshavchik Thanks for the comment - I updated the question to clarify that we can''t use an exception here.  I understand this is not the "native" way.  The question is whether it''s possible.$$, 1610174, 68462879, NULL),
  (120995397, $$If a warning is turned into an error, it''s a true error that will fail the build. Why is this a problem? Isn''t it what you want?$$, 440558, 68462879, NULL),
  (120995411, $$And what is the <i>actual</i> problem this is supposed to solve? Right now this question is more of an <a href="https://xyproblem.info/" rel="nofollow noreferrer">XY problem</a>.$$, 440558, 68462879, NULL),
  (120995444, $$Your MustCheck could check in its destructor (one that is marked noexcept(false)) if the object was checked, and if not then throw.  With the caveat that if it throws in the context of a throw-in-flight, it will terminate the application.$$, 4641116, 68462879, NULL),
  (120995445, $$@Peter that''s completely true - and (void) casting requires the programmer to explicitly acknowledge they are intentionally circumventing the compiler.  If context helps, this is for an API with a large surface area and a lot of junior programmers where we want to add explicit DANGER WILL ROBINSON alerts in the manner I described$$, 1610174, 68462879, NULL),
  (120995488, $$@Eljay yes, I had a similar idea that would be caught at runtime, and that might be what we need to go with, however I was wondering if there is a way to encode this behavior in the type system itself such that "not checking" is equivalent to a language/type error.$$, 1610174, 68462879, NULL),
  (120995525, $$Nope, C++''s type system does not work this way.$$, 3943312, 68462879, NULL),
  (120995551, $$DoSomething could take two parameters: lambda to call on success, and lambda to call on failure.  That way, the caller is responsible for handling the success and failure cases explicitly (even if the handler is a no-op).$$, 4641116, 68462879, NULL),
  (120995565, $$From what you describe, I suspect the [[nodiscard]] attribute, coupled with a build process that is configured (in a way that can''t be changed by junior programmers) to treat warnings as errors will suffice.   Also, this seems a case where active mentoring of junior members of the team by senior members is warranted.   Essentially, getting junior programmers to do something necessary for the project is a non-technical problem, and a purely technical solution (forcing compilation to fail is a technical solution) to a non-technical problem is rarely a good idea.$$, 4706785, 68462879, NULL),
  (120995572, $$@Eljay The callback approach is interesting.  I hadn''t considered it, but it conceptually could work.$$, 1610174, 68462879, NULL),
  (120995601, $$@Peter All good points.  It''s about layering safety.  I personally like to automate checking as much as possible, because humans err, and so this is an attempt to supplement social/process checks.  It might not be possible as I''ve described, but still an interesting question.  And hopefully someday [[cantdiscard]] is added :)$$, 1610174, 68462879, NULL),
  (120995630, $$<code>nodiscard</code> (configured to produce an error) does exactly what you are asking for -- there''s no stronger error condition than producing an error . But you reject it out of hand with no real explanation. The code in your example will produce an error where requested, if function is marked [[nodiscard]] and you configure the compiler to produce an error for this.$$, 1505939, 68462879, NULL),
  (120995637, $$"a type(s) that, if it''s not assigned to a variable from a function return, the compiler flags an error." is possible but no help, as the coder could just make this assignment and then not use the resulting variable$$, 1505939, 68462879, NULL);

-- (For Answer 68462942)
INSERT INTO comments(id, body, "userId", "questionId", "answerId")
VALUES
  (120995403, $$A link to a solution is welcome, but please ensure your answer is useful without it: <a href="//meta.stackexchange.com/a/8259">add context around the link</a> so your fellow users will have some idea what it is and why it’s there, then quote the most relevant part of the page you’re linking to in case the target page is unavailable. <a href="//stackoverflow.com/help/deleted-answers">Answers that are little more than a link may be deleted</a>. (And before you say that''s not possible with MS, they broke millions of links when they changed from MSDN to docs.)$$, 62576, NULL, 68462942),
  (120995410, $$Thanks - I updated the question to clarify that it''s not enough to enable warnings-as-errors.$$, 1610174, NULL, 68462942);

-- (For Answer 68463003)
INSERT INTO comments(id, body, "userId", "questionId", "answerId")
VALUES
  (120995468, $$C++ is meant to protect against Murphy, not Machiavelli.$$, 4641116, NULL, 68463003),
  (120995481, $$@Eljay, I totally agree, that is why I pretty much would stop at "I guess that is quite enough". What comes later is just a little game (and it has a little bonus). I think there is space for a <code>[[nodiscard]] class CheckedBool{...};</code> in a generic library.$$, 225186, NULL, 68463003),
  (120995523, $$@Eljay LOL!  I''m using that next time someone complains about C++ ;)$$, 1610174, NULL, 68463003);

-- (For Question 68463022)
INSERT INTO comments(id, body, "userId", "questionId", "answerId")
VALUES
  (120995508, $$You are not adding any items to the container with your add_items method, and therefore the read_items method has nothing to output.$$, 6890912, 68463022, NULL),
  (120995548, $$Hey! Well you would need to append (insert) items to the list “self.items” first right? Also, you could just define the variable “self.items” inside the class as an attribute (self.items = [ ]) then append to it!$$, 14492001, 68463022, NULL),
  (120995592, $$@JohnKugelman I see, I tried it again with a simpler ''for'' loop mathod to read empty array, and the output is the word "None". But in this case, that class doesn''t show any word or error at the same time. It just prints out "192:~ local$ /usr/local/bin/python3 /Users/local/Desktop/Python/question.py" and asking for the next command. Meaning that my ''b.read_items()'' isn''t executed properly.$$, 16295664, 68463022, NULL);

-- (For Answer 68463046)
INSERT INTO comments(id, body, "userId", "questionId", "answerId")
VALUES
  (120995623, $$I see, thanks for the help :)$$, 16295664, NULL, 68463046);

-- (For Question 68462964)
INSERT INTO comments(id, body, "userId", "questionId", "answerId")
VALUES
  (120995485, $$How are you calling the function? The return isn''t causing the error. What''s the expected output?$$, 1377002, 68462964, NULL),
  (120995505, $$It’s a little unclear what the 3 or 6 are referring to. But your returned array appears to be backwards; the problem statement indicates the checked-out books (presumably unavailable) should be first.$$, 438992, 68462964, NULL),
  (120995581, $$You may have to produce a minimal reproducible example, because as Dave says, you''re not getting 3 or 6 from that data as far as I can see.$$, 1377002, 68462964, NULL),
  (120995595, $$My fault Dave was correct i had my return values reverse, i swapped the available.push(book) for the unavailable.push(book) and it fixed it. Thanks guys!$$, 16490359, 68462964, NULL);

-- (For Question 68463043)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995579,
   $$<code>new Wrapper&lt;&gt;(\'Hello\')</code> is not the same type of class as <code>Wrapper&lt;String&gt;</code> I imagine some casting is happening$$,
   2310289,
   68463043,
   NULL);

-- (For Question 68462903)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995292,
   $$Shouldn''t it be <code>key={product.idFood}</code>?$$,
   1377002,
   68462903,
   NULL),
  (120995297,
   $$Oh true, I messed up while changing the variables right now. Let me update$$,
   10339394,
   68462903,
   NULL),
  (120995351,
   $$Depending on what your validation function looks like (adding an <code>onChange={validateInput}</code> to the inputs for example), <code>map</code> is the right way to go. It returns a new array of "things" which React can use to update the DOM.$$,
   1377002,
   68462903,
   NULL);


-- (For Question 68462917)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995310, $$date <code>05-03</code> has disease as <code>0</code> in original df and <code>1</code> in desired df? Is that expected?$$, 13628883, 68462917, NULL),
  (120995409, $$my bad, I fix it$$, 15954539, 68462917, NULL),
  (120995432, $$how many different id do you have?$$, 9274732, 68462917, NULL),
  (120995546, $$Do you want to match on ID and date or just date between the dfs and populate disease?$$, 13628883, 68462917, NULL),
  (120995573, $$I have 74 different id. I want to match according to id and date. for each id first set all the dates range (all days in 2013), and when the date meet ''diagnosis_date'', set the value according to the ''disease'' column in df$$, 15954539, 68462917, NULL);


-- (For Question 68462883)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995272, $$(Having no idea what Ramda is...) what''s wrong with <code>for (toCheck of toCheckArray) { if (originalObj[toCheck]) { doStuff() } }</code>$$, 2487517, 68462883, NULL),
  (120995291, $$Hi @Tibrogargan ! Nah absolutely nothing wrong with that! And I guess you''d imagine I know the ordinary way in js of solving this problem. Tho I am practising FP, and this question is tagged with FP.$$, 4249805, 68462883, NULL),
  (120995314, $$Making things more complicated because you''re ''doing FP'' is not a reason.  But here''s an FP way of doing the same thing with more keystrokes and [arguably] less readability: <code>toCheckArray.forEach( toCheck => { if (originalObject[toCheck]) { doStuff(originalObject[toCheck]) } } )</code>$$, 2487517, 68462883, NULL);

-- (For Question 68462972)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995406, $$Please take the <a href="https://stackoverflow.com/tour">tour</a> and see <a href="https://stackoverflow.com/questions/how-to-ask">How to Ask</a>$$, 14853083, 68462972, NULL),
  (120995555, $$I''m sorry for confusing question, I rewrite it now$$, 8978442, 68462972, NULL),
  (120995608, $$Quick tip: never post pictures of code.$$, 248567, 68462972, NULL),
  (120995631, $$ohh sorry im just new here, should i post it on text? thanks for the tip mate$$, 8978442, 68462972, NULL);

  -- (For Question 68462910)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995308, $$You could simplify the big <code>if</code> condition in the <code>main</code> function a little bit, if you learn about <a href="https://en.m.wikipedia.org/wiki/De_Morgan%27s_laws" rel="nofollow noreferrer">De Morgan''s laws</a>.$$, 440558, 68462910, NULL),
  (120995332, $$And what is the reason you use <code>write</code> to write your output rather than <code>printf</code>? What is your assignment? What are its requirements and limitations?$$, 440558, 68462910, NULL),
  (120995561, $$Note: <code>if (b == 0)</code> is a good check for <code>/</code>, but code is missing the <code>INT_MIN/-1</code> check.$$, 2410359, 68462910, NULL);

-- (For Question 68462912)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995285, $$kindly share the source code : <code>df.to_dict()</code>$$, 7175713, 68462912, NULL);

-- (For Answer 68462930)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995317, $$sorry, I simplified the example for the sake of the question. my strings are of multiple characters, so when I run this code there is a column for each character. I am looking for a column for each item of the list. See edit in my question.$$, 13132728, 68462912, 68462930),
  (120995347, $$I don’t understand code still works. Updated with new sample data but none of the code blocks have changed.$$, 15497888, 68462912, 68462930),
  (120995359, $$the second one does. thank you. upvoted$$, 13132728, 68462912, 68462930);

-- (For Question 68462872)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995587, $$The way it is formatted in the question, it does not look like valid json. Try adding  <code>{[</code> to the beginning of the json and <code>]}</code> to the end. This will make it a <code>List<Property></code>.$$, 14703882, 68462872, NULL);

-- (For Answer 68463091)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995641, $$I think you want just <code>[...]</code> not <code>{[...]}</code>$$, 14868997, 68462872, 68463091);

-- (For Question 68462891)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995413, $$Do both CSS classes have the same name? What are you using to bundle your app? Are you using CSS Modules? Your provided code gives us no insight into what the cause could be just the result you are receiving.$$, 4364635, 68462891, NULL);

-- (For Question 68463051)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995566, $$MSVC doesn''t support this, you will have to use a different compiler or dynamic allocation$$, 1505939, 68463051, NULL),
  (120995593, $$@M.M Oh.... that''s sad. Thank you for the answer!$$, 16491792, 68463051, NULL);

-- (For Question 68462871)
-- No comments for question 68462871

-- (For Question 68463071)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995639, $$You need to use vector.Insert(e, buffer);  (it''s an external function)$$, 3807729, 68463071, NULL),
  (120995640, $$What are expectations for friend member functions?$$, 6752050, 68463071, NULL);

-- (For Question 68462966)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995365, $$Just to clarify, I can fix it real quick by exploding it and passing the 0th element to the rest of the code, but I''d rather know what''s wrong and why it does that.$$, 1707385, 68462966, NULL),
  (120995376, $$Do you have any URL rewriting rules in place? If so, perhaps they''re misconfigured$$, 283366, 68462966, NULL),
  (120995405, $$There is an .htaccess with a few rewriting rules (which I did not write), but they are the same across the whole platform, and the same platform is used by other people on a few sites I manage. Nobody ever encountered this same issue.$$, 1707385, 68462966, NULL),
  (120995418, $$@NemoPS Please, do share your .htaccess content with us.$$, 4475908, 68462966, NULL),
  (120995419, $$On further analysis, it seems the same page has this issue with anything as first query parameter$$, 1707385, 68462966, NULL),
  (120995486, $$Posted the htaccess$$, 1707385, 68462966, NULL);

-- (For Question 68462992)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995436, $$Not an answer to this question, but from a software design perspective, it would probably be easier, safer, and faster to return a dict of dataframes keyed {name: pd.read_csv(f''{name}.csv'') for name in names} from gen_data instead.$$, 15497888, 68462992, NULL);

-- (For Question 68462993)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995476, $$Also <a href="https://stackoverflow.com/q/29044940/15497888">How can you use a variable name inside a Python format specifier</a>$$, 15497888, 68462993, NULL),
  (120995569, $$You should be using f-strings by the way, they have advantages over str.format().$$, 14860, 68462993, NULL);

-- (For Answer 68463082)
-- No comments for answer 68463082.

-- (For Question 68462977)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995426,
   $$Does this help? <a href="https://stackoverflow.com/questions/11225113/change-screen-resolution-in-java" title="change screen resolution in java">stackoverflow.com/questions/11225113/...</a>$$,
   2164365,
   68462977,
   NULL);

-- (For Question 68462981)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995458,
   $$Welcome to SO. You might find the help section useful when it comes to asking a good question. Also, consider including a minimal reproducible example.$$,
   1377002,
   68462981,
   NULL),
  (120995516,
   $$You don''t need a second parameter on the load function – try: $(\'#content\').load(\'http://localhost/HTML/acerca_de.html\');$$,
   6057915,
   68462981,
   NULL),
  (120995634,
   $$The selector should be space-delimited in the URL string (e.g. ''acerca_de.html #content'') rather than as a separate argument.$$,
   1175966,
   68462981,
   NULL);

-- (For Question 68462955)
INSERT INTO comments (id, body, "userId", "questionId", "answerId")
VALUES
  (120995380,
   $$1/3/2020 – Is that March 1st or January 3rd?$$,
   2164365,
   68462955,
   NULL);

-- (For Question 68462957)
-- No comments for question 68462957.

-- (For Answer 68462987)
-- No comments for answer 68462987.

-- (For Answer 68462989)
-- No comments for answer 68462989.

-- (For Question 68462965)
INSERT INTO comments (id, body, "userId", "questionId", "answerId") VALUES (120995379, $$<code>cat.object.getType()</code> since this code begins with <code>cat.object</code>, <code>this</code> will be set equal to <code>cat.object</code>. <code>cat.object</code> has no <code>.category</code> property (but it does have a <code>.type</code> property)$$, 3794812, 68462965, NULL);
-- (For Question 68463019)
INSERT INTO comments (id, body, "userId", "questionId", "answerId") VALUES (120995517, $$You&#39;ll need to make the form <code>inline-block</code>, too.$$, 1902010, 68463019, NULL);
-- (For Question 68462597)
INSERT INTO comments (id, body, "userId", "questionId", "answerId") VALUES (120994799, $$Using <code>[...(stringObj?.[jsonSplit[0]] || []), jsonSplit[1]];</code> might work. (It&#39;s not pretty though)$$, 989920, 68462597, NULL);
-- (For Question 68462861)
INSERT INTO comments (id, body, "userId", "questionId", "answerId") VALUES (120995227, $$<code>void Polynomial::add(Term t) { ... }</code> and the same for the rest of the member functions you want to implement outside the header.$$, 920069, 68462861, NULL);
INSERT INTO comments (id, body, "userId", "questionId", "answerId") VALUES (120995228, $$<code>void add(Term t) {...}</code> is not defining the member function. You mean <code>void Polynomoal::add(Term t) {...}</code>$$, 1413244, 68462861, NULL);
-- (For Question 68462550)
INSERT INTO comments (id, body, "userId", "questionId", "answerId") VALUES (120995207, $$What error and what operators?$$, 355230, 68462550, NULL);
-- (For Answer 68462591)
INSERT INTO comments (id, body, "userId", "questionId", "answerId") VALUES (120994791, $$Thanks a lot! I thought the error was that the variable r was the string. so I made that in(r). I didn&#39;t realize it was number_entry1.get(). Also I&#39;ll make sure to put the error if I have one in my question next time I post. Thanks Again!$$, 16139854, 68462550, 68462591);
INSERT INTO comments (id, body, "userId", "questionId", "answerId") VALUES (120995195, $$You forgot to mention that since <code>messagebox.showinfo()</code> doesn&#39;t really return any useful information, the assignment of its return value to <code>m1</code>, <code>m2</code>, or <code>m3</code> serves no purpose.$$, 355230, 68462550, 68462591);
INSERT INTO comments (id, body, "userId", "questionId", "answerId") VALUES (120995244, $$@martineau I added a &quot;final version&quot; to include all the possible little improvements (that I could think of) including what you mentioned about msgboxes$$, 14531062, 68462550, 68462591);
INSERT INTO comments (id, body, "userId", "questionId", "answerId") VALUES (120995265, $$Congratulations, You Got It! ;&#172;)$$, 355230, 68462550, 68462591);
-- (For Answer 68462932)
INSERT INTO comments (id, body, "userId", "questionId", "answerId") VALUES (120995526, $$To use C++ parlance, if you want to &#39;implement&#39; the method <code>add</code> that you &#39;declared&#39; to be part of your class <code>Polynomial</code>  in a .cpp file, you need to use the correct syntax to tell the compiler that the method is part of the class. Otherwise it will not know to include other class members (e.g. <code>vect</code>) in the scope of the method implementation. Hence: <code>void Polynomial::add(...)</code>. The method signature <code>add(...)</code> in the .cpp file tells the compiler that there is <i>another</i> method outside of the class <code>Polynomial</code> called <code>add</code> and that method will not have access to the members of <code>Polynomial</code>.$$, 4525932, 68462861, 68462932);