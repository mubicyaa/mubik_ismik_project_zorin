SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `shoe_shop` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `shoe_shop` ;

CREATE TABLE IF NOT EXISTS `shoe_shop`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `shoe_shop`.`manufacturers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `shoe_shop`.`pvz` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `postcode` CHAR(6) NOT NULL,
  `city` VARCHAR(30) NOT NULL,
  `street` VARCHAR(30) NOT NULL,
  `house` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 37
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `shoe_shop`.`orderstatus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `shoe_shop`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `shoe_shop`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(60) NOT NULL,
  `login` VARCHAR(50) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_role_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_role`
    FOREIGN KEY (`role_id`)
    REFERENCES `shoe_shop`.`roles` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `shoe_shop`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATETIME NOT NULL,
  `delivery_date` DATETIME NULL DEFAULT NULL,
  `pvz_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `receive_code` VARCHAR(10) NOT NULL,
  `status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orders_pvz_idx` (`pvz_id` ASC) VISIBLE,
  INDEX `fk_orders_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_orders_status_idx` (`status_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_pvz`
    FOREIGN KEY (`pvz_id`)
    REFERENCES `shoe_shop`.`pvz` (`id`),
  CONSTRAINT `fk_orders_status`
    FOREIGN KEY (`status_id`)
    REFERENCES `shoe_shop`.`orderstatus` (`id`),
  CONSTRAINT `fk_orders_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `shoe_shop`.`users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `shoe_shop`.`suppliers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `shoe_shop`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `article` VARCHAR(10) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `unit` VARCHAR(10) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `discount` INT NOT NULL,
  `stock_qty` INT NOT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `photo` VARCHAR(50) NULL DEFAULT NULL,
  `category_id` INT NOT NULL,
  `manufacturer_id` INT NOT NULL,
  `supplier_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_products_category_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_products_manufacturer_idx` (`manufacturer_id` ASC) VISIBLE,
  INDEX `fk_products_supplier_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `shoe_shop`.`categories` (`id`),
  CONSTRAINT `fk_products_manufacturer`
    FOREIGN KEY (`manufacturer_id`)
    REFERENCES `shoe_shop`.`manufacturers` (`id`),
  CONSTRAINT `fk_products_supplier`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `shoe_shop`.`suppliers` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `shoe_shop`.`prodorders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `qty` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_prodorders_order_idx` (`order_id` ASC) VISIBLE,
  INDEX `fk_prodorders_product_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_prodorders_order`
    FOREIGN KEY (`order_id`)
    REFERENCES `shoe_shop`.`orders` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_prodorders_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `shoe_shop`.`products` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
