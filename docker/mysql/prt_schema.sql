-- MySQL dump 10.13  Distrib 8.0.44, for Linux (x86_64)
--
-- Host: localhost    Database: pecosriver
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `abandoned_carts`
--

DROP TABLE IF EXISTS `abandoned_carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abandoned_carts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned DEFAULT NULL,
  `session_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cart_items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `cart_total` decimal(10,2) NOT NULL,
  `item_count` int NOT NULL,
  `is_recovered` tinyint(1) NOT NULL DEFAULT '0',
  `recovered_order_id` bigint unsigned DEFAULT NULL,
  `reminder_count` int NOT NULL DEFAULT '0',
  `last_reminder_at` timestamp NULL DEFAULT NULL,
  `abandoned_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `abandoned_carts_customer_id_index` (`customer_id`),
  KEY `abandoned_carts_email_index` (`email`),
  KEY `abandoned_carts_is_recovered_index` (`is_recovered`),
  KEY `abandoned_carts_abandoned_at_index` (`abandoned_at`),
  CONSTRAINT `abandoned_carts_chk_1` CHECK (json_valid(`cart_items`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_tasks`
--

DROP TABLE IF EXISTS `admin_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_tasks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `task_type` enum('call','email','follow_up','review','meeting','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'other',
  `priority` enum('low','medium','high') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'medium',
  `status` enum('pending','in_progress','completed','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `due_date` datetime DEFAULT NULL,
  `reminder_at` datetime DEFAULT NULL,
  `assigned_to` bigint unsigned DEFAULT NULL,
  `assigned_by` bigint unsigned DEFAULT NULL,
  `related_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `related_id` bigint unsigned DEFAULT NULL,
  `is_recurring` tinyint(1) NOT NULL DEFAULT '0',
  `recurrence_rule` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_tasks_assigned_to_index` (`assigned_to`),
  KEY `admin_tasks_status_index` (`status`),
  KEY `admin_tasks_due_date_index` (`due_date`),
  KEY `admin_tasks_related_type_related_id_index` (`related_type`,`related_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcement_settings`
--

DROP TABLE IF EXISTS `announcement_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcement_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `allow_dismiss` tinyint(1) NOT NULL DEFAULT '1',
  `rotation_speed` int NOT NULL DEFAULT '5',
  `animation` enum('fade','slide','none') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fade',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_text` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` enum('left','center','right') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'center',
  `bg_color` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#C41E3A',
  `text_color` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#FFFFFF',
  `display_order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_keys`
--

DROP TABLE IF EXISTS `api_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_keys` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `scopes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `ip_whitelist` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `rate_limit_per_minute` int NOT NULL DEFAULT '60',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `last_used_at` timestamp NULL DEFAULT NULL,
  `usage_count` int NOT NULL DEFAULT '0',
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_by` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_keys_key_unique` (`key`),
  CONSTRAINT `api_keys_chk_1` CHECK (json_valid(`scopes`)),
  CONSTRAINT `api_keys_chk_2` CHECK (json_valid(`ip_whitelist`))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_logs`
--

DROP TABLE IF EXISTS `api_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dropshipper_id` int DEFAULT NULL,
  `method` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `endpoint` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_code` int NOT NULL,
  `response_time` int NOT NULL COMMENT 'milliseconds',
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_body` text COLLATE utf8mb4_unicode_ci,
  `response_body` text COLLATE utf8mb4_unicode_ci,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `user_agent` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_dropshipper` (`dropshipper_id`),
  KEY `idx_status_code` (`status_code`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `api_logs_ibfk_1` FOREIGN KEY (`dropshipper_id`) REFERENCES `dropshippers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2758 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automation_enrollments`
--

DROP TABLE IF EXISTS `automation_enrollments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automation_enrollments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `workflow_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  `current_step` int DEFAULT NULL,
  `status` enum('active','completed','exited','paused') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `enrolled_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` timestamp NULL DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `automation_enrollments_workflow_id_customer_id_index` (`workflow_id`,`customer_id`),
  KEY `automation_enrollments_status_index` (`status`),
  CONSTRAINT `automation_enrollments_workflow_id_foreign` FOREIGN KEY (`workflow_id`) REFERENCES `automation_workflows` (`id`) ON DELETE CASCADE,
  CONSTRAINT `automation_enrollments_chk_1` CHECK (json_valid(`data`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automation_logs`
--

DROP TABLE IF EXISTS `automation_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automation_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `enrollment_id` bigint unsigned NOT NULL,
  `step_id` bigint unsigned NOT NULL,
  `action` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('success','failed','skipped') COLLATE utf8mb4_unicode_ci NOT NULL,
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `automation_logs_enrollment_id_index` (`enrollment_id`),
  CONSTRAINT `automation_logs_enrollment_id_foreign` FOREIGN KEY (`enrollment_id`) REFERENCES `automation_enrollments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automation_steps`
--

DROP TABLE IF EXISTS `automation_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automation_steps` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `workflow_id` bigint unsigned NOT NULL,
  `step_order` int NOT NULL,
  `step_type` enum('email','sms','wait','condition','action','split') COLLATE utf8mb4_unicode_ci NOT NULL,
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `automation_steps_workflow_id_foreign` (`workflow_id`),
  CONSTRAINT `automation_steps_workflow_id_foreign` FOREIGN KEY (`workflow_id`) REFERENCES `automation_workflows` (`id`) ON DELETE CASCADE,
  CONSTRAINT `automation_steps_chk_1` CHECK (json_valid(`config`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `automation_workflows`
--

DROP TABLE IF EXISTS `automation_workflows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `automation_workflows` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `trigger_type` enum('time','behavior','threshold','event','manual') COLLATE utf8mb4_unicode_ci NOT NULL,
  `trigger_config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `stats` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `automation_workflows_chk_1` CHECK (json_valid(`trigger_config`)),
  CONSTRAINT `automation_workflows_chk_2` CHECK (json_valid(`stats`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `banner_settings`
--

DROP TABLE IF EXISTS `banner_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banner_settings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `carousel_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `slide_duration` int NOT NULL DEFAULT '5',
  `show_indicators` tinyint(1) NOT NULL DEFAULT '1',
  `show_controls` tinyint(1) NOT NULL DEFAULT '1',
  `transition` enum('slide','fade') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'slide',
  `banner_height` int NOT NULL DEFAULT '400',
  `mobile_banner_height` int NOT NULL DEFAULT '250',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blog_categories`
--

DROP TABLE IF EXISTS `blog_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `display_order` int DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`),
  KEY `idx_display_order` (`display_order`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blog_post_tags`
--

DROP TABLE IF EXISTS `blog_post_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_post_tags` (
  `post_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`post_id`,`tag_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `blog_post_tags_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `blog_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_post_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `blog_tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blog_posts`
--

DROP TABLE IF EXISTS `blog_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `excerpt` text COLLATE utf8mb4_general_ci,
  `content` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `featured_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `author_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('draft','published','scheduled') COLLATE utf8mb4_general_ci DEFAULT 'draft',
  `publish_date` datetime DEFAULT NULL,
  `views` int DEFAULT '0',
  `meta_title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `meta_description` text COLLATE utf8mb4_general_ci,
  `meta_keywords` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`),
  KEY `idx_status` (`status`),
  KEY `idx_publish_date` (`publish_date`),
  KEY `idx_category` (`category_id`),
  CONSTRAINT `blog_posts_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `blog_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blog_tags`
--

DROP TABLE IF EXISTS `blog_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `canned_responses`
--

DROP TABLE IF EXISTS `canned_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `canned_responses` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shortcut` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `carrier_integrations`
--

DROP TABLE IF EXISTS `carrier_integrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrier_integrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `carrier_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `carrier_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `account_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_connected` tinyint(1) DEFAULT '0',
  `is_enabled` tinyint(1) DEFAULT '1',
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `last_connected_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carrier_code` (`carrier_code`),
  CONSTRAINT `carrier_integrations_chk_1` CHECK (json_valid(`settings`))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `session_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_upc` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_session_id` (`session_id`),
  KEY `idx_product_upc` (`product_upc`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catagories2`
--

DROP TABLE IF EXISTS `catagories2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catagories2` (
  `Category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShrtDescription` longtext COLLATE utf8mb4_unicode_ci,
  `lngDescription` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Directory` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CategoryCode` int DEFAULT NULL,
  `sOrder` int DEFAULT NULL,
  `Level` int DEFAULT NULL,
  `IsBottom` tinyint(1) NOT NULL,
  `IsOrdered` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `Category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShrtDescription` longtext COLLATE utf8mb4_unicode_ci,
  `lngDescription` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Directory` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CategoryCode` int NOT NULL DEFAULT '0',
  `sOrder` int DEFAULT NULL,
  `Level` int DEFAULT NULL,
  `IsBottom` tinyint(1) NOT NULL,
  `IsOrdered` tinyint(1) DEFAULT '0',
  KEY `idx_category_name` (`Category`),
  KEY `idx_isbottom` (`IsBottom`),
  KEY `idx_level` (`Level`),
  KEY `idx_category_bottom` (`Category`,`IsBottom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories2-bak`
--

DROP TABLE IF EXISTS `categories2-bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories2-bak` (
  `Category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShrtDescription` longtext COLLATE utf8mb4_unicode_ci,
  `lngDescription` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Directory` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CategoryCode` int DEFAULT NULL,
  `sOrder` int DEFAULT NULL,
  `Level` int DEFAULT NULL,
  `IsBottom` tinyint(1) NOT NULL,
  `IsOrdered` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories_backup`
--

DROP TABLE IF EXISTS `categories_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories_backup` (
  `Category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShrtDescription` longtext COLLATE utf8mb4_unicode_ci,
  `lngDescription` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Directory` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CategoryCode` int NOT NULL DEFAULT '0',
  `sOrder` int DEFAULT NULL,
  `Level` int DEFAULT NULL,
  `IsBottom` tinyint(1) NOT NULL,
  `IsOrdered` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories_old`
--

DROP TABLE IF EXISTS `categories_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories_old` (
  `Category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShrtDescription` longtext COLLATE utf8mb4_unicode_ci,
  `lngDescription` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Directory` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CategoryCode` int NOT NULL DEFAULT '0',
  `sOrder` int DEFAULT NULL,
  `Level` int DEFAULT NULL,
  `IsBottom` tinyint(1) NOT NULL,
  `IsOrdered` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_messages`
--

DROP TABLE IF EXISTS `contact_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('unread','read','replied','archived') COLLATE utf8mb4_unicode_ci DEFAULT 'unread',
  `user_id` int DEFAULT NULL COMMENT 'If submitted by logged-in user',
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `read_by` int DEFAULT NULL,
  `replied_at` timestamp NULL DEFAULT NULL,
  `replied_by` int DEFAULT NULL,
  `admin_notes` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_email` (`email`),
  KEY `idx_created_at` (`created_at`),
  KEY `user_id` (`user_id`),
  KEY `read_by` (`read_by`),
  KEY `replied_by` (`replied_by`),
  CONSTRAINT `contact_messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `contact_messages_ibfk_2` FOREIGN KEY (`read_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `contact_messages_ibfk_3` FOREIGN KEY (`replied_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `country_codes`
--

DROP TABLE IF EXISTS `country_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country_codes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Country_cd` varchar(2) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Country_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coupon_categories`
--

DROP TABLE IF EXISTS `coupon_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_categories` (
  `coupon_id` int NOT NULL,
  `category_code` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`coupon_id`,`category_code`),
  CONSTRAINT `coupon_categories_ibfk_1` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coupon_products`
--

DROP TABLE IF EXISTS `coupon_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_products` (
  `coupon_id` int NOT NULL,
  `product_id` double NOT NULL,
  PRIMARY KEY (`coupon_id`,`product_id`),
  CONSTRAINT `coupon_products_ibfk_1` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coupon_usage`
--

DROP TABLE IF EXISTS `coupon_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_usage` (
  `id` int NOT NULL AUTO_INCREMENT,
  `coupon_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `order_total` decimal(10,2) DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT NULL,
  `used_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_coupon` (`coupon_id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_order` (`order_id`),
  CONSTRAINT `coupon_usage_ibfk_1` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coupon_usages`
--

DROP TABLE IF EXISTS `coupon_usages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_usages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `coupon_id` int NOT NULL,
  `user_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `discount_amount` decimal(10,2) NOT NULL,
  `used_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_coupon_id` (`coupon_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `discount_type` enum('percentage','fixed') COLLATE utf8mb4_general_ci NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `min_order_amount` decimal(10,2) DEFAULT '0.00',
  `max_discount_amount` decimal(10,2) DEFAULT NULL,
  `usage_limit` int DEFAULT NULL,
  `usage_per_customer` int DEFAULT '1',
  `start_date` datetime DEFAULT NULL,
  `expiration_date` datetime DEFAULT NULL,
  `status` enum('active','inactive','expired') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `applies_to` enum('all','categories','products') COLLATE utf8mb4_general_ci DEFAULT 'all',
  `exclude_sale_items` tinyint(1) DEFAULT '0',
  `free_shipping` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `idx_code` (`code`),
  KEY `idx_status` (`status`),
  KEY `idx_expiration` (`expiration_date`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_reports`
--

DROP TABLE IF EXISTS `custom_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_reports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `type` enum('sales','customers','products','marketing','support','custom') COLLATE utf8mb4_unicode_ci NOT NULL,
  `metrics` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `dimensions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `filters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `date_range` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `chart_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'bar',
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` bigint unsigned NOT NULL,
  `shared_with` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `is_scheduled` tinyint(1) NOT NULL DEFAULT '0',
  `schedule_frequency` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `schedule_recipients` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `last_run_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `custom_reports_slug_unique` (`slug`),
  CONSTRAINT `custom_reports_chk_1` CHECK (json_valid(`metrics`)),
  CONSTRAINT `custom_reports_chk_2` CHECK (json_valid(`dimensions`)),
  CONSTRAINT `custom_reports_chk_3` CHECK (json_valid(`filters`)),
  CONSTRAINT `custom_reports_chk_4` CHECK (json_valid(`date_range`)),
  CONSTRAINT `custom_reports_chk_5` CHECK (json_valid(`shared_with`)),
  CONSTRAINT `custom_reports_chk_6` CHECK (json_valid(`schedule_recipients`))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ProdOrderID` int DEFAULT NULL,
  `orderdate` datetime DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tot` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qty` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `orderid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `prodid` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reseller` int DEFAULT NULL,
  `trackingid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_achievements`
--

DROP TABLE IF EXISTS `customer_achievements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_achievements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `achievement_id` bigint unsigned NOT NULL,
  `earned_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_achievements_customer_id_achievement_id_unique` (`customer_id`,`achievement_id`),
  KEY `customer_achievements_achievement_id_foreign` (`achievement_id`),
  CONSTRAINT `customer_achievements_achievement_id_foreign` FOREIGN KEY (`achievement_id`) REFERENCES `loyalty_achievements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_activities`
--

DROP TABLE IF EXISTS `customer_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_activities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `activity_type` enum('order','email','support','review','loyalty','login','note','wishlist','cart','account','other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_activities_customer_id_created_at_index` (`customer_id`,`created_at`),
  KEY `customer_activities_activity_type_index` (`activity_type`),
  CONSTRAINT `customer_activities_chk_1` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_cohorts`
--

DROP TABLE IF EXISTS `customer_cohorts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_cohorts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cohort_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cohort_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_count` int NOT NULL DEFAULT '0',
  `metrics` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `cohort_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_cohorts_cohort_type_cohort_value_unique` (`cohort_type`,`cohort_value`),
  CONSTRAINT `customer_cohorts_chk_1` CHECK (json_valid(`metrics`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_communications`
--

DROP TABLE IF EXISTS `customer_communications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_communications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `type` enum('email','sms','chat','phone','social','internal') COLLATE utf8mb4_unicode_ci NOT NULL,
  `direction` enum('inbound','outbound') COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `template_id` bigint unsigned DEFAULT NULL,
  `status` enum('draft','scheduled','sent','delivered','opened','clicked','bounced','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sent',
  `scheduled_at` timestamp NULL DEFAULT NULL,
  `sent_at` timestamp NULL DEFAULT NULL,
  `opened_at` timestamp NULL DEFAULT NULL,
  `clicked_at` timestamp NULL DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_communications_customer_id_created_at_index` (`customer_id`,`created_at`),
  KEY `customer_communications_type_index` (`type`),
  KEY `customer_communications_status_index` (`status`),
  CONSTRAINT `customer_communications_chk_1` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_metrics`
--

DROP TABLE IF EXISTS `customer_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_metrics` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `lifetime_value` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total_orders` int NOT NULL DEFAULT '0',
  `avg_order_value` decimal(10,2) NOT NULL DEFAULT '0.00',
  `first_order_date` date DEFAULT NULL,
  `last_order_date` date DEFAULT NULL,
  `days_since_last_order` int DEFAULT NULL,
  `purchase_frequency` decimal(5,2) DEFAULT NULL,
  `rfm_recency_score` int DEFAULT NULL,
  `rfm_frequency_score` int DEFAULT NULL,
  `rfm_monetary_score` int DEFAULT NULL,
  `rfm_segment` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `churn_risk_score` decimal(3,2) DEFAULT NULL,
  `health_score` int DEFAULT NULL,
  `email_open_rate` int DEFAULT NULL,
  `email_click_rate` int DEFAULT NULL,
  `calculated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_metrics_customer_id_unique` (`customer_id`),
  KEY `customer_metrics_rfm_segment_index` (`rfm_segment`),
  KEY `customer_metrics_churn_risk_score_index` (`churn_risk_score`),
  KEY `customer_metrics_health_score_index` (`health_score`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_notes`
--

DROP TABLE IF EXISTS `customer_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_notes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_pinned` tinyint(1) NOT NULL DEFAULT '0',
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `created_by` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_notes_customer_id_index` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_segment_members`
--

DROP TABLE IF EXISTS `customer_segment_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_segment_members` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `segment_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_segment_members_segment_id_customer_id_unique` (`segment_id`,`customer_id`),
  KEY `customer_segment_members_customer_id_index` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_segments`
--

DROP TABLE IF EXISTS `customer_segments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_segments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `rules` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `is_dynamic` tinyint(1) NOT NULL DEFAULT '1',
  `is_preset` tinyint(1) NOT NULL DEFAULT '0',
  `customer_count` int NOT NULL DEFAULT '0',
  `last_calculated` timestamp NULL DEFAULT NULL,
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_segments_name_unique` (`name`),
  CONSTRAINT `customer_segments_chk_1` CHECK (json_valid(`rules`))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_tag_assignments`
--

DROP TABLE IF EXISTS `customer_tag_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_tag_assignments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `tag_id` bigint unsigned NOT NULL,
  `assigned_by` bigint unsigned DEFAULT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_tag_assignments_customer_id_tag_id_unique` (`customer_id`,`tag_id`),
  KEY `customer_tag_assignments_customer_id_index` (`customer_id`),
  KEY `customer_tag_assignments_tag_id_index` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer_tags`
--

DROP TABLE IF EXISTS `customer_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_tags` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `color` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#6c757d',
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_auto` tinyint(1) NOT NULL DEFAULT '0',
  `auto_criteria` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `usage_count` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_tags_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `NameFirst` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameMiddle` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameLast` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Company` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `LastLogin` datetime DEFAULT NULL,
  `LastLoginIP` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(75) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `City` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `State` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillAddress1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillAddress2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillCity` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillState` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillZip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillPhone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillFax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipAddress1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipAddress2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipCity` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipState` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipZip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipPhone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipFax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Validated` tinyint(1) NOT NULL,
  `ProfileType` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CCType` varchar(24) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CCNum` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CCExp` datetime DEFAULT NULL,
  `Class` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MEMBEROPTIONS` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_exports`
--

DROP TABLE IF EXISTS `data_exports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_exports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('customers','orders','products','analytics','custom') COLLATE utf8mb4_unicode_ci NOT NULL,
  `filters` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `columns` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `format` enum('csv','xlsx','json') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'csv',
  `status` enum('pending','processing','completed','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `file_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_size` int DEFAULT NULL,
  `record_count` int DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `data_exports_chk_1` CHECK (json_valid(`filters`)),
  CONSTRAINT `data_exports_chk_2` CHECK (json_valid(`columns`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deal_activities`
--

DROP TABLE IF EXISTS `deal_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deal_activities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `deal_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `type` enum('call','email','meeting','note','task','stage_change','other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `deal_activities_deal_id_foreign` (`deal_id`),
  CONSTRAINT `deal_activities_deal_id_foreign` FOREIGN KEY (`deal_id`) REFERENCES `deals` (`id`) ON DELETE CASCADE,
  CONSTRAINT `deal_activities_chk_1` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deal_stages`
--

DROP TABLE IF EXISTS `deal_stages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deal_stages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#6c757d',
  `sort_order` int NOT NULL DEFAULT '0',
  `probability` int NOT NULL DEFAULT '0',
  `is_won` tinyint(1) NOT NULL DEFAULT '0',
  `is_lost` tinyint(1) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deal_stages_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `deals`
--

DROP TABLE IF EXISTS `deals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deals` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `deal_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lead_id` bigint unsigned DEFAULT NULL,
  `customer_id` int unsigned DEFAULT NULL,
  `stage_id` bigint unsigned NOT NULL,
  `value` decimal(12,2) NOT NULL,
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USD',
  `probability` int NOT NULL DEFAULT '0',
  `expected_close_date` date DEFAULT NULL,
  `actual_close_date` date DEFAULT NULL,
  `assigned_to` bigint unsigned DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `line_items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `won_at` timestamp NULL DEFAULT NULL,
  `lost_at` timestamp NULL DEFAULT NULL,
  `lost_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `deals_deal_number_unique` (`deal_number`),
  KEY `deals_lead_id_foreign` (`lead_id`),
  KEY `deals_stage_id_assigned_to_index` (`stage_id`,`assigned_to`),
  KEY `deals_expected_close_date_index` (`expected_close_date`),
  CONSTRAINT `deals_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE SET NULL,
  CONSTRAINT `deals_stage_id_foreign` FOREIGN KEY (`stage_id`) REFERENCES `deal_stages` (`id`),
  CONSTRAINT `deals_chk_1` CHECK (json_valid(`line_items`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dropship_order_items`
--

DROP TABLE IF EXISTS `dropship_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dropship_order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_upc` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quantity` int DEFAULT '1',
  `unit_price` decimal(10,2) DEFAULT '0.00',
  `total_price` decimal(10,2) DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `dropship_order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `dropship_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dropship_orders`
--

DROP TABLE IF EXISTS `dropship_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dropship_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dropshipper_id` int NOT NULL,
  `external_order_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address` text COLLATE utf8mb4_unicode_ci,
  `items_count` int DEFAULT '0',
  `subtotal` decimal(10,2) DEFAULT '0.00',
  `shipping_cost` decimal(10,2) DEFAULT '0.00',
  `tax_amount` decimal(10,2) DEFAULT '0.00',
  `total_amount` decimal(10,2) DEFAULT '0.00',
  `commission_amount` decimal(10,2) DEFAULT '0.00',
  `status` enum('pending','processing','shipped','delivered','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `tracking_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `carrier` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipped_at` timestamp NULL DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number` (`order_number`),
  KEY `dropshipper_id` (`dropshipper_id`),
  CONSTRAINT `dropship_orders_ibfk_1` FOREIGN KEY (`dropshipper_id`) REFERENCES `dropshippers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dropship_webhooks`
--

DROP TABLE IF EXISTS `dropship_webhooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dropship_webhooks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dropshipper_id` int NOT NULL,
  `event_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_dropshipper` (`dropshipper_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dropshipper_permissions`
--

DROP TABLE IF EXISTS `dropshipper_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dropshipper_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `dropshipper_id` int NOT NULL,
  `permission` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `granted` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_perm` (`dropshipper_id`,`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dropshippers`
--

DROP TABLE IF EXISTS `dropshippers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dropshippers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_key` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive','pending') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `commission_rate` decimal(5,2) DEFAULT '0.00',
  `total_orders` int DEFAULT '0',
  `total_revenue` decimal(12,2) DEFAULT '0.00',
  `address_line1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'USA',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_key` (`api_key`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_templates`
--

DROP TABLE IF EXISTS `email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_templates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` enum('order','service','marketing','transactional','personal') COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body_html` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `body_text` text COLLATE utf8mb4_unicode_ci,
  `variables` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_by` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `email_templates_chk_1` CHECK (json_valid(`variables`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emaillist`
--

DROP TABLE IF EXISTS `emaillist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emaillist` (
  `ID` int DEFAULT NULL,
  `Email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Categoryid` int DEFAULT NULL,
  `DateSubscribed` datetime DEFAULT NULL,
  `IsSubscribed` tinyint(1) NOT NULL,
  `NameFirst` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `SubscribedFrom` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `EventName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EnteredBy` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `StartDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `StartTime` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `EndTime` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_categories`
--

DROP TABLE IF EXISTS `faq_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `display_order` int DEFAULT '0',
  `icon` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`),
  KEY `idx_display_order` (`display_order`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `question` text COLLATE utf8mb4_general_ci NOT NULL,
  `answer` longtext COLLATE utf8mb4_general_ci NOT NULL,
  `display_order` int DEFAULT '0',
  `views` int DEFAULT '0',
  `helpful_count` int DEFAULT '0',
  `not_helpful_count` int DEFAULT '0',
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_category` (`category_id`),
  KEY `idx_display_order` (`display_order`),
  KEY `idx_status` (`status`),
  CONSTRAINT `faqs_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `faq_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `featured_categories`
--

DROP TABLE IF EXISTS `featured_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `featured_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned NOT NULL,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `featured_categories_category_id_unique` (`category_id`),
  KEY `featured_categories_sort_order_index` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `featured_products`
--

DROP TABLE IF EXISTS `featured_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `featured_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `upc` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `featured_products_upc_unique` (`upc`),
  KEY `featured_products_sort_order_index` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `footer_columns`
--

DROP TABLE IF EXISTS `footer_columns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `footer_columns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int NOT NULL DEFAULT '1',
  `is_visible` tinyint(1) NOT NULL DEFAULT '1',
  `column_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'links',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `footer_columns_position_unique` (`position`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `footer_links`
--

DROP TABLE IF EXISTS `footer_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `footer_links` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `column_id` bigint unsigned NOT NULL,
  `label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'bi-chevron-right',
  `feature_flag` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'internal',
  `sort_order` int NOT NULL DEFAULT '0',
  `is_visible` tinyint(1) NOT NULL DEFAULT '1',
  `is_core` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `footer_links_column_id_sort_order_index` (`column_id`,`sort_order`),
  CONSTRAINT `footer_links_column_id_foreign` FOREIGN KEY (`column_id`) REFERENCES `footer_columns` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_card_transactions`
--

DROP TABLE IF EXISTS `gift_card_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_card_transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gift_card_id` int NOT NULL,
  `order_id` int DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `type` enum('purchase','redemption','refund','void') COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance_after` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_gift_card` (`gift_card_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gift_cards`
--

DROP TABLE IF EXISTS `gift_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gift_cards` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `initial_balance` decimal(10,2) NOT NULL,
  `current_balance` decimal(10,2) NOT NULL,
  `purchaser_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recipient_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `recipient_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci,
  `status` enum('active','used','expired','voided') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `expires_at` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `idx_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `homepage_banners`
--

DROP TABLE IF EXISTS `homepage_banners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `homepage_banners` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `desktop_image` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile_image` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `link_text` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt_text` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` enum('full','left','center','right') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'full',
  `text_position` enum('left','center','right') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'center',
  `overlay_color` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'rgba(0,0,0,0.3)',
  `text_color` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#FFFFFF',
  `display_order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `homepage_sections`
--

DROP TABLE IF EXISTS `homepage_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `homepage_sections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `background_style` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'white',
  `background_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_visible` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `integration_sync_logs`
--

DROP TABLE IF EXISTS `integration_sync_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integration_sync_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `integration_id` bigint unsigned NOT NULL,
  `entity_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direction` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `records_synced` int NOT NULL DEFAULT '0',
  `records_failed` int NOT NULL DEFAULT '0',
  `errors` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `started_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `completed_at` timestamp NULL DEFAULT NULL,
  `status` enum('running','completed','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'running',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `integration_sync_logs_integration_id_foreign` (`integration_id`),
  CONSTRAINT `integration_sync_logs_integration_id_foreign` FOREIGN KEY (`integration_id`) REFERENCES `integrations` (`id`) ON DELETE CASCADE,
  CONSTRAINT `integration_sync_logs_chk_1` CHECK (json_valid(`errors`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `integrations`
--

DROP TABLE IF EXISTS `integrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integrations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `credentials` text COLLATE utf8mb4_unicode_ci,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `sync_entities` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `sync_direction` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'both',
  `sync_interval_minutes` int NOT NULL DEFAULT '60',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `is_connected` tinyint(1) NOT NULL DEFAULT '0',
  `last_sync_at` timestamp NULL DEFAULT NULL,
  `last_sync_error` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `integrations_provider_name_unique` (`provider`,`name`),
  CONSTRAINT `integrations_chk_1` CHECK (json_valid(`settings`)),
  CONSTRAINT `integrations_chk_2` CHECK (json_valid(`sync_entities`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory_movements`
--

DROP TABLE IF EXISTS `inventory_movements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_movements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `type` enum('in','out','adjustment') COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventory_transactions`
--

DROP TABLE IF EXISTS `inventory_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `transaction_type` enum('purchase','sale','return','adjustment','damaged','transfer') COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity_change` int NOT NULL COMMENT 'Positive = increase, Negative = decrease',
  `quantity_before` int NOT NULL,
  `quantity_after` int NOT NULL,
  `reference_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'order, purchase_order, manual, etc.',
  `reference_id` int DEFAULT NULL COMMENT 'ID of order/PO/etc.',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `user_id` int DEFAULT NULL COMMENT 'Who made the change',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product` (`product_id`),
  KEY `idx_date` (`created_at`),
  KEY `idx_type` (`transaction_type`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lead_activities`
--

DROP TABLE IF EXISTS `lead_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_activities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `lead_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `type` enum('call','email','meeting','note','task','status_change','other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `outcome` enum('completed','no_answer','left_message','scheduled','cancelled','pending') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scheduled_at` timestamp NULL DEFAULT NULL,
  `completed_at` timestamp NULL DEFAULT NULL,
  `duration_minutes` int DEFAULT NULL,
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lead_activities_lead_id_type_index` (`lead_id`,`type`),
  KEY `lead_activities_scheduled_at_index` (`scheduled_at`),
  CONSTRAINT `lead_activities_lead_id_foreign` FOREIGN KEY (`lead_id`) REFERENCES `leads` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lead_activities_chk_1` CHECK (json_valid(`metadata`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lead_sources`
--

DROP TABLE IF EXISTS `lead_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lead_sources` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lead_sources_code_unique` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `leads`
--

DROP TABLE IF EXISTS `leads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leads` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `lead_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` int unsigned DEFAULT NULL,
  `source_id` bigint unsigned DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('new','contacted','qualified','proposal','negotiation','won','lost','dormant') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'new',
  `priority` enum('low','medium','high','hot') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'medium',
  `estimated_value` decimal(12,2) DEFAULT NULL,
  `probability` int NOT NULL DEFAULT '0',
  `expected_close_date` date DEFAULT NULL,
  `assigned_to` bigint unsigned DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `lead_score` int NOT NULL DEFAULT '0',
  `score_breakdown` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `last_contacted_at` timestamp NULL DEFAULT NULL,
  `qualified_at` timestamp NULL DEFAULT NULL,
  `converted_at` timestamp NULL DEFAULT NULL,
  `lost_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `leads_lead_number_unique` (`lead_number`),
  KEY `leads_source_id_foreign` (`source_id`),
  KEY `leads_status_priority_index` (`status`,`priority`),
  KEY `leads_assigned_to_index` (`assigned_to`),
  KEY `leads_lead_score_index` (`lead_score`),
  CONSTRAINT `leads_source_id_foreign` FOREIGN KEY (`source_id`) REFERENCES `lead_sources` (`id`) ON DELETE SET NULL,
  CONSTRAINT `leads_chk_1` CHECK (json_valid(`score_breakdown`))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loyalty_achievements`
--

DROP TABLE IF EXISTS `loyalty_achievements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_achievements` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `badge_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `criteria` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `points_reward` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `loyalty_achievements_chk_1` CHECK (json_valid(`criteria`))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loyalty_members`
--

DROP TABLE IF EXISTS `loyalty_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_members` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `tier_id` int DEFAULT NULL,
  `total_points` int DEFAULT '0',
  `available_points` int DEFAULT '0',
  `lifetime_points` int DEFAULT '0',
  `joined_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `idx_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loyalty_point_rules`
--

DROP TABLE IF EXISTS `loyalty_point_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_point_rules` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `action_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `points_awarded` int NOT NULL,
  `points_type` enum('fixed','multiplier') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fixed',
  `conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `loyalty_point_rules_chk_1` CHECK (json_valid(`conditions`))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loyalty_points`
--

DROP TABLE IF EXISTS `loyalty_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_points` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `points_balance` int DEFAULT '0',
  `lifetime_points` int DEFAULT '0',
  `tier_level` enum('bronze','silver','gold','platinum') COLLATE utf8mb4_general_ci DEFAULT 'bronze',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user` (`user_id`),
  KEY `idx_tier` (`tier_level`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loyalty_rewards`
--

DROP TABLE IF EXISTS `loyalty_rewards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_rewards` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `points_cost` int NOT NULL,
  `reward_type` enum('discount_percentage','discount_fixed','free_shipping','product','other') COLLATE utf8mb4_general_ci NOT NULL,
  `reward_value` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `usage_limit` int DEFAULT NULL,
  `times_redeemed` int DEFAULT '0',
  `min_tier` enum('bronze','silver','gold','platinum') COLLATE utf8mb4_general_ci DEFAULT 'bronze',
  `display_order` int DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_status` (`status`),
  KEY `idx_cost` (`points_cost`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loyalty_settings`
--

DROP TABLE IF EXISTS `loyalty_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_value` text COLLATE utf8mb4_unicode_ci,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key` (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loyalty_tiers`
--

DROP TABLE IF EXISTS `loyalty_tiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_tiers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tier_name` enum('bronze','silver','gold','platinum') COLLATE utf8mb4_general_ci NOT NULL,
  `min_lifetime_points` int NOT NULL,
  `points_multiplier` decimal(3,2) DEFAULT '1.00',
  `benefits` text COLLATE utf8mb4_general_ci,
  `display_order` int DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tier_name` (`tier_name`),
  KEY `idx_points` (`min_lifetime_points`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loyalty_transactions`
--

DROP TABLE IF EXISTS `loyalty_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loyalty_transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `points` int NOT NULL,
  `transaction_type` enum('earned','redeemed','expired','adjusted','bonus') COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `order_id` int DEFAULT NULL,
  `reference_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_type` (`transaction_type`),
  KEY `idx_order` (`order_id`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mailbox`
--

DROP TABLE IF EXISTS `mailbox`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mailbox` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `mailmessage` longtext COLLATE utf8mb4_unicode_ci,
  `description` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profileid` int DEFAULT NULL,
  `datecreated` datetime DEFAULT NULL,
  `messagelimit` int DEFAULT NULL,
  `messageread` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `messagedate` datetime DEFAULT NULL,
  `isNew` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Attachments` bigint DEFAULT NULL,
  `Categorycode` int DEFAULT NULL,
  `ProID` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menutabledef`
--

DROP TABLE IF EXISTS `menutabledef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menutabledef` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `PageNumber` int DEFAULT NULL,
  `Description` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Link` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Sequence` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `newsletter_subscribers`
--

DROP TABLE IF EXISTS `newsletter_subscribers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `newsletter_subscribers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscribed_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('active','unsubscribed','bounced') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `unsubscribe_token` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `unsubscribe_token` (`unsubscribe_token`),
  KEY `idx_email` (`email`),
  KEY `idx_status` (`status`),
  KEY `idx_subscribed_date` (`subscribed_date`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification_log`
--

DROP TABLE IF EXISTS `notification_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `notification_type` enum('delivery','promo','payment','security') COLLATE utf8mb4_general_ci NOT NULL,
  `channel` enum('email','sms','push') COLLATE utf8mb4_general_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_general_ci,
  `status` enum('pending','sent','failed','delivered') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `external_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Twilio SID or Push ID',
  `error_message` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sent_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_type` (`notification_type`),
  KEY `idx_status` (`status`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notification_templates`
--

DROP TABLE IF EXISTS `notification_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `template_key` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `notification_type` enum('delivery','promo','payment','security') COLLATE utf8mb4_general_ci NOT NULL,
  `email_subject` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email_body` text COLLATE utf8mb4_general_ci,
  `sms_message` varchar(160) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `push_title` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `push_body` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `push_icon` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `push_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `template_key` (`template_key`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_items_old`
--

DROP TABLE IF EXISTS `order_items_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items_old` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `upc` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `item_number` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `item_size` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `unit_price` decimal(10,2) NOT NULL,
  `line_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order_status_history`
--

DROP TABLE IF EXISTS `order_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_first_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_last_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `total_amount` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `tax_amount` decimal(10,2) DEFAULT NULL,
  `shipping_cost` decimal(10,2) DEFAULT NULL,
  `payment_last4` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_card_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_notes` text COLLATE utf8mb4_unicode_ci,
  `status` enum('pending','processing','shipped','delivered','cancelled') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `shipping_address_id` int DEFAULT NULL,
  `billing_address_id` int DEFAULT NULL,
  `payment_method_id` int DEFAULT NULL,
  `billing_address1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_state` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_zip` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_address2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_state` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shipping_zip` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number` (`order_number`),
  KEY `shipping_address_id` (`shipping_address_id`),
  KEY `billing_address_id` (`billing_address_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_order_number` (`order_number`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`shipping_address_id`) REFERENCES `user_addresses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`billing_address_id`) REFERENCES `user_addresses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orders_old`
--

DROP TABLE IF EXISTS `orders_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_old` (
  `QTY` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Image` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UPC` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Price` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `OrderNo` int DEFAULT NULL,
  `Timestamp` datetime DEFAULT NULL,
  `ProdOrderID` int DEFAULT NULL,
  `OrderType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ItemSize` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_general_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photos` (
  `ID` int DEFAULT NULL,
  `Image` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Directory` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sOrder` int DEFAULT NULL,
  `sSection` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `predictive_scores`
--

DROP TABLE IF EXISTS `predictive_scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `predictive_scores` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int unsigned NOT NULL,
  `churn_probability` decimal(5,4) NOT NULL DEFAULT '0.0000',
  `churn_risk_level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `churn_factors` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `purchase_probability_30d` decimal(5,4) NOT NULL DEFAULT '0.0000',
  `predicted_order_value` decimal(12,2) DEFAULT NULL,
  `predicted_next_order` date DEFAULT NULL,
  `predicted_ltv` decimal(12,2) NOT NULL DEFAULT '0.00',
  `ltv_confidence` decimal(5,4) NOT NULL DEFAULT '0.0000',
  `engagement_score` int NOT NULL DEFAULT '0',
  `engagement_breakdown` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `calculated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `predictive_scores_customer_id_index` (`customer_id`),
  KEY `predictive_scores_churn_probability_index` (`churn_probability`),
  KEY `predictive_scores_engagement_score_index` (`engagement_score`),
  CONSTRAINT `predictive_scores_chk_1` CHECK (json_valid(`churn_factors`)),
  CONSTRAINT `predictive_scores_chk_2` CHECK (json_valid(`engagement_breakdown`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_answers`
--

DROP TABLE IF EXISTS `product_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_answers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint unsigned NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `answered_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answer_type` enum('official','customer') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'official',
  `answer` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  `helpful_votes` int NOT NULL DEFAULT '0',
  `unhelpful_votes` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_answers_question_id_index` (`question_id`),
  CONSTRAINT `product_answers_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `product_questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_history`
--

DROP TABLE IF EXISTS `product_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_history` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` double NOT NULL,
  `upc` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `old_value` text COLLATE utf8mb4_unicode_ci,
  `new_value` text COLLATE utf8mb4_unicode_ci,
  `action` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'update',
  `user_id` bigint unsigned DEFAULT NULL,
  `user_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `product_history_product_id_index` (`product_id`),
  KEY `product_history_upc_index` (`upc`),
  KEY `product_history_created_at_index` (`created_at`),
  KEY `product_history_action_index` (`action`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` double NOT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `display_order` int DEFAULT '0',
  `is_primary` tinyint(1) DEFAULT '0',
  `alt_text` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_display_order` (`display_order`)
) ENGINE=InnoDB AUTO_INCREMENT=338 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_questions`
--

DROP TABLE IF EXISTS `product_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_questions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `question` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','approved','rejected','answered') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `helpful_votes` int NOT NULL DEFAULT '0',
  `unhelpful_votes` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_questions_product_id_index` (`product_id`),
  KEY `product_questions_status_index` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product_reviews`
--

DROP TABLE IF EXISTS `product_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int DEFAULT NULL,
  `reviewer_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reviewer_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rating` int NOT NULL,
  `review_title` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `review_text` text COLLATE utf8mb4_unicode_ci,
  `is_verified_purchase` tinyint(1) DEFAULT '0',
  `status` enum('pending','approved','rejected','spam') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `helpful_count` int DEFAULT '0',
  `unhelpful_count` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_rating` (`rating`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `product_reviews_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `UPC` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Company` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Weight` text COLLATE utf8mb4_unicode_ci,
  `UOM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Price` decimal(19,4) DEFAULT NULL,
  `CategoryCode` int DEFAULT NULL,
  `ProductType` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Pkg_Per_Case` int DEFAULT NULL,
  `Class` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Sold_out` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Unit_price` decimal(19,4) DEFAULT NULL,
  `Mark_up` int DEFAULT NULL,
  `Qty_avail` int DEFAULT NULL,
  `reserved_quantity` int DEFAULT '0' COMMENT 'Reserved for pending orders',
  `reorder_point` int DEFAULT '10' COMMENT 'When to reorder',
  `reorder_quantity` int DEFAULT '50' COMMENT 'How many to reorder',
  `cost_price` decimal(10,2) DEFAULT NULL COMMENT 'What we pay for product',
  `last_restock_date` datetime DEFAULT NULL COMMENT 'Last time inventory added',
  `track_inventory` tinyint(1) DEFAULT '1' COMMENT 'Enable/disable tracking per product',
  `allow_backorder` tinyint(1) DEFAULT '0' COMMENT 'Allow selling when out of stock',
  `low_stock_threshold` int DEFAULT '5' COMMENT 'Low stock warning level'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products2`
--

DROP TABLE IF EXISTS `products2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products2` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ItemNumber` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShortDescription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LngDescription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UnitPrice` double DEFAULT NULL,
  `QTY` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CategoryCode` double DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products3`
--

DROP TABLE IF EXISTS `products3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products3` (
  `ID` double DEFAULT NULL,
  `ItemNumber` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShortDescription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LngDescription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(160) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `UnitPrice` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sale_price` decimal(10,2) DEFAULT NULL,
  `QTY` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CategoryCode` double DEFAULT NULL,
  `sOrder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UPC` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ItemSize` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `material` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_quantity` int DEFAULT '0' COMMENT 'Current stock on hand',
  `reserved_quantity` int DEFAULT '0' COMMENT 'Reserved for pending orders',
  `reorder_point` int DEFAULT '10' COMMENT 'When to reorder',
  `reorder_quantity` int DEFAULT '50' COMMENT 'How many to reorder',
  `cost_price` decimal(10,2) DEFAULT '0.00' COMMENT 'Cost per unit',
  `last_restock_date` datetime DEFAULT NULL COMMENT 'Last time inventory added',
  `track_inventory` tinyint(1) DEFAULT '1' COMMENT 'Enable inventory tracking',
  `allow_backorder` tinyint(1) DEFAULT '0' COMMENT 'Allow selling when out of stock',
  `low_stock_threshold` int DEFAULT '5' COMMENT 'Low stock warning level',
  `preferred_supplier_id` int DEFAULT NULL COMMENT 'Preferred supplier for reordering',
  `last_supplier_id` int DEFAULT NULL COMMENT 'Last supplier product was purchased from',
  `last_purchase_date` date DEFAULT NULL COMMENT 'Date of last purchase from supplier',
  `last_purchase_cost` decimal(10,2) DEFAULT NULL COMMENT 'Last purchase cost from supplier',
  KEY `idx_categorycode` (`CategoryCode`),
  KEY `idx_itemnumber` (`ItemNumber`),
  KEY `idx_upc` (`UPC`),
  KEY `idx_preferred_supplier` (`preferred_supplier_id`),
  KEY `idx_last_supplier` (`last_supplier_id`),
  CONSTRAINT `fk_products_last_supplier` FOREIGN KEY (`last_supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_products_preferred_supplier` FOREIGN KEY (`preferred_supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products3_backup`
--

DROP TABLE IF EXISTS `products3_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products3_backup` (
  `ID` double DEFAULT NULL,
  `ItemNumber` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShortDescription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LngDescription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UnitPrice` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `QTY` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CategoryCode` double DEFAULT NULL,
  `sOrder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UPC` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ItemSize` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products3_bak`
--

DROP TABLE IF EXISTS `products3_bak`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products3_bak` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `ItemNumber` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShortDescription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LngDescription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UnitPrice` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `QTY` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CategoryCode` double DEFAULT NULL,
  `sOrder` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=509 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products3_old`
--

DROP TABLE IF EXISTS `products3_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products3_old` (
  `ID` double DEFAULT NULL,
  `ItemNumber` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShortDescription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `LngDescription` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UnitPrice` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `QTY` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CategoryCode` double DEFAULT NULL,
  `sOrder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `UPC` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ItemSize` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profile`
--

DROP TABLE IF EXISTS `profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile` (
  `NameFirst` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameMiddle` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameLast` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Login` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Password` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Company` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `LastLogin` datetime DEFAULT NULL,
  `LastLoginIP` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `City` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `State` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillAddress1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillAddress2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillCity` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillState` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillZip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillPhone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillFax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipAddress1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipAddress2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipCity` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipState` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipZip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipPhone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipFax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Validated` tinyint(1) NOT NULL,
  `UserType` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isAdmin` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `NameFirst` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameMiddle` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameLast` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Login` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Password` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Company` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `LastLogin` datetime DEFAULT NULL,
  `LastLoginIP` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `City` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `State` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillAddress1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillAddress2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillCity` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillState` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillZip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillPhone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillFax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipAddress1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipAddress2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipCity` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipState` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipZip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipPhone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipFax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Validated` tinyint(1) NOT NULL,
  `UserType` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isAdmin` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `profilews`
--

DROP TABLE IF EXISTS `profilews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profilews` (
  `NameFirst` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameMiddle` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameLast` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Login` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Password` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Company` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Business_Type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `LastLogin` datetime DEFAULT NULL,
  `LastLoginIP` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `City` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `State` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillAddress1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillAddress2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillCity` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillState` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillZip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillPhone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BillFax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipAddress1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipAddress2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipCity` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipState` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipZip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipPhone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShipFax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Validated` varchar(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ProfileType` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CCType` varchar(24) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CCNum` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CCExp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_order_items`
--

DROP TABLE IF EXISTS `purchase_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Snapshot of product name at time of order',
  `sku` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Product SKU/Part Number',
  `quantity_ordered` int NOT NULL,
  `quantity_received` int NOT NULL DEFAULT '0',
  `unit_cost` decimal(10,2) NOT NULL COMMENT 'Cost per unit',
  `line_total` decimal(10,2) NOT NULL COMMENT 'quantity_ordered * unit_cost',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_po` (`purchase_order_id`),
  KEY `idx_product` (`product_id`),
  CONSTRAINT `fk_poi_purchase_order` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Line items for each purchase order';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_order_receiving`
--

DROP TABLE IF EXISTS `purchase_order_receiving`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_order_receiving` (
  `id` int NOT NULL AUTO_INCREMENT,
  `purchase_order_id` int NOT NULL,
  `purchase_order_item_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity_received` int NOT NULL,
  `received_date` datetime NOT NULL,
  `condition` enum('good','damaged','defective') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'good',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `received_by` int DEFAULT NULL COMMENT 'User ID who received the items',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_po` (`purchase_order_id`),
  KEY `idx_poi` (`purchase_order_item_id`),
  KEY `idx_product` (`product_id`),
  KEY `idx_date` (`received_date`),
  CONSTRAINT `fk_por_purchase_order` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_por_purchase_order_item` FOREIGN KEY (`purchase_order_item_id`) REFERENCES `purchase_order_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Detailed log of when items are received';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchase_orders`
--

DROP TABLE IF EXISTS `purchase_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchase_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `supplier_id` int DEFAULT NULL,
  `dropshipper_id` int DEFAULT NULL,
  `po_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'PO-YYYYMMDD-XXX format',
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `supplier_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_address` text COLLATE utf8mb4_unicode_ci,
  `order_date` date NOT NULL,
  `expected_delivery_date` date DEFAULT NULL,
  `actual_delivery_date` date DEFAULT NULL,
  `status` enum('draft','ordered','shipped','partially_received','received','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `subtotal` decimal(10,2) NOT NULL DEFAULT '0.00',
  `shipping_cost` decimal(10,2) DEFAULT '0.00',
  `tax` decimal(10,2) DEFAULT '0.00',
  `total_cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` int DEFAULT NULL COMMENT 'User ID who created the PO',
  `updated_by` int DEFAULT NULL COMMENT 'User ID who last updated',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `po_number` (`po_number`),
  UNIQUE KEY `idx_po_number` (`po_number`),
  KEY `idx_status` (`status`),
  KEY `idx_order_date` (`order_date`),
  KEY `idx_supplier` (`supplier_name`),
  KEY `fk_supplier` (`supplier_id`),
  KEY `fk_dropshipper` (`dropshipper_id`),
  CONSTRAINT `fk_dropshipper` FOREIGN KEY (`dropshipper_id`) REFERENCES `dropshippers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_supplier` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Purchase orders from suppliers';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `push_subscriptions`
--

DROP TABLE IF EXISTS `push_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `push_subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `endpoint` text COLLATE utf8mb4_general_ci NOT NULL,
  `p256dh_key` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `auth_key` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_agent` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_user` (`user_id`),
  KEY `idx_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qa_votes`
--

DROP TABLE IF EXISTS `qa_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `qa_votes` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `vote_type` enum('question','answer') COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` bigint unsigned NOT NULL,
  `voter_ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_id` bigint unsigned DEFAULT NULL,
  `vote` enum('helpful','unhelpful') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `qa_votes_vote_type_item_id_voter_ip_unique` (`vote_type`,`item_id`,`voter_ip`),
  KEY `qa_votes_vote_type_item_id_index` (`vote_type`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rate_limits`
--

DROP TABLE IF EXISTS `rate_limits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rate_limits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempt_count` int DEFAULT '1',
  `window_start` datetime NOT NULL,
  `last_attempt` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_identifier_action` (`identifier`,`action`),
  KEY `idx_window_start` (`window_start`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `referrals`
--

DROP TABLE IF EXISTS `referrals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `referrals` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `referrer_id` bigint unsigned NOT NULL,
  `referee_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `referee_id` bigint unsigned DEFAULT NULL,
  `referral_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','signed_up','first_purchase','credited') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `referrer_credit` decimal(10,2) NOT NULL DEFAULT '0.00',
  `referee_credit` decimal(10,2) NOT NULL DEFAULT '0.00',
  `converted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `referrals_referrer_id_index` (`referrer_id`),
  KEY `referrals_referral_code_index` (`referral_code`),
  KEY `referrals_referee_email_index` (`referee_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `regusers`
--

DROP TABLE IF EXISTS `regusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regusers` (
  `NameFirst` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameMiddle` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `NameLast` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Company` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `LastLogin` datetime DEFAULT NULL,
  `LastLoginIP` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(75) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `City` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `State` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `e_Phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fax` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Validated` tinyint(1) NOT NULL,
  `ID` int DEFAULT NULL,
  `Class` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MEMBEROPTIONS` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Login` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `d_phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zipcode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_snapshots`
--

DROP TABLE IF EXISTS `report_snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_snapshots` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `report_id` bigint unsigned NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `generated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `report_snapshots_report_id_generated_at_index` (`report_id`,`generated_at`),
  CONSTRAINT `report_snapshots_report_id_foreign` FOREIGN KEY (`report_id`) REFERENCES `custom_reports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `report_snapshots_chk_1` CHECK (json_valid(`data`)),
  CONSTRAINT `report_snapshots_chk_2` CHECK (json_valid(`summary`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `review_votes`
--

DROP TABLE IF EXISTS `review_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_votes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `review_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vote_type` enum('helpful','unhelpful') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_vote` (`review_id`,`user_id`,`ip_address`),
  CONSTRAINT `review_votes_ibfk_1` FOREIGN KEY (`review_id`) REFERENCES `product_reviews` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `rating` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `reviewer_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reviewer_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','rejected') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `helpful_count` int DEFAULT '0',
  `not_helpful_count` int DEFAULT '0',
  `verified_purchase` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product_id` (`product_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `reviews_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `setting_group` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_value` text COLLATE utf8mb4_unicode_ci,
  `setting_type` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'string',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_setting` (`setting_group`,`setting_key`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipping_classes`
--

DROP TABLE IF EXISTS `shipping_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_classes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `surcharge` decimal(10,2) DEFAULT '0.00',
  `is_default` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipping_methods`
--

DROP TABLE IF EXISTS `shipping_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_methods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `zone_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` decimal(10,2) NOT NULL,
  `delivery_time` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `zone_id` (`zone_id`),
  CONSTRAINT `shipping_methods_ibfk_1` FOREIGN KEY (`zone_id`) REFERENCES `shipping_zones` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipping_settings`
--

DROP TABLE IF EXISTS `shipping_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_value` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key` (`setting_key`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shipping_zones`
--

DROP TABLE IF EXISTS `shipping_zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_zones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `regions` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shippingtypes`
--

DROP TABLE IF EXISTS `shippingtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shippingtypes` (
  `ShippingTypeID` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ShippingTypeDesc` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sizes`
--

DROP TABLE IF EXISTS `sizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categorycode` int DEFAULT NULL,
  `sizes` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `specialty_categories`
--

DROP TABLE IF EXISTS `specialty_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialty_categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_visible` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `specialty_categories_category_id_index` (`category_id`),
  KEY `specialty_categories_sort_order_index` (`sort_order`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `specialty_products`
--

DROP TABLE IF EXISTS `specialty_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialty_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `specialty_category_id` bigint unsigned NOT NULL,
  `upc` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `sizes` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `colors` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `is_visible` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `specialty_products_specialty_category_id_foreign` (`specialty_category_id`),
  KEY `specialty_products_upc_index` (`upc`),
  KEY `specialty_products_sort_order_index` (`sort_order`),
  CONSTRAINT `specialty_products_specialty_category_id_foreign` FOREIGN KEY (`specialty_category_id`) REFERENCES `specialty_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `state` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `State` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Abbr` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_alerts`
--

DROP TABLE IF EXISTS `stock_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_alerts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `alert_type` enum('low_stock','out_of_stock','overstock') COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_quantity` int NOT NULL,
  `threshold_quantity` int NOT NULL,
  `is_resolved` tinyint(1) DEFAULT '0',
  `resolved_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product` (`product_id`),
  KEY `idx_resolved` (`is_resolved`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock_movements`
--

DROP TABLE IF EXISTS `stock_movements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_movements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `movement_type` enum('in','out','adjustment','transfer','return') COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL,
  `previous_quantity` int NOT NULL,
  `new_quantity` int NOT NULL,
  `reference_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reference_id` int DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_product` (`product_id`),
  KEY `idx_type` (`movement_type`),
  KEY `idx_created` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `suppliers`
--

DROP TABLE IF EXISTS `suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postal_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'USA',
  `status` enum('active','inactive','pending') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `tax_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_terms` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `total_orders` int DEFAULT '0',
  `total_amount` decimal(10,2) DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_company_name` (`company_name`),
  KEY `idx_status` (`status`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `support_tickets`
--

DROP TABLE IF EXISTS `support_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `support_tickets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint unsigned NOT NULL,
  `order_id` bigint unsigned DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` enum('order','return','product','shipping','billing','other') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'other',
  `priority` enum('low','medium','high','urgent') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'medium',
  `status` enum('open','in_progress','pending_customer','resolved','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'open',
  `assigned_to` bigint unsigned DEFAULT NULL,
  `first_response_at` timestamp NULL DEFAULT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `satisfaction_rating` tinyint DEFAULT NULL,
  `satisfaction_comment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `support_tickets_ticket_number_unique` (`ticket_number`),
  KEY `support_tickets_customer_id_index` (`customer_id`),
  KEY `support_tickets_status_index` (`status`),
  KEY `support_tickets_priority_index` (`priority`),
  KEY `support_tickets_assigned_to_index` (`assigned_to`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_classes`
--

DROP TABLE IF EXISTS `tax_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax_classes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_exemptions`
--

DROP TABLE IF EXISTS `tax_exemptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax_exemptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `exemption_type` enum('resale','nonprofit','government','other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `certificate_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expires_at` date DEFAULT NULL,
  `status` enum('active','expired','revoked') COLLATE utf8mb4_unicode_ci DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_rates`
--

DROP TABLE IF EXISTS `tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax_rates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `country_code` varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_code` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` decimal(5,3) NOT NULL DEFAULT '0.000',
  `is_compound` tinyint(1) DEFAULT '0',
  `tax_shipping` tinyint(1) DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `is_local` tinyint(1) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_location_city` (`country_code`,`state_code`,`city`)
) ENGINE=InnoDB AUTO_INCREMENT=263 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tax_settings`
--

DROP TABLE IF EXISTS `tax_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `setting_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `setting_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `setting_key` (`setting_key`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ticket_messages`
--

DROP TABLE IF EXISTS `ticket_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint unsigned NOT NULL,
  `sender_type` enum('customer','staff') COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender_id` bigint unsigned NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_internal` tinyint(1) NOT NULL DEFAULT '0',
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_messages_ticket_id_index` (`ticket_id`),
  CONSTRAINT `ticket_messages_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `support_tickets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ticket_messages_chk_1` CHECK (json_valid(`attachments`))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_addresses`
--

DROP TABLE IF EXISTS `user_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `address_type` enum('billing','shipping') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  `full_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_line1` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address_line2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `zip_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'USA',
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `user_addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_data`
--

DROP TABLE IF EXISTS `user_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_data` (
  `User_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int NOT NULL AUTO_INCREMENT,
  `Login` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Password` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Hint` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Role_Priveledge` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `User_phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `User_mobile` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CreateTime` datetime DEFAULT NULL,
  `UpdateTime` datetime DEFAULT NULL,
  `LastLogin` datetime DEFAULT NULL,
  `LastLoginIP` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Email` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Login_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Business_Name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Locationid` int DEFAULT NULL,
  `Address1` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Address2` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stateid` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zipcode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_phone_work` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_delivery_preferences`
--

DROP TABLE IF EXISTS `user_delivery_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_delivery_preferences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `special_instructions` text COLLATE utf8mb4_unicode_ci,
  `backup_location` text COLLATE utf8mb4_unicode_ci,
  `door_to_door` tinyint(1) DEFAULT '1',
  `weekend_delivery` tinyint(1) DEFAULT '1',
  `signature_required` tinyint(1) DEFAULT '0',
  `leave_with_neighbor` tinyint(1) DEFAULT '0',
  `authority_to_leave` tinyint(1) DEFAULT '1',
  `weekday_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weekend_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vacation_mode` tinyint(1) DEFAULT '0',
  `vacation_start` date DEFAULT NULL,
  `vacation_end` date DEFAULT NULL,
  `vacation_instructions` text COLLATE utf8mb4_unicode_ci,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_delivery_preferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_devices`
--

DROP TABLE IF EXISTS `user_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_devices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `device_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `device_type` enum('mobile','tablet','desktop') COLLATE utf8mb4_unicode_ci NOT NULL,
  `os_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `os_version` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_current` tinyint(1) DEFAULT '0',
  `last_seen` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `user_devices_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_gift_cards`
--

DROP TABLE IF EXISTS `user_gift_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_gift_cards` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `card_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance` decimal(10,2) DEFAULT '0.00',
  `initial_amount` decimal(10,2) NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `card_code` (`card_code`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_card_code` (`card_code`),
  CONSTRAINT `user_gift_cards_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_notification_preferences`
--

DROP TABLE IF EXISTS `user_notification_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_notification_preferences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `delivery_email` tinyint(1) DEFAULT '1',
  `delivery_sms` tinyint(1) DEFAULT '1',
  `delivery_push` tinyint(1) DEFAULT '1',
  `promo_email` tinyint(1) DEFAULT '1',
  `promo_sms` tinyint(1) DEFAULT '0',
  `promo_push` tinyint(1) DEFAULT '1',
  `payment_email` tinyint(1) DEFAULT '1',
  `payment_sms` tinyint(1) DEFAULT '1',
  `payment_push` tinyint(1) DEFAULT '1',
  `security_email` tinyint(1) DEFAULT '1',
  `security_sms` tinyint(1) DEFAULT '1',
  `security_push` tinyint(1) DEFAULT '1',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_notification_preferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_payment_methods`
--

DROP TABLE IF EXISTS `user_payment_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_payment_methods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  `card_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_last4` varchar(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `card_holder_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expiry_month` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expiry_year` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address_id` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `billing_address_id` (`billing_address_id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `user_payment_methods_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_payment_methods_ibfk_2` FOREIGN KEY (`billing_address_id`) REFERENCES `user_addresses` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_promo_codes`
--

DROP TABLE IF EXISTS `user_promo_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_promo_codes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `promo_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_type` enum('percentage','fixed') COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `is_used` tinyint(1) DEFAULT '0',
  `applied_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  CONSTRAINT `user_promo_codes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_wishlists`
--

DROP TABLE IF EXISTS `user_wishlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_wishlists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `added_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_wishlist` (`user_id`,`product_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_product_id` (`product_id`),
  CONSTRAINT `user_wishlists_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oauth_provider` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oauth_uid` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `oauth_token` text COLLATE utf8mb4_unicode_ci,
  `profile_picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `role` enum('customer','manager','admin') COLLATE utf8mb4_unicode_ci DEFAULT 'customer',
  `loyalty_points` int DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_email` (`email`),
  KEY `idx_oauth` (`oauth_provider`,`oauth_uid`),
  KEY `idx_role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webhook_logs`
--

DROP TABLE IF EXISTS `webhook_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webhook_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `webhook_id` bigint unsigned NOT NULL,
  `event` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `response_code` int DEFAULT NULL,
  `response_body` text COLLATE utf8mb4_unicode_ci,
  `duration_ms` int DEFAULT NULL,
  `status` enum('pending','success','failed','retrying') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `attempt_count` int NOT NULL DEFAULT '1',
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `next_retry_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `webhook_logs_webhook_id_status_index` (`webhook_id`,`status`),
  KEY `webhook_logs_created_at_index` (`created_at`),
  CONSTRAINT `webhook_logs_webhook_id_foreign` FOREIGN KEY (`webhook_id`) REFERENCES `webhooks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `webhook_logs_chk_1` CHECK (json_valid(`payload`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `webhooks`
--

DROP TABLE IF EXISTS `webhooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webhooks` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `events` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `timeout_seconds` int NOT NULL DEFAULT '30',
  `max_retries` int NOT NULL DEFAULT '3',
  `success_count` int NOT NULL DEFAULT '0',
  `failure_count` int NOT NULL DEFAULT '0',
  `last_triggered_at` timestamp NULL DEFAULT NULL,
  `last_success_at` timestamp NULL DEFAULT NULL,
  `last_error` text COLLATE utf8mb4_unicode_ci,
  `created_by` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `webhooks_chk_1` CHECK (json_valid(`events`))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wholesale_accounts`
--

DROP TABLE IF EXISTS `wholesale_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wholesale_accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` int unsigned NOT NULL,
  `business_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resale_certificate` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tier` enum('bronze','silver','gold','platinum') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'bronze',
  `discount_percentage` decimal(5,2) NOT NULL DEFAULT '0.00',
  `credit_limit` decimal(12,2) NOT NULL DEFAULT '0.00',
  `payment_terms_days` int NOT NULL DEFAULT '30',
  `status` enum('pending','approved','suspended','closed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `approved_at` timestamp NULL DEFAULT NULL,
  `approved_by` bigint unsigned DEFAULT NULL,
  `primary_contact_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary_contact_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `primary_contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `billing_address` text COLLATE utf8mb4_unicode_ci,
  `shipping_address` text COLLATE utf8mb4_unicode_ci,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wholesale_accounts_account_number_unique` (`account_number`),
  KEY `wholesale_accounts_customer_id_index` (`customer_id`),
  KEY `wholesale_accounts_status_tier_index` (`status`,`tier`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wholesale_orders`
--

DROP TABLE IF EXISTS `wholesale_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wholesale_orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_id` bigint unsigned NOT NULL,
  `order_id` int unsigned DEFAULT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `discount_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `tax_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total` decimal(12,2) NOT NULL,
  `status` enum('draft','pending','approved','processing','shipped','delivered','cancelled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `payment_status` enum('unpaid','partial','paid','overdue') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `due_date` date DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `wholesale_orders_order_number_unique` (`order_number`),
  KEY `wholesale_orders_account_id_status_index` (`account_id`,`status`),
  CONSTRAINT `wholesale_orders_account_id_foreign` FOREIGN KEY (`account_id`) REFERENCES `wholesale_accounts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-06 19:43:54
