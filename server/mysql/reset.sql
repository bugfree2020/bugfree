SET NAMES utf8mb4;

# database
DROP DATABASE IF EXISTS bugfree;
CREATE DATABASE bugfree;
USE bugfree;

# privilege
GRANT ALL PRIVILEGES ON `bugfree`.* TO 'bugfree'@'%';
FLUSH PRIVILEGES;

# history
DROP TABLE IF EXISTS `history`;
CREATE TABLE `history`
(
    id          CHAR(36) PRIMARY KEY,

    name        TINYTEXT,
    branch      TINYTEXT,
    ver         TINYTEXT,
    build_type  TINYTEXT,
    category    TINYTEXT,
    content     TINYTEXT,
    url_inner   TINYTEXT,
    url_outer   TINYTEXT,
    result      TINYTEXT,
    who         TINYTEXT,
    extra       JSON,

    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
