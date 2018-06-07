-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema gm_eclipse
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema gm_eclipse
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gm_eclipse` DEFAULT CHARACTER SET latin1 ;
USE `gm_eclipse` ;

-- -----------------------------------------------------
-- Table `gm_eclipse`.`t_people`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gm_eclipse`.`t_people` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `p_accountId` VARCHAR(16) NOT NULL,
  `p_name` VARCHAR(64) NULL,
  `p_email` VARCHAR(64) NULL,
  `p_userName` VARCHAR(64) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `p_accountId_UNIQUE` (`p_accountId` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 1083
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gm_eclipse`.`t_change`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gm_eclipse`.`t_change` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `ch_id` VARCHAR(256) NOT NULL,
  `ch_changeId` VARCHAR(64) NOT NULL,
  `ch_changeIdNum` INT(11) NOT NULL,
  `ch_project` VARCHAR(128) NOT NULL,
  `ch_branch` VARCHAR(128) NOT NULL,
  `ch_topic` VARCHAR(128) NULL DEFAULT NULL,
  `ch_authorAccountId` VARCHAR(16) NOT NULL,
  `ch_createdTime` DATETIME NULL DEFAULT NULL,
  `ch_updatedTime` DATETIME NULL DEFAULT NULL,
  `ch_status` VARCHAR(16) NOT NULL,
  `ch_mergeable` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_t_change_1_idx` (`ch_authorAccountId` ASC),
  UNIQUE INDEX `ch_id_UNIQUE` (`ch_id` ASC),
  CONSTRAINT `fk_t_change_1`
    FOREIGN KEY (`ch_authorAccountId`)
    REFERENCES `gm_eclipse`.`t_people` (`p_accountId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 15888
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gm_eclipse`.`t_revision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gm_eclipse`.`t_revision` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `rev_id` VARCHAR(64) NOT NULL,
  `rev_subject` LONGTEXT NOT NULL,
  `rev_message` LONGTEXT NULL,
  `rev_authorUsername` VARCHAR(64) NULL,
  `rev_createdTime` DATETIME NULL DEFAULT NULL,
  `rev_committerUsername` VARCHAR(64) NOT NULL,
  `rev_committedTime` DATETIME NULL DEFAULT NULL,
  `rev_ref` VARCHAR(256) NULL,
  `rev_git` VARCHAR(256) NULL,
  `rev_repo` VARCHAR(256) NULL DEFAULT NULL,
  `rev_http` VARCHAR(256) NULL DEFAULT NULL,
  `rev_ssh` VARCHAR(256) NULL DEFAULT NULL,
  `rev_patchSetNum` INT(11) NOT NULL,
  `rev_changeId` INT(11) NOT NULL,
  PRIMARY KEY (`id`, `rev_patchSetNum`),
  UNIQUE INDEX `rev_id_UNIQUE` (`rev_id` ASC),
  INDEX `fk_t_revision_1_idx` (`rev_changeId` ASC),
  INDEX `fk_t_revision_2_idx` (`rev_patchSetNum` ASC),
  CONSTRAINT `fk_t_revision_1`
    FOREIGN KEY (`rev_changeId`)
    REFERENCES `gm_eclipse`.`t_change` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 39910
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gm_eclipse`.`t_file`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gm_eclipse`.`t_file` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `f_fileName` VARCHAR(512) NOT NULL,
  `f_linesInserted` INT(11) NULL DEFAULT NULL,
  `f_linesDeleted` INT(11) NULL DEFAULT NULL,
  `f_revisionId` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_t_file_1_idx` (`f_revisionId` ASC),
  CONSTRAINT `fk_t_file_1`
    FOREIGN KEY (`f_revisionId`)
    REFERENCES `gm_eclipse`.`t_revision` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 638419
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `gm_eclipse`.`t_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `gm_eclipse`.`t_history` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `hist_id` VARCHAR(64) NOT NULL,
  `hist_message` LONGTEXT NOT NULL,
  `hist_authorAccountId` VARCHAR(16) NOT NULL,
  `hist_createdTime` DATETIME NULL DEFAULT NULL,
  `hist_patchSetNum` INT(11) NOT NULL,
  `hist_changeId` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_t_history_1_idx` (`hist_authorAccountId` ASC),
  INDEX `fk_t_history_2_idx` (`hist_changeId` ASC),
  INDEX `fk_t_history_3_idx` (`hist_patchSetNum` ASC),
  CONSTRAINT `fk_t_history_1`
    FOREIGN KEY (`hist_authorAccountId`)
    REFERENCES `gm_eclipse`.`t_people` (`p_accountId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_history_2`
    FOREIGN KEY (`hist_changeId`)
    REFERENCES `gm_eclipse`.`t_change` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_t_history_3`
    FOREIGN KEY (`hist_patchSetNum`)
    REFERENCES `gm_eclipse`.`t_revision` (`rev_patchSetNum`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 153177
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
