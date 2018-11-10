/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.18-log : Database - laravel_streavr
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values (1,'2014_10_12_100000_user_password_resets_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (2,'2017_05_23_031512_videos_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (3,'2017_05_23_031530_video_meta_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (4,'2017_05_23_031538_video_categories_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (5,'2017_05_23_031555_users_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (6,'2017_05_23_031602_user_meta_table',1);
insert  into `migrations`(`id`,`migration`,`batch`) values (7,'2017_07_05_073402_video_favorites_table',1);

/*Table structure for table `user_password_resets` */

DROP TABLE IF EXISTS `user_password_resets`;

CREATE TABLE `user_password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `user_password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `user_password_resets` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `enable` tinyint(1) DEFAULT '1',
  `user_level` int(11) NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`),
  KEY `enable` (`enable`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`first_name`,`last_name`,`email`,`username`,`password`,`enable`,`user_level`,`avatar`,`remember_token`,`created_at`,`updated_at`) values (1,'Admin','M','admin@streavr.com','michael','$2y$10$kfzZ9hG7bLY/4hhjvQCSJu7CJYUmnaHjzZAhnf4CC0xbORQAT.YfG',1,1,NULL,'NMfLtpG1qRI9H4DQCYXY3y1T0PVOfPI7KHmtdzUizfJ3amNMOVYTU0iQxQWP','2017-07-06 09:14:07','2017-07-06 19:25:33');
insert  into `users`(`id`,`first_name`,`last_name`,`email`,`username`,`password`,`enable`,`user_level`,`avatar`,`remember_token`,`created_at`,`updated_at`) values (2,'Mamie','Marin','mamie@gmail.com','mamie','$2y$10$TBI5i2Q.59oaFR39Yu4vF.dErs02ELNiQ32ke8Y7jge6ISqFbD9G2',1,2,NULL,NULL,'2017-07-06 09:17:49','2017-07-06 19:25:45');
insert  into `users`(`id`,`first_name`,`last_name`,`email`,`username`,`password`,`enable`,`user_level`,`avatar`,`remember_token`,`created_at`,`updated_at`) values (3,'James','Mullins','james@gmail.com','james','$2y$10$L6tcmggg3n.Z/OtoMKlp1.UtyvOkSaeMWnlPLOTGFbCdg.l5rrc/K',1,2,NULL,'GIUqaSHzGR1qmTjBhq0EnY7a2C61PZmf4mBwfy7LqpxipaD1aNnBIDHjaGWe','2017-07-06 09:19:46','2017-07-06 09:19:46');
insert  into `users`(`id`,`first_name`,`last_name`,`email`,`username`,`password`,`enable`,`user_level`,`avatar`,`remember_token`,`created_at`,`updated_at`) values (10,'Fname','Lname','test@gmail.com',NULL,'$2y$10$SPSQcUJfFcMLWFD7njJOWeLgXFUkXoevJOxqp9GHr8ZfaIh.NQD46',1,2,NULL,NULL,'2017-07-07 05:11:49','2017-07-07 05:11:49');

/*Table structure for table `video_categories` */

DROP TABLE IF EXISTS `video_categories`;

CREATE TABLE `video_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `ordering` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `video_categories_name_unique` (`name`),
  UNIQUE KEY `video_categories_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `video_categories` */

insert  into `video_categories`(`id`,`name`,`slug`,`thumbnail`,`thumbnail_url`,`description`,`ordering`) values (1,'Legends','legends','category_thumbnails/inLRKUqXkp83A8NuKIrStHcaI6742ectOVuWoNPC.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/category_thumbnails/inLRKUqXkp83A8NuKIrStHcaI6742ectOVuWoNPC.jpeg',NULL,1);
insert  into `video_categories`(`id`,`name`,`slug`,`thumbnail`,`thumbnail_url`,`description`,`ordering`) values (2,'Music','music','category_thumbnails/0UhU4tIu0Jea1S5IJV3rBSdMkApIicx6aLMNoMlb.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/category_thumbnails/0UhU4tIu0Jea1S5IJV3rBSdMkApIicx6aLMNoMlb.jpeg','This is the music category.',2);
insert  into `video_categories`(`id`,`name`,`slug`,`thumbnail`,`thumbnail_url`,`description`,`ordering`) values (3,'Ocean','ocean','category_thumbnails/R8n1mWkJmCvYQrua1npelJT50iPfCQgtm0r2YUCy.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/category_thumbnails/R8n1mWkJmCvYQrua1npelJT50iPfCQgtm0r2YUCy.jpeg',NULL,3);
insert  into `video_categories`(`id`,`name`,`slug`,`thumbnail`,`thumbnail_url`,`description`,`ordering`) values (4,'Nature','nature','category_thumbnails/lq81hzBde7gpjEjtBEylqFyN0qhnKsq1Hvjy3LnD.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/category_thumbnails/lq81hzBde7gpjEjtBEylqFyN0qhnKsq1Hvjy3LnD.jpeg',NULL,4);
insert  into `video_categories`(`id`,`name`,`slug`,`thumbnail`,`thumbnail_url`,`description`,`ordering`) values (5,'Wedding','wedding','category_thumbnails/DtLTXLfQOUyQKK69qK6ep79z0b9X0ut846BRAaaw.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/category_thumbnails/DtLTXLfQOUyQKK69qK6ep79z0b9X0ut846BRAaaw.jpeg',NULL,6);
insert  into `video_categories`(`id`,`name`,`slug`,`thumbnail`,`thumbnail_url`,`description`,`ordering`) values (6,'Animal','animal','category_thumbnails/EcbX5WLZL0rDPKQYLSSKI7G25Gp0dxOhMndBSUad.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/category_thumbnails/EcbX5WLZL0rDPKQYLSSKI7G25Gp0dxOhMndBSUad.jpeg',NULL,5);
insert  into `video_categories`(`id`,`name`,`slug`,`thumbnail`,`thumbnail_url`,`description`,`ordering`) values (7,'Travel','travel','category_thumbnails/lWxo3GHoaqEqaCxUSfngJWcz08DTiCKlJ0XXtOMO.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/category_thumbnails/lWxo3GHoaqEqaCxUSfngJWcz08DTiCKlJ0XXtOMO.jpeg',NULL,7);
insert  into `video_categories`(`id`,`name`,`slug`,`thumbnail`,`thumbnail_url`,`description`,`ordering`) values (8,'Yoga','yoga','category_thumbnails/2ZuOR6gNDbD1ZTTVYVg5L1oCJ33kAuq4x1oAMDwm.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/category_thumbnails/2ZuOR6gNDbD1ZTTVYVg5L1oCJ33kAuq4x1oAMDwm.jpeg',NULL,8);

/*Table structure for table `video_favorites` */

DROP TABLE IF EXISTS `video_favorites`;

CREATE TABLE `video_favorites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `video_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_2` (`user_id`,`video_id`),
  KEY `user_id` (`user_id`),
  KEY `video_id` (`video_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `video_favorites` */

insert  into `video_favorites`(`id`,`user_id`,`video_id`) values (3,1,2);
insert  into `video_favorites`(`id`,`user_id`,`video_id`) values (6,3,1);
insert  into `video_favorites`(`id`,`user_id`,`video_id`) values (5,3,2);
insert  into `video_favorites`(`id`,`user_id`,`video_id`) values (1,3,4);
insert  into `video_favorites`(`id`,`user_id`,`video_id`) values (10,3,5);
insert  into `video_favorites`(`id`,`user_id`,`video_id`) values (2,3,6);
insert  into `video_favorites`(`id`,`user_id`,`video_id`) values (4,3,9);

/*Table structure for table `video_meta` */

DROP TABLE IF EXISTS `video_meta`;

CREATE TABLE `video_meta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `video_id` bigint(20) NOT NULL,
  `meta_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `video_id` (`video_id`),
  KEY `meta_key` (`meta_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `video_meta` */

/*Table structure for table `videos` */

DROP TABLE IF EXISTS `videos`;

CREATE TABLE `videos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT '1',
  `video_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_size` int(11) DEFAULT NULL,
  `thumbnail` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumbnail_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ordering` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `visibility` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `visibility` (`visibility`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `videos` */

insert  into `videos`(`id`,`title`,`description`,`user_id`,`category_id`,`video_name`,`video_size`,`thumbnail`,`thumbnail_url`,`video`,`video_url`,`ordering`,`created_at`,`updated_at`,`visibility`) values (1,'3333333333','33333333333333333\r\n333333333333333333',1,3,'3333.mp4',1443448,'video_thumbnails/p97Sdqo6A19j7IZ7xxVPBSPFqEcwplKOxD46JSGB.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/video_thumbnails/p97Sdqo6A19j7IZ7xxVPBSPFqEcwplKOxD46JSGB.jpeg','videos/9baa3cd04a77a8c3d8449367e4047436.mp4','https://streavr-app.s3-ap-southeast-1.amazonaws.com/videos/9baa3cd04a77a8c3d8449367e4047436.mp4',9223372036854775807,'2017-07-05 20:39:52','2017-07-05 20:39:52',1);
insert  into `videos`(`id`,`title`,`description`,`user_id`,`category_id`,`video_name`,`video_size`,`thumbnail`,`thumbnail_url`,`video`,`video_url`,`ordering`,`created_at`,`updated_at`,`visibility`) values (2,'travel video','22222222222222222',2,1,'travel video.mp4',1443448,'video_thumbnails/nXEVSYbOVOIAcKFDQuUbCYGMzxV63dGwyTiv0JCU.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/video_thumbnails/nXEVSYbOVOIAcKFDQuUbCYGMzxV63dGwyTiv0JCU.jpeg','videos/e24a3cb803dacd92643329742e7d662e.mp4','https://streavr-app.s3-ap-southeast-1.amazonaws.com/videos/e24a3cb803dacd92643329742e7d662e.mp4',9223372036854775807,'2017-07-05 20:45:29','2017-07-05 20:45:29',1);
insert  into `videos`(`id`,`title`,`description`,`user_id`,`category_id`,`video_name`,`video_size`,`thumbnail`,`thumbnail_url`,`video`,`video_url`,`ordering`,`created_at`,`updated_at`,`visibility`) values (4,'japanese cherry bloom II','7777777777777777777',1,4,'flower.mp4',2443448,'video_thumbnails/FbjtXjzfdamuik38jjvX8vBEMK32KE5gjqqTPCGz.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/video_thumbnails/FbjtXjzfdamuik38jjvX8vBEMK32KE5gjqqTPCGz.jpeg','videos/20028cff745f6955ef4e419b3c7d3184.mp4','https://streavr-app.s3-ap-southeast-1.amazonaws.com/videos/20028cff745f6955ef4e419b3c7d3184.mp4',9223372036854775807,'2017-07-05 20:49:29','2017-07-05 20:49:29',1);
insert  into `videos`(`id`,`title`,`description`,`user_id`,`category_id`,`video_name`,`video_size`,`thumbnail`,`thumbnail_url`,`video`,`video_url`,`ordering`,`created_at`,`updated_at`,`visibility`) values (5,'cow video','cccccccccccccccccccccccccc',3,1,'cow.mp4',1443448,'video_thumbnails/TyTtx9TJIIF1E1nyDfgHoTvsHgZP6lWGv1mEIQJw.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/video_thumbnails/TyTtx9TJIIF1E1nyDfgHoTvsHgZP6lWGv1mEIQJw.jpeg','videos/eb61350964217e99ff80cd2ca8e39b92.mp4','https://streavr-app.s3-ap-southeast-1.amazonaws.com/videos/eb61350964217e99ff80cd2ca8e39b92.mp4',9223372036854775807,'2017-07-05 20:54:16','2017-07-05 20:54:16',1);
insert  into `videos`(`id`,`title`,`description`,`user_id`,`category_id`,`video_name`,`video_size`,`thumbnail`,`thumbnail_url`,`video`,`video_url`,`ordering`,`created_at`,`updated_at`,`visibility`) values (6,'bbbbbbbbbbbbbbb11','bbbbbbb11\r\nbbbbbbbbbbbbbbbbbbbbb',3,1,'graveyard cemetery I.mp4',NULL,'video_thumbnails/qtbzOMNBz6oA4xLvfAX08YPcds5aLTJsR8BFbUFQ.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/video_thumbnails/qtbzOMNBz6oA4xLvfAX08YPcds5aLTJsR8BFbUFQ.jpeg','videos/1a96186c1f2919e1fae74e53d0bd79bf.mp4','https://streavr-app.s3-ap-southeast-1.amazonaws.com/videos/1a96186c1f2919e1fae74e53d0bd79bf.mp4',9223372036854775807,'2017-07-06 05:20:51','2017-07-06 05:20:51',1);
insert  into `videos`(`id`,`title`,`description`,`user_id`,`category_id`,`video_name`,`video_size`,`thumbnail`,`thumbnail_url`,`video`,`video_url`,`ordering`,`created_at`,`updated_at`,`visibility`) values (7,'when a child is born',NULL,3,1,'japanese cherry bloom II.mp4',1443448,'video_thumbnails/HS7Zur1GSnlMaJjXfCOR5oqBq6uwde4qohGkFRci.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/video_thumbnails/HS7Zur1GSnlMaJjXfCOR5oqBq6uwde4qohGkFRci.jpeg','videos/89f1d15f2fcaa164950f96a3bb7b1331.mp4','https://streavr-app.s3-ap-southeast-1.amazonaws.com/videos/89f1d15f2fcaa164950f96a3bb7b1331.mp4',9223372036854775807,'2017-07-06 05:04:45','2017-07-06 05:04:45',1);
insert  into `videos`(`id`,`title`,`description`,`user_id`,`category_id`,`video_name`,`video_size`,`thumbnail`,`thumbnail_url`,`video`,`video_url`,`ordering`,`created_at`,`updated_at`,`visibility`) values (8,'mmmmmmmmmmmmmmm','mmm',3,1,'vineyard VI.mp4',1123123,'video_thumbnails/Gc4DQXgToqIUZIP420rh3bNL667kuEZq7vVMC96S.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/video_thumbnails/Gc4DQXgToqIUZIP420rh3bNL667kuEZq7vVMC96S.jpeg','videos/6370ff864314c9182c9e9899d468afbd.mp4','https://streavr-app.s3-ap-southeast-1.amazonaws.com/videos/6370ff864314c9182c9e9899d468afbd.mp4',9223372036854775807,'2017-07-06 05:08:48','2017-07-06 05:08:48',1);
insert  into `videos`(`id`,`title`,`description`,`user_id`,`category_id`,`video_name`,`video_size`,`thumbnail`,`thumbnail_url`,`video`,`video_url`,`ordering`,`created_at`,`updated_at`,`visibility`) values (9,'simple wedding',NULL,1,5,'graveyard cemetery I.mp4',1443448,'video_thumbnails/mjtsymeSOFmDG4rvtnutyeyuTZ4HZnlZ4senqfzA.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/video_thumbnails/mjtsymeSOFmDG4rvtnutyeyuTZ4HZnlZ4senqfzA.jpeg','videos/3d191a4ddf9681f4f9709eabaa8db289.mp4','https://streavr-app.s3-ap-southeast-1.amazonaws.com/videos/3d191a4ddf9681f4f9709eabaa8db289.mp4',9223372036854775807,'2017-07-06 05:13:08','2017-07-06 05:13:08',1);
insert  into `videos`(`id`,`title`,`description`,`user_id`,`category_id`,`video_name`,`video_size`,`thumbnail`,`thumbnail_url`,`video`,`video_url`,`ordering`,`created_at`,`updated_at`,`visibility`) values (10,'30MB video file',NULL,1,1,'big_buck_bunny_720p_30mb.mp4',31491130,'video_thumbnails/oEjWSEm57yd5jrUJDu9vsbekbwgqwvRWE6yWWECV.jpeg','https://streavr-app.s3-ap-southeast-1.amazonaws.com/video_thumbnails/oEjWSEm57yd5jrUJDu9vsbekbwgqwvRWE6yWWECV.jpeg','videos/d7e304f98964e6c74c3dfac33f614c76.mp4','https://streavr-app.s3-ap-southeast-1.amazonaws.com/videos/d7e304f98964e6c74c3dfac33f614c76.mp4',9223372036854775807,'2017-07-08 12:05:37','2017-07-08 12:05:37',1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
