CREATE TABLE `players` (
  `identifier` varchar(255) NOT NULL,
  `account` varchar(255) DEFAULT NULL,
  `group` varchar(255) DEFAULT NULL,
  `vip` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `players_inv` (
  `identifier` varchar(255) DEFAULT NULL,
  `item_label` varchar(255) DEFAULT NULL,
  `item_name` varchar(255) DEFAULT NULL,
  `item_count` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

ALTER TABLE `players`
  ADD PRIMARY KEY (`identifier`);
COMMIT;

ALTER TABLE `players_inv` ADD `id` INT(10) NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY (`id`);
