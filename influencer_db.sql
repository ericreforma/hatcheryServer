-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 07, 2020 at 11:38 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `influencer_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `description`) VALUES
(1, 'Techie'),
(2, 'Foodie'),
(3, 'Adventurous'),
(4, 'Funny'),
(5, 'Hacktivist'),
(6, 'Sociable'),
(7, 'Party Goer'),
(8, 'Sporty'),
(9, 'Biker'),
(10, 'Car Enthusiast'),
(11, 'Educator'),
(12, 'Music Lover'),
(13, 'Gamer'),
(14, 'Fashionista'),
(15, 'Hiker'),
(16, 'Prankster'),
(17, 'Mr./Ms. Science'),
(18, 'Religion'),
(19, 'Artist'),
(20, 'Actor/Actress'),
(21, 'Good Samaritan'),
(22, 'Animal Lover'),
(23, 'Wild'),
(24, 'KPOP'),
(25, 'Political'),
(26, 'Rebellious'),
(27, 'Bookworm'),
(28, 'Movie'),
(29, 'War Freak'),
(30, 'Curious'),
(31, 'Detective'),
(32, 'Beauty and Wellness'),
(33, 'Conspiracy'),
(34, 'Marine Life'),
(35, 'Trendy'),
(36, 'Photography'),
(37, 'Fit'),
(38, 'Reviewer');

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `session_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `campaign_type` int(1) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender` int(1) NOT NULL,
  `isDelete` int(1) NOT NULL DEFAULT '0',
  `attachment` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_session`
--

CREATE TABLE `chat_session` (
  `id` int(11) NOT NULL,
  `campaign_type` int(11) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `user_id` varchar(200) NOT NULL,
  `client_id` varchar(200) NOT NULL,
  `client_read` int(1) NOT NULL DEFAULT '0',
  `user_read` int(1) NOT NULL DEFAULT '0',
  `new_message` varchar(50) DEFAULT NULL,
  `new_message_from` int(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tag_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `business_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_nature` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media_id` int(11) NOT NULL,
  `contact_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

CREATE TABLE `country` (
  `id` int(11) NOT NULL,
  `code` varchar(2) NOT NULL,
  `name` varchar(25) NOT NULL,
  `monetary_sign` varchar(5) NOT NULL,
  `phone_prefix` varchar(5) DEFAULT NULL,
  `image_url` varchar(200) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`id`, `code`, `name`, `monetary_sign`, `phone_prefix`, `image_url`, `created_at`, `updated_at`) VALUES
(1, 'PH', 'Philippines', 'Php', '+63', 'flag_philippines.png', '2019-11-08 00:00:00', '2019-11-08 00:00:00'),
(2, 'SG', 'Singapore', 'Sgd', '+65', 'flag_singapore.png', '2019-11-08 00:00:00', '2019-11-08 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE `event` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `media_id` int(11) NOT NULL,
  `days_total` int(11) NOT NULL,
  `hours_total` decimal(12,1) NOT NULL,
  `venue` varchar(200) NOT NULL,
  `venue_address` text NOT NULL,
  `est_audience` int(11) NOT NULL,
  `status_id` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event_applicants`
--

CREATE TABLE `event_applicants` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `eventjob_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `job_description` varchar(250) NOT NULL,
  `status_id` int(11) DEFAULT NULL,
  `status` varchar(55) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event_applicant_schedule`
--

CREATE TABLE `event_applicant_schedule` (
  `id` int(11) NOT NULL,
  `eventapplicant_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `eventjob_id` int(11) NOT NULL,
  `eventjobschedule_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `job_description` int(11) NOT NULL,
  `schedule_date` date NOT NULL,
  `schedule_from` datetime NOT NULL,
  `schedule_to` datetime NOT NULL,
  `breaktime` decimal(5,2) NOT NULL,
  `workhours` decimal(5,2) NOT NULL,
  `rate` decimal(5,2) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `event_applicant_schedule`
--

INSERT INTO `event_applicant_schedule` (`id`, `eventapplicant_id`, `client_id`, `user_id`, `event_id`, `eventjob_id`, `eventjobschedule_id`, `job_id`, `job_description`, `schedule_date`, `schedule_from`, `schedule_to`, `breaktime`, `workhours`, `rate`, `created_at`, `updated_at`) VALUES
(4, 5, 1, 1, 1, 2, 11, 7, 0, '2020-04-14', '2020-04-14 08:00:00', '2020-04-14 17:00:00', '60.00', '8.00', '96.00', '2020-04-15 22:39:51', '2020-04-15 22:39:51'),
(5, 5, 1, 1, 1, 2, 12, 7, 0, '2020-04-15', '2020-04-15 08:00:00', '2020-04-15 17:00:00', '60.00', '8.00', '96.00', '2020-04-15 22:39:51', '2020-04-15 22:39:51'),
(6, 5, 1, 1, 1, 2, 13, 7, 0, '2020-04-16', '2020-04-16 08:00:00', '2020-04-16 17:00:00', '60.00', '8.00', '96.00', '2020-04-15 22:39:51', '2020-04-15 22:39:51'),
(7, 5, 1, 1, 1, 2, 14, 7, 0, '2020-04-17', '2020-04-17 08:00:00', '2020-04-17 17:00:00', '60.00', '8.00', '96.00', '2020-04-15 22:39:51', '2020-04-15 22:39:51'),
(8, 5, 1, 1, 1, 2, 15, 7, 0, '2020-04-18', '2020-04-18 08:00:00', '2020-04-18 17:00:00', '60.00', '8.00', '96.00', '2020-04-15 22:39:51', '2020-04-15 22:39:51'),
(9, 5, 1, 1, 1, 2, 16, 7, 0, '2020-04-19', '2020-04-19 08:00:00', '2020-04-19 17:00:00', '60.00', '8.00', '96.00', '2020-04-15 22:39:51', '2020-04-15 22:39:51'),
(10, 5, 1, 1, 1, 2, 17, 7, 0, '2020-04-20', '2020-04-20 08:00:00', '2020-04-20 17:00:00', '60.00', '8.00', '96.00', '2020-04-15 22:39:51', '2020-04-15 22:39:51'),
(11, 5, 1, 1, 1, 2, 18, 7, 0, '2020-04-21', '2020-04-21 08:00:00', '2020-04-21 17:00:00', '60.00', '8.00', '96.00', '2020-04-15 22:39:51', '2020-04-15 22:39:51'),
(12, 5, 1, 1, 1, 2, 19, 7, 0, '2020-04-22', '2020-04-22 08:00:00', '2020-04-22 17:00:00', '60.00', '8.00', '96.00', '2020-04-15 22:39:51', '2020-04-15 22:39:51'),
(13, 5, 1, 1, 1, 2, 20, 7, 0, '2020-04-23', '2020-04-23 08:00:00', '2020-04-23 17:00:00', '60.00', '8.00', '96.00', '2020-04-15 22:39:51', '2020-04-15 22:39:51'),
(14, 1, 1, 1, 1, 1, 1, 5, 0, '2020-08-10', '2020-08-10 08:00:00', '2020-08-10 17:00:00', '60.00', '8.00', '16.00', '2020-07-01 12:00:51', '2020-07-01 12:00:51'),
(15, 1, 1, 1, 1, 1, 2, 5, 0, '2020-08-11', '2020-08-11 08:00:00', '2020-08-11 17:00:00', '60.00', '8.00', '16.00', '2020-07-01 12:00:51', '2020-07-01 12:00:51'),
(16, 1, 1, 1, 1, 1, 3, 5, 0, '2020-08-12', '2020-08-12 08:00:00', '2020-08-12 17:00:00', '60.00', '8.00', '16.00', '2020-07-01 12:00:51', '2020-07-01 12:00:51'),
(17, 2, 1, 1, 1, 2, 21, 11, 0, '2020-08-13', '2020-08-13 08:00:00', '2020-08-13 17:00:00', '60.00', '8.00', '40.00', '2020-07-01 12:00:51', '2020-07-01 12:00:51'),
(18, 2, 1, 1, 1, 2, 24, 11, 0, '2020-08-16', '2020-08-16 08:00:00', '2020-08-16 17:00:00', '60.00', '8.00', '40.00', '2020-07-01 12:00:51', '2020-07-01 12:00:51'),
(19, 2, 1, 1, 1, 2, 23, 11, 0, '2020-08-15', '2020-08-15 08:00:00', '2020-08-15 17:00:00', '60.00', '8.00', '40.00', '2020-07-01 12:00:51', '2020-07-01 12:00:51'),
(20, 2, 1, 1, 1, 2, 22, 11, 0, '2020-08-14', '2020-08-14 08:00:00', '2020-08-14 17:00:00', '60.00', '8.00', '40.00', '2020-07-01 12:00:51', '2020-07-01 12:00:51'),
(21, 1, 1, 1, 1, 2, 11, 8, 0, '2020-07-15', '2020-07-15 08:00:00', '2020-07-15 17:00:00', '60.00', '8.00', '16.00', '2020-07-02 14:35:30', '2020-07-02 14:35:30'),
(22, 1, 1, 1, 1, 2, 12, 8, 0, '2020-07-16', '2020-07-16 08:00:00', '2020-07-16 17:00:00', '60.00', '8.00', '16.00', '2020-07-02 14:35:30', '2020-07-02 14:35:30'),
(23, 1, 1, 1, 1, 2, 13, 8, 0, '2020-07-17', '2020-07-17 08:00:00', '2020-07-17 17:00:00', '60.00', '8.00', '16.00', '2020-07-02 14:35:30', '2020-07-02 14:35:30'),
(24, 1, 1, 1, 1, 2, 14, 8, 0, '2020-07-18', '2020-07-18 08:00:00', '2020-07-18 17:00:00', '60.00', '8.00', '16.00', '2020-07-02 14:35:30', '2020-07-02 14:35:30'),
(25, 2, 1, 1, 1, 3, 30, 11, 0, '2020-07-24', '2020-07-24 08:00:00', '2020-07-24 17:00:00', '60.00', '8.00', '32.00', '2020-07-02 14:35:30', '2020-07-02 14:35:30'),
(26, 2, 1, 1, 1, 3, 29, 11, 0, '2020-07-23', '2020-07-23 08:00:00', '2020-07-23 17:00:00', '60.00', '8.00', '32.00', '2020-07-02 14:35:30', '2020-07-02 14:35:30');

-- --------------------------------------------------------

--
-- Table structure for table `event_jobs`
--

CREATE TABLE `event_jobs` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `job_description` varchar(200) NOT NULL,
  `quantity` int(11) NOT NULL,
  `rate` decimal(12,2) NOT NULL,
  `rate_unit` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event_job_schedule`
--

CREATE TABLE `event_job_schedule` (
  `id` int(11) NOT NULL,
  `eventjob_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `job_description` varchar(250) NOT NULL,
  `schedule_date` date NOT NULL,
  `schedule_from` datetime NOT NULL,
  `schedule_to` datetime NOT NULL,
  `breaktime` decimal(5,2) NOT NULL,
  `workhours` decimal(5,2) NOT NULL,
  `rate` decimal(5,2) NOT NULL,
  `isRemoved` int(1) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event_job_skills`
--

CREATE TABLE `event_job_skills` (
  `id` int(11) NOT NULL,
  `eventjob_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `skill_description` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `event_schedule`
--

CREATE TABLE `event_schedule` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `date_from` datetime NOT NULL,
  `date_to` datetime NOT NULL,
  `breaktime` int(11) NOT NULL,
  `workhours` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL,
  `description` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `description`) VALUES
(1, 'Administrative'),
(2, 'Booth Attendant'),
(3, 'Brand Ambassadors'),
(4, 'Customer Service'),
(5, 'Cashier'),
(6, 'Data Entry'),
(7, 'Driver/Rider/Delivery'),
(8, 'Education/Training'),
(9, 'Events'),
(10, 'Flyer Distribution'),
(11, 'Food & Beverage'),
(12, 'Human Resources'),
(13, 'Maintenance'),
(14, 'Modelling'),
(15, 'Performer'),
(16, 'Photography/Videography'),
(17, 'Promoter'),
(18, 'Receptionist'),
(19, 'Retail, Sales and Marketing'),
(20, 'Roadshows'),
(21, 'Surveyor'),
(22, 'Telemarketing'),
(23, 'Warehousing & Logistics');

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `owner_id` int(11) NOT NULL,
  `owner` tinyint(4) NOT NULL,
  `holder` int(2) NOT NULL,
  `holder_id` int(11) NOT NULL,
  `filename` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extension` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinyint(4) NOT NULL,
  `file_type` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` text COLLATE utf8mb4_unicode_ci,
  `url_thumb` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(19, '2014_10_12_000000_create_users_table', 1),
(20, '2014_10_12_100000_create_password_resets_table', 1),
(21, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(22, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(23, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(24, '2016_06_01_000004_create_oauth_clients_table', 1),
(25, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(26, '2019_04_23_080053_create_client_table', 1),
(27, '2019_04_26_034030_create_user_rating_table', 1),
(28, '2019_04_26_035054_create_media_table', 1),
(29, '2019_04_26_035853_create_client_campaign_table', 1),
(30, '2019_04_26_053713_create_chat_table', 1),
(31, '2019_08_22_073853_create_user_socialmedia_table', 1),
(32, '2019_09_01_223948_create_client_campaign_tags_table', 1),
(33, '2019_09_01_224020_create_client_campaign_incentives_table', 1),
(34, '2019_09_20_081019_create_category_table', 1),
(35, '2019_09_20_085327_create_user_category_table', 1),
(36, '2019_09_23_102141_create_post_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `user_type` int(1) NOT NULL,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `from_name` varchar(150) NOT NULL,
  `message` varchar(150) NOT NULL,
  `isOpened` int(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`id`, `user_type`, `from_id`, `to_id`, `type`, `from_name`, `message`, `isOpened`, `created_at`, `updated_at`) VALUES
(12, 0, 1, 1, 1, 'Eric', 'approved your post', 1, '2020-03-06 14:38:35', '2020-03-06 14:38:43'),
(13, 0, 1, 1, 1, 'Eric', 'rejected your post', 1, '2020-03-11 10:59:49', '2020-03-11 18:39:52'),
(14, 0, 1, 1, 1, 'Eric', 'pending your post', 0, '2020-03-11 11:02:32', '2020-03-11 11:02:32'),
(15, 0, 1, 1, 1, 'Eric', 'approved your post', 0, '2020-03-11 11:02:43', '2020-03-11 11:02:43'),
(16, 0, 1, 2, 1, 'Eric', 'approved your post', 0, '2020-03-11 11:04:04', '2020-03-11 11:04:04'),
(17, 0, 1, 1, 1, 'Eric', 'rejected your post', 0, '2020-03-11 11:04:25', '2020-03-11 11:04:25'),
(18, 0, 1, 2, 1, 'Eric', 'rejected your post', 0, '2020-03-11 11:04:46', '2020-03-11 11:04:46'),
(19, 0, 1, 1, 1, 'Eric', 'approved your post', 0, '2020-03-11 18:09:18', '2020-03-11 18:09:18'),
(20, 0, 1, 1, 1, 'Eric', 'approved your post', 0, '2020-03-11 18:15:02', '2020-03-11 18:15:02'),
(21, 0, 1, 1, 1, 'BCD', 'accepted your application', 1, '2020-03-12 10:08:28', '2020-03-12 10:12:26'),
(22, 0, 1, 1, 1, 'BCD', 'accepted your application', 0, '2020-03-12 10:08:58', '2020-03-12 10:08:58'),
(23, 0, 1, 1, 1, 'BCD', 'accepted your application', 0, '2020-03-12 10:09:53', '2020-03-12 10:09:53'),
(24, 0, 1, 1, 1, 'BCD', 'requested your application', 1, '2020-03-12 10:27:48', '2020-03-12 15:32:47'),
(25, 0, 1, 1, 1, 'ericcompany', 'approved your post', 0, '2020-03-31 10:24:49', '2020-03-31 10:24:49'),
(26, 0, 1, 1, 1, 'ericcompany', 'rejected your post', 0, '2020-03-31 12:53:42', '2020-03-31 12:53:42'),
(27, 0, 1, 1, 1, 'ericcompany', 'pending your post', 0, '2020-03-31 14:46:02', '2020-03-31 14:46:02'),
(28, 0, 1, 1, 1, 'ericcompany', 'approved your post', 1, '2020-03-31 14:57:27', '2020-04-16 21:24:28'),
(29, 0, 1, 1, 1, 'ericcompany', 'rejected your post', 0, '2020-04-02 06:11:42', '2020-04-02 06:11:42'),
(30, 0, 1, 1, 1, 'ericcompany', 'pending your post', 0, '2020-04-02 06:31:52', '2020-04-02 06:31:52'),
(31, 0, 1, 1, 1, 'ericcompany', 'approved your post', 0, '2020-04-02 06:39:18', '2020-04-02 06:39:18'),
(32, 0, 1, 1, 1, 'ericcompany', 'rejected your post', 0, '2020-04-16 21:28:33', '2020-04-16 21:28:33'),
(33, 0, 1, 1, 1, 'ericcompany', 'pending your post', 0, '2020-04-16 21:28:50', '2020-04-16 21:28:50'),
(34, 0, 1, 1, 1, 'ericcompany', 'pending your post', 0, '2020-04-16 21:32:14', '2020-04-16 21:32:14'),
(35, 0, 1, 1, 1, 'ericcompany', 'approved your post', 0, '2020-04-16 21:34:32', '2020-04-16 21:34:32'),
(36, 0, 1, 1, 1, 'ericcompany', 'rejected your post', 0, '2020-04-26 20:09:36', '2020-04-26 20:09:36'),
(37, 0, 1, 1, 1, 'ericcompany', 'pending your post', 0, '2020-04-26 20:10:10', '2020-04-26 20:10:10'),
(38, 0, 1, 1, 1, 'ericcompany', 'approved your post', 0, '2020-04-26 20:12:33', '2020-04-26 20:12:33'),
(39, 0, 1, 1, 1, 'ericcompany', 'rejected your post', 0, '2020-04-26 20:13:08', '2020-04-26 20:13:08'),
(40, 0, 1, 1, 1, 'ericcompany', 'pending your post', 0, '2020-04-26 20:14:05', '2020-04-26 20:14:05'),
(41, 0, 1, 1, 1, 'ericcompany', 'approved your post', 0, '2020-04-26 23:06:47', '2020-04-26 23:06:47'),
(42, 0, 1, 1, 1, 'ericcompany', 'rejected your post', 0, '2020-04-26 23:07:53', '2020-04-26 23:07:53'),
(43, 0, 1, 1, 1, 'ericcompany', 'pending your post', 0, '2020-04-26 23:08:03', '2020-04-26 23:08:03'),
(44, 0, 1, 1, 1, 'ericcompany', 'approved your post', 0, '2020-04-26 23:12:38', '2020-04-26 23:12:38'),
(45, 0, 1, 1, 1, 'ericcompany', 'rejected your post', 0, '2020-04-27 05:33:53', '2020-04-27 05:33:53'),
(46, 0, 1, 1, 1, 'ericcompany', 'pending your post', 0, '2020-04-27 05:57:53', '2020-04-27 05:57:53'),
(47, 0, 1, 1, 1, 'ericcompany', 'approved your post', 0, '2020-04-27 05:58:32', '2020-04-27 05:58:32'),
(48, 0, 1, 1, 1, 'ericcompany', 'rejected your post', 0, '2020-04-27 07:41:03', '2020-04-27 07:41:03'),
(49, 0, 1, 1, 1, 'ericcompany', 'pending your post', 0, '2020-04-27 07:41:10', '2020-04-27 07:41:10'),
(50, 0, 1, 1, 1, 'ericcompany', 'pending your post', 0, '2020-04-27 07:56:12', '2020-04-27 07:56:12'),
(51, 0, 1, 1, 1, 'ericcompany', 'approved your post', 0, '2020-04-27 07:57:02', '2020-04-27 07:57:02'),
(52, 0, 1, 1, 1, 'ericcompany', 'rejected your post', 0, '2020-04-27 07:58:04', '2020-04-27 07:58:04'),
(53, 0, 1, 1, 1, 'ericcompany', 'pending your post', 0, '2020-04-27 07:58:12', '2020-04-27 07:58:12'),
(54, 0, 1, 1, 1, 'ericcompany', 'rejected your post', 0, '2020-04-27 07:59:03', '2020-04-27 07:59:03'),
(55, 0, 1, 1, 1, 'ericcompany', 'pending your post', 0, '2020-04-27 07:59:12', '2020-04-27 07:59:12'),
(56, 0, 1, 1, 1, 'ericcompany', 'approved your post', 0, '2020-04-27 07:59:17', '2020-04-27 07:59:17'),
(57, 0, 1, 1, 1, 'ericcompany', 'active your post', 0, '2020-04-27 07:59:22', '2020-04-27 07:59:22'),
(58, 0, 1, 1, 1, 'ericcompany', 'approved your post', 0, '2020-04-27 07:59:31', '2020-04-27 07:59:31'),
(59, 0, 1, 1, 1, 'ericcompany', 'approved your post', 0, '2020-05-04 11:21:58', '2020-05-04 11:21:58'),
(60, 0, 1, 34, 1, 'ericcompany', 'approved your post', 1, '2020-05-07 17:50:17', '2020-05-07 17:50:33'),
(61, 0, 1, 35, 1, 'ericcompany', 'approved your post', 0, '2020-05-08 14:06:04', '2020-05-08 14:06:04'),
(62, 0, 1, 36, 1, 'ericcompany', 'approved your post', 0, '2020-05-08 14:34:39', '2020-05-08 14:34:39'),
(63, 0, 1, 38, 1, 'ericcompany', 'approved your post', 0, '2020-05-08 17:32:01', '2020-05-08 17:32:01'),
(64, 0, 1, 39, 1, 'ericcompany', 'approved your post', 0, '2020-05-11 01:37:59', '2020-05-11 01:37:59'),
(65, 0, 1, 41, 1, 'ericcompany', 'approved your post', 0, '2020-05-11 04:37:56', '2020-05-11 04:37:56'),
(66, 0, 1, 41, 1, 'ericcompany', 'approved your post', 0, '2020-05-11 06:49:47', '2020-05-11 06:49:47'),
(67, 0, 1, 41, 1, 'ericcompany', 'approved your post', 0, '2020-05-14 11:32:01', '2020-05-14 11:32:01'),
(68, 0, 1, 48, 1, 'ericcompany', 'approved your post', 0, '2020-05-14 16:39:00', '2020-05-14 16:39:00'),
(69, 0, 1, 48, 1, 'ericcompany', 'approved your post', 0, '2020-05-14 16:40:02', '2020-05-14 16:40:02'),
(70, 0, 1, 55, 1, 'ericcompany', 'approved your post', 0, '2020-05-26 15:53:38', '2020-05-26 15:53:38'),
(71, 0, 1, 55, 1, 'ericcompany', 'approved your post', 0, '2020-05-27 22:34:33', '2020-05-27 22:34:33'),
(72, 0, 1, 55, 1, 'ericcompany', 'approved your post', 0, '2020-05-27 23:12:33', '2020-05-27 23:12:33'),
(73, 0, 1, 55, 1, 'ericcompany', 'approved your post', 0, '2020-05-28 00:54:00', '2020-05-28 00:54:00'),
(74, 0, 1, 56, 1, 'ericcompany', 'approved your post', 0, '2020-05-28 02:09:16', '2020-05-28 02:09:16'),
(75, 0, 1, 56, 1, 'ericcompany', 'approved your post', 0, '2020-05-28 07:29:30', '2020-05-28 07:29:30'),
(76, 0, 1, 56, 1, 'ericcompany', 'approved your post', 0, '2020-05-28 07:42:29', '2020-05-28 07:42:29'),
(77, 0, 1, 56, 1, 'ericcompany', 'declined your online post', 0, '2020-05-28 07:45:25', '2020-05-28 07:45:25'),
(78, 0, 1, 56, 1, 'ericcompany', 'declined your online post', 0, '2020-05-28 07:46:50', '2020-05-28 07:46:50'),
(79, 0, 1, 56, 1, 'ericcompany', 'declined your online post', 0, '2020-05-28 07:50:31', '2020-05-28 07:50:31'),
(80, 0, 1, 56, 1, 'ericcompany', 'active your post', 0, '2020-05-28 07:51:04', '2020-05-28 07:51:04'),
(81, 0, 1, 56, 1, 'ericcompany', 'completed your post', 0, '2020-05-28 09:34:23', '2020-05-28 09:34:23'),
(82, 0, 1, 1, 1, 'EricOmpany', 'accepted your application', 0, '2020-07-01 15:12:33', '2020-07-01 15:12:33'),
(83, 0, 1, 1, 1, 'EricOmpany', 'accepted your application', 0, '2020-07-01 15:12:37', '2020-07-01 15:12:37'),
(84, 0, 1, 1, 1, 'ERic Com', 'accepted your application', 0, '2020-07-02 14:35:46', '2020-07-02 14:35:46'),
(85, 0, 1, 1, 1, 'ERic Com', 'complete your application', 0, '2020-07-02 15:04:07', '2020-07-02 15:04:07');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('00375a1c3c6ca1c82f1555b6ad89b297bc01c6268645aeab7934c3263dc564db19940b277d44ead1', 12, 1, 'influencer', '[]', 0, '2020-01-02 01:23:58', '2020-01-02 01:23:58', '2021-01-02 09:23:58'),
('006f17ea1ec1b97ce871ae1c66833f893e59a40bb0835675ff92a0611158872ff6d64f119efa93a9', 1, 1, 'influencer', '[]', 0, '2019-09-25 18:52:27', '2019-09-25 18:52:27', '2020-09-26 02:52:27'),
('019ba0b6b3e7884865865c25dde7250b7cea868b6bab4afa35e0c9b0f63473de7331cdbe6585a876', 1, 1, 'influencerToken', '[]', 0, '2019-12-03 12:49:22', '2019-12-03 12:49:22', '2020-12-03 20:49:22'),
('01c6cfacd9661d489e6713aa0525940322315668c5e65a7768da5605813d40a0686361f1b25603c5', 1, 1, 'influencer', '[]', 0, '2020-07-02 06:19:38', '2020-07-02 06:19:38', '2021-07-02 14:19:38'),
('023d8276578cbfc2ec209fd75a4b726a6552f40a7368b32b21735e2c254f5ea63227dfe5b3c2c8ad', 1, 1, 'influencerToken', '[]', 1, '2019-09-23 18:47:20', '2019-09-23 18:47:20', '2020-09-24 02:47:20'),
('0300049c52afaa943f68870641221e7a4c956da0b3fb3bf4a878ebdb5cfda43e168b4538c645b510', 12, 1, 'influencer', '[]', 0, '2020-01-09 01:57:07', '2020-01-09 01:57:07', '2021-01-09 09:57:07'),
('04b815559d53523170b1381b9c4c03c19ed385fe8d565c09041ba921306dd81914864d08c14aaa52', 27, 1, 'tapads', '[]', 1, '2019-10-16 07:37:01', '2019-10-16 07:37:01', '2020-10-16 15:37:01'),
('0597c2e17f04fd442c02287d1f79b900fe3c7cf4f42ff36aea7db36293c88a44347e1a0badd71802', 1, 1, 'influencer', '[]', 0, '2019-11-22 08:09:55', '2019-11-22 08:09:55', '2020-11-22 16:09:55'),
('0639670c58fbcec1318fbc105193e8fc6ea656bc8fc74efaeb9e70498ec079d8080dcf9b99179b1d', 1, 1, 'influencer', '[]', 0, '2019-09-26 17:27:04', '2019-09-26 17:27:04', '2020-09-27 01:27:04'),
('06be5bc6b2b56eb316a98b5b568ad5c3c23427d8bff5692bcc0adb1ac5b8984f95346007bf231f80', 1, 1, 'influencer', '[]', 0, '2020-05-07 09:44:55', '2020-05-07 09:44:55', '2021-05-07 17:44:55'),
('0720995d000714fe2b34b0ebf6a28297c2a9d29ce98892a4d74b5ad5db6f9660b2c96d8aa0cbf497', 1, 1, 'influencer', '[]', 0, '2019-09-25 23:27:28', '2019-09-25 23:27:28', '2020-09-26 07:27:28'),
('0780ab341ba91297aa4596414c6e60e36c72a0e16a7f7cc18a4bd2cfdad82001912e2198948b3576', 5, 1, 'tapads', '[]', 0, '2020-01-08 06:56:50', '2020-01-08 06:56:50', '2021-01-08 14:56:50'),
('08680dcaf3198b6fa50d0073f384c2f8283aaef389242c1cfbe6bf2f94e9a325b828531ee625cbd5', 1, 1, 'influencer', '[]', 0, '2019-10-16 01:48:24', '2019-10-16 01:48:24', '2020-10-16 09:48:24'),
('088d8ef78a5b3f5d4a98ad3706ec1f3535c13d868255570882889bad4ecbd0b59393df8f38a3c617', 3, 1, 'tapads', '[]', 0, '2020-01-02 10:03:49', '2020-01-02 10:03:49', '2021-01-02 18:03:49'),
('097e44844a1d626ac430bd04f5a4c6d60e13269459897765acfa57ee99a3227b582be07e98dcbdb4', 1, 1, 'influencer', '[]', 0, '2019-10-06 17:37:46', '2019-10-06 17:37:46', '2020-10-07 01:37:46'),
('09c36035272dc92394ea6827c8a98550b43d64768f30f465011069ff76d2b6b13e1ccff88a5012c3', 1, 1, 'influencer', '[]', 0, '2020-04-12 10:08:13', '2020-04-12 10:08:13', '2021-04-12 18:08:13'),
('0a047e5b75166c3be556fc1e52659207f36deeec2ed3f1c59fc11b3c11e7b693462e552248108a52', 1, 1, 'influencer', '[]', 0, '2019-11-07 14:49:35', '2019-11-07 14:49:35', '2020-11-07 22:49:35'),
('0a15f85b2679d516167471cbb04ba103f25564ee1acc9faa7348f275a672aaa6ea95b955740038ef', 4, 1, 'influencer', '[]', 0, '2019-12-17 10:27:34', '2019-12-17 10:27:34', '2020-12-17 18:27:34'),
('0b2cbf1343f96f4d2b6c5bfb42fdc8b4c5aa47ea3663779c4c6892de90f6b420ae3e73733379bde2', 1, 1, 'influencerToken', '[]', 1, '2019-11-28 09:09:29', '2019-11-28 09:09:29', '2020-11-28 17:09:29'),
('0c5111c42a077c137ba565565ce17114238556d1848e964d068d2c60ced358b5e2dca2a805246f1b', 1, 1, 'tapads', '[]', 0, '2019-11-27 08:07:48', '2019-11-27 08:07:48', '2020-11-27 16:07:48'),
('0ce0707586e7f516e1198acfe80b5f2c08031765737e5d360ca3718654c378aa960ee646da1fa36b', 1, 1, 'influencer', '[]', 0, '2020-04-19 06:03:29', '2020-04-19 06:03:29', '2021-04-19 14:03:29'),
('0d68a802665dda72a09d4f013d7f505b6a2d37fd2ecb8fe8c7cd21a355fab4999723506822c51d6b', 1, 1, 'influencer', '[]', 0, '2020-03-11 02:21:33', '2020-03-11 02:21:33', '2021-03-11 10:21:33'),
('0d6aa9c627b4ba7a5d21a2706cc605b7262ec2791664bf499bec0b7f814281e1c5e81e05363cd98d', 5, 1, 'tapads', '[]', 0, '2020-01-02 10:32:59', '2020-01-02 10:32:59', '2021-01-02 18:32:59'),
('0de60775ddc070ffc2aedf88e34cd598087d695e4813d9f4a6ad324c5b9b3e8f54bd34c7d95ccb2e', 1, 1, 'influencer', '[]', 0, '2019-11-26 12:28:29', '2019-11-26 12:28:29', '2020-11-26 20:28:29'),
('0e48afa76c2dbea6bbd7ebfff2c8b1fdb521c713fb5e02f5a72e38111209217e5737fbb5f4d65476', 1, 1, 'influencer', '[]', 0, '2019-12-17 09:40:09', '2019-12-17 09:40:09', '2020-12-17 17:40:09'),
('0f4b9be27aa4cbbd74a62392382e0a521edd91ea30a75012d4e43b6e0185bf38d1f4dc5fd3163529', 1, 1, 'influencer', '[]', 0, '2019-11-27 08:29:22', '2019-11-27 08:29:22', '2020-11-27 16:29:22'),
('0f580b6da6d4216fc59ac63e3026d5ff3af2335d07c9fd52eb3e88794abdb890cbbc00d72cf349e2', 1, 1, 'influencerToken', '[]', 0, '2019-10-21 01:56:05', '2019-10-21 01:56:05', '2020-10-21 09:56:05'),
('0f853fb775df89ade1a221f531bf56a21b924e5b4d5327ffff2164db4965eb84c0220ec253af7300', 1, 1, 'influencerToken', '[]', 0, '2019-12-03 14:07:02', '2019-12-03 14:07:02', '2020-12-03 22:07:02'),
('107f6f85db937369502203255ce8bccf21d8f2ec20cc3eefb8db3ba5d57396e5d807a2a6c8650297', 42, 1, 'tapads', '[]', 0, '2019-10-25 00:43:26', '2019-10-25 00:43:26', '2020-10-25 08:43:26'),
('108245b727f9aa2afc05f5b84d3e736793ff50d82a2add5d7faf1fe655d15d14e0a751e37ed0d965', 1, 1, 'influencer', '[]', 0, '2019-10-15 15:55:43', '2019-10-15 15:55:43', '2020-10-15 23:55:43'),
('11795d54aec15326ca7ed7b3d66d38c48ba34dc36003a55da0aef1e8291190397a138c5ad9bb6387', 1, 1, 'influencer', '[]', 0, '2019-09-25 21:38:12', '2019-09-25 21:38:12', '2020-09-26 05:38:12'),
('1267b3648c5a8efd4a70d5fc22fca0e165e68d4c44fdf452a443a2f9ebb3bd674cf1405ff9c84052', 1, 1, 'influencerToken', '[]', 0, '2019-10-18 09:58:14', '2019-10-18 09:58:14', '2020-10-18 17:58:14'),
('12a5ca73d867bcf24d83c1b90a375e2d0a98a45650d53d446abf082d2188ae3a628e06d7c9606509', 5, 1, 'tapads', '[]', 0, '2020-01-10 03:55:01', '2020-01-10 03:55:01', '2021-01-10 11:55:01'),
('152e288c9497e3121408e6bf54c5e2ab5d4baf662c750e0de739bd2306788b6a460887956cea7596', 1, 1, 'influencer', '[]', 0, '2020-02-24 01:14:36', '2020-02-24 01:14:36', '2021-02-24 09:14:36'),
('155d9e1f00a6faf416a57d3c19f74e7e809455b76be46be45b39c9f245d678dd5eddc40aef795a1e', 1, 1, 'influencerToken', '[]', 0, '2019-12-06 01:10:31', '2019-12-06 01:10:31', '2020-12-06 09:10:31'),
('158f0c8aea74ad71cc23dce635b234c25b04af4eb7f58ded1956302930b0a66305984a94ceef5d32', 1, 1, 'influencer', '[]', 0, '2019-11-26 09:36:15', '2019-11-26 09:36:15', '2020-11-26 17:36:15'),
('16231933bb3e8448118a4e7ea8c320032365914d57775de6a81b68bc5b6c1ac57243c8666b7a36cc', 1, 1, 'influencer', '[]', 0, '2019-12-06 03:49:03', '2019-12-06 03:49:03', '2020-12-06 11:49:03'),
('166b7d683d4082ac160ad6c8b5017ba8008bc048e0086784da2200ab1f61b3d52f4905ec1ab9fb4a', 40, 1, 'influencerToken', '[]', 1, '2019-11-08 06:12:43', '2019-11-08 06:12:43', '2020-11-08 14:12:43'),
('16f1e7ba1e1a4cf331e283b716ae8239b4a2f3dd563f445a945424eb9d9d508d0f50e05a8e5bf197', 1, 1, 'tapads', '[]', 0, '2020-01-20 02:38:07', '2020-01-20 02:38:07', '2021-01-20 10:38:07'),
('171dd460e4aa465b4c9ac1ff39d6de3ff40750a641f2556790c2cc4f0d7aaa7fd3d18997c85bab41', 1, 1, 'influencer', '[]', 0, '2019-10-14 00:58:53', '2019-10-14 00:58:53', '2020-10-14 08:58:53'),
('188523bd9bfb909ceff6846b42986906f436a904e7c482010c0d622799b6f5838560d818a342fd51', 1, 1, 'influencerToken', '[]', 0, '2019-10-17 02:59:13', '2019-10-17 02:59:13', '2020-10-17 10:59:13'),
('1949beb4797f8b9d1944884d4a7bf869b23ecfcc496cda154eea5d766fdec357164f76155ce5f590', 1, 1, 'influencer', '[]', 0, '2019-09-25 18:43:49', '2019-09-25 18:43:49', '2020-09-26 02:43:49'),
('194c66537df88adfaf210673c4a250954118d17dd856553836f98ef1dd10537015f6faf14aa9f48a', 5, 1, 'tapads', '[]', 0, '2020-01-02 10:30:38', '2020-01-02 10:30:38', '2021-01-02 18:30:38'),
('1a134bc5b668f66e3bd73af8a4d2bb58560902f85291811a8b80be9e9aad33e4ef552fce69ee0beb', 1, 1, 'influencer', '[]', 0, '2020-03-03 06:43:13', '2020-03-03 06:43:13', '2021-03-03 14:43:13'),
('1aaf933d8f2f229983b94179f4f55503fa2a30e81dad0bf6319f929c9d1000f74cbbb92465f50e03', 1, 1, 'influencer', '[]', 0, '2020-03-05 12:40:09', '2020-03-05 12:40:09', '2021-03-05 20:40:09'),
('1b8b934efd0230b9807cde0b2f0e5fca1a7f00e71298efa9818631b50b9dddee775042bce1baa9b4', 11, 1, 'tapads', '[]', 0, '2019-10-16 06:46:03', '2019-10-16 06:46:03', '2020-10-16 14:46:03'),
('1ba71531f32bd792558cd9efde1560731c2b54581292e2b29f19bf85f14c1f110915a0001a2feea3', 1, 1, 'influencer', '[]', 0, '2019-11-25 01:14:20', '2019-11-25 01:14:20', '2020-11-25 09:14:20'),
('1bdde1a789de8b11509d9a472cd20a5a0d3820a426d66c5444c02c4ddc9f09148b94887874c0b112', 1, 1, 'influencerToken', '[]', 0, '2019-10-17 01:59:32', '2019-10-17 01:59:32', '2020-10-17 09:59:32'),
('1d25abcd8f3a39fc04b222a681ff4d4adbac4955bd0905e7176626bbc000e2eba05404b759d973f5', 12, 1, 'influencer', '[]', 0, '2020-01-14 00:27:25', '2020-01-14 00:27:25', '2021-01-14 08:27:25'),
('1dfc8459eb93e69d510d8fa444b2b68b4189167a5cc75ac4db87b623098d9d6eb75e383389fc1bd4', 1, 1, 'influencerToken', '[]', 0, '2019-09-23 18:51:06', '2019-09-23 18:51:06', '2020-09-24 02:51:06'),
('1eace0cd1c54178aaba29dc6ec0b9b83d93466f7cb93eb3df6ebdd17a93d129b7797a46bf41071ff', 5, 1, 'tapads', '[]', 1, '2019-11-28 22:02:33', '2019-11-28 22:02:33', '2020-11-29 06:02:33'),
('1ede5ff9ade6f4ede2f82347d71aa575772f0478b5af4f3d582035ef041a1f2de7a672dac0015a77', 1, 1, 'influencer', '[]', 0, '2020-05-24 07:47:02', '2020-05-24 07:47:02', '2021-05-24 15:47:02'),
('1f1d044363e7f32d258de8c9f810067dbfc6e019863b2da20d6348c3fbd80bdfa8f593977def4970', 1, 1, 'influencer', '[]', 0, '2020-05-14 05:24:12', '2020-05-14 05:24:12', '2021-05-14 13:24:12'),
('1f245cfc0a8c226a0439c8580d9afd86dbbc1de3d2b7d9c92139647f25fc95e67997fde816f143b9', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:05:44', '2019-09-25 19:05:44', '2020-09-26 03:05:44'),
('1fd2b9424ce7d245f82a37e6a57f8d6d1d8e4d756e9350d2a2cdaa143e0c2dc4fd24719db362fea7', 24, 1, 'tapads', '[]', 1, '2019-10-16 07:30:33', '2019-10-16 07:30:33', '2020-10-16 15:30:33'),
('1ff9310e336e822eef70f7e8ad34963481562d4bbb1f6f35779b19616edca3cd2847cbf3b758d6a3', 1, 1, 'influencer', '[]', 0, '2019-09-25 21:31:17', '2019-09-25 21:31:17', '2020-09-26 05:31:17'),
('214e9aaafb7ef788ee9fb3f3d7c9a29f9d9dbc2fc53da1a4b90a9628546205aae435b828a884349b', 1, 1, 'influencerToken', '[]', 0, '2019-10-17 07:53:18', '2019-10-17 07:53:18', '2020-10-17 15:53:18'),
('21f2fb352453a3584b53bb12eb67a736ccba920d328dbd349387ec7ac7cd3e9d6dd7e409119c7e25', 12, 1, 'influencer', '[]', 0, '2020-01-23 04:31:04', '2020-01-23 04:31:04', '2021-01-23 12:31:04'),
('221d7a6adb643c118417ab1b5487bf7eb5b6bc591d36c688b6ced1598fda1a78e719f2828d697f8b', 11, 1, 'influencer', '[]', 0, '2019-12-18 06:17:20', '2019-12-18 06:17:20', '2020-12-18 14:17:20'),
('2244f4b5ea300da7ba1237f30c5875da25f257f5ac1b2fff681423ddf948748617151e60ad275381', 1, 1, 'influencer', '[]', 0, '2019-10-16 02:03:53', '2019-10-16 02:03:53', '2020-10-16 10:03:53'),
('22af8beb958ff0c52763ee63b81d28ae69b1f2b6b9b096fd6716092ee32fa2030fcaee42a4004acb', 1, 1, 'influencer', '[]', 0, '2019-10-28 08:24:40', '2019-10-28 08:24:40', '2020-10-28 16:24:40'),
('22c6f45a01089fe7c94fe10745b36beea5cf27b820c879dfcb9d46d22e9b54dfd363cd34e8cb6790', 1, 1, 'influencer', '[]', 0, '2019-10-16 01:50:49', '2019-10-16 01:50:49', '2020-10-16 09:50:49'),
('23fd6aabf722d89ac82719be162c9da51f8455f5e879c3e534decd63de366679260f2be22f4537a6', 1, 1, 'influencer', '[]', 0, '2020-02-12 05:15:14', '2020-02-12 05:15:14', '2021-02-12 13:15:14'),
('244d7cf0380aacd21aafab08e00e00813a402b3b935c0327d1c4400a806e46bf42168dc4a3452baf', 1, 1, 'influencer', '[]', 0, '2020-03-09 01:27:00', '2020-03-09 01:27:00', '2021-03-09 09:27:00'),
('24776150c84ac66e6dc1b72c4de16ddd1a85205a21ce72a2260da34cf883a26f3e1ad4bbdc819c07', 25, 1, 'tapads', '[]', 0, '2019-10-16 07:33:21', '2019-10-16 07:33:21', '2020-10-16 15:33:21'),
('24db0028c00445cb5dd7a5487265aeda28c35061bce7a308e24af3240c6d2de8dc594a62f51260b3', 41, 1, 'influencerToken', '[]', 0, '2019-10-24 05:38:16', '2019-10-24 05:38:16', '2020-10-24 13:38:16'),
('25005897aa379e3c65285d57c74c8474f5298e1e4e4d03a90dd82291103959efa6d5c4c29c4d3510', 1, 1, 'influencer', '[]', 0, '2019-10-30 07:16:36', '2019-10-30 07:16:36', '2020-10-30 15:16:36'),
('255440e20f5ccf12a272110ecf052fea2905dbca38f55e550d1edf430bbbc61f73a6155a96f7ac40', 1, 1, 'influencer', '[]', 0, '2019-09-25 00:52:10', '2019-09-25 00:52:10', '2020-09-25 08:52:10'),
('25571922851d1556a9bb8c6857066a0c17acbe6b7c0e88f9785dbb98c6e526bc6fcb15b8ee4ae5a3', 1, 1, 'tapads', '[]', 0, '2020-03-03 06:37:17', '2020-03-03 06:37:17', '2021-03-03 14:37:17'),
('259285c5161f8fa5647207fd2f0e282aee3ff5778f2175ea5a311dfae664f13d19ea44f80bf8ba2c', 1, 1, 'influencer', '[]', 0, '2020-04-14 06:46:10', '2020-04-14 06:46:10', '2021-04-14 14:46:10'),
('262746e70016a25054219d89ae14a91fc0c358a08b971f2d195b3c7fd54c8ad93d7dfa616f64bbe7', 1, 1, 'influencer', '[]', 0, '2019-11-04 01:20:53', '2019-11-04 01:20:53', '2020-11-04 09:20:53'),
('271c8b513b035c0e6c105d32e63079f605f30a81e239b28f209cdf524942de20ae3ada0f64dd456e', 1, 1, 'influencerToken', '[]', 0, '2019-12-04 07:51:14', '2019-12-04 07:51:14', '2020-12-04 15:51:14'),
('2735cf4b785aea00852cf236f01c8997036785ecabdddf24f3be7b1ce44629163abc610ba6b99a49', 1, 1, 'tapads', '[]', 0, '2020-02-21 03:08:56', '2020-02-21 03:08:56', '2021-02-21 11:08:56'),
('27698fa52877378a9c715f9fc82adcfbe2002aeb22741ebe6a6c75d45f12fdf6c0297fba6254b9c5', 1, 1, 'tapads', '[]', 0, '2020-02-19 08:43:24', '2020-02-19 08:43:24', '2021-02-19 16:43:24'),
('28dc2279e0910f7ca9839a52a10817a2ff9b159f71aaeb743a139a95afc5e145adbc828ac9463ea2', 1, 1, 'influencer', '[]', 0, '2020-03-29 23:03:54', '2020-03-29 23:03:54', '2021-03-30 07:03:54'),
('29c030ba74839038e58ffa53a064a5eb175e8dd2480f42b4a256a4efdbc37a83849631c6aa281f41', 1, 1, 'influencer', '[]', 0, '2020-07-01 03:58:32', '2020-07-01 03:58:32', '2021-07-01 11:58:32'),
('29c491ddc184fc625cef1164248ee40d5d6c78e3b42b3296abfde4e482bab74c12956be2f27db0be', 5, 1, 'influencer', '[]', 0, '2019-12-17 10:27:41', '2019-12-17 10:27:41', '2020-12-17 18:27:41'),
('2a2b3e63810eaa1d55927900ed972e09cf4f3d586214ad89309e0ce81134f909e8f19ae3defaea69', 1, 1, 'influencerToken', '[]', 1, '2019-12-05 07:28:42', '2019-12-05 07:28:42', '2020-12-05 15:28:42'),
('2a6c0890785e48d066b5cc6796e326e884620abbd34eff98674a5681fedd9f9cfc8849179df7e27a', 14, 1, 'tapads', '[]', 0, '2019-10-16 06:56:27', '2019-10-16 06:56:27', '2020-10-16 14:56:27'),
('2b85f500a971b7638b00d766147875e1e65d1c46efe9e586e2b373d67b7642a8eb7a1a4a5a7efa14', 1, 1, 'tapads', '[]', 0, '2020-01-30 12:20:32', '2020-01-30 12:20:32', '2021-01-30 20:20:32'),
('2c3bda7037ab7053309f75a4fbaa9c6932443755ea3826ed1e719343446bf8ccdfc8aff5210f93c2', 11, 1, 'influencer', '[]', 0, '2019-12-18 06:18:52', '2019-12-18 06:18:52', '2020-12-18 14:18:52'),
('2c96337c1cbe3b4ac0e979dcc9eaec67a8e272e5b5b234b5b69f50eec84e4db847e5955ab0492708', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:07:51', '2019-09-25 19:07:51', '2020-09-26 03:07:51'),
('2cc0c8b226761cee78cf9f70a230216ac57b8ad696052e4d75b93f8f9ba8ba6f36ae26b80992ccd6', 1, 1, 'influencer', '[]', 0, '2019-11-27 02:28:42', '2019-11-27 02:28:42', '2020-11-27 10:28:42'),
('2de0b4ffcc464ccc702305eeddca6ea6dfa2aeafd5891bad1e5011b43292e8581361067d4ca41bd9', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:55:24', '2019-09-25 19:55:24', '2020-09-26 03:55:24'),
('2de1a0048a96c4031f12cd364cdd0b8dcbb094c56a40e2abb2f6d65d80a518ec59ab055200110ebf', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:44:29', '2019-09-25 19:44:29', '2020-09-26 03:44:29'),
('2eadceb4a55dc72945c50f05245a88fd5ce93ccfe980097d3121e0200ee36cdc798ff75f0c0ae2ec', 12, 1, 'influencer', '[]', 0, '2020-01-07 01:40:51', '2020-01-07 01:40:51', '2021-01-07 09:40:51'),
('2eea57a9f3336b70119983316fb3d45a228f596956e5f11931fc212c8ad2dbad24b383e0688aac8f', 30, 1, 'tapads', '[]', 1, '2019-10-16 07:58:13', '2019-10-16 07:58:13', '2020-10-16 15:58:13'),
('327e033613a2a2f2d93db2e0cd31ac36a45e24c319ce36efa3729b3fadf72c674ef5357c2a49be28', 12, 1, 'influencer', '[]', 0, '2020-01-03 07:32:15', '2020-01-03 07:32:15', '2021-01-03 15:32:15'),
('330204a354df07b4c8e253b12cd4f07d82a9bc5ba8b3fe56e4321f0e0e6745bef52eb35589971936', 38, 1, 'tapads', '[]', 1, '2019-10-23 08:16:55', '2019-10-23 08:16:55', '2020-10-23 16:16:55'),
('334848b4d00375f5558ffaa837fa54e9939b4adcb111b83eba31525d9160d23f9c6acd36ca79d648', 1, 1, 'influencer', '[]', 0, '2020-05-13 05:04:54', '2020-05-13 05:04:54', '2021-05-13 13:04:54'),
('34ef9d700425609f8e14bbe88bba7221393b12b7320b85d4861a516a08f58a201ddf71f0bcc34cb4', 18, 1, 'tapads', '[]', 1, '2019-10-16 07:07:03', '2019-10-16 07:07:03', '2020-10-16 15:07:03'),
('35994acd0405ad8b79d2c5f5a127ea725e280074a95c522b23b3859c086e19000a2ec218beee343b', 40, 1, 'influencerToken', '[]', 0, '2019-11-07 20:59:38', '2019-11-07 20:59:38', '2020-11-08 04:59:38'),
('35ace14ec05a5f03245c438ac9046db1f117f748848d3538e89873d0be3783363d69d3839ee22e67', 1, 1, 'tapads', '[]', 0, '2020-02-19 08:11:26', '2020-02-19 08:11:26', '2021-02-19 16:11:26'),
('35e355426a2a2cc9687874df7742b3fbb3f0dee6d622859267af2cac9c1de5b415cafe32f85f1b95', 1, 1, 'influencer', '[]', 0, '2019-09-25 20:04:44', '2019-09-25 20:04:44', '2020-09-26 04:04:44'),
('3641277d0b137a1f10e8f36fd862a4e33f0be76a31397c784b2f562b37990e4d1c2bf9d62ecea176', 40, 1, 'influencerToken', '[]', 0, '2019-11-27 07:04:43', '2019-11-27 07:04:43', '2020-11-27 15:04:43'),
('3658dca4359e8a6e6d81aae9a8f6d35f983a5442316b66db5b92d36fe6e20d8b11546dd322c998d9', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:56:12', '2019-09-25 19:56:12', '2020-09-26 03:56:12'),
('36c7c76dfc5006b93629042d1c9a8f78e0c2440afef2404805db6986d647fd9b21151ec1f416cbf1', 40, 1, 'influencerToken', '[]', 0, '2019-11-08 01:22:31', '2019-11-08 01:22:31', '2020-11-08 09:22:31'),
('3801ba11a858d81ef1d47498be29afd1b8b08735a59a771a71cab17646bf92d518579587a3232525', 1, 1, 'influencer', '[]', 0, '2019-10-02 18:01:07', '2019-10-02 18:01:07', '2020-10-03 02:01:07'),
('38dbe00d77590523452736daf1f82c024d9fe1982d8a1abad60ad2a0e4135d0005010a0e209c7ad2', 1, 1, 'influencerToken', '[]', 1, '2019-11-27 09:35:06', '2019-11-27 09:35:06', '2020-11-27 17:35:06'),
('3919b1d3fd998d1dff5d93c3de00bbc1c469f43af27ac5132e363effe335ab46bbfa8157d838115b', 1, 1, 'influencer', '[]', 0, '2019-09-26 17:27:04', '2019-09-26 17:27:04', '2020-09-27 01:27:04'),
('39545a5e30224247abaa92b9033a45e3a037a396218e8dd39a0e94d97a3d032b5f1a7136e1071c1e', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:47:27', '2019-09-25 19:47:27', '2020-09-26 03:47:27'),
('39ab4fe44ed4b1b429c58734d1e32fe18feaf36dfb37552087e46ad5c3ba434737e80aaed0a50ba7', 1, 1, 'influencer', '[]', 0, '2019-10-01 17:27:34', '2019-10-01 17:27:34', '2020-10-02 01:27:34'),
('3a6cd3ae9e57e4129d8979dec0f1542d5cae1c6ab9a67804da8686d0e6a664c1adaf3b3b9db6c122', 1, 1, 'influencerToken', '[]', 0, '2019-12-03 13:25:13', '2019-12-03 13:25:13', '2020-12-03 21:25:13'),
('3aeaabc18d35065bbda4bace1676f1c278cf1428995654fcc51b0b26dbcb7564f24fb2aebfa8e969', 1, 1, 'tapads', '[]', 0, '2020-02-13 06:03:12', '2020-02-13 06:03:12', '2021-02-13 14:03:12'),
('3b872835066775aed0dba61b7f6b4f8826fac9a80c389c3dcaf85011b09709562539275194258328', 1, 1, 'tapads', '[]', 0, '2020-03-06 02:29:32', '2020-03-06 02:29:32', '2021-03-06 10:29:32'),
('3d49c69a0b5270856dbb00d4624a727c42cb94ae0d2d88c72b59f85dc15b8447f8f9f7dab937bfe1', 10, 1, 'tapads', '[]', 0, '2019-10-16 03:44:51', '2019-10-16 03:44:51', '2020-10-16 11:44:51'),
('3e0a3d91cf098fa1bb3c0379f675f52790727b3e0e68361783790e0c6df494fc9af32dec5b2eb737', 1, 1, 'influencer', '[]', 0, '2019-09-25 00:51:51', '2019-09-25 00:51:51', '2020-09-25 08:51:51'),
('3e1db5676637f8bfb4125685e4678f92c0cc52ba1c91967ef8efbaa39bc4c47fce4fee3b01a3fea1', 1, 1, 'influencer', '[]', 0, '2020-02-07 02:34:54', '2020-02-07 02:34:54', '2021-02-07 10:34:54'),
('3e42184dce2c6c127a03aa9ce2ce254d6343063ea382eb8037262a42a95d375d0cff04a2c95c0fe2', 1, 1, 'influencer', '[]', 0, '2020-02-17 02:01:38', '2020-02-17 02:01:38', '2021-02-17 10:01:38'),
('3e816ef842ca4644b126c0033b31e9de53c6b2ec3196a4074143a5b95ba48729210a1d5b076dc9c2', 1, 1, 'influencer', '[]', 0, '2019-09-25 18:03:57', '2019-09-25 18:03:57', '2020-09-26 02:03:57'),
('3f4797d6a18f8f1b1732922a215d0a3a269ca6868fbfc947031e2e2c7b14f6040e53f1bc392891dd', 1, 1, 'influencer', '[]', 0, '2019-09-25 18:49:50', '2019-09-25 18:49:50', '2020-09-26 02:49:50'),
('3f8e66fe60171131ce3ee3862110cffcbb48af93db8ce99efbab866d1d58ba38d5f70f460911dcb6', 12, 1, 'influencer', '[]', 0, '2020-01-02 01:21:31', '2020-01-02 01:21:31', '2021-01-02 09:21:31'),
('3f8f885029fcd9a8d36d52d6d4a0e5477dbfd4c88678b9df8f87a6606894c73c6735142da30a2c3c', 12, 1, 'influencer', '[]', 0, '2020-01-16 01:57:55', '2020-01-16 01:57:55', '2021-01-16 09:57:55'),
('40648cd21f1fbc43761a65bb8ee93c7ce0a4f9cc4e70eccbc1a1cb4823a0fad91b7bae6c4a4dfc7a', 1, 1, 'influencer', '[]', 0, '2020-02-27 02:24:59', '2020-02-27 02:24:59', '2021-02-27 10:24:59'),
('40914116f515225ce962d1266f67581abd46ab6d06726fa0bacb249adc5320cf25b7a365bd3b3786', 1, 1, 'influencer', '[]', 0, '2020-06-11 02:06:28', '2020-06-11 02:06:28', '2021-06-11 10:06:28'),
('417e536f872c9c0318d580138237fb665b48004dda4917c26119f2ad04444cb524d20999df148b3c', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:56:40', '2019-09-25 19:56:40', '2020-09-26 03:56:40'),
('4291576f64debd7a740074cf023e523290eb8e1d90e7f3f82a37d5efc6a367ab24b56cdb87cfeb9d', 41, 1, 'influencerToken', '[]', 0, '2019-10-28 07:38:04', '2019-10-28 07:38:04', '2020-10-28 15:38:04'),
('42c8da2eace65ecab9b676e50dcf13d21b549e51888ffdb7598c5ef8a7477cfa8c4642284e267b7c', 1, 1, 'influencer', '[]', 0, '2019-09-23 22:52:55', '2019-09-23 22:52:55', '2020-09-24 06:52:55'),
('438ce189d6709eb02d6e10202deb35716114a0b60e91812464c91df9ef08d3d77058f75f28730640', 1, 1, 'influencer', '[]', 0, '2019-10-18 09:59:32', '2019-10-18 09:59:32', '2020-10-18 17:59:32'),
('445092491401c74b426f48e492ad7b1ae4cf08ae7ae5333bb859680bb9e4a1e4c350d6a474505d41', 7, 1, 'tapads', '[]', 1, '2019-11-28 22:10:48', '2019-11-28 22:10:48', '2020-11-29 06:10:48'),
('458621ebd2ddb045f8608564da5d2a15b8c338b7878fbe8c3d31af1f5f658f3a54012ecdb2c21b90', 1, 1, 'influencerToken', '[]', 0, '2019-10-24 01:57:34', '2019-10-24 01:57:34', '2020-10-24 09:57:34'),
('458d693e9001e0d8db36a27ac82d2e4899b482f465631f0e0520981a389eafa762ac7ddcbda4e10f', 1, 1, 'influencer', '[]', 0, '2020-05-12 02:55:51', '2020-05-12 02:55:51', '2021-05-12 10:55:51'),
('461f207038f1d66903f5a43027a93f5846db918f10f96ae2373adeab06925d7297ee9e1aaa514697', 1, 1, 'influencer', '[]', 0, '2020-05-03 03:38:46', '2020-05-03 03:38:46', '2021-05-03 11:38:46'),
('462eaad8d587913f142efaff78a43d7a694e6fccbd971faec4ad109b29705119ca3c9d5a5172e1a7', 9, 1, 'influencer', '[]', 0, '2019-12-18 02:59:54', '2019-12-18 02:59:54', '2020-12-18 10:59:54'),
('4813a068e6e8a55abe910a779b2092a15c2981804cbbb036cbc3133f10d8367a968a8dc01b8427f0', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:52:21', '2019-09-25 19:52:21', '2020-09-26 03:52:21'),
('491c00653e07e5a37ccee7f453000fe9dd86f70dcbf1742c092348f6ce281cdaccc624072a65c75a', 1, 1, 'influencer', '[]', 0, '2019-10-31 02:41:41', '2019-10-31 02:41:41', '2020-10-31 10:41:41'),
('49feb146a21093a880e17e1b9ed77ba0e8aa192ff28022a7bfcc947d037970974fa316afd976b9d3', 1, 1, 'influencer', '[]', 0, '2020-05-27 18:09:09', '2020-05-27 18:09:09', '2021-05-28 02:09:09'),
('4a437ee89b7520960887243c3eee6e52c6a4ea48ca86dd556f6bd6d0d8efa4772c63372eb23caac6', 1, 1, 'influencerToken', '[]', 1, '2019-10-22 05:43:03', '2019-10-22 05:43:03', '2020-10-22 13:43:03'),
('4b037e57a90ac1bd5f9dce41a0286f60f15e74ee046de6fbd640ff4a3c4787b5302f6e00115a58ba', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:51:03', '2019-09-25 19:51:03', '2020-09-26 03:51:03'),
('4b7a39f21d61753218b00c4342bbc9def0edb520b7422564b971e767614f7d010e49f6b95d6a66cd', 11, 1, 'influencer', '[]', 0, '2019-12-18 05:55:33', '2019-12-18 05:55:33', '2020-12-18 13:55:33'),
('4bfbf3341589b44c024a89866b4e443c0455e47d7711ca38b6da13db1287f99b1de0613cac6a4e5e', 37, 1, 'tapads', '[]', 1, '2019-10-23 08:06:01', '2019-10-23 08:06:01', '2020-10-23 16:06:01'),
('4c52a6663f2a3567ebab8702f6197ece6905ae304db65950fcf5cf4001b5760f331db4b34e790262', 1, 1, 'influencerToken', '[]', 0, '2019-10-21 09:57:37', '2019-10-21 09:57:37', '2020-10-21 17:57:37'),
('4d0ff2da68d55bfe5ae37a670ccfaa5807aa9dd71b8523e602a5faf35b30a9bb65b02ae93e1856ce', 3, 1, 'influencer', '[]', 0, '2019-12-17 10:27:22', '2019-12-17 10:27:22', '2020-12-17 18:27:22'),
('4d11e212e37d227e2eefbf5c8535bc4cfcc2b289857f40c79ad6d719eb10a646697b16ea0f27cc6b', 1, 1, 'influencerToken', '[]', 1, '2019-11-28 22:27:56', '2019-11-28 22:27:56', '2020-11-29 06:27:56'),
('4d1eb75879ef33f958ebd46d26f47e7023e098fd3bd0b08156c723eaeba3372a89e0492066ba500d', 1, 1, 'influencer', '[]', 0, '2020-05-13 17:17:24', '2020-05-13 17:17:24', '2021-05-14 01:17:24'),
('4d4efd50852da07c4ed9604643fd4a458b407e6aa6cb77cbdeb0476d5370f69f6df7f9e4d2ee4390', 1, 1, 'influencer', '[]', 0, '2019-09-25 01:53:40', '2019-09-25 01:53:40', '2020-09-25 09:53:40'),
('4dd09c04e30136e58b8a94b4cdc4d9ba6e17cabc58c5a89b3c06a0355eb2cb88dc7418ae2ae0b5b3', 1, 1, 'influencer', '[]', 0, '2020-05-17 05:40:15', '2020-05-17 05:40:15', '2021-05-17 13:40:15'),
('4e9bd928607efaad5ba8c28ac458098bcb2261e01f022c886c7035bd2351eb986849ed2e57bb274e', 1, 1, 'influencer', '[]', 0, '2020-03-10 06:02:37', '2020-03-10 06:02:37', '2021-03-10 14:02:37'),
('4f1f885b64f3d926ab4cf48e8f59e13eb1f57e8e0212c1a981e3d06d96e08b3f765033a3d15afcb7', 1, 1, 'tapads', '[]', 0, '2020-03-19 05:34:09', '2020-03-19 05:34:09', '2021-03-19 13:34:09'),
('4f2f07e09414ab9a31455ebb73df0c1d979b40ef0f1a6238ceb24036f2546af82afe09da9c8e09b0', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:56:45', '2019-09-25 19:56:45', '2020-09-26 03:56:45'),
('5021db3532b0a88712bc462b1675dc1d3505623d8fef5b1db149d41bdecd6f04192eb2ae8ce6b56e', 1, 1, 'influencer', '[]', 0, '2019-10-08 17:25:07', '2019-10-08 17:25:07', '2020-10-09 01:25:07'),
('5089479738d038ce8b5b49ff6c5617133e647473e304fdc3509049b31c50359355d8546938831a9e', 1, 1, 'tapads', '[]', 0, '2020-02-26 05:28:12', '2020-02-26 05:28:12', '2021-02-26 13:28:12'),
('524db12d5a1c8e2d4dd21e3e63e39db61c7d831cde9ead656738c727a1803b0813c3caa9a8ec4dee', 1, 1, 'influencer', '[]', 0, '2020-04-01 22:22:39', '2020-04-01 22:22:39', '2021-04-02 06:22:39'),
('531f3bd747edbd5198b9152cc40198911dcf6708612bb93abc4c8bdb03287140be28087ada922d33', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:04:19', '2019-09-25 19:04:19', '2020-09-26 03:04:19'),
('5333cccab61253233ee3df5943f6f36e08a4ca10ee70916675341ae7089aca9ff8db6bc761d42e9b', 1, 1, 'influencer', '[]', 0, '2019-09-25 00:45:09', '2019-09-25 00:45:09', '2020-09-25 08:45:09'),
('554e30c9171e2d63065d53c4cf416fa269c47d6b40cae43fe22046c9f8102c7f764563efc28e8a09', 5, 1, 'tapads', '[]', 0, '2020-01-03 01:05:15', '2020-01-03 01:05:15', '2021-01-03 09:05:15'),
('56dd70d29b3200d31f8cb9624d30739cccfe838d9c0387a99bbf3d96f92b7620fab2feb1ba90790a', 1, 1, 'influencerToken', '[]', 0, '2019-10-17 02:54:07', '2019-10-17 02:54:07', '2020-10-17 10:54:07'),
('571ce09ad1d084398c0cb40ea44ce4160f8125216d4c0f6b2e067686410ba5d82f565b6764b0e9b9', 4, 1, 'tapads', '[]', 0, '2020-01-02 10:18:38', '2020-01-02 10:18:38', '2021-01-02 18:18:38'),
('5742ed7e449cdd3477ddfdeaa8b6f737dfcf31240adb812f1edf30a52cfd527376b978e18aac17bb', 2, 1, 'tapads', '[]', 0, '2020-01-02 09:53:09', '2020-01-02 09:53:09', '2021-01-02 17:53:09'),
('593e8f0a33203db897e3df833a3578b70beaeef1dcee4987c1a08fd9dc18f91779d1b173580e14c3', 11, 1, 'influencer', '[]', 0, '2019-12-18 05:57:07', '2019-12-18 05:57:07', '2020-12-18 13:57:07'),
('59a40d72c01b537334648137d805d3ba06742e732db4eaf54506e7d0bc1fc84bd5ee58b1ffbd5761', 1, 1, 'influencer', '[]', 0, '2019-11-28 10:20:52', '2019-11-28 10:20:52', '2020-11-28 18:20:52'),
('59df8d4049b4672240acb42e6cd78516b8d42334533b0dad068adf1097da3c1afcd98798e00de729', 12, 1, 'influencer', '[]', 0, '2020-01-02 01:09:21', '2020-01-02 01:09:21', '2021-01-02 09:09:21'),
('5a1c8805d62df095f1c780ad313fcd43e53199c8073309f204c99e1e80f8aeda4bd6bb4a27d4a53b', 1, 1, 'influencer', '[]', 0, '2020-03-31 01:00:26', '2020-03-31 01:00:26', '2021-03-31 09:00:26'),
('5b0dbdf476fe2704adad4275141d67fbee932b8c61a01d46c439d27dc50a9a1a3d1f59539f55ab38', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:55:19', '2019-09-25 19:55:19', '2020-09-26 03:55:19'),
('5b5162f71d6285965a34e330967284040a5a071aec8ee410a9a4b391595379eec1a493a22fc945c1', 1, 1, 'influencer', '[]', 0, '2019-09-30 17:32:05', '2019-09-30 17:32:05', '2020-10-01 01:32:05'),
('5b737fc4455e8300b0f586d9727967fb76212263f2efe8ae9c20535cea996791b179148e5cd8c0c1', 1, 1, 'influencer', '[]', 0, '2019-09-25 00:52:46', '2019-09-25 00:52:46', '2020-09-25 08:52:46'),
('5ecc4ab69c8e00286be03151576ad125bb93c3e24eaa20f0d6bfe39fde30eb19dfdbee49f8d4712e', 3, 1, 'tapads', '[]', 0, '2020-01-03 10:06:34', '2020-01-03 10:06:34', '2021-01-03 18:06:34'),
('60718226f718da91a42fa1245c2b196c25d3ebf70e286baa473612844a05fb31ef9211939dfbb470', 1, 1, 'influencer', '[]', 0, '2019-09-25 23:37:13', '2019-09-25 23:37:13', '2020-09-26 07:37:13'),
('60f3389a72ecf6df1ac6d804a185212b5f45aeeba57218efc6ff95c8656e524f0e754776fbc165af', 32, 1, 'tapads', '[]', 0, '2019-10-18 05:22:05', '2019-10-18 05:22:05', '2020-10-18 13:22:05'),
('62edcb5b75417d3ef2e97aa8b0a9feca4435bc5d8b68f6c60b751a2ccaf603ab67cc49f05a14d211', 4, 1, 'tapads', '[]', 0, '2019-11-28 05:47:49', '2019-11-28 05:47:49', '2020-11-28 13:47:49'),
('638e2db9cf0d0b603eae7ed579ede32a0095d77718e19ce6a1cba58ba7e2fb5ccdfd6076dcd2df45', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:06:13', '2019-09-25 19:06:13', '2020-09-26 03:06:13'),
('646141f60a790549b417fdfc58cb7c7db5f5aa2755ee15895698ce3add66467f87d20aac424548ca', 1, 1, 'influencer', '[]', 0, '2019-09-25 18:54:09', '2019-09-25 18:54:09', '2020-09-26 02:54:09'),
('65c4ab43db2314c9d71e59842123b04cb6f7fd89abd6d55f10449a36980a2f21045a5344fdb3f3b0', 1, 1, 'influencer', '[]', 0, '2020-04-01 22:11:11', '2020-04-01 22:11:11', '2021-04-02 06:11:11'),
('6675cf1b9178b3f0761e478e83ec32b74c7aead1deffb5e30842475a84612372d53ee2a51794a075', 41, 1, 'influencerToken', '[]', 0, '2019-10-28 02:29:16', '2019-10-28 02:29:16', '2020-10-28 10:29:16'),
('66f0f1c6ad7660a224c2115540c1a26c0139aefba25cebffbdbb454e0226b9246977f7e94367bd48', 2, 1, 'influencerToken', '[]', 1, '2019-11-27 13:21:25', '2019-11-27 13:21:25', '2020-11-27 21:21:25'),
('670a09ecf3210d8b937d06d5c9babca2593d97c6d92ad5c41f4272fb5a3e040fd4383c25753bfe2d', 5, 1, 'tapads', '[]', 0, '2020-01-03 01:02:00', '2020-01-03 01:02:00', '2021-01-03 09:02:00'),
('679ff298d2b25e2f344ff1a9f105dd5c4a9439de7deaeec2f3ad1c5db42b3e98192c0c408713bd13', 1, 1, 'influencerToken', '[]', 0, '2019-12-04 00:52:14', '2019-12-04 00:52:14', '2020-12-04 08:52:14'),
('6884ad7d5cebd9ae5c914c028e712f21f0174a4a05a5e133f4afb1ca884b4326b5f1a57775e9e1d5', 1, 1, 'influencer', '[]', 0, '2020-02-21 03:07:14', '2020-02-21 03:07:14', '2021-02-21 11:07:14'),
('6897a5d4f22938c0a2320da6843674a0d1c5513a1ea1859314e2a3f44029986d8bece2705042f241', 1, 1, 'influencerToken', '[]', 0, '2019-10-17 09:53:32', '2019-10-17 09:53:32', '2020-10-17 17:53:32'),
('68cb502bb7a76dcc7dbf9696d63167d66ceec5c1c1c418e64a99d65e63d12c19eedf17abe7ea9630', 1, 1, 'tapads', '[]', 0, '2020-03-18 00:16:51', '2020-03-18 00:16:51', '2021-03-18 08:16:51'),
('68eb02caf9cc6c583b5dff00bf25c5db22c5c2b3dd2103df48117f04b00250ece6da4bf63b5ee512', 43, 1, 'tapads', '[]', 1, '2019-11-08 03:47:56', '2019-11-08 03:47:56', '2020-11-08 11:47:56'),
('6922ba4755c5b1bc11a41b2899cad9cc21a768c86206b19fc8e3861fec24a82edaa630822ec8882e', 1, 1, 'influencer', '[]', 0, '2019-11-08 03:08:40', '2019-11-08 03:08:40', '2020-11-08 11:08:40'),
('6b08febf7f1f3629955ab1bd8d0a2c4c8d451f476227d38c2d1dffafa88b9e59c4c2c3e0a3aab982', 1, 1, 'influencer', '[]', 0, '2020-07-01 03:53:21', '2020-07-01 03:53:21', '2021-07-01 11:53:21'),
('6b3deefeff6d0a4b4f2537424ef08a348027213603f77bfff9825d06215964493281fab6af5110a6', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:51:55', '2019-09-25 19:51:55', '2020-09-26 03:51:55'),
('6d4d83e226abb14e283a47a0fd9d054bc93808a11441192344b8a5a060a71ca645cbcfdc67a382ba', 1, 1, 'influencer', '[]', 0, '2020-04-30 02:33:31', '2020-04-30 02:33:31', '2021-04-30 10:33:31'),
('6d6800aa8a3681aac63ab49aa692abae93a9e255487d4a1edb9139b02005766e72449843c3f4f39d', 1, 1, 'influencer', '[]', 0, '2019-12-02 08:25:30', '2019-12-02 08:25:30', '2020-12-02 16:25:30'),
('6d84b11d53b0341b22726f26c35e004e9c80a7d42c84ffa0bc7d34d34cd687f9d133259724975e0e', 6, 1, 'influencer', '[]', 0, '2019-12-17 10:28:44', '2019-12-17 10:28:44', '2020-12-17 18:28:44'),
('6dd63f089568b5fdf9ddb959259ff56aaa1d3317bc4c931c0416fdaea63d06b9a9b7f3a22323dac2', 1, 1, 'influencerToken', '[]', 0, '2019-10-22 00:15:55', '2019-10-22 00:15:55', '2020-10-22 08:15:55'),
('6e7ee36b189417ec423dabf4475df6d47f32164d7a2b45b3d6f006ea420d665f8b75aa83b8bba19a', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:00:49', '2019-09-25 19:00:49', '2020-09-26 03:00:49'),
('6ecf1e09d70a887fd8e5a36a59ec64794cc3e5d4746e3507215a71e29eb39114ff075a49ceefe1e2', 5, 1, 'tapads', '[]', 0, '2020-01-03 10:19:59', '2020-01-03 10:19:59', '2021-01-03 18:19:59'),
('6ed2ed768360de0ffe642dbef483c0b8ef12949ef0882c8f15163f55bfe2da1f5f4cb9da87f03448', 6, 1, 'tapads', '[]', 0, '2019-10-16 03:24:48', '2019-10-16 03:24:48', '2020-10-16 11:24:48'),
('70373a4beea937aba459f6b4282bddb48e635cbd5176e8bbf51a346a33f57cf0c63a732740107cf6', 1, 1, 'tapads', '[]', 0, '2020-03-11 08:55:40', '2020-03-11 08:55:40', '2021-03-11 16:55:40'),
('70daebf41db45cea6d3fa66bc3c13a41f72b8dc41c1996187eff8378cc7eb1030d7ff67494911785', 1, 1, 'influencer', '[]', 0, '2019-11-26 14:18:35', '2019-11-26 14:18:35', '2020-11-26 22:18:35'),
('7102dae348521c06e3ffac84cc8fb96e95a88b3400a7e8821dc1d43f7c1cc4089cee0c7c041ebc7a', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:05:47', '2019-09-25 19:05:47', '2020-09-26 03:05:47'),
('725e0bf21861bd15d9e0394af12bd9fc034bcc8a4dc4c961ec777d04ca55e5dd272e3a3725a89a7f', 1, 1, 'influencerToken', '[]', 0, '2019-12-05 22:46:19', '2019-12-05 22:46:19', '2020-12-06 06:46:19'),
('72a9a1f41d5f6c9114e75d0a83eb968d6eb3c3b084a787dcd57f9fbaf887f5670ab834f27db2bff8', 1, 1, 'tapads', '[]', 0, '2020-01-02 09:49:37', '2020-01-02 09:49:37', '2021-01-02 17:49:37'),
('72d6c632918d49029756414f9300f078e98c9c2a0a0d1bed7d70b909589df816152819251ec5521b', 12, 1, 'influencer', '[]', 0, '2020-01-02 01:25:19', '2020-01-02 01:25:19', '2021-01-02 09:25:19'),
('7332855e88f247544395cd9362a067ee00e900a3a8cfe4d5a2159724310d79e2305fbbc6fa3468da', 9, 1, 'influencer', '[]', 0, '2019-12-18 03:20:43', '2019-12-18 03:20:43', '2020-12-18 11:20:43'),
('73b1caba886669b0feab9c637046bf99c38fe348f6698f5cba151b44dfbac4d387ec8dca7c24f2b7', 1, 1, 'influencer', '[]', 0, '2019-09-25 18:41:27', '2019-09-25 18:41:27', '2020-09-26 02:41:27'),
('742060e2c843505335196ef8717f13ce753db9f62a1fcc95e667e428ed9ffced792d3a50a42f722f', 1, 1, 'influencer', '[]', 0, '2020-05-31 08:57:03', '2020-05-31 08:57:03', '2021-05-31 16:57:03'),
('748a42c323e90537264833100a24b096d88fca53ab04fb518bf9285f36fc2bb57b40bc1a51c1bcf3', 1, 1, 'tapads', '[]', 0, '2020-02-13 06:35:39', '2020-02-13 06:35:39', '2021-02-13 14:35:39'),
('74f928d3d595ce31c8fa898e345ad9eda4485f5f9be2feb4d9ea7fe3bb0351d8e103ca7f0d914d97', 40, 1, 'influencerToken', '[]', 0, '2019-11-27 07:09:38', '2019-11-27 07:09:38', '2020-11-27 15:09:38'),
('7589df5f42c66c111377c3601a98fac4db52fb5f980a2a2e994b27bc85ff0a395d20b1d6c901fbfd', 1, 1, 'influencerToken', '[]', 1, '2019-10-23 07:18:49', '2019-10-23 07:18:49', '2020-10-23 15:18:49'),
('7623b94d378c51eccda9715d23667d2defa4796c704035de6041250adf71ec371b7849fe1590dbba', 1, 1, 'influencer', '[]', 0, '2019-12-05 02:26:58', '2019-12-05 02:26:58', '2020-12-05 10:26:58'),
('767041bdeeb18919434ed19865addfafda60199dde95ac22100bee4b5a04439c71878942a4f05f70', 40, 1, 'influencerToken', '[]', 1, '2019-11-08 00:10:41', '2019-11-08 00:10:41', '2020-11-08 08:10:41'),
('76badc730f90e5489f9265f20d9a515eef240900a69486780f4fd5fd5136c49befc9597c539f29a5', 1, 1, 'influencer', '[]', 0, '2020-06-08 02:01:37', '2020-06-08 02:01:37', '2021-06-08 10:01:37'),
('77f751685fd788f3abceb573b8e53c348cedd5fcfe928cb940ec0c530f41eedee8a27aed691ef4c2', 1, 1, 'influencer', '[]', 0, '2020-02-05 01:58:05', '2020-02-05 01:58:05', '2021-02-05 09:58:05'),
('780970c158f31faa8ec5a0a0e9f86170336309067e76fdef1383152126fb9da9ac432a24b312eeb3', 7, 1, 'influencer', '[]', 0, '2019-12-17 10:32:32', '2019-12-17 10:32:32', '2020-12-17 18:32:32'),
('78686062c89b0c0e0b27a33965f01ca0f42a22fbeae4ec4dc62fb13655edb4c6937b85e286b0b5c1', 1, 1, 'influencer', '[]', 0, '2019-10-11 01:34:21', '2019-10-11 01:34:21', '2020-10-11 09:34:21'),
('78ad76e3e44e4c8223026ce3a6bd8c6567dff269118627b0be87c40d1d98cdc869f792f5147260f1', 1, 1, 'influencerToken', '[]', 0, '2019-12-03 13:57:51', '2019-12-03 13:57:51', '2020-12-03 21:57:51'),
('78e1b6cd8985c77de8dab8542ac20244d2a1b8a71bf1674551f772e645e143da3159e68c8cff0e4a', 1, 1, 'influencerToken', '[]', 0, '2019-12-04 02:33:21', '2019-12-04 02:33:21', '2020-12-04 10:33:21'),
('7951f8cee40ded6b34eda839fa4e074ba8e9e168eab63723601fc6c1714392c664da21fc07a0e4ed', 1, 1, 'influencer', '[]', 0, '2019-10-21 00:59:07', '2019-10-21 00:59:07', '2020-10-21 08:59:07'),
('796411a3567468d70200a4344d5a2bf9e84211084f829df8dcc6e8912a25b47cd6b3b030e4cf6689', 1, 1, 'influencer', '[]', 0, '2019-09-24 23:29:52', '2019-09-24 23:29:52', '2020-09-25 07:29:52'),
('797b288fde714acb6f5cfb5296ea963432a41dc69943d4050700220553b8358472f1648d25a246a3', 15, 1, 'tapads', '[]', 0, '2019-10-16 06:57:01', '2019-10-16 06:57:01', '2020-10-16 14:57:01'),
('7ba9b0f1c7e3f7cff4af7773267f506a5163055d2241affddd65fc25ac89eb1e2ffcb8fb69b15fe0', 12, 1, 'influencer', '[]', 0, '2020-01-29 06:37:19', '2020-01-29 06:37:19', '2021-01-29 14:37:19'),
('7bc1266604500dd2122beadc6b424a75928e1c8139c44885ad3083e3c8a7e654d49ab31d87363746', 40, 1, 'influencerToken', '[]', 0, '2019-10-28 01:16:50', '2019-10-28 01:16:50', '2020-10-28 09:16:50'),
('7cc23301892d2e84ab3985612520330197ebf5b271d5586659206153ab77cdd83155da086389c39a', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:05:18', '2019-09-25 19:05:18', '2020-09-26 03:05:18'),
('7dfaba412aceea931bab20402c6808157ed7d6e191af780b121221c245da09f27ac268bac9443522', 12, 1, 'influencer', '[]', 0, '2020-01-22 02:46:29', '2020-01-22 02:46:29', '2021-01-22 10:46:29'),
('7e40dc568f0adc963f0964fbfc20d170acfc3aba5e71d050fa6044ffd391310452caebeb2d3a68d0', 15, 1, 'tapads', '[]', 1, '2019-12-05 09:53:13', '2019-12-05 09:53:13', '2020-12-05 17:53:13'),
('7fe373839a242a103848df0af468ce06d674e55483ff9db8842cccf53e3249839d8dd773025a6815', 1, 1, 'influencer', '[]', 0, '2020-02-11 01:53:51', '2020-02-11 01:53:51', '2021-02-11 09:53:51'),
('7fe9b047309fa9460a49dae98b569083c2baef2b6b4d9bebd69f2fd0fb59695c7ac0b75690a8b2e9', 41, 1, 'influencerToken', '[]', 0, '2019-10-28 02:56:16', '2019-10-28 02:56:16', '2020-10-28 10:56:16'),
('803a1bd743ecde0a02fc923d0c388b8410fcdc757ac90ae9ee72cf1f5c68adb8d20210c2b3cea9af', 1, 1, 'influencerToken', '[]', 0, '2019-10-21 10:00:55', '2019-10-21 10:00:55', '2020-10-21 18:00:55'),
('8086ca1c34065ae029a3c868a5b8d011e568204e76776252abca5fd463ff2faf71f28aaf580bc22b', 1, 1, 'influencer', '[]', 0, '2019-09-30 17:34:01', '2019-09-30 17:34:01', '2020-10-01 01:34:01'),
('8105b398507fae949292295d23863d9b32de4a3aa91c711619c7f4e384f53304938a13bb6a2f174d', 1, 1, 'influencer', '[]', 0, '2019-12-09 02:43:03', '2019-12-09 02:43:03', '2020-12-09 10:43:03'),
('8129196bfb4f83602740b38b851ba235ebee4a4dfffcdb2838c40835c83b40378f66fa9393b37777', 16, 1, 'influencerToken', '[]', 0, '2019-12-05 11:16:30', '2019-12-05 11:16:30', '2020-12-05 19:16:30'),
('815213214f0bbbee6448578b8e04e56f74b1bce86d5bccee0ad4066014e4f9a6b1e6b914395c2148', 1, 1, 'influencer', '[]', 0, '2019-09-25 20:06:01', '2019-09-25 20:06:01', '2020-09-26 04:06:01'),
('8209adabc7f69def8e7baa5980683c0d631dc2b3069e6a5c533f0de2a483e9e29dff0c2e023add72', 1, 1, 'influencer', '[]', 0, '2019-11-18 01:48:37', '2019-11-18 01:48:37', '2020-11-18 09:48:37'),
('8260121608215133962563b2b8646669b130b36486b8dee9f54567a12f387b1b9c13f7e8209a81c3', 35, 1, 'tapads', '[]', 1, '2019-10-23 07:58:46', '2019-10-23 07:58:46', '2020-10-23 15:58:46'),
('8353c5d4be9436f94b6d110114da5db2fa59e88d4ce8a93162401907a917313cfe260add09dff148', 1, 1, 'influencer', '[]', 0, '2020-02-13 02:16:55', '2020-02-13 02:16:55', '2021-02-13 10:16:55'),
('8398e74288dc022b0489aa623b96a1d88ae381f4f00667cd05a9b174834e6ae7fb5f73dc80d8ccc4', 1, 1, 'influencer', '[]', 0, '2020-03-29 21:46:31', '2020-03-29 21:46:31', '2021-03-30 05:46:31'),
('839c20aee8bfd45a0860a11a51cab90415c27b832ec9ba3558aac5120b8a22cbb5a6c1cb27ab6c11', 1, 1, 'tapads', '[]', 0, '2020-02-13 07:55:59', '2020-02-13 07:55:59', '2021-02-13 15:55:59'),
('83ab3ba4172e9d3e468c64bb978ba46d7dd9178d4aaa054107adf56e53de4e952c4477d5da65a94d', 16, 1, 'tapads', '[]', 0, '2019-12-05 11:14:22', '2019-12-05 11:14:22', '2020-12-05 19:14:22'),
('83fdeee8aebf76e1d4b73e0261eec334fa9a7f9089466205227dcf45e76c29ef5686cc91fdb08063', 22, 1, 'tapads', '[]', 0, '2019-10-16 07:18:14', '2019-10-16 07:18:14', '2020-10-16 15:18:14'),
('84452d0f89774880b84fa435d263f322a10cad6bd5850a06b393a134c9e54da07e2f1a4db8bd7a9d', 8, 1, 'influencerToken', '[]', 0, '2019-10-16 03:37:36', '2019-10-16 03:37:36', '2020-10-16 11:37:36'),
('845758d13d076d24b7b72cae86a134e19ce5ac5d9200f80289a5b7371d8c330b23dab6d48d568092', 1, 1, 'influencer', '[]', 0, '2019-12-05 12:22:27', '2019-12-05 12:22:27', '2020-12-05 20:22:27'),
('867de8a0df540df5eaca819ab5b2cb1b0d077b754f066d07f8a40dcae219c28f10ce4c7c4f276e02', 12, 1, 'influencer', '[]', 0, '2020-01-15 02:45:27', '2020-01-15 02:45:27', '2021-01-15 10:45:27'),
('86e0bd30c313a8ca22dcfc1cf94940dd3ad1890a1165973bfbc031872f6965612e33e45f0f028e05', 1, 1, 'influencer', '[]', 0, '2020-02-03 01:50:48', '2020-02-03 01:50:48', '2021-02-03 09:50:48'),
('87699ab06a4810b88c9c819b894e1b776426886e67c24f281d7f9076ca9badc8eaea3e08240dd9f6', 28, 1, 'tapads', '[]', 1, '2019-10-16 07:48:42', '2019-10-16 07:48:42', '2020-10-16 15:48:42'),
('87f45a5db85e55247eb750cb6bb018dd5d82e9846ee73531c6540723597580870c6fe1ee36baf773', 1, 1, 'influencer', '[]', 0, '2019-09-23 23:27:28', '2019-09-23 23:27:28', '2020-09-24 07:27:28'),
('8866174981b1227bfc119b4960eb465eff6388d7b0c19030ccd3d0075a7a4e81a529f5c2a03564b9', 1, 1, 'influencerToken', '[]', 0, '2019-10-23 05:28:35', '2019-10-23 05:28:35', '2020-10-23 13:28:35'),
('89126b0e53ba0c983582196b46ceb3f811a2d68e0a8082d021e45d9fa4f83b21b3a394514cfca871', 1, 1, 'influencer', '[]', 0, '2020-02-28 02:00:17', '2020-02-28 02:00:17', '2021-02-28 10:00:17'),
('8932882241440d600951781b8bd9b79ae9bad006302ff6caa090a2082fd68c53d1542e2ce9ac27fb', 1, 1, 'influencer', '[]', 0, '2019-09-25 21:37:52', '2019-09-25 21:37:52', '2020-09-26 05:37:52'),
('897dda5ea25a91b9e25b7d066c2aee3be7cc06b7b4ea85ff75f87ce12ea2fcaaac05b835dbdd122c', 12, 1, 'influencer', '[]', 0, '2020-01-06 01:50:37', '2020-01-06 01:50:37', '2021-01-06 09:50:37'),
('89891a23eeb35bc6d24c0617de65e164dd720fbf0982ee97e40d842326b6fe770a7ac7fbcc466291', 40, 1, 'influencerToken', '[]', 0, '2019-11-27 06:29:03', '2019-11-27 06:29:03', '2020-11-27 14:29:03'),
('898a73799f2537961304dfa5bb5d1065dd90755cb164ba41acef05c2d8a34df3deb1af09f04394e8', 1, 1, 'influencer', '[]', 0, '2019-11-13 00:45:57', '2019-11-13 00:45:57', '2020-11-13 08:45:57'),
('8a48b8386f60950d9183a17cea02aa59a5875355cc54be10719d3abe53df6775ab8fa6a9edaa3ac9', 1, 1, 'tapads', '[]', 0, '2020-01-27 01:38:38', '2020-01-27 01:38:38', '2021-01-27 09:38:38'),
('8aeed9c1f48d7bb57e7ae680e62f6965bea1aad64618fa80dfb31bf3cd09584addecc4aafc8e9bc5', 31, 1, 'tapads', '[]', 1, '2019-10-16 08:01:41', '2019-10-16 08:01:41', '2020-10-16 16:01:41'),
('8afb8eee9561b5c03566213cef6a192f44f611b05d5f94108c119142b8168af4ddce45c8cb30323a', 1, 1, 'tapads', '[]', 0, '2020-03-17 13:03:13', '2020-03-17 13:03:13', '2021-03-17 21:03:13'),
('8cb8b1afdd55d20c2dd676e662e9d462796ceba4c09c4a86c1de1d43a718cbf0602c1837fbd07e78', 1, 1, 'influencer', '[]', 0, '2020-04-26 21:33:44', '2020-04-26 21:33:44', '2021-04-27 05:33:44'),
('8ce385815aed74f347cc85021fbe54251a53b94c13f827ef8251562cdf7b8aa568b8894a4ce76280', 12, 1, 'influencer', '[]', 0, '2020-01-13 00:00:16', '2020-01-13 00:00:16', '2021-01-13 08:00:16'),
('8d95201ea08d1be7ac3fa03b4ce799e30956d075275cb1ba665c53afba5924f414df82ebb99d544c', 1, 1, 'influencer', '[]', 0, '2019-12-03 00:31:55', '2019-12-03 00:31:55', '2020-12-03 08:31:55'),
('8f239f9a26c140c0c0733be173aae0db7ebf5d266140631381ce2b3beda3b1c689e13380590c15c5', 1, 1, 'influencer', '[]', 0, '2019-11-26 01:02:16', '2019-11-26 01:02:16', '2020-11-26 09:02:16'),
('8fbece4c317a15b710a91f082481f866e689c0f1a334992d139b610ac3184b1d923ce24352498573', 1, 1, 'influencer', '[]', 0, '2019-12-04 06:24:28', '2019-12-04 06:24:28', '2020-12-04 14:24:28'),
('90aa4c0efd5c24a09209bb721df68fdf7803e17d0019515404e79730b0da09d9f8741fc1d94c425a', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:56:11', '2019-09-25 19:56:11', '2020-09-26 03:56:11'),
('90c2e7f7e2da6bf0da50b0eeb6c2f491e064843b34ae90633764b21bd379659bc225ed2130af5541', 29, 1, 'tapads', '[]', 1, '2019-10-16 07:55:49', '2019-10-16 07:55:49', '2020-10-16 15:55:49'),
('910190cb6b7b1ca3e6c6d6e0cea0f175fb5a0fe6ca19e5d94fbda1c53149413b282239a83fb05061', 1, 1, 'influencerToken', '[]', 0, '2019-09-23 22:45:41', '2019-09-23 22:45:41', '2020-09-24 06:45:41'),
('916676928cc35884da39005dc94d72f8a7ecae05c54613ab39236b18ecf7a2ed33196971299f5638', 1, 1, 'influencer', '[]', 0, '2019-11-07 01:01:39', '2019-11-07 01:01:39', '2020-11-07 09:01:39'),
('918fb1f182a6f33ecb1406de2e787f92260bdecaf2bc0ed954a87db4873cb48f0555862980cf1d32', 9, 1, 'tapads', '[]', 0, '2019-10-16 03:41:35', '2019-10-16 03:41:35', '2020-10-16 11:41:35'),
('91c965a18111eee84a4b498eaa87510e2932e00dffd2a3a1d2f75502b52f599a7f639cb903ca4cba', 1, 1, 'influencer', '[]', 0, '2020-02-19 08:45:00', '2020-02-19 08:45:00', '2021-02-19 16:45:00'),
('921299f3176fcfd95aa13e1671d13da625a2c7dbf2fcc10f079f7cb4b97ba6be825b570c430b08b4', 1, 1, 'tapads', '[]', 0, '2020-02-03 01:44:19', '2020-02-03 01:44:19', '2021-02-03 09:44:19'),
('931c346023187f015086bf1e75b241433b4b2d6afd68a3c940a4161e09b0f1a8f8181868d75f5e66', 1, 1, 'influencer', '[]', 0, '2019-11-11 06:00:08', '2019-11-11 06:00:08', '2020-11-11 14:00:08'),
('9372c1a912624dd841d5bce78d6a52dfa39e8fd596359a55514333103fdb46f882ddb2f957a91cc1', 12, 1, 'influencer', '[]', 0, '2020-01-08 01:35:55', '2020-01-08 01:35:55', '2021-01-08 09:35:55'),
('94701159a7e8affcfa66169043ecaac9599de0be1a3dba675342e876f9eaefddbc09ba0d9e55555a', 1, 1, 'influencerToken', '[]', 1, '2019-10-16 08:01:09', '2019-10-16 08:01:09', '2020-10-16 16:01:09'),
('95021995b691596adb445ec2883467e0ed9f51c4a50207875349ef3c3a9fc44efa94a51cd111667d', 1, 1, 'tapads', '[]', 0, '2020-02-24 08:21:20', '2020-02-24 08:21:20', '2021-02-24 16:21:20'),
('9546db7ead9836ffa2e771b14f1fe943fb07c45f9e532fb3714eb201b35708c3b4b5416627a32a10', 1, 1, 'influencer', '[]', 0, '2020-03-12 01:13:37', '2020-03-12 01:13:37', '2021-03-12 09:13:37'),
('95a72eb3f1a241f8e40c1d983f6e22fac660e3ba9f7fa6e671afc151b207f261c036d74dc9342ffc', 1, 1, 'influencerToken', '[]', 0, '2019-12-05 07:06:03', '2019-12-05 07:06:03', '2020-12-05 15:06:03'),
('9692ad5b53a70aa1ff540408f9b814abd2784a636dfbbf50eaaa1cc2abe90ffbe35a598b9fe37461', 1, 1, 'influencer', '[]', 0, '2019-11-06 00:58:12', '2019-11-06 00:58:12', '2020-11-06 08:58:12'),
('97a167e5d2b54fa1887ef535eb50ba42c87d9ac31ec0bc0888e082cf597586843dcc116ff7d61fc0', 1, 1, 'influencer', '[]', 0, '2020-05-18 08:17:08', '2020-05-18 08:17:08', '2021-05-18 16:17:08'),
('97bbb351a73a37adbb1adaf0ede76090469ec9e2bc20b14cc62fa63c953a18f077c94b484d840b37', 1, 1, 'influencerToken', '[]', 0, '2019-10-15 22:32:51', '2019-10-15 22:32:51', '2020-10-16 06:32:51'),
('991461842d5e331065ea1c2e1bbf07f3eeb5c82170bfc70636ba62fd2bbeaccc6d2492dcc4750771', 1, 1, 'influencer', '[]', 0, '2019-10-07 17:20:07', '2019-10-07 17:20:07', '2020-10-08 01:20:07'),
('9aaf4c4baa07fde137ed9f2f23d5e0645f95dcd33edf6d12083dd452f152e2b098a4bfffe1ab806d', 12, 1, 'influencer', '[]', 0, '2020-01-23 01:16:49', '2020-01-23 01:16:49', '2021-01-23 09:16:49'),
('9b3627ea7d771d9fdd2be65da4828e1d8e4a65af9e516b6a0d746c6da91a3ecaa8728209b927603c', 10, 1, 'influencer', '[]', 0, '2019-12-18 05:44:39', '2019-12-18 05:44:39', '2020-12-18 13:44:39'),
('9c2c7e5c01c342199ceb5f3a5f53249de1e1d964686ffcf285e8f8c5f66fc739dcc1240cb1f4840b', 40, 1, 'influencerToken', '[]', 0, '2019-11-22 03:52:17', '2019-11-22 03:52:17', '2020-11-22 11:52:17'),
('9c5d752d4fc90f48b2b943276f1a9631a1f43e081e74af8341651e55028681539f28b802cbf4e4ee', 2, 1, 'influencer', '[]', 0, '2019-12-17 10:22:34', '2019-12-17 10:22:34', '2020-12-17 18:22:34'),
('9c63cd7c46ea98ea2194ab3e8c675bdcd56b7cfa8e6c9264c4ab5caa046ea4606593918f18a36aee', 1, 1, 'influencer', '[]', 0, '2020-05-04 02:39:52', '2020-05-04 02:39:52', '2021-05-04 10:39:52'),
('9d17e1566fc9c5ae312a646fa6594a5385d9dd50baedd992337a6e65f5685bc0819ca5834598b502', 1, 1, 'influencer', '[]', 0, '2020-03-10 08:56:28', '2020-03-10 08:56:28', '2021-03-10 16:56:28'),
('9db8238d29c4738f762893817b05d9d08bc1a2b1e14f9cb9e184e0064b23649c49e064adff351edf', 1, 1, 'influencerToken', '[]', 0, '2019-12-04 01:12:54', '2019-12-04 01:12:54', '2020-12-04 09:12:54'),
('9deb434dbf17ce824bf92ee01edc374aeb4accf48692b13e84362a458baa4b3951fac2313e664787', 12, 1, 'influencer', '[]', 0, '2020-01-28 02:08:27', '2020-01-28 02:08:27', '2021-01-28 10:08:27'),
('9eff3c5ead249db74b74bc2872820adacfd0a8a575bf11de50f49b996775d5c93f4cfae56693716c', 1, 1, 'influencerToken', '[]', 0, '2019-12-05 20:11:19', '2019-12-05 20:11:19', '2020-12-06 04:11:19'),
('a149826d99afafff00202a83b7bb23fb852e361443579a213109ccf1ecd2799fc1e01040a1d24973', 1, 1, 'tapads', '[]', 0, '2020-03-10 02:56:20', '2020-03-10 02:56:20', '2021-03-10 10:56:20'),
('a2ceb6d7cd0503dac3279db4a6670686808cc88e27616a4c8f3f86694b547c3d1274fbb88f41ed3e', 1, 1, 'influencerToken', '[]', 0, '2019-12-04 01:20:18', '2019-12-04 01:20:18', '2020-12-04 09:20:18'),
('a32ec6f47720c1703b3ca57cb8809824c1adc1389807a3a20c28fa95803876392fe8e16ee92ad977', 11, 1, 'influencer', '[]', 0, '2019-12-18 06:00:06', '2019-12-18 06:00:06', '2020-12-18 14:00:06'),
('a4b9d0c93af0e6fc96b5d9e70d669b11b9cc9e725c3b9a6b465f68aebd1f7070ca4ea551bea28dc2', 1, 1, 'influencer', '[]', 0, '2019-09-25 01:02:40', '2019-09-25 01:02:40', '2020-09-25 09:02:40');
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('a502cb38dc3994a3d607f1aefe8a042b36ef7b81a7aa76f105f3531f2e22f234d65e6893ebf0b3fe', 1, 1, 'influencer', '[]', 0, '2020-05-12 01:48:51', '2020-05-12 01:48:51', '2021-05-12 09:48:51'),
('a56fd3b2d7a855e4cd2e83e16259e9faa951fe449665a14ff480492894b0f83a9267310f880af23f', 1, 1, 'influencer', '[]', 0, '2019-10-14 06:39:06', '2019-10-14 06:39:06', '2020-10-14 14:39:06'),
('a612a2c7c3fd06005e199cb16acf40e179520556243227099b348409cd17f58e2c6548fdfabc6baa', 1, 1, 'influencerToken', '[]', 0, '2019-12-04 09:01:41', '2019-12-04 09:01:41', '2020-12-04 17:01:41'),
('a71247155ab109f15d3aa054ce314d9351e65e4a6d5471f8bfc83e6c9d9467d5319ee5667bfb749a', 1, 1, 'influencer', '[]', 0, '2019-11-29 01:05:12', '2019-11-29 01:05:12', '2020-11-29 09:05:12'),
('a7bea3514dbd903fa2aabddba796ace468a043c170b4f2bc88ffe788e5e6b56a7ab5050bc8dc6b97', 13, 1, 'tapads', '[]', 0, '2019-10-16 06:53:39', '2019-10-16 06:53:39', '2020-10-16 14:53:39'),
('a863d41847d85a49b2f28fb1247b811d5e15b54286a9605e5f99452a84b5231e351b8b9bcd9889cc', 1, 1, 'influencer', '[]', 0, '2019-09-25 00:42:34', '2019-09-25 00:42:34', '2020-09-25 08:42:34'),
('a8741c087a9ed46e9c6bef3e79d1730f01172601aefa43a6e9304c12bcb78fd1f040478501e330b3', 1, 1, 'influencer', '[]', 0, '2019-09-25 20:04:04', '2019-09-25 20:04:04', '2020-09-26 04:04:04'),
('a87492fd9f5d7fc94222445de761e6022337f2ec982cf8a954f4f2f258fb953544b6939fbb23f2ca', 10, 1, 'influencer', '[]', 0, '2019-12-18 03:28:54', '2019-12-18 03:28:54', '2020-12-18 11:28:54'),
('a9303df3d30ecdb37ede025c17b6b3086eb6a0cb7610e9cac44efb8fa7d19660123ef6d5beffb818', 1, 1, 'influencer', '[]', 0, '2020-04-23 07:14:11', '2020-04-23 07:14:11', '2021-04-23 15:14:11'),
('a93aeafc14c447e7e1be216d3202fcf93b6c914a852a268650da97a612f7ffa7a886d7139ae0f10f', 19, 1, 'tapads', '[]', 0, '2019-10-16 07:16:57', '2019-10-16 07:16:57', '2020-10-16 15:16:57'),
('a99800fa2ce2f0535f8f08c29f00d92f608b1494d99674fbcd85b31397b058dc60d3d6353098fcff', 1, 1, 'influencer', '[]', 0, '2019-09-25 18:04:41', '2019-09-25 18:04:41', '2020-09-26 02:04:41'),
('aa09c3568c4fd9192d5e40f47facb4812d9cb32a8a3e9151aa78a05d9ed523cba7638c01e5958b56', 5, 1, 'tapads', '[]', 0, '2020-01-03 03:17:42', '2020-01-03 03:17:42', '2021-01-03 11:17:42'),
('aa3f3a45b4314abfaa8f3bfb92de109caef9ebd388612835e93bfa827bef8cbeca7bd3d80f7dceef', 1, 1, 'influencer', '[]', 0, '2019-12-05 14:28:50', '2019-12-05 14:28:50', '2020-12-05 22:28:50'),
('aa674fe0a43daa275111589cff68c0ddb740b12330e1c9c94f98d9de2830e770c1374ff8b031547c', 1, 1, 'influencer', '[]', 0, '2020-05-03 12:52:10', '2020-05-03 12:52:10', '2021-05-03 20:52:10'),
('aac0e09e3452c2cbafce678bfeb352f2fad837fae60f9fa63e5a4653a1a2865d49e7d3fdd8edbdb9', 41, 1, 'tapads', '[]', 0, '2019-10-24 02:35:29', '2019-10-24 02:35:29', '2020-10-24 10:35:29'),
('ab09c31df200526e3b20a617b3cfa352852b4d9e4b25a8d6e0c4b096ac9f9c0750806212add27b4a', 12, 1, 'influencer', '[]', 0, '2020-01-17 02:17:11', '2020-01-17 02:17:11', '2021-01-17 10:17:11'),
('abd62bc6a4ac4fe70e29154c8980394813e7c430ed6d86c1fd7077bb148c991998c45faf6d333894', 1, 1, 'influencer', '[]', 0, '2019-10-30 00:52:47', '2019-10-30 00:52:47', '2020-10-30 08:52:47'),
('abf073a1a8ed528bd5898b12ee90190be9b6354af965e0e9383191164fdf7ee5d6e987e115b082da', 1, 1, 'influencerToken', '[]', 0, '2019-12-04 01:25:24', '2019-12-04 01:25:24', '2020-12-04 09:25:24'),
('ac156b94a5dd611b61d20f85cc02f47d695f8803109b8206a3cc70e47ef8fa5c49e92bd23fb0748f', 39, 1, 'tapads', '[]', 0, '2019-10-23 08:24:03', '2019-10-23 08:24:03', '2020-10-23 16:24:03'),
('ac8fa9147e42104e323f07c6f1c48280c3ed9482e2ee3b0dd7a2fcd4821b3589a87a9f888888c96c', 1, 1, 'influencer', '[]', 0, '2019-09-25 01:57:06', '2019-09-25 01:57:06', '2020-09-25 09:57:06'),
('adfde50bf756dd664ae0c9de735e55de174a1ccc36540dbf60ed7742d9a4bcd7f2c7d94d9fab4972', 1, 1, 'influencer', '[]', 0, '2020-05-12 15:08:44', '2020-05-12 15:08:44', '2021-05-12 23:08:44'),
('ae7a3abb2ec712ca142c4ef9d9a40fae6ce44b9a8eec498b972963cdd7a1ab99d694137244da8d5b', 5, 1, 'tapads', '[]', 0, '2020-01-03 03:53:25', '2020-01-03 03:53:25', '2021-01-03 11:53:25'),
('aef1959e8d142af9df2d9f84d3e7f1731c52c21ddf48b7447895e7833055942108f8e856a922c300', 1, 1, 'influencer', '[]', 0, '2019-09-25 01:54:10', '2019-09-25 01:54:10', '2020-09-25 09:54:10'),
('af6c2db298a73312d29cd9a8475970bb1427477e0a17ee487ac8802daddd0965358a6bc0c93bef7a', 26, 1, 'tapads', '[]', 1, '2019-10-16 07:35:15', '2019-10-16 07:35:15', '2020-10-16 15:35:15'),
('b03ec86320c86056b1fe0f4d622ec1ef44220d53db99da4420ef8c16a2ab11b045846b8e43cfc0d5', 1, 1, 'influencer', '[]', 0, '2019-10-22 05:13:04', '2019-10-22 05:13:04', '2020-10-22 13:13:04'),
('b06a8c07936972a364be20929d2c1f12ed7ee211347f8e8cf0875ba47c161cddfa65a091e565ca69', 12, 1, 'influencer', '[]', 0, '2020-01-02 01:22:20', '2020-01-02 01:22:20', '2021-01-02 09:22:20'),
('b0852df627ec8eda97eb7713a9779c06f491f7fcd272dfcbde885bc61b0db968971f9348dd5383ba', 1, 1, 'influencer', '[]', 0, '2020-02-10 02:21:42', '2020-02-10 02:21:42', '2021-02-10 10:21:42'),
('b0fd9b19c32a56e872654ad78d1a096eeff86bfee0aa53fc5508b0edaa3a15d8cb4b65dfb60290a4', 36, 1, 'tapads', '[]', 1, '2019-10-23 08:05:09', '2019-10-23 08:05:09', '2020-10-23 16:05:09'),
('b181faf51d03008318bf213a4da48d6b1dede6cfc6a7545843653ef4d8e5a610eee2589cbfcc6cc6', 5, 1, 'tapads', '[]', 0, '2020-01-08 02:12:34', '2020-01-08 02:12:34', '2021-01-08 10:12:34'),
('b18dca0d0be696bd90495bc539ac1601d7f492d5906d3b7360c05cab63f8af7dd2689581819fff8f', 1, 1, 'influencer', '[]', 0, '2020-02-04 02:35:57', '2020-02-04 02:35:57', '2021-02-04 10:35:57'),
('b355db58971351daef2b702ac2f07bbeb68fd7866cc22c87733ae987ddb9557d1c6c1d7d3f119ae1', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:56:11', '2019-09-25 19:56:11', '2020-09-26 03:56:11'),
('b41560a0ee409be09f4096cde4b000d0c09ebff5345d2406637a89dfe4c2f4054a6c19431a2892b1', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:56:41', '2019-09-25 19:56:41', '2020-09-26 03:56:41'),
('b498a3d124839f8962bf75a37d3cc55b8eeee7f7b849283b5992fd609819d36e9bf77db539757146', 9, 1, 'tapads', '[]', 0, '2020-01-30 23:17:43', '2020-01-30 23:17:43', '2021-01-31 07:17:43'),
('b5e8813c2d54688692200bfd9365ca22b68dff8fa8479d7dd6690d5a72c26961636659cfc1536054', 1, 1, 'influencerToken', '[]', 0, '2019-09-23 02:35:42', '2019-09-23 02:35:42', '2020-09-23 10:35:42'),
('b69db245453fa08ca1645c413813506c9df31cefc69112913a73ae0d7131302d32c03c8badd5f4df', 1, 1, 'influencer', '[]', 0, '2020-03-25 20:56:10', '2020-03-25 20:56:10', '2021-03-26 04:56:10'),
('b6f4fb522af47840e9a9620471a1f21b47a17a09e84a06c812c833d22da192bdf87c030dbb4b47e6', 1, 1, 'influencerToken', '[]', 0, '2019-12-03 23:37:47', '2019-12-03 23:37:47', '2020-12-04 07:37:47'),
('b7c3a5c416dc6c26352b99e531993c36f94a3f4c2d9762d7ac37e404443fe4893e834a15b3c42d1b', 1, 1, 'influencer', '[]', 0, '2019-09-25 01:56:30', '2019-09-25 01:56:30', '2020-09-25 09:56:30'),
('b82776210cdc47139303366de26f1291a34d4cd597006335656c344a5c140c1df92648c0a7006863', 40, 1, 'influencerToken', '[]', 0, '2019-11-26 09:29:40', '2019-11-26 09:29:40', '2020-11-26 17:29:40'),
('b866914e4daac8a83553750317984e73950c006e3091f4d0d7d1d0612ee28e1c19ca183882ffad02', 1, 1, 'influencer', '[]', 0, '2019-11-07 00:51:24', '2019-11-07 00:51:24', '2020-11-07 08:51:24'),
('b88682ef11675b10969a913e130dcd9f89b21978402aaa388bce8a2cb12438c3e8beda44cc60df98', 11, 1, 'influencer', '[]', 0, '2020-01-03 07:26:48', '2020-01-03 07:26:48', '2021-01-03 15:26:48'),
('b9a47e682ee0f816acc8a56b3b3c044654bd44b2840a7a393c30df9a13cdc0f78196f9061bb3a120', 40, 1, 'influencerToken', '[]', 0, '2019-11-26 09:32:26', '2019-11-26 09:32:26', '2020-11-26 17:32:26'),
('ba047e558aa06c443827effd2f49b11f417064dd41a88468a04c5a127380dde3352502df17aeaf97', 12, 1, 'influencer', '[]', 0, '2020-01-29 02:12:42', '2020-01-29 02:12:42', '2021-01-29 10:12:42'),
('ba53b0b904f2191c476edfd718f88e8793d399d675112bab1d45db17c0a053f90fee5c71cfab3abc', 1, 1, 'influencer', '[]', 0, '2019-09-25 00:30:00', '2019-09-25 00:30:00', '2020-09-25 08:30:00'),
('ba5fdd29a12444fbfc604e608b6d5a6244dce0c329d0062860c6d6162ca64489861a219ea8b49666', 1, 1, 'influencerToken', '[]', 0, '2019-11-28 06:46:44', '2019-11-28 06:46:44', '2020-11-28 14:46:44'),
('bb63077d90b64d26378e4448c1404e9cceb52b46d603a18a37ea7bc948a49564d8abfc5b3ad430ba', 1, 1, 'influencer', '[]', 0, '2020-05-01 03:49:25', '2020-05-01 03:49:25', '2021-05-01 11:49:25'),
('bb844f9a267c2f17c029b68ed60274a290402c75276d08badeb0d87706017f4ca9216a18c211ee37', 1, 1, 'influencer', '[]', 0, '2019-11-19 01:35:58', '2019-11-19 01:35:58', '2020-11-19 09:35:58'),
('bb863e895fa48eb26839ff4cb2657595a1afcb2ab55fa75e0c0669aa2454ba183148e4f40c055ab0', 1, 1, 'influencer', '[]', 0, '2020-05-19 01:16:59', '2020-05-19 01:16:59', '2021-05-19 09:16:59'),
('bde5d9a3bf797221bfe9e76ad9b0949528eb8f5556aa67e318f02a3a9fdaf948aa81726283be63c3', 1, 1, 'influencer', '[]', 0, '2019-11-05 01:17:44', '2019-11-05 01:17:44', '2020-11-05 09:17:44'),
('be08cd42cd34f0e181a5324f229ab288108b5277732eef75a7c8441a887d857b0320e16d0db64154', 1, 1, 'influencerToken', '[]', 0, '2019-10-17 09:53:11', '2019-10-17 09:53:11', '2020-10-17 17:53:11'),
('bfc7feab40a430314d2d9df8adca080c29d10ff0c66aae16b4ee3f5831523b6d189bfbdf7ef41266', 1, 1, 'influencer', '[]', 0, '2020-02-26 10:00:22', '2020-02-26 10:00:22', '2021-02-26 18:00:22'),
('c05248b8989c0d096514fdf4a9a3dffcbaf94e50bd119efbe0b429b9eede74419cf68f1936102176', 12, 1, 'influencer', '[]', 0, '2020-01-20 01:58:29', '2020-01-20 01:58:29', '2021-01-20 09:58:29'),
('c0e49118e97928e402d6a7ba451137da39cdf3317c329dbe706ae6170f5feb3991502a1138296b5f', 1, 1, 'influencer', '[]', 0, '2019-09-25 00:41:24', '2019-09-25 00:41:24', '2020-09-25 08:41:24'),
('c0e67eb1757ac7b5f3affdc89b6f13ea0d536a62629303ae72325a80d7bd644c4431a1dfeaf1eb43', 2, 1, 'tapads', '[]', 0, '2020-03-10 09:27:57', '2020-03-10 09:27:57', '2021-03-10 17:27:57'),
('c0e9b17626736f228aac3e8759890394e2f2162fdce48edfa50a36b691eae09d5208061b58576401', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:55:22', '2019-09-25 19:55:22', '2020-09-26 03:55:22'),
('c260ed011ab938be578cd60e5dd7c0b5124ee45e3121b5503e23eb25ad3977c420de7942508c3dea', 1, 1, 'influencer', '[]', 0, '2020-04-16 13:27:09', '2020-04-16 13:27:09', '2021-04-16 21:27:09'),
('c3edca755cc187cb2cfc2b8b22f58d3a31dfc92ab9e33d286eb95f918763dc6aef8841c3d3d9ced1', 1, 1, 'influencerToken', '[]', 1, '2019-09-23 02:36:14', '2019-09-23 02:36:14', '2020-09-23 10:36:14'),
('c4c17e816ac74a046dead37f15a83d6f256eff84cf2198e85d9a1af176df0dcbd42de3c216224efb', 1, 1, 'influencer', '[]', 0, '2020-04-15 14:12:18', '2020-04-15 14:12:18', '2021-04-15 22:12:18'),
('c58ff2d61675db19b36be591dc43f4f03c498b14951d31cdfe76cae02637910ad61222c531241237', 1, 1, 'influencer', '[]', 0, '2020-02-20 01:55:17', '2020-02-20 01:55:17', '2021-02-20 09:55:17'),
('c64ac2fa7ae7764b8b9ac5183026f06e13782de28781e337ee728211bc968c823736101b2fdd88d9', 6, 1, 'tapads', '[]', 1, '2019-11-28 22:09:53', '2019-11-28 22:09:53', '2020-11-29 06:09:53'),
('c66f89a75544410120ea72dcca5933fe928f6437457bfef495d1096e6b9179f9c95439f10ac16354', 40, 1, 'influencerToken', '[]', 0, '2019-10-24 05:37:24', '2019-10-24 05:37:24', '2020-10-24 13:37:24'),
('c6e7fb8f83bbd7a583d65687e067640dd0a82341d8705ee113f43ae8418e7a14bfefee01b90df812', 1, 1, 'influencerToken', '[]', 0, '2019-10-16 10:00:10', '2019-10-16 10:00:10', '2020-10-16 18:00:10'),
('c7b5ea6583c7f1a88699c952ee4d07fbfe5094bc778a4298b74b7aae5e61418a031a2517f04d5127', 1, 1, 'influencer', '[]', 0, '2020-03-04 01:59:28', '2020-03-04 01:59:28', '2021-03-04 09:59:28'),
('c887129cda34396a6832fa943be712a20a0ca6543d944929014b094c1adb26fe02862b80741d2b94', 1, 1, 'influencer', '[]', 0, '2019-11-21 23:40:41', '2019-11-21 23:40:41', '2020-11-22 07:40:41'),
('c90a7d526c8462b0c14ee649fde7308175eee7876d49f9477427de577f2d37d0946c0795723e23db', 1, 1, 'influencerToken', '[]', 0, '2019-12-04 07:36:51', '2019-12-04 07:36:51', '2020-12-04 15:36:51'),
('c9ad1f39dbe7ad948be569ae7c9f13e05e0ac5934aa91bbc63732ab1b68aa0c21ec048a5af4f3b26', 1, 1, 'influencerToken', '[]', 0, '2019-12-03 12:19:43', '2019-12-03 12:19:43', '2020-12-03 20:19:43'),
('ca51ece3570e96c252f6107c895a56f837097f1f4bf2d37055ff1fcee6bf6d799018ed455e8539e0', 14, 1, 'tapads', '[]', 1, '2019-11-28 22:24:15', '2019-11-28 22:24:15', '2020-11-29 06:24:15'),
('caf7070ab055625c0acd8944a805de5fa485a2394459b6378572b3254dc2df2e14d7c522480fa969', 34, 1, 'tapads', '[]', 0, '2019-10-18 06:05:51', '2019-10-18 06:05:51', '2020-10-18 14:05:51'),
('cb1c648a928c10a4d76dff0e0e4d522aaad490f6d53f5866571a2eb3252b7296e499de0a96702a67', 12, 1, 'influencer', '[]', 0, '2020-01-02 00:52:57', '2020-01-02 00:52:57', '2021-01-02 08:52:57'),
('cb4ad87139437228c1803f24f3fdc50d8abbf6b0d1d38d8a8658c2fd6b88d054a33b8eec6b21a53d', 1, 1, 'influencer', '[]', 0, '2020-04-28 04:07:00', '2020-04-28 04:07:00', '2021-04-28 12:07:00'),
('cced7d1e2e2efc74fc2194e1c806487ed3d4075022aea2074e6618822931b67ac1c1b3a41b1280b5', 11, 1, 'influencer', '[]', 0, '2019-12-18 05:48:13', '2019-12-18 05:48:13', '2020-12-18 13:48:13'),
('cd04d686b7d215182c814d671ba3f00becc92a8f8243961517189b4ef88442a2f80f9acc8c26e0ff', 1, 1, 'influencer', '[]', 0, '2019-09-26 00:16:05', '2019-09-26 00:16:05', '2020-09-26 08:16:05'),
('cd8ec71891fd3a4bd34dbac041c74589860df8319fea5f4c99bba88fc1f3fe353d3a380adafd572b', 1, 1, 'tapads', '[]', 0, '2020-03-11 08:52:02', '2020-03-11 08:52:02', '2021-03-11 16:52:02'),
('cda9dd8e4dc40dae6237bcd1c0fcbb052c66edc607d7d78b00fe1c4b1d9e4f1443034d7aa38c539f', 12, 1, 'influencer', '[]', 0, '2020-01-30 01:56:32', '2020-01-30 01:56:32', '2021-01-30 09:56:32'),
('d143b02994d91768fec318b7277630500907bc654dd80e0eba86d846df7687bce6a09a7dd0bffb21', 1, 1, 'influencer', '[]', 0, '2020-02-06 06:26:16', '2020-02-06 06:26:16', '2021-02-06 14:26:16'),
('d19661e90386ab0a72fcb9f82c5c8ca883a4a32429d6f3e5cdaa2453abe75bf1ae6338e9daeb3f67', 40, 1, 'influencerToken', '[]', 1, '2019-10-24 10:46:01', '2019-10-24 10:46:01', '2020-10-24 18:46:01'),
('d2760572e0abfc4119705d0efae9e987b857fabe52824014640cd0a29dd7b2c2bba91372ad2df3ad', 8, 1, 'influencer', '[]', 0, '2019-12-18 02:20:46', '2019-12-18 02:20:46', '2020-12-18 10:20:46'),
('d2a30f7722d098a45bd137e081816ee992711456ccc74ff051080ad8a94d6eeab05512f452bc3690', 33, 1, 'tapads', '[]', 1, '2019-10-18 05:34:00', '2019-10-18 05:34:00', '2020-10-18 13:34:00'),
('d428bd80291621a2b79c62caecdd5d9991c87e4a6f4f34532f7f402629d82c64c407c6d48fd144e8', 6, 1, 'tapads', '[]', 0, '2020-01-07 06:12:45', '2020-01-07 06:12:45', '2021-01-07 14:12:45'),
('d42fc1e7e59be414162e82a6d7899e2c5be7321f39ebb00bf4e6a725f484e40a5560800451ba4ef5', 1, 1, 'tapads', '[]', 0, '2020-02-20 07:50:44', '2020-02-20 07:50:44', '2021-02-20 15:50:44'),
('d490626875660fc9967524f7a63ce2167d56c0b12de3a09dd8364281e0274aaf474808900912e566', 1, 1, 'influencerToken', '[]', 0, '2019-10-22 09:04:40', '2019-10-22 09:04:40', '2020-10-22 17:04:40'),
('d4e95e8eb28341a59cc042ff72ccdaab717cc82b619c5659cc7192249530c5f63d9ce2cd73f09977', 1, 1, 'influencer', '[]', 0, '2020-05-27 06:05:19', '2020-05-27 06:05:19', '2021-05-27 14:05:19'),
('d53b2b43f416f6635a52393c200bf2c95b30a52beaf561343dd8fb20e55cabeea5105f01a1b06524', 1, 1, 'influencer', '[]', 0, '2019-09-25 18:46:55', '2019-09-25 18:46:55', '2020-09-26 02:46:55'),
('d5c1e5a67f5c6f4e6d3dbda3e390f46cc99fb31c4a5f53d0295d4127a06d21a5fc4d61200e19aa4d', 1, 1, 'influencer', '[]', 0, '2020-03-05 13:03:28', '2020-03-05 13:03:28', '2021-03-05 21:03:28'),
('d5f2b3b72ebe88669a9ee9b9044fecfa158d00167e88248c7969f5be56dd988ee64843101ec5f2d2', 1, 1, 'influencer', '[]', 0, '2019-11-22 01:10:58', '2019-11-22 01:10:58', '2020-11-22 09:10:58'),
('d77154c66e339d72b9241cf15c400600463e1c7704d26ce25a59ec55abb7452cafa607b2f5e1eaef', 17, 1, 'tapads', '[]', 0, '2019-10-16 07:02:13', '2019-10-16 07:02:13', '2020-10-16 15:02:13'),
('d89a7561f5dd26b58e1ebf4aa6b7c15fa1202f7379b576e5f58e4b202cf63a1347b5e8e83b7cded2', 1, 1, 'influencer', '[]', 0, '2019-11-27 09:16:10', '2019-11-27 09:16:10', '2020-11-27 17:16:10'),
('d8b6dcc1fa04c0d010c2f01b5cd1ec7a4fdf23133126670a76eb9328824fc182560d14b1b25739c4', 43, 1, 'influencerToken', '[]', 0, '2019-11-08 03:48:25', '2019-11-08 03:48:25', '2020-11-08 11:48:25'),
('d8f517030c2aa7ece44480e6054f8ef82adbbefc7e93e1e6ff68603fcb6f3ca55829a35d665275b7', 1, 1, 'influencer', '[]', 0, '2019-10-14 03:52:24', '2019-10-14 03:52:24', '2020-10-14 11:52:24'),
('d952e05e00d8b57072a77b24a4555b1decb695e93c610a3c38504729cff7cd3fe24007914b8e1220', 12, 1, 'influencer', '[]', 0, '2020-01-30 07:04:36', '2020-01-30 07:04:36', '2021-01-30 15:04:36'),
('d95ea4b0d1af690db7d82e4dd3705343341068b538e0cbd81d7a5697dd8a87cabd6bececd61e303d', 1, 1, 'tapads', '[]', 0, '2020-03-09 07:07:20', '2020-03-09 07:07:20', '2021-03-09 15:07:20'),
('d97831a88df50169784d0091adeb5f82d605348cd0e34b6c1591d304d4d08818d9519d86cc21c4a4', 1, 1, 'influencer', '[]', 0, '2020-03-30 12:49:32', '2020-03-30 12:49:32', '2021-03-30 20:49:32'),
('d9972e17e628bcd9da7de4c42b370a49e5043fdc891a0fc094639a2cd5b931f314a7982947a1518a', 1, 1, 'influencer', '[]', 0, '2019-09-23 23:27:17', '2019-09-23 23:27:17', '2020-09-24 07:27:17'),
('d9d1199b54d49302461e1f246be623e9b1d6d86d0fb41d47f1f82cfcb08a007c0f75de21071a37b7', 10, 1, 'influencer', '[]', 0, '2019-12-18 03:29:06', '2019-12-18 03:29:06', '2020-12-18 11:29:06'),
('da3253eca43a5102d1a32ed2aca1eed286b2079c82d58b4c83984044e7e2ee9f58afe3fa273af2a3', 1, 1, 'influencer', '[]', 0, '2020-05-10 15:25:46', '2020-05-10 15:25:46', '2021-05-10 23:25:46'),
('dabf73a7d326f24c1b4b9f9369fafa4ed302d765b585152e742a31ffe73b7c2b718c8e1af3ca2f36', 2, 1, 'tapads', '[]', 0, '2019-11-27 13:10:49', '2019-11-27 13:10:49', '2020-11-27 21:10:49'),
('dc0bd62b8689c076e7f00974f9ec02976798a97c8aa12efcc3fad1411e747e1f5432ac71a5a2efbe', 1, 1, 'influencer', '[]', 0, '2019-11-20 01:36:16', '2019-11-20 01:36:16', '2020-11-20 09:36:16'),
('dc8b08ad3275422f17b1ac360124f2513257aa179b5a7e828463c310776b63f5eb851ad725d3065d', 1, 1, 'influencer', '[]', 0, '2019-11-21 01:05:15', '2019-11-21 01:05:15', '2020-11-21 09:05:15'),
('dcd3fe7de6d7fa0bfdc53e150b926aa36c46858dbb5617f5a9aefa7bffedf565b6fd7a3da38130c4', 1, 1, 'influencer', '[]', 0, '2020-02-18 03:03:57', '2020-02-18 03:03:57', '2021-02-18 11:03:57'),
('dd4df32b0938d2cb4a23cbba2caf011be1861824aa350918b89bd51d609ea4f4c45e0a61e1c8f784', 1, 1, 'influencer', '[]', 0, '2019-09-25 20:05:28', '2019-09-25 20:05:28', '2020-09-26 04:05:28'),
('dd7d26b5f0b2112b44e2bca7e3ce9ceadf8c3d4200c1a20be018a270e99dfed6c707a3165cd275e7', 1, 1, 'influencer', '[]', 0, '2019-12-02 02:19:52', '2019-12-02 02:19:52', '2020-12-02 10:19:52'),
('ddc8687fe1db2e6708848cd6d31258c8da87a8796d8be989700cf3bb178a07b54f1b3cf793a533be', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:07:14', '2019-09-25 19:07:14', '2020-09-26 03:07:14'),
('ddeb7fa714ab2929ec5ba99aa8f35ca2a0951fa3c9a95b6e08b7c9d1d39577bfb6ade620c0815846', 11, 1, 'influencer', '[]', 0, '2019-12-18 05:48:21', '2019-12-18 05:48:21', '2020-12-18 13:48:21'),
('def70dd0ca46b57db54fc21982c2162ddc789831a6b94d57fc7eba1903c58533c6fe57b6a1b59b23', 1, 1, 'influencerToken', '[]', 0, '2019-11-28 23:00:28', '2019-11-28 23:00:28', '2020-11-29 07:00:28'),
('df2129f7f9e05e216a4df8cb6744428261063b1b32d11280cad179ee31442d6646428d941d896561', 1, 1, 'influencer', '[]', 0, '2020-05-08 06:04:27', '2020-05-08 06:04:27', '2021-05-08 14:04:27'),
('e0e8d43d74d4c3d6892cfcfe26737ae2c09647f5027435a3fd8e580be35ba02a3844395298e1de06', 1, 1, 'influencer', '[]', 0, '2019-11-27 22:19:51', '2019-11-27 22:19:51', '2020-11-28 06:19:51'),
('e2aa8a092a83b46ea02e1aada660cf6b2c6be8fc81bce39510372f8448088d4b0830be75bcfbc5c7', 11, 1, 'influencer', '[]', 0, '2020-01-06 01:46:39', '2020-01-06 01:46:39', '2021-01-06 09:46:39'),
('e2eb5103a1a505b48398e5cc195f6ac1c0f78bfaadd347fdfd6748d4e9b8c24c8bed35f2dc217099', 1, 1, 'influencer', '[]', 0, '2020-03-29 14:44:41', '2020-03-29 14:44:41', '2021-03-29 22:44:41'),
('e3a9a5d4d9ed61ffae76e46c1a2b8970e4cfd765bda4dfc3b545dabf1b28307cbd7529d3c07faab2', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:04:48', '2019-09-25 19:04:48', '2020-09-26 03:04:48'),
('e3de00b27fa8f13752b79aefb1b840aed7dcb43c2934a626b0d46f02b6c8acafeef5760e5ab21c57', 1, 1, 'tapads', '[]', 0, '2020-02-20 08:03:50', '2020-02-20 08:03:50', '2021-02-20 16:03:50'),
('e3f5c9f6760a4a1d0e9ce58babbae68a87a8bcf9768db5514ac5b1ce77d98c146f455263f13d8fc2', 11, 1, 'influencer', '[]', 0, '2019-12-18 06:01:59', '2019-12-18 06:01:59', '2020-12-18 14:01:59'),
('e451919a80f5fff6f8b9a4e1706238c939b98baec4d8caa62ac5a23dd861eadcb6d7f480ad61fd19', 12, 1, 'tapads', '[]', 0, '2019-10-16 06:52:08', '2019-10-16 06:52:08', '2020-10-16 14:52:08'),
('e49a81d24703c9c033ba524ffe90c8ba2b400a4e6b9e07d67f6197b10209f9e4a5bc2c6aa3938230', 1, 1, 'influencerToken', '[]', 0, '2019-10-24 01:15:15', '2019-10-24 01:15:15', '2020-10-24 09:15:15'),
('e600e98ea974e8b0590c5573ffd2bcdf216d1c4476c90152a08fda0818c2b3b85501d23bfd8f165f', 1, 1, 'influencer', '[]', 0, '2019-10-09 17:57:55', '2019-10-09 17:57:55', '2020-10-10 01:57:55'),
('e68b3b03089d0a246795a77dbb7d1962fc85908362cba4a89baaee0cb2c873859b28206d00fb3563', 1, 1, 'influencer', '[]', 0, '2019-10-02 21:48:39', '2019-10-02 21:48:39', '2020-10-03 05:48:39'),
('e6e4d7f659056cdaee9d1c30ef21b68922caf93e1e09253c2ca8ebdb0b96ba82dd5b3b4a961c1b44', 3, 1, 'tapads', '[]', 1, '2019-11-27 13:38:56', '2019-11-27 13:38:56', '2020-11-27 21:38:56'),
('e7d27e87f5a665dbc2dfa0a14e6893a0e6b44350a63b6ce41c1c846e374c29cdad482ff517ae3997', 1, 1, 'influencerToken', '[]', 1, '2019-10-18 05:10:30', '2019-10-18 05:10:30', '2020-10-18 13:10:30'),
('e8d1b519478ece7f83a8cc771fa3952206c6efc18d69b5bc43aa10002f721222f53b6f8da3e4e96d', 12, 1, 'influencer', '[]', 0, '2020-01-13 12:16:10', '2020-01-13 12:16:10', '2021-01-13 20:16:10'),
('e90b5959ad5af6bfbe272c5e867af75b5861a6e9ba99693369b52792e41e698cdaaf299f665f1f22', 1, 1, 'influencer', '[]', 0, '2019-10-16 01:54:18', '2019-10-16 01:54:18', '2020-10-16 09:54:18'),
('e95885b6cd26506dc4c8c9751f7614b7a80112cfb3f4b341378b16212483cf8f1209d6f80acdf625', 1, 1, 'influencer', '[]', 0, '2020-04-26 06:31:05', '2020-04-26 06:31:05', '2021-04-26 14:31:05'),
('e9746e09b76585cfb9c9f11a50e7ad46fc30bd5fe208521d29055b498a70fd2435dd695597a9a9a9', 11, 1, 'influencer', '[]', 0, '2020-01-09 01:56:43', '2020-01-09 01:56:43', '2021-01-09 09:56:43'),
('e98aaef54e681b44e42572faaf7619f9a400fb1c08645fe4052acd07c754e1332494bbf7d13f5ade', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:56:08', '2019-09-25 19:56:08', '2020-09-26 03:56:08'),
('e9d4a991aa99367f6012dd22b484b16e653c4a61d3e9a737c1e54010351530f916db8fbb4728c8e3', 3, 1, 'tapads', '[]', 0, '2020-01-02 10:29:42', '2020-01-02 10:29:42', '2021-01-02 18:29:42'),
('ea7abeae0d02c130b34642623057668916159773f21d4b876491d9810342b90d5bc68de594f4e14f', 1, 1, 'influencer', '[]', 0, '2019-12-09 15:48:41', '2019-12-09 15:48:41', '2020-12-09 23:48:41'),
('ea96fb68cdde99959612e307629f4adb15bc467f5137d8aa1e45148171f6301254da5162659c6200', 40, 1, 'tapads', '[]', 1, '2019-10-24 02:06:13', '2019-10-24 02:06:13', '2020-10-24 10:06:13'),
('eac73f0085e5e904b38a6f99258ab2ba4742baa69c7e5aaf1b6de7a811ebe237cc974c83e0a7dffc', 12, 1, 'influencer', '[]', 0, '2020-01-03 02:55:01', '2020-01-03 02:55:01', '2021-01-03 10:55:01'),
('ec3e4cd216c36c1cbc09bed0463a4d8151e8fb02798ea7f158273e11fb524c593e726fc7b60ede34', 12, 1, 'influencer', '[]', 0, '2020-01-27 10:42:25', '2020-01-27 10:42:25', '2021-01-27 18:42:25'),
('ee68e71a6e8337485df8ee25887a38ad13391da86dcba0095df97ba2d1afa9dd9622c42214713d5a', 12, 1, 'influencer', '[]', 0, '2020-01-10 01:44:00', '2020-01-10 01:44:00', '2021-01-10 09:44:00'),
('eeb9f6bd40caa1270d5b6392ca03ce9bd925fc771f7bae259d77d6e7f88f1114e92fedbb63c1827b', 1, 1, 'influencerToken', '[]', 0, '2019-12-03 12:52:43', '2019-12-03 12:52:43', '2020-12-03 20:52:43'),
('f0eadc87117d319dcf0d484ec6b39d563a65520546c7e3b3818b1a73b4ec485ffd4d7d6efe8e1e9e', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:06:38', '2019-09-25 19:06:38', '2020-09-26 03:06:38'),
('f15099bf4eee84656f1f689a603325236dd6f841278c86c5549d48cbe37a24fbe036088fd3842dc9', 12, 1, 'influencer', '[]', 0, '2020-01-30 12:04:56', '2020-01-30 12:04:56', '2021-01-30 20:04:56'),
('f1b00913d19d83e1b72b14d272bafb9b7a5a3111fafc97dacbfde947d65b07c3c704282166f79863', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:56:39', '2019-09-25 19:56:39', '2020-09-26 03:56:39'),
('f389d12a3efc775435c26b2f54b8453ac9253db678a3c608384d821913a41a691964862b5693a54b', 1, 1, 'influencer', '[]', 0, '2019-11-12 01:12:00', '2019-11-12 01:12:00', '2020-11-12 09:12:00'),
('f3f01c5228dcf1f4a9fa239180519c037443eaded13591df8e81fdde6f342f5569729a3afa70b383', 41, 1, 'influencerToken', '[]', 1, '2019-10-24 10:46:33', '2019-10-24 10:46:33', '2020-10-24 18:46:33'),
('f454c2b43dca7e2eff75be2f0c1f36908714d02b4fd19a483612cbdc93f2dc8b0f6942f684279e8d', 12, 1, 'influencer', '[]', 0, '2020-01-24 08:14:12', '2020-01-24 08:14:12', '2021-01-24 16:14:12'),
('f468f6aac3dc35e33943eb82b904f4f701bfd8e308ed30fb5cf2ae6768da897e31e3b0dd0863a6b1', 1, 1, 'influencerToken', '[]', 0, '2019-12-09 02:58:38', '2019-12-09 02:58:38', '2020-12-09 10:58:38'),
('f485b0da9f930d056f47d9836cefc070333150eb64db09ba383caf8bc0de2d2267e873b90ae498cb', 35, 1, 'influencerToken', '[]', 0, '2019-10-23 08:19:55', '2019-10-23 08:19:55', '2020-10-23 16:19:55'),
('f598b4df837da65593c8f014583faec51eda0a737b744a22466da478a05c27d5380c8c99cd3965dd', 1, 1, 'influencerToken', '[]', 1, '2019-12-05 11:03:01', '2019-12-05 11:03:01', '2020-12-05 19:03:01'),
('f6398981965f742b7eadb71f11bb067c251bb028081178c077489b415ee1167203fc078516e6a77b', 1, 1, 'influencer', '[]', 0, '2019-10-03 18:00:14', '2019-10-03 18:00:14', '2020-10-04 02:00:14'),
('f6e01be72a3cb548a69affcfccef219a652a9a954c9d9c9d22020689207ee70d34225e05500655e3', 40, 1, 'influencerToken', '[]', 0, '2019-11-08 06:53:23', '2019-11-08 06:53:23', '2020-11-08 14:53:23'),
('f74149585200629cf1563c0880a1a55096006bf69575da9c96fb18d1d1dfddd1e655d6e857fb82e1', 1, 1, 'influencer', '[]', 0, '2020-05-03 00:48:29', '2020-05-03 00:48:29', '2021-05-03 08:48:29'),
('f78222fae89917ddaefd5b1b8e05e69446b7f846118b9b0b870613cb8c26eb6dd521d1e038a4277a', 8, 1, 'tapads', '[]', 0, '2019-10-16 03:37:36', '2019-10-16 03:37:36', '2020-10-16 11:37:36'),
('f8231efce2d37d003be8201b4bd63fe5735ea4715a453524fb333e18b33a7556dd29cd9ad196314a', 1, 1, 'tapads', '[]', 0, '2020-02-13 07:40:19', '2020-02-13 07:40:19', '2021-02-13 15:40:19'),
('f8b6e62525a67c8ac17c08fb29adb94267712b4650ba74a905563afca847478e94ecbbdb272976d6', 1, 1, 'influencer', '[]', 0, '2019-09-25 19:56:10', '2019-09-25 19:56:10', '2020-09-26 03:56:10'),
('f9ffbd1f397f61eaefb09d62f861aea92ed30395873986ab9cdfb3f88ade4a7e14fd68e5c3ecad55', 1, 1, 'tapads', '[]', 0, '2020-02-24 02:17:05', '2020-02-24 02:17:05', '2021-02-24 10:17:05'),
('fa943b17a26819c1769cb4367547d72d1a223357250d94ad69ebd7a8b8fde23080fd74c38e7284e6', 12, 1, 'influencer', '[]', 0, '2020-01-02 00:52:16', '2020-01-02 00:52:16', '2021-01-02 08:52:16'),
('faa2ac8856f898da0a8357ce260d56763fa1be6ab19fd7d251ada62e253d701db630b19f0a8792b9', 1, 1, 'influencer', '[]', 0, '2020-05-26 13:58:27', '2020-05-26 13:58:27', '2021-05-26 21:58:27'),
('fae7efd9145ccc79b66187162e72528594d5c523a002c168479f547126eeb157dff5098097e33536', 1, 1, 'tapads', '[]', 0, '2020-03-06 06:03:05', '2020-03-06 06:03:05', '2021-03-06 14:03:05'),
('fb2ad027bec517d1c851240b9baf63472d21198a5b13be36558e2c5c6c243c985800731379a1fcd4', 1, 1, 'influencer', '[]', 0, '2019-10-14 06:04:40', '2019-10-14 06:04:40', '2020-10-14 14:04:40'),
('fb5e4f1edff18d793ad3745ccd55074ad14bbb4da391339044889112d543ed8fe7af1275cd29f209', 12, 1, 'influencer', '[]', 0, '2020-01-02 00:52:05', '2020-01-02 00:52:05', '2021-01-02 08:52:05'),
('fb6de17b59aafaa1a8f9ad287037e92c87ee0b6b4eec082c73ec2bab9ac2f0682f697cef287cb9e5', 1, 1, 'influencer', '[]', 0, '2020-07-01 20:57:39', '2020-07-01 20:57:39', '2021-07-02 04:57:39'),
('fb7270599f9cf06340a771696fb4c827cfc8bdfd18d7a0ce702c54527263cadeceba12d23c876365', 1, 1, 'influencer', '[]', 0, '2020-05-26 01:01:28', '2020-05-26 01:01:28', '2021-05-26 09:01:28'),
('fb7f44f890ea0a0dc6aa6ba15803314c01fbef97fbdba19ebc82b30a541e4095ab24f97583badf41', 1, 1, 'influencerToken', '[]', 0, '2019-10-18 01:41:47', '2019-10-18 01:41:47', '2020-10-18 09:41:47'),
('fc8fe01fe0b3aab4869b55b5d5b585438a13c48de7cb318d8387334192106cee4b572f1413dddd68', 1, 1, 'influencer', '[]', 0, '2020-03-06 01:53:22', '2020-03-06 01:53:22', '2021-03-06 09:53:22'),
('fcc17cf984d2db66c0b385eb6ad5b55d000cd41e8d2d39f2b668561b315ecf445ddbbff8a858181e', 1, 1, 'influencer', '[]', 0, '2019-09-25 01:48:33', '2019-09-25 01:48:33', '2020-09-25 09:48:33'),
('fcde8883104595f339bd867646c03be95f3304eb75dfac1bd912c8518b2f748a7ccfb219c55fba68', 1, 1, 'tapads', '[]', 0, '2020-02-26 06:38:50', '2020-02-26 06:38:50', '2021-02-26 14:38:50'),
('fce1972bd39a7625636462d96d1e437fde69c8272aee07894dca7936d580eb75125ba9c790fb0bb8', 1, 1, 'influencer', '[]', 0, '2019-11-11 10:17:47', '2019-11-11 10:17:47', '2020-11-11 18:17:47'),
('fdf35edf4caf324e31cb58cb3f6f716dff6ee214b9dd755025cf7abb66820cb69c3d8bcdd3dd687e', 1, 1, 'influencer', '[]', 0, '2020-04-09 14:12:39', '2020-04-09 14:12:39', '2021-04-09 22:12:39'),
('ff0ab57c145e474a9c8a65a2ebad00f2133d343699cb853b4943190644e83cab7a884ff3d1cb6fcd', 5, 1, 'tapads', '[]', 0, '2020-01-02 10:31:40', '2020-01-02 10:31:40', '2021-01-02 18:31:40'),
('ff262a81f48e0cfb51491a3de4827364b138d3b598b67c1d624bbfbaca37d77525baa1e74a7487fb', 1, 1, 'tapads', '[]', 0, '2020-01-27 10:28:32', '2020-01-27 10:28:32', '2021-01-27 18:28:32');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', '1edByvgJUSoiweR6ly0KY7He2gxyBVRAUFd8Hy5W', 'http://localhost', 1, 0, 0, '2019-09-23 02:35:13', '2019-09-23 02:35:13'),
(2, NULL, 'Laravel Password Grant Client', '421MNYiDuYEZbOlSXUbJBClF2o3W6UVU0yRErO9t', 'http://localhost', 0, 1, 0, '2019-09-23 02:35:13', '2019-09-23 02:35:13');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2019-09-23 02:35:13', '2019-09-23 02:35:13');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `social_media_id` int(11) NOT NULL,
  `user_sm_campaign_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `media_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ' ',
  `caption` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `tags` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_id` int(11) NOT NULL,
  `status` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `version` int(11) NOT NULL DEFAULT '0',
  `post_origin_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post_engagement`
--

CREATE TABLE `post_engagement` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_campaign_id` int(11) NOT NULL,
  `likes` int(11) NOT NULL,
  `comments` int(11) NOT NULL,
  `shares` int(11) NOT NULL,
  `views` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `post_online`
--

CREATE TABLE `post_online` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `sma_type` int(1) NOT NULL,
  `sma` varchar(50) NOT NULL,
  `online_user_id` varchar(100) NOT NULL,
  `online_user_photo` text NOT NULL,
  `online_user_name` varchar(150) NOT NULL,
  `online_post_id` varchar(100) NOT NULL,
  `online_post_caption` text NOT NULL,
  `online_post_media` text NOT NULL,
  `online_post_likes` int(11) NOT NULL,
  `online_post_comments` int(11) NOT NULL,
  `online_post_shares` int(11) NOT NULL,
  `online_post_timestamp` varchar(200) NOT NULL,
  `online_post_permalink` text NOT NULL,
  `isFeatured` int(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `post_online`
--

INSERT INTO `post_online` (`id`, `post_id`, `campaign_id`, `user_id`, `client_id`, `sma_type`, `sma`, `online_user_id`, `online_user_photo`, `online_user_name`, `online_post_id`, `online_post_caption`, `online_post_media`, `online_post_likes`, `online_post_comments`, `online_post_shares`, `online_post_timestamp`, `online_post_permalink`, `isFeatured`, `created_at`, `updated_at`) VALUES
(14, 31, 4, 56, 1, 0, 'facebook', '103343797878120', 'https://scontent.fmnl17-1.fna.fbcdn.net/v/t1.0-1/cp0/p50x50/83518199_104082261137607_7630149485997326336_o.png?_nc_cat=101&_nc_sid=dbb9e7&_nc_ohc=DFwXob-vNCYAX-1TOmS&_nc_ht=scontent.fmnl17-1.fna&oh=e8cae7781e9d20766069d98627306cb6&oe=5EF487C5', 'ukaynikikay21', '103343797878120_135878337957999', 'Bili na po mura lang ?', 'https://scontent.fmnl8-1.fna.fbcdn.net/v/t1.0-9/s720x720/89371359_135878301291336_1045345106556616704_n.jpg?_nc_cat=104&_nc_sid=110474&_nc_ohc=jMd_bra4iXAAX-ngkAS&_nc_ht=scontent.fmnl8-1.fna&_nc_tp=7&oh=376b7361b9300f5ebb57713a49212b26&oe=5EF2B4BA', 1, 0, 0, '2020-03-07T14:25:07+0000', 'https://www.facebook.com/103343797878120/posts/135878337957999/', 1, '2020-05-28 07:50:53', '2020-05-28 10:37:21');

-- --------------------------------------------------------

--
-- Table structure for table `post_sma`
--

CREATE TABLE `post_sma` (
  `id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `sma_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `reportproblem`
--

CREATE TABLE `reportproblem` (
  `id` int(11) NOT NULL,
  `subject` varchar(200) DEFAULT NULL,
  `title` text,
  `email` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reportproblem`
--

INSERT INTO `reportproblem` (`id`, `subject`, `title`, `email`, `message`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, 'asdasdasdsad', 'asdasdsad', '2020-01-27 18:30:41', '2020-01-27 18:30:41'),
(2, NULL, NULL, 'asdasdsadsad', 'wdsawdasdwdasdada sada sd as', '2020-01-27 18:31:38', '2020-01-27 18:31:38'),
(3, NULL, NULL, 'asdasdasd', 'sdsadasdsadsad das asd sad da', '2020-01-27 18:39:51', '2020-01-27 18:39:51'),
(4, NULL, NULL, 'asdasdas', 'dasdasdasdsd', '2020-01-27 18:40:27', '2020-01-27 18:40:27'),
(5, NULL, NULL, 'asdasdsad', 'sadsadsads', '2020-01-27 18:41:01', '2020-01-27 18:41:01'),
(6, 'General Enquiry', 'testing title', 'eric@eric.com', 'thedsf asdfD ASDF', '2020-03-20 15:22:10', '2020-03-20 15:22:10'),
(7, 'General Enquiry', 'testing title', 'eric@eric.com', 'thedsf asdfD ASDF', '2020-03-20 15:23:04', '2020-03-20 15:23:04');

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` int(11) NOT NULL,
  `description` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`id`, `description`) VALUES
(1, 'Accounting/ Finance'),
(2, 'Administrative'),
(3, 'Arts & Creative'),
(4, 'Beauty & Wellness'),
(5, 'Building/ Construction'),
(6, 'Cleaning/ Housekeeping'),
(7, 'Customer Service/ Receptionists'),
(8, 'Drivers/ Riders/ Delivery'),
(9, 'Data Entry & Survey'),
(10, 'Education/ Training'),
(11, 'Engineering'),
(12, 'Flyer Distribution'),
(13, 'Hospitality/ F&B'),
(14, 'Human Resources'),
(15, 'Information Technology'),
(16, 'Manufacturing'),
(17, 'Nursing/ Health Care'),
(18, 'Sales/ Retail/ Marketing'),
(19, 'Security'),
(20, 'Part Time/ Roadshows/ Events'),
(21, 'Warehousing & Logistics');

-- --------------------------------------------------------

--
-- Table structure for table `social_media`
--

CREATE TABLE `social_media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_id` int(11) DEFAULT NULL,
  `gender` int(11) NOT NULL,
  `followers` int(11) NOT NULL,
  `age_from` int(11) NOT NULL,
  `age_to` int(11) NOT NULL,
  `deadline` datetime NOT NULL,
  `duration_from` date NOT NULL,
  `duration_to` date NOT NULL,
  `currency_id` int(11) NOT NULL,
  `total_budget` decimal(12,2) NOT NULL,
  `collaborator_count` int(11) NOT NULL,
  `collaborator_budget` decimal(12,2) NOT NULL,
  `engagement_budget` decimal(12,2) NOT NULL,
  `basic_pay` decimal(12,2) NOT NULL,
  `status_id` int(11) DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `social_media_budget`
--

CREATE TABLE `social_media_budget` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `social_media_id` int(11) NOT NULL,
  `engagement` int(11) NOT NULL,
  `min` int(11) NOT NULL,
  `max` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `per_unit` decimal(12,2) NOT NULL,
  `cost` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `social_media_category`
--

CREATE TABLE `social_media_category` (
  `id` int(11) NOT NULL,
  `social_media_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `description` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `social_media_sma`
--

CREATE TABLE `social_media_sma` (
  `id` int(11) NOT NULL,
  `social_media_id` int(11) NOT NULL,
  `sm_id` int(11) NOT NULL,
  `sm_description` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `social_media_tags`
--

CREATE TABLE `social_media_tags` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `social_media_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `caption` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `source` int(11) NOT NULL,
  `source_id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `remarks` text,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id`, `type`, `source`, `source_id`, `status`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 'POSTED', NULL, '2020-01-02 09:26:46', '2020-01-02 09:26:46'),
(2, 1, 1, 1, 'INTERESTED', NULL, '2020-01-03 09:05:32', '2020-01-03 09:05:32'),
(3, 1, 1, 1, 'PENDING', NULL, '2020-01-03 09:08:03', '2020-01-03 09:08:03'),
(4, 1, 4, 1, 'PENDING', NULL, '2020-01-03 09:08:03', '2020-01-03 09:08:03'),
(5, 1, 2, 1, 'POSTED', '', '2020-01-03 15:33:01', '2020-01-03 15:33:01'),
(6, 1, 1, 1, 'PENDING', NULL, '2020-01-03 18:07:03', '2020-01-03 18:07:03'),
(7, 1, 4, 2, 'PENDING', NULL, '2020-01-03 18:07:03', '2020-01-03 18:07:03'),
(8, 1, 1, 1, 'PENDING', NULL, '2020-01-07 14:13:08', '2020-01-07 14:13:08'),
(9, 1, 4, 3, 'PENDING', NULL, '2020-01-07 14:13:08', '2020-01-07 14:13:08'),
(10, 1, 1, 2, 'POSTED', NULL, '2020-01-08 15:04:08', '2020-01-08 15:04:08'),
(11, 1, 1, 2, 'PENDING', NULL, '2020-01-08 15:04:44', '2020-01-08 15:04:44'),
(12, 1, 4, 4, 'PENDING', NULL, '2020-01-08 15:04:44', '2020-01-08 15:04:44'),
(13, 1, 2, 2, 'POSTED', '', '2020-01-14 16:19:45', '2020-01-14 16:19:45'),
(14, 1, 2, 3, 'POSTED', '', '2020-01-14 16:20:10', '2020-01-14 16:20:10'),
(15, 1, 2, 4, 'POSTED', '', '2020-01-14 16:22:17', '2020-01-14 16:22:17'),
(16, 1, 2, 1, 'POSTED', '', '2020-01-15 10:57:11', '2020-01-15 10:57:11'),
(17, 3, 1, 1, 'PENDING', NULL, '2020-01-20 10:38:20', '2020-01-20 10:38:20'),
(18, 1, 1, 1, 'POSTED', NULL, '2020-01-22 10:50:14', '2020-01-22 10:50:14'),
(19, 1, 2, 2, 'POSTED', '', '2020-01-23 10:02:43', '2020-01-23 10:02:43'),
(20, 1, 2, 3, 'POSTED', '', '2020-01-23 10:10:32', '2020-01-23 10:10:32'),
(21, 1, 2, 4, 'POSTED', '', '2020-01-23 10:10:51', '2020-01-23 10:10:51'),
(22, 1, 2, 5, 'POSTED', '', '2020-01-23 10:13:34', '2020-01-23 10:13:34'),
(23, 1, 2, 6, 'POSTED', '', '2020-01-23 10:17:25', '2020-01-23 10:17:25'),
(24, 1, 2, 7, 'POSTED', '', '2020-01-23 10:19:51', '2020-01-23 10:19:51'),
(25, 1, 2, 8, 'POSTED', '', '2020-01-23 10:22:54', '2020-01-23 10:22:54'),
(26, 1, 2, 9, 'POSTED', '', '2020-01-23 10:23:21', '2020-01-23 10:23:21'),
(27, 1, 2, 10, 'POSTED', '', '2020-01-23 10:23:52', '2020-01-23 10:23:52'),
(28, 1, 2, 11, 'POSTED', '', '2020-01-23 10:26:58', '2020-01-23 10:26:58'),
(29, 1, 2, 12, 'POSTED', '', '2020-01-23 10:34:48', '2020-01-23 10:34:48'),
(30, 1, 2, 13, 'POSTED', '', '2020-01-23 10:35:05', '2020-01-23 10:35:05'),
(31, 1, 2, 14, 'POSTED', '', '2020-01-23 10:36:37', '2020-01-23 10:36:37'),
(32, 1, 2, 15, 'POSTED', '', '2020-01-23 10:37:32', '2020-01-23 10:37:32'),
(33, 1, 2, 16, 'POSTED', '', '2020-01-23 10:44:24', '2020-01-23 10:44:24'),
(34, 1, 2, 17, 'POSTED', '', '2020-01-23 10:44:56', '2020-01-23 10:44:56'),
(35, 1, 2, 18, 'POSTED', '', '2020-01-23 10:46:06', '2020-01-23 10:46:06'),
(36, 1, 2, 19, 'POSTED', '', '2020-01-23 10:49:21', '2020-01-23 10:49:21'),
(37, 1, 2, 20, 'POSTED', '', '2020-01-23 10:53:06', '2020-01-23 10:53:06'),
(38, 1, 2, 21, 'POSTED', '', '2020-01-23 10:55:55', '2020-01-23 10:55:55'),
(39, 1, 2, 22, 'POSTED', '', '2020-01-23 11:00:12', '2020-01-23 11:00:12'),
(40, 1, 2, 23, 'POSTED', '', '2020-01-23 11:02:31', '2020-01-23 11:02:31'),
(41, 1, 2, 24, 'POSTED', '', '2020-01-23 11:12:09', '2020-01-23 11:12:09'),
(42, 1, 2, 25, 'POSTED', '', '2020-01-23 11:14:38', '2020-01-23 11:14:38'),
(43, 1, 2, 26, 'POSTED', '', '2020-01-23 11:16:05', '2020-01-23 11:16:05'),
(44, 1, 2, 27, 'POSTED', '', '2020-01-23 11:17:37', '2020-01-23 11:17:37'),
(45, 1, 2, 28, 'POSTED', '', '2020-01-23 11:19:45', '2020-01-23 11:19:45'),
(46, 1, 2, 1, 'POSTED', '', '2020-01-23 11:21:39', '2020-01-23 11:21:39'),
(47, 3, 1, 1, 'PENDING', NULL, '2020-01-23 11:23:03', '2020-01-23 11:23:03'),
(48, 1, 1, 1, 'PENDING', NULL, '2020-01-23 11:41:21', '2020-01-23 11:41:21'),
(49, 1, 4, 1, 'PENDING', NULL, '2020-01-23 11:41:21', '2020-01-23 11:41:21'),
(50, 1, 4, 1, 'APPROVED', NULL, '2020-01-23 12:31:24', '2020-01-23 12:31:24'),
(51, 3, 1, 1, 'ACCEPTED', NULL, '2020-01-23 12:35:32', '2020-01-23 12:35:32'),
(52, 3, 1, 1, 'REQUESTED', NULL, '2020-01-23 12:35:39', '2020-01-23 12:35:39'),
(53, 3, 1, 1, 'ACCEPTED', NULL, '2020-01-23 12:37:04', '2020-01-23 12:37:04'),
(54, 3, 1, 1, 'REQUESTED', NULL, '2020-01-23 12:37:06', '2020-01-23 12:37:06'),
(55, 3, 1, 1, 'ACCEPTED', NULL, '2020-01-23 12:37:08', '2020-01-23 12:37:08'),
(56, 3, 1, 1, 'REQUESTED', NULL, '2020-01-23 12:37:19', '2020-01-23 12:37:19'),
(57, 3, 1, 1, 'REJECTED', NULL, '2020-01-23 12:37:22', '2020-01-23 12:37:22'),
(58, 3, 1, 1, 'REQUESTED', NULL, '2020-01-23 12:37:28', '2020-01-23 12:37:28'),
(59, 3, 1, 1, 'ACCEPTED', NULL, '2020-01-23 12:38:48', '2020-01-23 12:38:48'),
(60, 3, 1, 1, 'REQUESTED', NULL, '2020-01-23 12:38:58', '2020-01-23 12:38:58'),
(61, 1, 4, 1, 'APPROVED', NULL, '2020-01-23 12:41:26', '2020-01-23 12:41:26'),
(62, 1, 2, 2, 'POSTED', '', '2020-01-29 15:08:42', '2020-01-29 15:08:42'),
(63, 1, 2, 3, 'POSTED', '', '2020-01-29 15:27:19', '2020-01-29 15:27:19'),
(64, 3, 1, 1, 'REJECTED', NULL, '2020-01-29 16:30:40', '2020-01-29 16:30:40'),
(65, 3, 1, 1, 'REQUESTED', NULL, '2020-01-29 16:34:40', '2020-01-29 16:34:40'),
(66, 3, 1, 1, 'ACCEPTED', NULL, '2020-01-29 16:34:42', '2020-01-29 16:34:42'),
(67, 3, 1, 1, 'REQUESTED', NULL, '2020-01-29 16:36:44', '2020-01-29 16:36:44'),
(68, 3, 1, 1, 'REJECTED', NULL, '2020-01-29 16:36:54', '2020-01-29 16:36:54'),
(69, 3, 1, 1, 'REQUESTED', NULL, '2020-01-29 16:36:57', '2020-01-29 16:36:57'),
(70, 3, 1, 1, 'ACCEPTED', NULL, '2020-01-29 16:37:10', '2020-01-29 16:37:10'),
(71, 3, 1, 1, 'REQUESTED', NULL, '2020-01-29 16:37:13', '2020-01-29 16:37:13'),
(72, 1, 1, 2, 'POSTED', NULL, '2020-01-29 18:00:05', '2020-01-29 18:00:05'),
(73, 1, 1, 3, 'POSTED', NULL, '2020-01-29 18:01:44', '2020-01-29 18:01:44'),
(74, 1, 1, 4, 'POSTED', NULL, '2020-01-29 18:06:21', '2020-01-29 18:06:21'),
(75, 1, 1, 1, 'POSTED', NULL, '2020-01-29 18:13:36', '2020-01-29 18:13:36'),
(76, 3, 1, 1, 'ACCEPTED', NULL, '2020-01-30 10:04:39', '2020-01-30 10:04:39'),
(77, 1, 4, 1, 'APPROVED', NULL, '2020-01-30 10:04:59', '2020-01-30 10:04:59'),
(78, 3, 1, 1, 'REQUESTED', NULL, '2020-01-30 10:25:16', '2020-01-30 10:25:16'),
(79, 3, 1, 1, 'ACCEPTED', NULL, '2020-01-30 10:42:36', '2020-01-30 10:42:36'),
(80, 3, 1, 1, 'REQUESTED', NULL, '2020-01-30 11:15:48', '2020-01-30 11:15:48'),
(81, 1, 4, 1, 'APPROVED', NULL, '2020-01-30 11:29:41', '2020-01-30 11:29:41'),
(82, 1, 4, 1, 'APPROVED', NULL, '2020-01-30 11:29:45', '2020-01-30 11:29:45'),
(83, 1, 4, 1, 'APPROVED', NULL, '2020-01-30 11:48:01', '2020-01-30 11:48:01'),
(84, 1, 4, 1, 'APPROVED', NULL, '2020-01-30 13:28:20', '2020-01-30 13:28:20'),
(85, 1, 4, 1, 'APPROVED', NULL, '2020-01-30 13:28:20', '2020-01-30 13:28:20'),
(86, 1, 4, 1, 'APPROVED', NULL, '2020-01-30 13:28:20', '2020-01-30 13:28:20'),
(87, 1, 4, 1, 'APPROVED', NULL, '2020-01-30 13:28:20', '2020-01-30 13:28:20'),
(88, 1, 4, 1, 'APPROVED', NULL, '2020-01-30 15:23:07', '2020-01-30 15:23:07'),
(89, 1, 2, 1, 'POSTED', '', '2020-02-03 09:51:30', '2020-02-03 09:51:30'),
(90, 1, 1, 1, 'POSTED', NULL, '2020-02-03 09:52:39', '2020-02-03 09:52:39'),
(91, 1, 1, 1, 'PENDING', NULL, '2020-02-03 09:53:15', '2020-02-03 09:53:15'),
(92, 1, 4, 1, 'PENDING', NULL, '2020-02-03 09:53:15', '2020-02-03 09:53:15'),
(93, 1, 4, 1, 'APPROVED', NULL, '2020-02-03 09:53:47', '2020-02-03 09:53:47'),
(94, 1, 4, 1, 'APPROVED', NULL, '2020-02-04 16:41:57', '2020-02-04 16:41:57'),
(95, 1, 1, 1, 'PENDING', NULL, '2020-02-04 17:11:04', '2020-02-04 17:11:04'),
(96, 1, 4, 2, 'PENDING', NULL, '2020-02-04 17:11:04', '2020-02-04 17:11:04'),
(97, 1, 1, 1, 'PENDING', NULL, '2020-02-12 12:23:35', '2020-02-12 12:23:35'),
(98, 1, 4, 3, 'PENDING', NULL, '2020-02-12 12:23:36', '2020-02-12 12:23:36'),
(99, 1, 1, 2, 'POSTED', NULL, '2020-02-19 16:46:12', '2020-02-19 16:46:12'),
(100, 1, 1, 2, 'INTERESTED', NULL, '2020-02-19 16:46:24', '2020-02-19 16:46:24'),
(101, 1, 1, 2, 'INTERESTED', NULL, '2020-02-20 14:50:42', '2020-02-20 14:50:42'),
(102, 1, 1, 2, 'INTERESTED', NULL, '2020-02-20 17:40:40', '2020-02-20 17:40:40'),
(103, 1, 1, 2, 'INTERESTED', NULL, '2020-02-20 17:53:05', '2020-02-20 17:53:05'),
(104, 1, 1, 2, 'INTERESTED', NULL, '2020-02-21 16:08:46', '2020-02-21 16:08:46'),
(105, 1, 1, 2, 'INTERESTED', NULL, '2020-02-24 09:18:10', '2020-02-24 09:18:10'),
(106, 1, 1, 2, 'INTERESTED', NULL, '2020-02-24 09:20:48', '2020-02-24 09:20:48'),
(107, 1, 1, 2, 'INTERESTED', NULL, '2020-02-24 09:27:07', '2020-02-24 09:27:07'),
(108, 1, 1, 2, 'INTERESTED', NULL, '2020-02-24 13:53:28', '2020-02-24 13:53:28'),
(109, 1, 1, 2, 'INTERESTED', NULL, '2020-02-24 16:21:51', '2020-02-24 16:21:51'),
(110, 1, 4, 1, 'PENDING', NULL, '2020-02-24 19:50:13', '2020-02-24 19:50:13'),
(111, 1, 4, 1, 'PENDING', NULL, '2020-02-24 19:52:02', '2020-02-24 19:52:02'),
(112, 1, 4, 1, 'PENDING', NULL, '2020-02-24 19:52:31', '2020-02-24 19:52:31'),
(113, 1, 4, 1, 'PENDING', NULL, '2020-02-24 19:53:25', '2020-02-24 19:53:25'),
(114, 1, 4, 1, 'CANCELLED', NULL, '2020-02-24 19:55:45', '2020-02-24 19:55:45'),
(115, 1, 4, 1, 'CANCELLED', NULL, '2020-02-24 19:56:29', '2020-02-24 19:56:29'),
(116, 1, 4, 2, 'CANCELLED', NULL, '2020-02-24 20:04:49', '2020-02-24 20:04:49'),
(117, 1, 4, 3, 'CANCELLED', NULL, '2020-02-24 20:05:30', '2020-02-24 20:05:30'),
(118, 1, 4, 1, 'CANCELLED', NULL, '2020-02-24 20:08:39', '2020-02-24 20:08:39'),
(119, 1, 4, 1, 'CANCELLED', NULL, '2020-02-24 20:09:43', '2020-02-24 20:09:43'),
(120, 1, 4, 1, 'CANCELLED', NULL, '2020-02-24 20:11:40', '2020-02-24 20:11:40'),
(121, 1, 4, 1, 'CANCELLED', NULL, '2020-02-24 20:24:35', '2020-02-24 20:24:35'),
(122, 1, 4, 2, 'CANCELLED', NULL, '2020-02-24 20:24:40', '2020-02-24 20:24:40'),
(123, 1, 4, 2, 'CANCELLED', NULL, '2020-02-24 20:25:53', '2020-02-24 20:25:53'),
(124, 1, 4, 2, 'CANCELLED', NULL, '2020-02-24 20:26:01', '2020-02-24 20:26:01'),
(125, 1, 4, 3, 'CANCELLED', NULL, '2020-02-24 20:27:34', '2020-02-24 20:27:34'),
(126, 1, 4, 1, 'CANCELLED', NULL, '2020-02-24 20:30:00', '2020-02-24 20:30:00'),
(127, 1, 4, 1, 'CANCELLED', NULL, '2020-02-24 20:32:40', '2020-02-24 20:32:40'),
(128, 1, 1, 1, 'PENDING', NULL, '2020-02-26 13:32:48', '2020-02-26 13:32:48'),
(129, 1, 4, 4, 'PENDING', NULL, '2020-02-26 13:32:49', '2020-02-26 13:32:49'),
(130, 1, 1, 1, 'PENDING', NULL, '2020-02-26 15:03:23', '2020-02-26 15:03:23'),
(131, 1, 4, 5, 'PENDING', NULL, '2020-02-26 15:03:23', '2020-02-26 15:03:23'),
(132, 1, 1, 1, 'PENDING', NULL, '2020-02-26 15:28:09', '2020-02-26 15:28:09'),
(133, 1, 4, 6, 'PENDING', NULL, '2020-02-26 15:28:09', '2020-02-26 15:28:09'),
(134, 1, 1, 1, 'PENDING', NULL, '2020-02-26 15:29:47', '2020-02-26 15:29:47'),
(135, 1, 4, 7, 'PENDING', NULL, '2020-02-26 15:29:47', '2020-02-26 15:29:47'),
(136, 1, 4, 7, 'CANCELLED', NULL, '2020-02-26 15:38:40', '2020-02-26 15:38:40'),
(137, 1, 4, 7, 'CANCELLED', NULL, '2020-02-26 15:44:01', '2020-02-26 15:44:01'),
(138, 1, 1, 1, 'PENDING', NULL, '2020-02-26 16:10:08', '2020-02-26 16:10:08'),
(139, 1, 4, 8, 'PENDING', NULL, '2020-02-26 16:10:08', '2020-02-26 16:10:08'),
(140, 1, 4, 8, 'CANCELLED', NULL, '2020-02-26 16:10:15', '2020-02-26 16:10:15'),
(141, 1, 4, 8, 'PENDING', NULL, '2020-02-26 16:10:15', '2020-02-26 16:10:15'),
(142, 1, 4, 8, 'PENDING', NULL, '2020-02-26 16:10:15', '2020-02-26 16:10:15'),
(143, 1, 1, 2, 'PENDING', NULL, '2020-02-26 16:11:29', '2020-02-26 16:11:29'),
(144, 1, 4, 9, 'PENDING', NULL, '2020-02-26 16:11:29', '2020-02-26 16:11:29'),
(145, 1, 4, 9, 'CANCELLED', NULL, '2020-02-26 16:11:38', '2020-02-26 16:11:38'),
(146, 1, 4, 9, 'INTERESTED', NULL, '2020-02-26 16:11:38', '2020-02-26 16:11:38'),
(147, 1, 4, 9, 'INTERESTED', NULL, '2020-02-26 16:11:38', '2020-02-26 16:11:38'),
(148, 1, 1, 1, 'PENDING', NULL, '2020-03-04 10:31:19', '2020-03-04 10:31:19'),
(149, 1, 4, 10, 'PENDING', NULL, '2020-03-04 10:31:19', '2020-03-04 10:31:19'),
(150, 1, 1, 1, 'PENDING', NULL, '2020-03-04 10:31:19', '2020-03-04 10:31:19'),
(151, 1, 4, 11, 'PENDING', NULL, '2020-03-04 10:31:19', '2020-03-04 10:31:19'),
(152, 1, 4, 7, 'APPROVED', NULL, '2020-03-05 21:04:00', '2020-03-05 21:04:00'),
(153, 1, 4, 7, 'REJECTED', NULL, '2020-03-05 21:27:33', '2020-03-05 21:27:33'),
(154, 1, 4, 7, 'PENDING', NULL, '2020-03-05 21:27:39', '2020-03-05 21:27:39'),
(155, 1, 4, 7, 'APPROVED', NULL, '2020-03-05 21:30:29', '2020-03-05 21:30:29'),
(156, 1, 4, 7, 'APPROVED', NULL, '2020-03-05 21:33:12', '2020-03-05 21:33:12'),
(157, 1, 4, 7, 'REJECTED', NULL, '2020-03-05 21:36:18', '2020-03-05 21:36:18'),
(158, 1, 4, 7, 'REJECTED', NULL, '2020-03-05 21:39:37', '2020-03-05 21:39:37'),
(159, 1, 4, 7, 'PENDING', NULL, '2020-03-06 09:53:29', '2020-03-06 09:53:29'),
(160, 1, 4, 7, 'APPROVED', NULL, '2020-03-06 11:01:23', '2020-03-06 11:01:23'),
(161, 1, 4, 7, 'REJECTED', NULL, '2020-03-06 11:15:31', '2020-03-06 11:15:31'),
(162, 1, 4, 7, 'PENDING', NULL, '2020-03-06 11:22:23', '2020-03-06 11:22:23'),
(163, 1, 4, 7, 'APPROVED', NULL, '2020-03-06 14:38:35', '2020-03-06 14:38:35'),
(164, 1, 1, 1, 'PENDING', NULL, '2020-03-10 17:30:49', '2020-03-10 17:30:49'),
(165, 1, 4, 12, 'PENDING', NULL, '2020-03-10 17:30:49', '2020-03-10 17:30:49'),
(166, 1, 4, 7, 'REJECTED', NULL, '2020-03-11 10:59:49', '2020-03-11 10:59:49'),
(167, 1, 4, 7, 'PENDING', NULL, '2020-03-11 11:02:32', '2020-03-11 11:02:32'),
(168, 1, 4, 7, 'APPROVED', NULL, '2020-03-11 11:02:43', '2020-03-11 11:02:43'),
(169, 1, 4, 12, 'APPROVED', NULL, '2020-03-11 11:04:04', '2020-03-11 11:04:04'),
(170, 1, 4, 7, 'REJECTED', NULL, '2020-03-11 11:04:25', '2020-03-11 11:04:25'),
(171, 1, 4, 12, 'REJECTED', NULL, '2020-03-11 11:04:46', '2020-03-11 11:04:46'),
(172, 1, 4, 10, 'APPROVED', NULL, '2020-03-11 18:09:18', '2020-03-11 18:09:18'),
(173, 1, 4, 10, 'APPROVED', NULL, '2020-03-11 18:15:02', '2020-03-11 18:15:02'),
(174, 3, 1, 1, 'PENDING', NULL, '2020-03-12 10:04:44', '2020-03-12 10:04:44'),
(175, 3, 1, 1, 'ACCEPTED', NULL, '2020-03-12 10:04:55', '2020-03-12 10:04:55'),
(176, 3, 1, 1, 'ACCEPTED', NULL, '2020-03-12 10:07:52', '2020-03-12 10:07:52'),
(177, 3, 1, 1, 'ACCEPTED', NULL, '2020-03-12 10:07:54', '2020-03-12 10:07:54'),
(178, 3, 1, 1, 'ACCEPTED', NULL, '2020-03-12 10:08:16', '2020-03-12 10:08:16'),
(179, 3, 1, 1, 'ACCEPTED', NULL, '2020-03-12 10:08:28', '2020-03-12 10:08:28'),
(180, 3, 1, 1, 'ACCEPTED', NULL, '2020-03-12 10:08:58', '2020-03-12 10:08:58'),
(181, 3, 1, 1, 'ACCEPTED', NULL, '2020-03-12 10:09:53', '2020-03-12 10:09:53'),
(182, 3, 1, 1, 'REQUESTED', NULL, '2020-03-12 10:27:47', '2020-03-12 10:27:47'),
(183, 1, 1, 2, 'PENDING', NULL, '2020-03-18 08:31:16', '2020-03-18 08:31:16'),
(184, 1, 4, 13, 'PENDING', NULL, '2020-03-18 08:31:16', '2020-03-18 08:31:16'),
(185, 3, 1, 2, 'PENDING', NULL, '2020-03-18 08:41:06', '2020-03-18 08:41:06'),
(186, 1, 1, 2, 'PENDING', NULL, '2020-03-18 08:41:40', '2020-03-18 08:41:40'),
(187, 1, 4, 14, 'PENDING', NULL, '2020-03-18 08:41:40', '2020-03-18 08:41:40'),
(188, 1, 1, 1, 'PENDING', NULL, '2020-03-26 07:18:06', '2020-03-26 07:18:06'),
(189, 1, 1, 1, 'PENDING', NULL, '2020-03-26 07:20:15', '2020-03-26 07:20:15'),
(190, 1, 4, 15, 'PENDING', NULL, '2020-03-26 07:20:15', '2020-03-26 07:20:15'),
(191, 1, 1, 1, 'POSTED', NULL, '2020-03-29 22:46:43', '2020-03-29 22:46:43'),
(192, 1, 2, 1, 'POSTED', '', '2020-03-29 22:50:41', '2020-03-29 22:50:41'),
(193, 1, 1, 1, 'PENDING', NULL, '2020-03-29 22:58:40', '2020-03-29 22:58:40'),
(194, 1, 4, 1, 'PENDING', NULL, '2020-03-29 22:58:40', '2020-03-29 22:58:40'),
(195, 1, 1, 1, 'POSTED', NULL, '2020-03-30 05:48:23', '2020-03-30 05:48:23'),
(196, 1, 1, 2, 'POSTED', NULL, '2020-03-30 06:02:26', '2020-03-30 06:02:26'),
(197, 1, 1, 1, 'POSTED', NULL, '2020-03-30 07:05:39', '2020-03-30 07:05:39'),
(198, 1, 1, 2, 'POSTED', NULL, '2020-03-30 07:08:26', '2020-03-30 07:08:26'),
(199, 1, 1, 3, 'POSTED', NULL, '2020-03-30 07:13:17', '2020-03-30 07:13:17'),
(200, 1, 1, 4, 'POSTED', NULL, '2020-03-30 07:16:05', '2020-03-30 07:16:05'),
(201, 1, 1, 5, 'POSTED', NULL, '2020-03-30 22:38:27', '2020-03-30 22:38:27'),
(202, 1, 1, 6, 'POSTED', NULL, '2020-03-30 22:48:25', '2020-03-30 22:48:25'),
(203, 1, 1, 6, 'PENDING', NULL, '2020-03-31 10:16:56', '2020-03-31 10:16:56'),
(204, 1, 4, 1, 'PENDING', NULL, '2020-03-31 10:16:56', '2020-03-31 10:16:56'),
(205, 1, 1, 6, 'PENDING', NULL, '2020-03-31 10:21:00', '2020-03-31 10:21:00'),
(206, 1, 4, 2, 'PENDING', NULL, '2020-03-31 10:21:00', '2020-03-31 10:21:00'),
(207, 1, 4, 2, 'APPROVED', NULL, '2020-03-31 10:24:49', '2020-03-31 10:24:49'),
(208, 1, 4, 2, 'REJECTED', NULL, '2020-03-31 12:53:42', '2020-03-31 12:53:42'),
(209, 1, 2, 1, 'POSTED', '', '2020-03-31 14:08:39', '2020-03-31 14:08:39'),
(210, 1, 4, 2, 'PENDING', NULL, '2020-03-31 14:46:02', '2020-03-31 14:46:02'),
(211, 1, 4, 2, 'APPROVED', NULL, '2020-03-31 14:57:27', '2020-03-31 14:57:27'),
(212, 1, 4, 2, 'REJECTED', NULL, '2020-04-02 06:11:42', '2020-04-02 06:11:42'),
(213, 1, 4, 2, 'PENDING', NULL, '2020-04-02 06:31:52', '2020-04-02 06:31:52'),
(214, 1, 4, 2, 'APPROVED', NULL, '2020-04-02 06:39:18', '2020-04-02 06:39:18'),
(215, 1, 2, 1, 'POSTED', '', '2020-04-12 18:09:09', '2020-04-12 18:09:09'),
(216, 1, 2, 1, 'POSTED', '', '2020-04-12 19:19:39', '2020-04-12 19:19:39'),
(217, 3, 1, 2, 'PENDING', NULL, '2020-04-14 07:53:48', '2020-04-14 07:53:48'),
(218, 3, 1, 3, 'PENDING', NULL, '2020-04-14 07:54:48', '2020-04-14 07:54:48'),
(219, 3, 1, 4, 'PENDING', NULL, '2020-04-14 07:55:26', '2020-04-14 07:55:26'),
(220, 3, 1, 5, 'PENDING', NULL, '2020-04-15 22:39:51', '2020-04-15 22:39:51'),
(221, 1, 4, 2, 'REJECTED', NULL, '2020-04-16 21:28:33', '2020-04-16 21:28:33'),
(222, 1, 4, 2, 'PENDING', NULL, '2020-04-16 21:28:50', '2020-04-16 21:28:50'),
(223, 1, 4, 2, 'PENDING', NULL, '2020-04-16 21:32:13', '2020-04-16 21:32:13'),
(224, 1, 4, 2, 'APPROVED', NULL, '2020-04-16 21:34:32', '2020-04-16 21:34:32'),
(225, 1, 4, 2, 'REJECTED', NULL, '2020-04-26 20:09:36', '2020-04-26 20:09:36'),
(226, 1, 4, 2, 'PENDING', NULL, '2020-04-26 20:10:10', '2020-04-26 20:10:10'),
(227, 1, 4, 2, 'APPROVED', NULL, '2020-04-26 20:12:33', '2020-04-26 20:12:33'),
(228, 1, 4, 2, 'REJECTED', NULL, '2020-04-26 20:13:08', '2020-04-26 20:13:08'),
(229, 1, 4, 2, 'PENDING', NULL, '2020-04-26 20:14:05', '2020-04-26 20:14:05'),
(230, 1, 4, 2, 'APPROVED', NULL, '2020-04-26 23:06:47', '2020-04-26 23:06:47'),
(231, 1, 4, 2, 'REJECTED', NULL, '2020-04-26 23:07:53', '2020-04-26 23:07:53'),
(232, 1, 4, 2, 'PENDING', NULL, '2020-04-26 23:08:03', '2020-04-26 23:08:03'),
(233, 1, 4, 2, 'APPROVED', NULL, '2020-04-26 23:12:38', '2020-04-26 23:12:38'),
(234, 1, 4, 2, 'REJECTED', NULL, '2020-04-27 05:33:53', '2020-04-27 05:33:53'),
(235, 1, 4, 2, 'PENDING', NULL, '2020-04-27 05:57:53', '2020-04-27 05:57:53'),
(236, 1, 4, 2, 'APPROVED', NULL, '2020-04-27 05:58:32', '2020-04-27 05:58:32'),
(237, 1, 4, 2, 'REJECTED', NULL, '2020-04-27 07:41:03', '2020-04-27 07:41:03'),
(238, 1, 4, 2, 'PENDING', NULL, '2020-04-27 07:41:10', '2020-04-27 07:41:10'),
(239, 1, 4, 2, 'PENDING', NULL, '2020-04-27 07:56:12', '2020-04-27 07:56:12'),
(240, 1, 4, 2, 'APPROVED', NULL, '2020-04-27 07:57:01', '2020-04-27 07:57:01'),
(241, 1, 4, 2, 'REJECTED', NULL, '2020-04-27 07:58:04', '2020-04-27 07:58:04'),
(242, 1, 4, 2, 'PENDING', NULL, '2020-04-27 07:58:12', '2020-04-27 07:58:12'),
(243, 1, 4, 2, 'REJECTED', NULL, '2020-04-27 07:59:03', '2020-04-27 07:59:03'),
(244, 1, 4, 2, 'PENDING', NULL, '2020-04-27 07:59:12', '2020-04-27 07:59:12'),
(245, 1, 4, 2, 'APPROVED', NULL, '2020-04-27 07:59:17', '2020-04-27 07:59:17'),
(246, 1, 4, 2, 'ACTIVE', NULL, '2020-04-27 07:59:22', '2020-04-27 07:59:22'),
(247, 1, 4, 2, 'APPROVED', NULL, '2020-04-27 07:59:31', '2020-04-27 07:59:31'),
(248, 1, 1, 5, 'PENDING', NULL, '2020-04-27 20:18:09', '2020-04-27 20:18:09'),
(249, 1, 4, 3, 'PENDING', NULL, '2020-04-27 20:18:10', '2020-04-27 20:18:10'),
(250, 1, 1, 5, 'PENDING', NULL, '2020-04-27 20:18:20', '2020-04-27 20:18:20'),
(251, 1, 4, 4, 'PENDING', NULL, '2020-04-27 20:18:20', '2020-04-27 20:18:20'),
(252, 1, 1, 5, 'PENDING', NULL, '2020-04-27 20:19:15', '2020-04-27 20:19:15'),
(253, 1, 4, 5, 'PENDING', NULL, '2020-04-27 20:19:15', '2020-04-27 20:19:15'),
(254, 1, 1, 2, 'PENDING', NULL, '2020-04-27 20:25:34', '2020-04-27 20:25:34'),
(255, 1, 4, 6, 'PENDING', NULL, '2020-04-27 20:25:34', '2020-04-27 20:25:34'),
(256, 1, 1, 6, 'PENDING', NULL, '2020-05-03 20:52:49', '2020-05-03 20:52:49'),
(257, 1, 4, 7, 'PENDING', NULL, '2020-05-03 20:52:49', '2020-05-03 20:52:49'),
(258, 1, 1, 4, 'INTERESTED', NULL, '2020-05-03 22:24:15', '2020-05-03 22:24:15'),
(259, 1, 1, 2, 'INTERESTED', NULL, '2020-05-04 06:47:41', '2020-05-04 06:47:41'),
(260, 1, 1, 3, 'INTERESTED', NULL, '2020-05-04 06:50:21', '2020-05-04 06:50:21'),
(261, 1, 1, 2, 'INTERESTED', NULL, '2020-05-04 06:56:50', '2020-05-04 06:56:50'),
(262, 1, 4, 6, 'CANCELLED', NULL, '2020-05-04 08:51:34', '2020-05-04 08:51:34'),
(263, 1, 1, 6, 'PENDING', NULL, '2020-05-04 08:57:09', '2020-05-04 08:57:09'),
(264, 1, 4, 8, 'PENDING', NULL, '2020-05-04 08:57:09', '2020-05-04 08:57:09'),
(265, 1, 1, 4, 'PENDING', NULL, '2020-05-04 10:51:05', '2020-05-04 10:51:05'),
(266, 1, 4, 9, 'PENDING', NULL, '2020-05-04 10:51:05', '2020-05-04 10:51:05'),
(267, 1, 4, 9, 'APPROVED', NULL, '2020-05-04 11:21:58', '2020-05-04 11:21:58'),
(268, 1, 4, 2, 'ACTIVE', NULL, '2020-05-04 16:35:04', '2020-05-04 16:35:04'),
(269, 1, 1, 4, 'PENDING', NULL, '2020-05-07 17:44:36', '2020-05-07 17:44:36'),
(270, 1, 4, 10, 'PENDING', NULL, '2020-05-07 17:44:36', '2020-05-07 17:44:36'),
(271, 1, 4, 10, 'APPROVED', NULL, '2020-05-07 17:50:17', '2020-05-07 17:50:17'),
(272, 1, 1, 4, 'PENDING', NULL, '2020-05-08 14:05:24', '2020-05-08 14:05:24'),
(273, 1, 4, 11, 'PENDING', NULL, '2020-05-08 14:05:24', '2020-05-08 14:05:24'),
(274, 1, 4, 11, 'APPROVED', NULL, '2020-05-08 14:06:04', '2020-05-08 14:06:04'),
(275, 1, 1, 4, 'PENDING', NULL, '2020-05-08 14:34:26', '2020-05-08 14:34:26'),
(276, 1, 4, 12, 'PENDING', NULL, '2020-05-08 14:34:26', '2020-05-08 14:34:26'),
(277, 1, 4, 12, 'APPROVED', NULL, '2020-05-08 14:34:39', '2020-05-08 14:34:39'),
(278, 1, 1, 4, 'PENDING', NULL, '2020-05-08 17:31:50', '2020-05-08 17:31:50'),
(279, 1, 4, 13, 'PENDING', NULL, '2020-05-08 17:31:50', '2020-05-08 17:31:50'),
(280, 1, 4, 13, 'APPROVED', NULL, '2020-05-08 17:32:01', '2020-05-08 17:32:01'),
(281, 1, 1, 4, 'PENDING', NULL, '2020-05-11 01:37:36', '2020-05-11 01:37:36'),
(282, 1, 4, 14, 'PENDING', NULL, '2020-05-11 01:37:36', '2020-05-11 01:37:36'),
(283, 1, 4, 14, 'APPROVED', NULL, '2020-05-11 01:37:59', '2020-05-11 01:37:59'),
(284, 1, 1, 3, 'PENDING', NULL, '2020-05-11 04:37:43', '2020-05-11 04:37:43'),
(285, 1, 4, 15, 'PENDING', NULL, '2020-05-11 04:37:43', '2020-05-11 04:37:43'),
(286, 1, 4, 15, 'APPROVED', NULL, '2020-05-11 04:37:56', '2020-05-11 04:37:56'),
(287, 1, 4, 15, 'ACTIVE', NULL, '2020-05-11 06:04:08', '2020-05-11 06:04:08'),
(288, 1, 4, 15, 'ACTIVE', NULL, '2020-05-11 06:07:04', '2020-05-11 06:07:04'),
(289, 1, 4, 15, 'ACTIVE', NULL, '2020-05-11 06:08:59', '2020-05-11 06:08:59'),
(290, 1, 4, 15, 'ACTIVE', NULL, '2020-05-11 06:09:55', '2020-05-11 06:09:55'),
(291, 1, 1, 4, 'PENDING', NULL, '2020-05-11 06:49:29', '2020-05-11 06:49:29'),
(292, 1, 4, 16, 'PENDING', NULL, '2020-05-11 06:49:29', '2020-05-11 06:49:29'),
(293, 1, 4, 16, 'APPROVED', NULL, '2020-05-11 06:49:47', '2020-05-11 06:49:47'),
(294, 1, 4, 16, 'ACTIVE', NULL, '2020-05-11 07:09:36', '2020-05-11 07:09:36'),
(295, 1, 4, 15, 'ACTIVE', NULL, '2020-05-11 07:37:06', '2020-05-11 07:37:06'),
(296, 1, 4, 15, 'ACTIVE', NULL, '2020-05-11 07:42:11', '2020-05-11 07:42:11'),
(297, 1, 4, 16, 'ACTIVE', NULL, '2020-05-11 08:37:16', '2020-05-11 08:37:16'),
(298, 1, 1, 4, 'PENDING', NULL, '2020-05-12 11:08:30', '2020-05-12 11:08:30'),
(299, 1, 4, 17, 'PENDING', NULL, '2020-05-12 11:08:31', '2020-05-12 11:08:31'),
(300, 1, 1, 4, 'PENDING', NULL, '2020-05-14 11:10:43', '2020-05-14 11:10:43'),
(301, 1, 4, 18, 'PENDING', NULL, '2020-05-14 11:10:43', '2020-05-14 11:10:43'),
(302, 1, 4, 18, 'APPROVED', NULL, '2020-05-14 11:32:01', '2020-05-14 11:32:01'),
(303, 1, 1, 4, 'PENDING', NULL, '2020-05-14 16:18:24', '2020-05-14 16:18:24'),
(304, 1, 4, 19, 'PENDING', NULL, '2020-05-14 16:18:24', '2020-05-14 16:18:24'),
(305, 1, 1, 5, 'PENDING', NULL, '2020-05-14 16:19:15', '2020-05-14 16:19:15'),
(306, 1, 4, 20, 'PENDING', NULL, '2020-05-14 16:19:15', '2020-05-14 16:19:15'),
(307, 1, 1, 4, 'PENDING', NULL, '2020-05-14 16:37:37', '2020-05-14 16:37:37'),
(308, 1, 4, 21, 'PENDING', NULL, '2020-05-14 16:37:38', '2020-05-14 16:37:38'),
(309, 1, 1, 5, 'PENDING', NULL, '2020-05-14 16:38:45', '2020-05-14 16:38:45'),
(310, 1, 4, 22, 'PENDING', NULL, '2020-05-14 16:38:45', '2020-05-14 16:38:45'),
(311, 1, 4, 22, 'APPROVED', NULL, '2020-05-14 16:38:59', '2020-05-14 16:38:59'),
(312, 1, 4, 22, 'ACTIVE', NULL, '2020-05-14 16:39:31', '2020-05-14 16:39:31'),
(313, 1, 4, 21, 'APPROVED', NULL, '2020-05-14 16:40:02', '2020-05-14 16:40:02'),
(314, 1, 4, 21, 'ACTIVE', NULL, '2020-05-14 16:40:33', '2020-05-14 16:40:33'),
(315, 1, 1, 5, 'PENDING', NULL, '2020-05-17 23:28:07', '2020-05-17 23:28:07'),
(316, 1, 4, 23, 'PENDING', NULL, '2020-05-17 23:28:07', '2020-05-17 23:28:07'),
(317, 1, 1, 5, 'PENDING', NULL, '2020-05-18 07:22:28', '2020-05-18 07:22:28'),
(318, 1, 4, 24, 'PENDING', NULL, '2020-05-18 07:22:28', '2020-05-18 07:22:28'),
(319, 1, 1, 5, 'PENDING', NULL, '2020-05-18 09:14:48', '2020-05-18 09:14:48'),
(320, 1, 4, 25, 'PENDING', NULL, '2020-05-18 09:14:48', '2020-05-18 09:14:48'),
(321, 1, 1, 6, 'PENDING', NULL, '2020-05-18 16:41:20', '2020-05-18 16:41:20'),
(322, 1, 4, 26, 'PENDING', NULL, '2020-05-18 16:41:20', '2020-05-18 16:41:20'),
(323, 1, 1, 4, 'PENDING', NULL, '2020-05-26 15:40:16', '2020-05-26 15:40:16'),
(324, 1, 4, 27, 'PENDING', NULL, '2020-05-26 15:40:16', '2020-05-26 15:40:16'),
(325, 1, 4, 27, 'APPROVED', NULL, '2020-05-26 15:53:38', '2020-05-26 15:53:38'),
(326, 1, 4, 27, 'ACTIVE', NULL, '2020-05-26 17:33:40', '2020-05-26 17:33:40'),
(327, 1, 1, 3, 'PENDING', NULL, '2020-05-27 21:41:17', '2020-05-27 21:41:17'),
(328, 1, 4, 28, 'PENDING', NULL, '2020-05-27 21:41:17', '2020-05-27 21:41:17'),
(329, 1, 1, 3, 'PENDING', NULL, '2020-05-27 21:58:27', '2020-05-27 21:58:27'),
(330, 1, 4, 29, 'PENDING', NULL, '2020-05-27 21:58:27', '2020-05-27 21:58:27'),
(331, 1, 4, 29, 'APPROVED', NULL, '2020-05-27 22:34:33', '2020-05-27 22:34:33'),
(332, 1, 1, 4, 'PENDING', NULL, '2020-05-27 23:12:22', '2020-05-27 23:12:22'),
(333, 1, 4, 30, 'PENDING', NULL, '2020-05-27 23:12:22', '2020-05-27 23:12:22'),
(334, 1, 4, 30, 'APPROVED', NULL, '2020-05-27 23:12:33', '2020-05-27 23:12:33'),
(335, 1, 4, 27, 'APPROVED', NULL, '2020-05-28 00:54:00', '2020-05-28 00:54:00'),
(336, 1, 1, 4, 'PENDING', NULL, '2020-05-28 02:08:50', '2020-05-28 02:08:50'),
(337, 1, 4, 31, 'PENDING', NULL, '2020-05-28 02:08:50', '2020-05-28 02:08:50'),
(338, 1, 4, 31, 'APPROVED', NULL, '2020-05-28 02:09:16', '2020-05-28 02:09:16'),
(339, 1, 4, 31, 'VERIFICATION', NULL, '2020-05-28 02:16:24', '2020-05-28 02:16:24'),
(340, 1, 4, 31, 'APPROVED', NULL, '2020-05-28 07:29:30', '2020-05-28 07:29:30'),
(341, 1, 4, 31, 'VERIFICATION', NULL, '2020-05-28 07:42:16', '2020-05-28 07:42:16'),
(342, 1, 4, 31, 'APPROVED', NULL, '2020-05-28 07:42:28', '2020-05-28 07:42:28'),
(343, 1, 4, 31, 'VERIFICATION', NULL, '2020-05-28 07:45:07', '2020-05-28 07:45:07'),
(344, 1, 4, 31, 'APPROVED', NULL, '2020-05-28 07:45:25', '2020-05-28 07:45:25'),
(345, 1, 4, 31, 'VERIFICATION', NULL, '2020-05-28 07:46:36', '2020-05-28 07:46:36'),
(346, 1, 4, 31, 'APPROVED', NULL, '2020-05-28 07:46:50', '2020-05-28 07:46:50'),
(347, 1, 4, 31, 'VERIFICATION', NULL, '2020-05-28 07:50:14', '2020-05-28 07:50:14'),
(348, 1, 4, 31, 'APPROVED', NULL, '2020-05-28 07:50:31', '2020-05-28 07:50:31'),
(349, 1, 4, 31, 'VERIFICATION', NULL, '2020-05-28 07:50:53', '2020-05-28 07:50:53'),
(350, 1, 4, 31, 'ACTIVE', NULL, '2020-05-28 07:51:04', '2020-05-28 07:51:04'),
(351, 1, 4, 31, 'COMPLETED', NULL, '2020-05-28 09:34:23', '2020-05-28 09:34:23'),
(352, 1, 1, 3, 'INTERESTED', NULL, '2020-06-08 11:00:28', '2020-06-08 11:00:28'),
(353, 1, 1, 7, 'POSTED', NULL, '2020-06-11 16:59:11', '2020-06-11 16:59:11'),
(354, 1, 1, 8, 'POSTED', NULL, '2020-06-11 17:02:57', '2020-06-11 17:02:57'),
(355, 1, 1, 9, 'POSTED', NULL, '2020-06-11 17:20:52', '2020-06-11 17:20:52'),
(356, 1, 1, 2, 'PENDING', NULL, '2020-06-16 16:57:19', '2020-06-16 16:57:19'),
(357, 1, 4, 1, 'PENDING', NULL, '2020-06-16 16:57:19', '2020-06-16 16:57:19'),
(358, 1, 1, 2, 'PENDING', NULL, '2020-06-16 16:57:46', '2020-06-16 16:57:46'),
(359, 1, 4, 2, 'PENDING', NULL, '2020-06-16 16:57:46', '2020-06-16 16:57:46'),
(360, 1, 1, 2, 'PENDING', NULL, '2020-06-16 16:58:43', '2020-06-16 16:58:43'),
(361, 1, 4, 3, 'PENDING', NULL, '2020-06-16 16:58:44', '2020-06-16 16:58:44'),
(362, 1, 1, 2, 'PENDING', NULL, '2020-06-16 17:01:00', '2020-06-16 17:01:00'),
(363, 1, 4, 4, 'PENDING', NULL, '2020-06-16 17:01:00', '2020-06-16 17:01:00'),
(364, 1, 1, 2, 'PENDING', NULL, '2020-06-16 17:01:04', '2020-06-16 17:01:04'),
(365, 1, 4, 5, 'PENDING', NULL, '2020-06-16 17:01:04', '2020-06-16 17:01:04'),
(366, 1, 1, 4, 'PENDING', NULL, '2020-06-16 17:01:43', '2020-06-16 17:01:43'),
(367, 1, 4, 6, 'PENDING', NULL, '2020-06-16 17:01:43', '2020-06-16 17:01:43'),
(368, 1, 1, 4, 'PENDING', NULL, '2020-06-16 17:01:59', '2020-06-16 17:01:59'),
(369, 1, 4, 7, 'PENDING', NULL, '2020-06-16 17:01:59', '2020-06-16 17:01:59'),
(370, 1, 1, 2, 'PENDING', NULL, '2020-06-16 17:03:13', '2020-06-16 17:03:13'),
(371, 1, 4, 8, 'PENDING', NULL, '2020-06-16 17:03:13', '2020-06-16 17:03:13'),
(372, 1, 1, 2, 'PENDING', NULL, '2020-06-16 17:05:06', '2020-06-16 17:05:06'),
(373, 1, 4, 9, 'PENDING', NULL, '2020-06-16 17:05:06', '2020-06-16 17:05:06'),
(374, 1, 2, 1, 'POSTED', '', '2020-07-01 11:59:25', '2020-07-01 11:59:25'),
(375, 3, 1, 1, 'PENDING', NULL, '2020-07-01 12:00:51', '2020-07-01 12:00:51'),
(376, 3, 1, 2, 'PENDING', NULL, '2020-07-01 12:00:51', '2020-07-01 12:00:51'),
(377, 1, 1, 1, 'POSTED', NULL, '2020-07-01 14:17:56', '2020-07-01 14:17:56'),
(378, 1, 1, 1, 'PENDING', NULL, '2020-07-01 14:20:54', '2020-07-01 14:20:54'),
(379, 1, 4, 1, 'PENDING', NULL, '2020-07-01 14:20:54', '2020-07-01 14:20:54'),
(380, 3, 1, 1, 'ACCEPTED', NULL, '2020-07-01 15:12:33', '2020-07-01 15:12:33'),
(381, 3, 1, 1, 'ACCEPTED', NULL, '2020-07-01 15:12:37', '2020-07-01 15:12:37'),
(382, 1, 2, 1, 'POSTED', '', '2020-07-02 14:20:37', '2020-07-02 14:20:37'),
(383, 3, 1, 1, 'PENDING', NULL, '2020-07-02 14:35:30', '2020-07-02 14:35:30'),
(384, 3, 1, 2, 'PENDING', NULL, '2020-07-02 14:35:30', '2020-07-02 14:35:30'),
(385, 3, 1, 2, 'ACCEPTED', NULL, '2020-07-02 14:35:45', '2020-07-02 14:35:45'),
(386, 3, 1, 2, 'COMPLETE', NULL, '2020-07-02 15:04:07', '2020-07-02 15:04:07');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT ' ',
  `media_id` int(11) DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `gender` int(1) DEFAULT NULL,
  `birthdate` date DEFAULT '1971-01-01',
  `contact_number` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `phone_prefix` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_verified` int(1) DEFAULT '0',
  `phone_verified_at` datetime DEFAULT NULL,
  `location` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `country_id` int(11) NOT NULL DEFAULT '0',
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified` int(11) NOT NULL DEFAULT '0',
  `email_verification_code` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fcm_token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_category`
--

CREATE TABLE `user_category` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `description` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_event`
--

CREATE TABLE `user_event` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `eventjob_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `job_description` varchar(150) NOT NULL,
  `status_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_interested`
--

CREATE TABLE `user_interested` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `campaign_type` int(11) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_rating`
--

CREATE TABLE `user_rating` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `rate` tinyint(4) NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_sma`
--

CREATE TABLE `user_sma` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `app_id` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `app_user_id` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `type_name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `access_token` text COLLATE utf8mb4_unicode_ci,
  `credential` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_link` text COLLATE utf8mb4_unicode_ci,
  `profile_picture` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `page_id` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_name` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_username` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `page_access_token` text COLLATE utf8mb4_unicode_ci,
  `page_link` text COLLATE utf8mb4_unicode_ci,
  `page_fan_count` int(11) DEFAULT NULL,
  `page_profile_picture` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_socialmedia_campaign`
--

CREATE TABLE `user_socialmedia_campaign` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `social_media_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '0',
  `status` varchar(150) DEFAULT NULL,
  `favorite` int(11) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat_session`
--
ALTER TABLE `chat_session`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `client_email_unique` (`email`);

--
-- Indexes for table `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `event_applicants`
--
ALTER TABLE `event_applicants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `event_applicant_schedule`
--
ALTER TABLE `event_applicant_schedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `event_jobs`
--
ALTER TABLE `event_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `event_job_schedule`
--
ALTER TABLE `event_job_schedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `event_job_skills`
--
ALTER TABLE `event_job_skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `event_schedule`
--
ALTER TABLE `event_schedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post_online`
--
ALTER TABLE `post_online`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `post_sma`
--
ALTER TABLE `post_sma`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reportproblem`
--
ALTER TABLE `reportproblem`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_media`
--
ALTER TABLE `social_media`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_media_budget`
--
ALTER TABLE `social_media_budget`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_media_category`
--
ALTER TABLE `social_media_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_media_sma`
--
ALTER TABLE `social_media_sma`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_media_tags`
--
ALTER TABLE `social_media_tags`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_category`
--
ALTER TABLE `user_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_event`
--
ALTER TABLE `user_event`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_interested`
--
ALTER TABLE `user_interested`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_rating`
--
ALTER TABLE `user_rating`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_sma`
--
ALTER TABLE `user_sma`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_socialmedia_campaign`
--
ALTER TABLE `user_socialmedia_campaign`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_session`
--
ALTER TABLE `chat_session`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `country`
--
ALTER TABLE `country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_applicants`
--
ALTER TABLE `event_applicants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_applicant_schedule`
--
ALTER TABLE `event_applicant_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `event_jobs`
--
ALTER TABLE `event_jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_job_schedule`
--
ALTER TABLE `event_job_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_job_skills`
--
ALTER TABLE `event_job_skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `event_schedule`
--
ALTER TABLE `event_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `post_online`
--
ALTER TABLE `post_online`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `post_sma`
--
ALTER TABLE `post_sma`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reportproblem`
--
ALTER TABLE `reportproblem`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `social_media`
--
ALTER TABLE `social_media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_media_budget`
--
ALTER TABLE `social_media_budget`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_media_category`
--
ALTER TABLE `social_media_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_media_sma`
--
ALTER TABLE `social_media_sma`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `social_media_tags`
--
ALTER TABLE `social_media_tags`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=387;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_category`
--
ALTER TABLE `user_category`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_event`
--
ALTER TABLE `user_event`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_interested`
--
ALTER TABLE `user_interested`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_rating`
--
ALTER TABLE `user_rating`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_sma`
--
ALTER TABLE `user_sma`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_socialmedia_campaign`
--
ALTER TABLE `user_socialmedia_campaign`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
