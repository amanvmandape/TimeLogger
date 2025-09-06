use emp_timesheets

CREATE TABLE `memcreds` (
  `id` int NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `role` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idMemCreds_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `timesheet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mem_id` int NOT NULL,
  `wk_start` date NOT NULL,
  `wk_end` date NOT NULL,
  `mon` int DEFAULT '0',
  `tue` int DEFAULT '0',
  `wed` int DEFAULT '0',
  `thu` int DEFAULT '0',
  `fri` int DEFAULT '0',
  `sat` int DEFAULT '0',
  `sun` int DEFAULT '0',
  `state` enum('unsubmitted','submitted','approved','rejected') DEFAULT 'unsubmitted',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mem_id` (`mem_id`,`wk_start`),
  CONSTRAINT `timesheet_ibfk_1` FOREIGN KEY (`mem_id`) REFERENCES `memcreds` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
