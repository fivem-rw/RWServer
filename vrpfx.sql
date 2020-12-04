-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- 생성 시간: 20-12-02 16:33
-- 서버 버전: 10.4.13-MariaDB
-- PHP 버전: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 데이터베이스: `vrpfx`
--

DELIMITER $$
--
-- 프로시저
--
CREATE DEFINER=`vrpfx`@`%` PROCEDURE `backup_user_data` (IN `in_time` DATETIME)  NO SQL
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION 
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

insert into backup_vrp_user_data (user_id,dkey,dvalue,created_at) 
(SELECT user_id,dkey,dvalue,in_time FROM vrp_user_data where dkey = 'vRP:datatable');

INSERT INTO backup_vrp_user_moneys (user_id,wallet,diamante,bank,credit,loanlimit,loan,creditrating,exp,licrevoked,created_at) 
(SELECT user_id,wallet,diamante,bank,credit,loanlimit,loan,creditrating,exp,licrevoked,in_time FROM vrp_user_moneys where 1);

INSERT INTO backup_vrp_user_vehicles (user_id,vehicle,modifications,created_at) 
(SELECT user_id,vehicle,modifications,in_time FROM vrp_user_vehicles where 1);

COMMIT;

END$$

CREATE DEFINER=`vrpfx`@`%` PROCEDURE `change_user_id` (IN `old_user_id` INT(11), IN `new_user_id` INT(11))  NO SQL
BEGIN

DECLARE n_user_id int(11);
SET n_user_id = new_user_id;

IF n_user_id = -1 THEN
	select id into n_user_id from vrp_users order by id desc limit 1;
    SET n_user_id = n_user_id + 1;
END IF;

update vrp_users set id=n_user_id where id=old_user_id;

SET @dkey_old = CONCAT('chest:u',old_user_id,'veh');
SET @dkey_new = CONCAT('chest:u',n_user_id,'veh');

update `vrp_srv_data` set dkey=REPLACE(dkey,@dkey_old,@dkey_new) WHERE dkey like CONCAT('%',@dkey_old,'%');

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_changed_identity` (IN `old_user_id` INT(11), IN `new_user_id` INT(11))  NO SQL
BEGIN

DECLARE s_user_id int(11);
SET s_user_id = -1;

select user_id into s_user_id from vrp_user_ids where user_id = new_user_id and identifier NOT REGEXP '^ip:';

IF s_user_id = -1 THEN
  update vrp_user_ids set user_id = new_user_id where user_id = old_user_id;
END IF;

END$$

CREATE DEFINER=`vrpfx`@`%` PROCEDURE `restore_user_data` (IN `in_user_id` INT(11), IN `in_time` DATETIME)  NO SQL
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION 
BEGIN
ROLLBACK;
RESIGNAL;
END;

START TRANSACTION;

delete from vrp_user_data where dkey = 'vRP:datatable' and user_id = in_user_id;
insert into vrp_user_data (user_id,dkey,dvalue,updated) 
(SELECT user_id,dkey,dvalue,now() FROM backup_vrp_user_data where dkey = 'vRP:datatable' and user_id = in_user_id and created_at = in_time);

delete from vrp_user_moneys where user_id = in_user_id;
INSERT INTO vrp_user_moneys (user_id,wallet,diamante,bank,credit,loanlimit,loan,creditrating,exp,licrevoked) 
(SELECT user_id,wallet,diamante,bank,credit,loanlimit,loan,creditrating,exp,licrevoked FROM backup_vrp_user_moneys where user_id = in_user_id and created_at = in_time);

delete from vrp_user_vehicles where user_id = in_user_id;
INSERT INTO vrp_user_vehicles (user_id,vehicle,modifications) 
(SELECT user_id,vehicle,modifications FROM backup_vrp_user_vehicles where user_id = in_user_id and created_at = in_time);

COMMIT;

END$$

CREATE DEFINER=`vrpfx`@`%` PROCEDURE `restore_user_error` (IN `in_user_id` INT(11))  NO SQL
BEGIN

DECLARE n_user_id int(11);
DECLARE n_user_id2 int(11);
SET n_user_id = 0;
SET n_user_id2 = 0;

select user_id into n_user_id from vrp_user_ids where user_id = in_user_id limit 1;
SET n_user_id = n_user_id;

IF n_user_id != 0 THEN
	select user_id into n_user_id2 from vrp_user_data where user_id = in_user_id and dkey = 'vRP:datatable' limit 1;
	SET n_user_id2 = n_user_id2;
	IF n_user_id2 = 0 THEN
		insert into vrp_user_data set user_id = in_user_id, dkey = 'vRP:datatable', dvalue = '{"groups":{"user":true}}';
	END IF;
END IF;

END$$

--
-- 함수
--
CREATE DEFINER=`vrpfx`@`%` FUNCTION `get_dataitem_id` (`param_data` JSON, `param_u_str` VARCHAR(255) CHARSET utf8) RETURNS INT(11) NO SQL
BEGIN

DECLARE u_id INT(11);
SET u_id = 0;

IF param_u_str = "" THEN
    IF u_id = null or u_id = 0 THEN
        SET u_id = FLOOR((RAND() * (999999-111111+1))+111111);
        insert into vrp_dataitem_ids set id = u_id, u_str = param_u_str, data = param_data, created_at=now();
    END IF;
ELSE 
	select id into u_id from vrp_dataitem_ids where 1 and u_str = param_u_str;
    IF u_id = null or u_id = 0 THEN
        SET u_id = FLOOR((RAND() * (999999-111111+1))+111111);
        insert into vrp_dataitem_ids set id = u_id, u_str = param_u_str, data = param_data, created_at=now();
    END IF;
END IF;

return u_id;

END$$

CREATE DEFINER=`vrpfx`@`%` FUNCTION `get_vc_status` (`param_user_id` INT(11)) RETURNS VARCHAR(255) CHARSET utf8mb4 NO SQL
BEGIN

DECLARE total_bet_amount decimal(16,0);
DECLARE loss_amount decimal(16,0);
DECLARE win_amount decimal(16,0);
SET total_bet_amount = 0;
SET loss_amount = 0;
SET win_amount = 0;

select sum(bet_amount) into total_bet_amount from vrp_vc_bets where user_id = param_user_id and is_result = 1;

select sum(bet_amount) into loss_amount from vrp_vc_bets where user_id = param_user_id and is_result = 1 and is_winner = 0;

select sum((bet_amount*odd_value)-bet_amount) into win_amount from vrp_vc_bets where user_id = param_user_id and is_result = 1 and is_winner = 1;

return concat('[',total_bet_amount,',',win_amount,',',loss_amount,',',win_amount-loss_amount,']');

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- 테이블 구조 `backup_vrp_user_data`
--

CREATE TABLE `backup_vrp_user_data` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` longtext DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `backup_vrp_user_moneys`
--

CREATE TABLE `backup_vrp_user_moneys` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `wallet` decimal(20,0) NOT NULL DEFAULT 0,
  `diamante` decimal(20,0) NOT NULL DEFAULT 0,
  `bank` decimal(20,0) NOT NULL DEFAULT 0,
  `credit` decimal(20,0) NOT NULL DEFAULT 0,
  `loanlimit` decimal(20,0) NOT NULL DEFAULT 0,
  `loan` decimal(20,0) NOT NULL DEFAULT 0,
  `creditrating` decimal(20,0) NOT NULL DEFAULT 0,
  `exp` decimal(20,0) NOT NULL DEFAULT 0,
  `licrevoked` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `backup_vrp_user_vehicles`
--

CREATE TABLE `backup_vrp_user_vehicles` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `modifications` longtext NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `phone_app_chat`
--

CREATE TABLE `phone_app_chat` (
  `id` int(11) NOT NULL,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 테이블 구조 `phone_app_notes`
--

CREATE TABLE `phone_app_notes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `phone_calls`
--

CREATE TABLE `phone_calls` (
  `id` int(11) NOT NULL,
  `owner` varchar(255) NOT NULL COMMENT 'Num such owner',
  `num` varchar(255) NOT NULL COMMENT 'Reference number of the contact',
  `incoming` int(11) NOT NULL COMMENT 'Defined if we are at the origin of the calls',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Calls accept or not'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 테이블 구조 `phone_messages`
--

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL,
  `transmitter` varchar(255) NOT NULL,
  `receiver` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 테이블 구조 `phone_stocks`
--

CREATE TABLE `phone_stocks` (
  `ID` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Label` varchar(50) NOT NULL,
  `Current` double DEFAULT NULL,
  `Min` double NOT NULL,
  `Max` double NOT NULL,
  `Med` double UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `phone_users_contacts`
--

CREATE TABLE `phone_users_contacts` (
  `id` int(11) NOT NULL,
  `identifier` int(11) DEFAULT NULL,
  `number` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 테이블 구조 `tax`
--

CREATE TABLE `tax` (
  `id` int(11) NOT NULL,
  `statecoffers` int(11) NOT NULL,
  `hi` int(11) NOT NULL,
  `army` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `twitter_accounts`
--

CREATE TABLE `twitter_accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- 테이블 구조 `twitter_likes`
--

CREATE TABLE `twitter_likes` (
  `id` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- 테이블 구조 `twitter_tweets`
--

CREATE TABLE `twitter_tweets` (
  `id` int(11) NOT NULL,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_dataitem_ids`
--

CREATE TABLE `vrp_dataitem_ids` (
  `id` int(11) NOT NULL,
  `data` longtext NOT NULL,
  `u_str` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_event1_tickets`
--

CREATE TABLE `vrp_event1_tickets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0,
  `type` enum('1','2','3','4','5','6') NOT NULL,
  `value` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_event2_tickets`
--

CREATE TABLE `vrp_event2_tickets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0,
  `type` enum('1','2','3','4','5','6') NOT NULL,
  `value` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_newbie_bonus`
--

CREATE TABLE `vrp_newbie_bonus` (
  `user_id` int(11) NOT NULL,
  `code` varchar(100) NOT NULL,
  `state` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_srv_data`
--

CREATE TABLE `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` longtext DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_users`
--

CREATE TABLE `vrp_users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `last_login` varchar(100) DEFAULT NULL,
  `last_login_ip` varchar(100) DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  `online` int(11) NOT NULL DEFAULT 0,
  `whitelisted` tinyint(1) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  `revived` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_user_business`
--

CREATE TABLE `vrp_user_business` (
  `user_id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `capital` int(11) DEFAULT NULL,
  `laundered` int(11) DEFAULT NULL,
  `reset_timestamp` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_user_data`
--

CREATE TABLE `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` longtext DEFAULT NULL,
  `updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_user_homes`
--

CREATE TABLE `vrp_user_homes` (
  `user_id` int(11) NOT NULL,
  `home` varchar(100) DEFAULT NULL,
  `number` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_user_identities`
--

CREATE TABLE `vrp_user_identities` (
  `user_id` int(11) NOT NULL,
  `registration` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_user_ids`
--

CREATE TABLE `vrp_user_ids` (
  `identifier` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_user_moneys`
--

CREATE TABLE `vrp_user_moneys` (
  `user_id` int(11) NOT NULL,
  `wallet` decimal(20,0) NOT NULL DEFAULT 0,
  `diamante` decimal(20,0) NOT NULL DEFAULT 0,
  `bank` decimal(20,0) NOT NULL DEFAULT 0,
  `credit` decimal(20,0) NOT NULL DEFAULT 0,
  `loanlimit` decimal(20,0) NOT NULL DEFAULT 0,
  `loan` decimal(20,0) NOT NULL DEFAULT 0,
  `creditrating` decimal(20,0) NOT NULL DEFAULT 0,
  `exp` decimal(20,0) NOT NULL DEFAULT 0,
  `licrevoked` int(11) DEFAULT NULL,
  `exp2` int(11) DEFAULT 0,
  `stock` bigint(20) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_user_salary`
--

CREATE TABLE `vrp_user_salary` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `pay_amount` decimal(20,0) DEFAULT NULL,
  `pay_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_user_vehicles`
--

CREATE TABLE `vrp_user_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `modifications` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_vc_bets`
--

CREATE TABLE `vrp_vc_bets` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `player_src` int(11) DEFAULT NULL,
  `run_id` int(11) NOT NULL,
  `odd_id` int(11) NOT NULL,
  `odd_value` decimal(10,2) NOT NULL,
  `bet_amount` decimal(20,0) NOT NULL,
  `is_process` tinyint(1) NOT NULL DEFAULT 0,
  `is_result` tinyint(1) NOT NULL DEFAULT 0,
  `is_winner` tinyint(1) NOT NULL DEFAULT 0,
  `is_execute` tinyint(1) NOT NULL DEFAULT 0,
  `is_get_money` tinyint(1) NOT NULL DEFAULT 0,
  `is_cancel` tinyint(1) NOT NULL DEFAULT 0,
  `is_error_recv` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_vc_odds`
--

CREATE TABLE `vrp_vc_odds` (
  `id` int(11) NOT NULL,
  `run_id` int(11) NOT NULL,
  `odd_id` int(11) NOT NULL,
  `odd_value` decimal(10,2) NOT NULL,
  `is_winner` tinyint(1) NOT NULL DEFAULT 0,
  `is_enable` tinyint(1) NOT NULL DEFAULT 0,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 트리거 `vrp_vc_odds`
--
DELIMITER $$
CREATE TRIGGER `update_bets_as_update_odds` AFTER UPDATE ON `vrp_vc_odds` FOR EACH ROW BEGIN

if new.is_winner = 1 then
update vrp_vc_bets set is_winner=1,updated_at=now() where run_id=old.run_id and odd_id=old.odd_id and is_process = 1 and is_cancel = 0;
end if;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_vc_results`
--

CREATE TABLE `vrp_vc_results` (
  `id` bigint(20) NOT NULL,
  `run_id` int(11) NOT NULL,
  `draw_code` bigint(20) NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 테이블 구조 `vrp_vc_revive`
--

CREATE TABLE `vrp_vc_revive` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` decimal(20,0) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `backup_vrp_user_data`
--
ALTER TABLE `backup_vrp_user_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `created_at` (`created_at`);

--
-- 테이블의 인덱스 `backup_vrp_user_moneys`
--
ALTER TABLE `backup_vrp_user_moneys`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `created_at` (`created_at`);

--
-- 테이블의 인덱스 `backup_vrp_user_vehicles`
--
ALTER TABLE `backup_vrp_user_vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `created_at` (`created_at`);

--
-- 테이블의 인덱스 `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  ADD PRIMARY KEY (`id`);

--
-- 테이블의 인덱스 `phone_app_notes`
--
ALTER TABLE `phone_app_notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `channel` (`channel`),
  ADD KEY `user_id` (`user_id`);

--
-- 테이블의 인덱스 `phone_calls`
--
ALTER TABLE `phone_calls`
  ADD PRIMARY KEY (`id`);

--
-- 테이블의 인덱스 `phone_messages`
--
ALTER TABLE `phone_messages`
  ADD PRIMARY KEY (`id`);

--
-- 테이블의 인덱스 `phone_stocks`
--
ALTER TABLE `phone_stocks`
  ADD PRIMARY KEY (`ID`);

--
-- 테이블의 인덱스 `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  ADD PRIMARY KEY (`id`);

--
-- 테이블의 인덱스 `tax`
--
ALTER TABLE `tax`
  ADD PRIMARY KEY (`id`);

--
-- 테이블의 인덱스 `twitter_accounts`
--
ALTER TABLE `twitter_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- 테이블의 인덱스 `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  ADD KEY `FK_twitter_likes_twitter_tweets` (`tweetId`);

--
-- 테이블의 인덱스 `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_twitter_tweets_twitter_accounts` (`authorId`);

--
-- 테이블의 인덱스 `vrp_dataitem_ids`
--
ALTER TABLE `vrp_dataitem_ids`
  ADD PRIMARY KEY (`id`),
  ADD KEY `u_str` (`u_str`);

--
-- 테이블의 인덱스 `vrp_event1_tickets`
--
ALTER TABLE `vrp_event1_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `value` (`value`);

--
-- 테이블의 인덱스 `vrp_event2_tickets`
--
ALTER TABLE `vrp_event2_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `value` (`value`);

--
-- 테이블의 인덱스 `vrp_newbie_bonus`
--
ALTER TABLE `vrp_newbie_bonus`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- 테이블의 인덱스 `vrp_srv_data`
--
ALTER TABLE `vrp_srv_data`
  ADD PRIMARY KEY (`dkey`),
  ADD KEY `user_id` (`user_id`);

--
-- 테이블의 인덱스 `vrp_users`
--
ALTER TABLE `vrp_users`
  ADD PRIMARY KEY (`id`);

--
-- 테이블의 인덱스 `vrp_user_business`
--
ALTER TABLE `vrp_user_business`
  ADD PRIMARY KEY (`user_id`);

--
-- 테이블의 인덱스 `vrp_user_data`
--
ALTER TABLE `vrp_user_data`
  ADD PRIMARY KEY (`user_id`,`dkey`),
  ADD KEY `user_id` (`user_id`);

--
-- 테이블의 인덱스 `vrp_user_homes`
--
ALTER TABLE `vrp_user_homes`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `home` (`home`,`number`);

--
-- 테이블의 인덱스 `vrp_user_identities`
--
ALTER TABLE `vrp_user_identities`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `registration` (`registration`);

--
-- 테이블의 인덱스 `vrp_user_ids`
--
ALTER TABLE `vrp_user_ids`
  ADD PRIMARY KEY (`identifier`),
  ADD KEY `fk_user_ids_users` (`user_id`);

--
-- 테이블의 인덱스 `vrp_user_moneys`
--
ALTER TABLE `vrp_user_moneys`
  ADD PRIMARY KEY (`user_id`);

--
-- 테이블의 인덱스 `vrp_user_salary`
--
ALTER TABLE `vrp_user_salary`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- 테이블의 인덱스 `vrp_user_vehicles`
--
ALTER TABLE `vrp_user_vehicles`
  ADD PRIMARY KEY (`user_id`,`vehicle`);

--
-- 테이블의 인덱스 `vrp_vc_bets`
--
ALTER TABLE `vrp_vc_bets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `run_id` (`run_id`),
  ADD KEY `is_result` (`is_result`),
  ADD KEY `is_winner` (`is_winner`),
  ADD KEY `is_execute` (`is_execute`),
  ADD KEY `is_cancel` (`is_cancel`),
  ADD KEY `is_error_recv` (`is_error_recv`),
  ADD KEY `odd_id` (`odd_id`),
  ADD KEY `odd_value` (`odd_value`);

--
-- 테이블의 인덱스 `vrp_vc_odds`
--
ALTER TABLE `vrp_vc_odds`
  ADD PRIMARY KEY (`id`),
  ADD KEY `run_id` (`run_id`),
  ADD KEY `is_enable` (`is_enable`),
  ADD KEY `odd_id` (`odd_id`),
  ADD KEY `odd_value` (`odd_value`);

--
-- 테이블의 인덱스 `vrp_vc_results`
--
ALTER TABLE `vrp_vc_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `run_id` (`run_id`);

--
-- 테이블의 인덱스 `vrp_vc_revive`
--
ALTER TABLE `vrp_vc_revive`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `backup_vrp_user_data`
--
ALTER TABLE `backup_vrp_user_data`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `backup_vrp_user_moneys`
--
ALTER TABLE `backup_vrp_user_moneys`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `backup_vrp_user_vehicles`
--
ALTER TABLE `backup_vrp_user_vehicles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `phone_app_notes`
--
ALTER TABLE `phone_app_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `phone_calls`
--
ALTER TABLE `phone_calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `phone_messages`
--
ALTER TABLE `phone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `phone_stocks`
--
ALTER TABLE `phone_stocks`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `tax`
--
ALTER TABLE `tax`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `twitter_accounts`
--
ALTER TABLE `twitter_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `twitter_likes`
--
ALTER TABLE `twitter_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `vrp_event1_tickets`
--
ALTER TABLE `vrp_event1_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `vrp_event2_tickets`
--
ALTER TABLE `vrp_event2_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `vrp_users`
--
ALTER TABLE `vrp_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `vrp_user_salary`
--
ALTER TABLE `vrp_user_salary`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `vrp_vc_bets`
--
ALTER TABLE `vrp_vc_bets`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `vrp_vc_odds`
--
ALTER TABLE `vrp_vc_odds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `vrp_vc_results`
--
ALTER TABLE `vrp_vc_results`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- 테이블의 AUTO_INCREMENT `vrp_vc_revive`
--
ALTER TABLE `vrp_vc_revive`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- 덤프된 테이블의 제약사항
--

--
-- 테이블의 제약사항 `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  ADD CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE;

--
-- 테이블의 제약사항 `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  ADD CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`);

--
-- 테이블의 제약사항 `vrp_newbie_bonus`
--
ALTER TABLE `vrp_newbie_bonus`
  ADD CONSTRAINT `vrp_newbie_bonus_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON UPDATE CASCADE;

--
-- 테이블의 제약사항 `vrp_user_business`
--
ALTER TABLE `vrp_user_business`
  ADD CONSTRAINT `fk_user_business_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON UPDATE CASCADE;

--
-- 테이블의 제약사항 `vrp_user_data`
--
ALTER TABLE `vrp_user_data`
  ADD CONSTRAINT `fk_user_data_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON UPDATE CASCADE;

--
-- 테이블의 제약사항 `vrp_user_homes`
--
ALTER TABLE `vrp_user_homes`
  ADD CONSTRAINT `fk_user_homes_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON UPDATE CASCADE;

--
-- 테이블의 제약사항 `vrp_user_identities`
--
ALTER TABLE `vrp_user_identities`
  ADD CONSTRAINT `fk_user_identities_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON UPDATE CASCADE;

--
-- 테이블의 제약사항 `vrp_user_ids`
--
ALTER TABLE `vrp_user_ids`
  ADD CONSTRAINT `fk_user_ids_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON UPDATE CASCADE;

--
-- 테이블의 제약사항 `vrp_user_moneys`
--
ALTER TABLE `vrp_user_moneys`
  ADD CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON UPDATE CASCADE;

--
-- 테이블의 제약사항 `vrp_user_salary`
--
ALTER TABLE `vrp_user_salary`
  ADD CONSTRAINT `vrp_user_salary_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON UPDATE CASCADE;

--
-- 테이블의 제약사항 `vrp_user_vehicles`
--
ALTER TABLE `vrp_user_vehicles`
  ADD CONSTRAINT `fk_user_vehicles_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
