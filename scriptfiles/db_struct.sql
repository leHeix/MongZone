CREATE TABLE IF NOT EXISTS USERS (
	ID MEDIUMINT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	NAME VARCHAR(24) NOT NULL UNIQUE,
	PASSWORD VARBINARY(60) NOT NULL,
	SEX TINYINT NOT NULL,
	AGE TINYINT NOT NULL,
	MONEY INT NOT NULL DEFAULT 0,
	HEALTH FLOAT NOT NULL DEFAULT 100.0,
	ARMOR FLOAT NOT NULL DEFAULT 0.0,
	POS_X FLOAT NOT NULL,
	POS_Y FLOAT NOT NULL,
	POS_Z FLOAT NOT NULL,
	POS_ANGLE FLOAT NOT NULL,
	VIRTUALWORLD MEDIUMINT NOT NULL,
	INTERIOR MEDIUMINT NOT NULL,
	LAST_CONNECTION DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	XP INT NOT NULL DEFAULT 0,
	SKIN SMALLINT NOT NULL,
	HUNGER FLOAT NOT NULL DEFAULT 0.0,
	THIRST FLOAT NOT NULL DEFAULT 0.0,
	ADMIN TINYINT NOT NULL DEFAULT 0,

	CURRENT_CONNECTION INTEGER UNSIGNED NOT NULL,
	PLAYED_TIME INTEGER UNSIGNED NOT NULL DEFAULT 0
);

UPDATE `USERS` SET CURRENT_CONNECTION = 0;

CREATE TABLE IF NOT EXISTS CONNECTION_LOGS (
	ACCOUNT_ID MEDIUMINT UNSIGNED NOT NULL,
	IP_ADDRESS VARCHAR(16) NOT NULL,
	DATE DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
	FOREIGN KEY(ACCOUNT_ID) REFERENCES USERS(ID) ON DELETE CASCADE
);