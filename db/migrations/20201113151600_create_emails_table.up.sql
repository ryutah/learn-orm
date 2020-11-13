create table email(
  email VARCHAR(256) NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY(email),
  INDEX `fk_user_id_idx` (`user_id`),
  CONSTRAINT `fk_user_id_idx` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB;
