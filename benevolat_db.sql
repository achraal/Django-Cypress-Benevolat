-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 21 mai 2025 à 19:01
-- Version du serveur : 11.7.2-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `benevolat_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add mission', 6, 'add_mission'),
(22, 'Can change mission', 6, 'change_mission'),
(23, 'Can delete mission', 6, 'delete_mission'),
(24, 'Can view mission', 6, 'view_mission'),
(25, 'Can add competence', 7, 'add_competence'),
(26, 'Can change competence', 7, 'change_competence'),
(27, 'Can delete competence', 7, 'delete_competence'),
(28, 'Can view competence', 7, 'view_competence'),
(29, 'Can add benevole', 8, 'add_benevole'),
(30, 'Can change benevole', 8, 'change_benevole'),
(31, 'Can delete benevole', 8, 'delete_benevole'),
(32, 'Can view benevole', 8, 'view_benevole'),
(33, 'Can add liste attente', 9, 'add_listeattente'),
(34, 'Can change liste attente', 9, 'change_listeattente'),
(35, 'Can delete liste attente', 9, 'delete_listeattente'),
(36, 'Can view liste attente', 9, 'view_listeattente'),
(37, 'Can add evaluation', 10, 'add_evaluation'),
(38, 'Can change evaluation', 10, 'change_evaluation'),
(39, 'Can delete evaluation', 10, 'delete_evaluation'),
(40, 'Can view evaluation', 10, 'view_evaluation'),
(41, 'Can add signalement', 11, 'add_signalement'),
(42, 'Can change signalement', 11, 'change_signalement'),
(43, 'Can delete signalement', 11, 'delete_signalement'),
(44, 'Can view signalement', 11, 'view_signalement'),
(45, 'Can add historique participation', 12, 'add_historiqueparticipation'),
(46, 'Can change historique participation', 12, 'change_historiqueparticipation'),
(47, 'Can delete historique participation', 12, 'delete_historiqueparticipation'),
(48, 'Can view historique participation', 12, 'view_historiqueparticipation'),
(49, 'Can add association', 13, 'add_association'),
(50, 'Can change association', 13, 'change_association'),
(51, 'Can delete association', 13, 'delete_association'),
(52, 'Can view association', 13, 'view_association'),
(53, 'Can add user', 14, 'add_utilisateur'),
(54, 'Can change user', 14, 'change_utilisateur'),
(55, 'Can delete user', 14, 'delete_utilisateur'),
(56, 'Can view user', 14, 'view_utilisateur'),
(57, 'Can add message', 15, 'add_message'),
(58, 'Can change message', 15, 'change_message'),
(59, 'Can delete message', 15, 'delete_message'),
(60, 'Can view message', 15, 'view_message'),
(61, 'Can add notification', 16, 'add_notification'),
(62, 'Can change notification', 16, 'change_notification'),
(63, 'Can delete notification', 16, 'delete_notification'),
(64, 'Can view notification', 16, 'view_notification');

-- --------------------------------------------------------

--
-- Structure de la table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(13, 'missions', 'association'),
(8, 'missions', 'benevole'),
(7, 'missions', 'competence'),
(10, 'missions', 'evaluation'),
(12, 'missions', 'historiqueparticipation'),
(9, 'missions', 'listeattente'),
(6, 'missions', 'mission'),
(11, 'missions', 'signalement'),
(5, 'sessions', 'session'),
(15, 'utilisateurs', 'message'),
(16, 'utilisateurs', 'notification'),
(14, 'utilisateurs', 'utilisateur');

-- --------------------------------------------------------

--
-- Structure de la table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-04-22 19:20:42.230624'),
(2, 'contenttypes', '0002_remove_content_type_name', '2025-04-22 19:20:42.375673'),
(3, 'auth', '0001_initial', '2025-04-22 19:20:42.548531'),
(4, 'auth', '0002_alter_permission_name_max_length', '2025-04-22 19:20:42.591311'),
(5, 'auth', '0003_alter_user_email_max_length', '2025-04-22 19:20:42.603628'),
(6, 'auth', '0004_alter_user_username_opts', '2025-04-22 19:20:42.614897'),
(7, 'auth', '0005_alter_user_last_login_null', '2025-04-22 19:20:42.634625'),
(8, 'auth', '0006_require_contenttypes_0002', '2025-04-22 19:20:42.637454'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2025-04-22 19:20:42.649760'),
(10, 'auth', '0008_alter_user_username_max_length', '2025-04-22 19:20:42.667257'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2025-04-22 19:20:42.682986'),
(12, 'auth', '0010_alter_group_name_max_length', '2025-04-22 19:20:42.718450'),
(13, 'auth', '0011_update_proxy_permissions', '2025-04-22 19:20:42.739010'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2025-04-22 19:20:42.750822'),
(15, 'utilisateurs', '0001_initial', '2025-04-22 19:20:43.104828'),
(16, 'admin', '0001_initial', '2025-04-22 19:20:43.432968'),
(17, 'admin', '0002_logentry_remove_auto_add', '2025-04-22 19:20:43.446720'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2025-04-22 19:20:43.468701'),
(19, 'missions', '0001_initial', '2025-04-22 19:20:43.542088'),
(20, 'missions', '0002_mission_capacite_max_mission_inscrits', '2025-04-22 19:20:43.686979'),
(21, 'missions', '0003_competence_benevole_listeattente', '2025-04-22 19:20:43.963753'),
(22, 'missions', '0004_association', '2025-04-22 19:20:43.990093'),
(23, 'missions', '0005_delete_association_mission_disponibilites_requises_and_more', '2025-04-22 19:20:44.123270'),
(24, 'missions', '0006_alter_listeattente_benevole_and_more', '2025-04-22 19:20:44.862597'),
(25, 'missions', '0007_mission_urgent', '2025-04-22 19:20:44.916170'),
(26, 'missions', '0008_association', '2025-04-22 19:20:44.930371'),
(27, 'missions', '0009_evaluation_delete_association', '2025-04-22 19:20:45.062638'),
(28, 'missions', '0010_signalement', '2025-04-22 19:20:45.151242'),
(29, 'missions', '0011_participation', '2025-04-22 19:20:45.247940'),
(30, 'missions', '0012_historiqueparticipation_delete_participation', '2025-04-22 19:20:45.454900'),
(31, 'missions', '0013_remove_historiqueparticipation_role', '2025-04-22 19:20:45.536089'),
(32, 'missions', '0014_association', '2025-04-22 19:20:45.556458'),
(33, 'missions', '0015_mission_is_valid', '2025-04-22 19:20:45.641885'),
(34, 'missions', '0016_mission_date_creation', '2025-04-22 19:20:45.735367'),
(35, 'sessions', '0001_initial', '2025-04-22 19:20:45.800575'),
(36, 'utilisateurs', '0002_message', '2025-04-22 19:20:45.920135'),
(37, 'utilisateurs', '0003_notification', '2025-04-22 19:20:46.924391'),
(38, 'utilisateurs', '0004_utilisateur_is_valid', '2025-04-22 19:20:47.009900');

-- --------------------------------------------------------

--
-- Structure de la table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('d88hdl3ag61rca17ls7wt0tmmi4h0a5a', '.eJxVjEEOgjAQRe_StWloO4WpS_ecgcx0WkFNSSisjHcXEha6_e-9_1YDbes4bDUtwyTqqkBdfjem-EzlAPKgcp91nMu6TKwPRZ-06n6W9Lqd7t_BSHXcazS2E8dNBnAZxSME9kAu26YVH1DQArcJpcsOiRrpKERPSIbNbrL6fAHSqDfh:1u7gvs:H0OJCjPE-vuUhalSWxybl3gmar35ywwkHmAKJ0rBnmw', '2025-05-07 20:43:00.858920');

-- --------------------------------------------------------

--
-- Structure de la table `missions_association`
--

CREATE TABLE `missions_association` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `is_valid` tinyint(1) NOT NULL,
  `date_creation` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `missions_benevole`
--

CREATE TABLE `missions_benevole` (
  `id` bigint(20) NOT NULL,
  `disponibilites` varchar(200) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `missions_benevole_competences`
--

CREATE TABLE `missions_benevole_competences` (
  `id` bigint(20) NOT NULL,
  `benevole_id` bigint(20) NOT NULL,
  `competence_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `missions_competence`
--

CREATE TABLE `missions_competence` (
  `id` bigint(20) NOT NULL,
  `nom` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `missions_evaluation`
--

CREATE TABLE `missions_evaluation` (
  `id` bigint(20) NOT NULL,
  `note` int(11) NOT NULL,
  `commentaire` longtext NOT NULL,
  `date` datetime(6) NOT NULL,
  `benevole_id` bigint(20) NOT NULL,
  `mission_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `missions_evaluation`
--

INSERT INTO `missions_evaluation` (`id`, `note`, `commentaire`, `date`, `benevole_id`, `mission_id`) VALUES
(1, 5, 'Je soutiens énormément', '2025-04-23 21:20:48.946784', 7, 6),
(2, 4, '', '2025-05-20 20:46:51.818342', 7, 6);

-- --------------------------------------------------------

--
-- Structure de la table `missions_historiqueparticipation`
--

CREATE TABLE `missions_historiqueparticipation` (
  `id` bigint(20) NOT NULL,
  `date_participation` datetime(6) NOT NULL,
  `mission_id` bigint(20) NOT NULL,
  `utilisateur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `missions_historiqueparticipation`
--

INSERT INTO `missions_historiqueparticipation` (`id`, `date_participation`, `mission_id`, `utilisateur_id`) VALUES
(1, '2025-04-23 21:03:32.353294', 1, 7),
(2, '2025-04-23 21:03:35.380648', 3, 7),
(3, '2025-04-23 21:03:38.078729', 7, 7),
(4, '2025-04-23 21:03:40.251826', 6, 7),
(5, '2025-04-23 21:03:42.377649', 4, 7),
(6, '2025-04-23 21:03:46.306726', 5, 7),
(7, '2025-04-23 21:04:09.927208', 1, 5),
(8, '2025-04-23 21:04:29.978991', 1, 6),
(9, '2025-04-23 21:04:35.619821', 6, 6),
(10, '2025-04-23 21:05:02.857200', 1, 8),
(11, '2025-04-23 21:05:06.109277', 5, 8),
(12, '2025-04-23 21:05:33.212540', 1, 9),
(13, '2025-04-23 21:06:31.682323', 1, 10),
(14, '2025-04-23 21:06:35.016020', 6, 10),
(15, '2025-04-23 21:06:59.478927', 1, 12),
(16, '2025-04-23 21:07:53.877503', 1, 12),
(17, '2025-04-23 21:08:14.305678', 1, 13),
(18, '2025-04-23 21:10:08.105769', 1, 1),
(19, '2025-04-23 21:14:21.836184', 1, 14),
(20, '2025-04-23 21:36:36.965823', 5, 5),
(21, '2025-04-23 21:36:59.432183', 5, 14),
(22, '2025-04-23 21:37:16.102276', 5, 6),
(23, '2025-04-23 21:37:44.135413', 6, 15),
(24, '2025-04-29 20:15:32.638081', 6, 5),
(25, '2025-04-30 11:51:27.265090', 8, 9),
(26, '2025-05-14 21:46:39.848290', 8, 5),
(27, '2025-05-20 20:46:23.618341', 4, 7),
(28, '2025-05-20 20:53:05.834673', 4, 7);

-- --------------------------------------------------------

--
-- Structure de la table `missions_listeattente`
--

CREATE TABLE `missions_listeattente` (
  `id` bigint(20) NOT NULL,
  `date_inscription` datetime(6) NOT NULL,
  `benevole_id` bigint(20) NOT NULL,
  `mission_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `missions_listeattente`
--

INSERT INTO `missions_listeattente` (`id`, `date_inscription`, `benevole_id`, `mission_id`) VALUES
(1, '2025-04-23 21:18:23.013751', 15, 1),
(2, '2025-04-23 21:37:47.768755', 15, 5),
(3, '2025-04-29 19:42:19.100239', 4, 1),
(4, '2025-05-20 20:46:31.688047', 7, 5);

-- --------------------------------------------------------

--
-- Structure de la table `missions_mission`
--

CREATE TABLE `missions_mission` (
  `id` bigint(20) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `lieu` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `competences_requises` varchar(255) DEFAULT NULL,
  `categorie` varchar(100) NOT NULL,
  `cause` varchar(100) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `document` varchar(100) DEFAULT NULL,
  `association_id` bigint(20) NOT NULL,
  `capacite_max` int(10) UNSIGNED NOT NULL CHECK (`capacite_max` >= 0),
  `disponibilites_requises` varchar(255) DEFAULT NULL,
  `urgent` tinyint(1) NOT NULL,
  `is_valid` tinyint(1) NOT NULL,
  `date_creation` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `missions_mission`
--

INSERT INTO `missions_mission` (`id`, `titre`, `description`, `lieu`, `date`, `competences_requises`, `categorie`, `cause`, `image`, `document`, `association_id`, `capacite_max`, `disponibilites_requises`, `urgent`, `is_valid`, `date_creation`) VALUES
(1, 'Distribution alimentaire aux personnes démunies', 'Aider à la préparation et à la distribution de repas et colis alimentaires aux personnes en grande précarité.', 'Centre d\'accueil Les Restos, Paris', '2025-10-06', 'Organisation, empathie, gestion de stocks', 'Social', 'Lutte contre la pauvreté', '', '', 4, 10, 'Samedi matin', 1, 0, '2025-04-23 19:50:44.158450'),
(3, 'Centre d\'accueil et soutien pour mineurs non accompagnés', 'Hébergement temporaire et soutien médical, psychologique et légal pour mineurs vulnérables', 'Pantin, Île-de-France', '2025-01-06', 'Médecine, droit, psychologie, animation sociale', 'Social', 'Protection des mineurs vulnérables', '', '', 4, 10, 'Horaires flexibles, travail en équipe', 0, 0, '2025-04-23 20:50:00.984317'),
(4, 'Programme d\'urgence hivernal pour personnes sans-abris', 'Hébergement d\'urgence et distribution de matériel d\'hygiène durant l\'hiver', 'Paris', '2025-01-12', 'Logistique, gestion de crise, relation sociale', 'Humanitaire', 'Aide aux sans-abris', '', '', 4, 10, 'Soirée et nuit', 1, 1, '2025-04-23 20:53:28.523129'),
(5, 'Soutien psychologique aux victimes de catastrophes naturelles', 'Accompagnement psychologique des personnes touchées par des inondations dans la région PACA', 'Nice', '2025-05-30', 'Psychologie, écoute active', 'Santé mentale', 'Aide aux victimes', '', '', 4, 5, 'Horaires flexibles', 0, 1, '2025-04-23 20:56:31.466245'),
(6, 'Distribution de colis alimentaires à Gaza', 'Distribution de colis alimentaires pour 70 000 personnes pendant le Ramadan, incluant des denrées thérapeutiques.', 'Gaza', '2025-05-26', 'Logistique, distribution, gestion crise', 'Humanitaire', 'Crise alimentaire', '', '', 4, 45, 'Disponibilité flexible', 1, 1, '2025-04-23 20:58:54.329377'),
(7, 'Collecte et distribution de dons alimentaires', 'Coordination des collectes alimentaires et distribution aux familles en difficulté', 'Toulouse', '2025-05-05', 'Logistique, communication', 'Social', 'Lutte contre la précarité alimentaire', '', '', 4, 10, 'Week-end', 1, 1, '2025-04-23 21:00:36.453339'),
(8, 'Intervention médicale d’urgence au Soudan du Sud', 'Soins médicaux d’urgence aux populations déplacées, prise en charge des blessés, centre mobile', 'Juba, Soudan du Sud', '2025-05-15', 'Médecin généraliste, infirmier, chirurgien', 'Urgence médicale', 'Conflit', '', '', 3, 5, '1 à 3 mois', 0, 0, '2025-04-30 09:33:57.726411');

-- --------------------------------------------------------

--
-- Structure de la table `missions_mission_inscrits`
--

CREATE TABLE `missions_mission_inscrits` (
  `id` bigint(20) NOT NULL,
  `mission_id` bigint(20) NOT NULL,
  `utilisateur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `missions_mission_inscrits`
--

INSERT INTO `missions_mission_inscrits` (`id`, `mission_id`, `utilisateur_id`) VALUES
(18, 1, 1),
(7, 1, 5),
(8, 1, 6),
(1, 1, 7),
(10, 1, 8),
(12, 1, 9),
(13, 1, 10),
(15, 1, 12),
(17, 1, 13),
(19, 1, 14),
(2, 3, 7),
(5, 4, 7),
(20, 5, 5),
(22, 5, 6),
(6, 5, 7),
(11, 5, 8),
(21, 5, 14),
(24, 6, 5),
(9, 6, 6),
(4, 6, 7),
(14, 6, 10),
(23, 6, 15),
(3, 7, 7),
(26, 8, 5),
(25, 8, 9);

-- --------------------------------------------------------

--
-- Structure de la table `missions_signalement`
--

CREATE TABLE `missions_signalement` (
  `id` bigint(20) NOT NULL,
  `motif` longtext NOT NULL,
  `date_signalement` datetime(6) NOT NULL,
  `mission_id` bigint(20) NOT NULL,
  `utilisateur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `missions_signalement`
--

INSERT INTO `missions_signalement` (`id`, `motif`, `date_signalement`, `mission_id`, `utilisateur_id`) VALUES
(1, 'C\'est une arnaque', '2025-04-23 21:20:19.971191', 1, 7),
(2, 'arnaque', '2025-05-20 20:47:10.005401', 3, 7);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs_message`
--

CREATE TABLE `utilisateurs_message` (
  `id` bigint(20) NOT NULL,
  `contenu` longtext NOT NULL,
  `date_envoye` datetime(6) NOT NULL,
  `destinataire_id` bigint(20) NOT NULL,
  `expediteur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateurs_message`
--

INSERT INTO `utilisateurs_message` (`id`, `contenu`, `date_envoye`, `destinataire_id`, `expediteur_id`) VALUES
(1, 'Très bon travail', '2025-04-23 21:19:51.904884', 4, 7),
(2, 'Bonjour vos missions sont à la hauteur', '2025-04-29 19:39:59.908394', 4, 5),
(3, 'Salut ca va', '2025-05-01 13:50:57.712762', 5, 6),
(4, 'Tres bon travail', '2025-05-01 14:01:53.621678', 3, 6);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs_notification`
--

CREATE TABLE `utilisateurs_notification` (
  `id` bigint(20) NOT NULL,
  `message` longtext NOT NULL,
  `lu` tinyint(1) NOT NULL,
  `date` datetime(6) NOT NULL,
  `utilisateur_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateurs_notification`
--

INSERT INTO `utilisateurs_notification` (`id`, `message`, `lu`, `date`, `utilisateur_id`) VALUES
(1, 'Le bénévole achraf s\'est inscrit à la mission \'Distribution alimentaire aux personnes démunies\'.', 1, '2025-04-23 21:03:32.357988', 4),
(2, 'Le bénévole achraf s\'est inscrit à la mission \'Centre d\'accueil et soutien pour mineurs non accompagnés\'.', 0, '2025-04-23 21:03:35.389432', 4),
(3, 'Le bénévole achraf s\'est inscrit à la mission \'Collecte et distribution de dons alimentaires\'.', 1, '2025-04-23 21:03:38.086725', 4),
(4, 'Le bénévole achraf s\'est inscrit à la mission \'Distribution de colis alimentaires à Gaza\'.', 1, '2025-04-23 21:03:40.256652', 4),
(5, 'Le bénévole achraf s\'est inscrit à la mission \'Programme d\'urgence hivernal pour personnes sans-abris\'.', 0, '2025-04-23 21:03:42.384436', 4),
(6, 'Le bénévole achraf s\'est inscrit à la mission \'Soutien psychologique aux victimes de catastrophes naturelles\'.', 0, '2025-04-23 21:03:46.310439', 4),
(7, 'Le bénévole samad s\'est inscrit à la mission \'Distribution alimentaire aux personnes démunies\'.', 0, '2025-04-23 21:04:09.931438', 4),
(8, 'Le bénévole ayman s\'est inscrit à la mission \'Distribution alimentaire aux personnes démunies\'.', 0, '2025-04-23 21:04:29.985097', 4),
(9, 'Le bénévole ayman s\'est inscrit à la mission \'Distribution de colis alimentaires à Gaza\'.', 0, '2025-04-23 21:04:35.625238', 4),
(10, 'Le bénévole mehdi s\'est inscrit à la mission \'Distribution alimentaire aux personnes démunies\'.', 0, '2025-04-23 21:05:02.861914', 4),
(11, 'Le bénévole mehdi s\'est inscrit à la mission \'Soutien psychologique aux victimes de catastrophes naturelles\'.', 0, '2025-04-23 21:05:06.113772', 4),
(12, 'Le bénévole anas s\'est inscrit à la mission \'Distribution alimentaire aux personnes démunies\'.', 0, '2025-04-23 21:05:33.216950', 4),
(13, 'Le bénévole othmane s\'est inscrit à la mission \'Distribution alimentaire aux personnes démunies\'.', 0, '2025-04-23 21:06:31.687565', 4),
(14, 'Le bénévole othmane s\'est inscrit à la mission \'Distribution de colis alimentaires à Gaza\'.', 1, '2025-04-23 21:06:35.019854', 4),
(15, 'Le bénévole khalid s\'est inscrit à la mission \'Distribution alimentaire aux personnes démunies\'.', 0, '2025-04-23 21:06:59.482821', 4),
(16, 'Le bénévole khalid s\'est inscrit à la mission \'Distribution alimentaire aux personnes démunies\'.', 1, '2025-04-23 21:07:53.883978', 4),
(17, 'Le bénévole yassine s\'est inscrit à la mission \'Distribution alimentaire aux personnes démunies\'.', 1, '2025-04-23 21:08:14.313735', 4),
(18, 'Le bénévole malak s\'est inscrit à la mission \'Distribution alimentaire aux personnes démunies\'.', 0, '2025-04-23 21:10:08.109670', 4),
(19, 'Le bénévole salma s\'est inscrit à la mission \'Distribution alimentaire aux personnes démunies\'.', 0, '2025-04-23 21:14:21.841411', 4),
(20, 'Vous avez reçu un message de achraf.', 0, '2025-04-23 21:19:51.911316', 4),
(21, 'Le bénévole samad s\'est inscrit à la mission \'Soutien psychologique aux victimes de catastrophes naturelles\'.', 0, '2025-04-23 21:36:36.972118', 4),
(22, 'Le bénévole salma s\'est inscrit à la mission \'Soutien psychologique aux victimes de catastrophes naturelles\'.', 0, '2025-04-23 21:36:59.439520', 4),
(23, 'Le bénévole ayman s\'est inscrit à la mission \'Soutien psychologique aux victimes de catastrophes naturelles\'.', 1, '2025-04-23 21:37:16.110613', 4),
(24, 'Le bénévole maria s\'est inscrit à la mission \'Distribution de colis alimentaires à Gaza\'.', 0, '2025-04-23 21:37:44.143487', 4),
(25, 'Vous avez reçu un message de samad.', 1, '2025-04-29 19:39:59.913202', 4),
(26, 'Le bénévole samad s\'est inscrit à la mission \'Distribution de colis alimentaires à Gaza\'.', 1, '2025-04-29 20:15:32.647092', 4),
(27, 'Le bénévole anas s\'est inscrit à la mission \'Intervention médicale d’urgence au Soudan du Sud\'.', 0, '2025-04-30 11:51:27.271016', 3),
(28, 'Vous avez reçu un message de ayman.', 0, '2025-05-01 13:50:57.715547', 5),
(29, 'Vous avez reçu un message de ayman.', 0, '2025-05-01 14:01:53.627049', 3),
(30, 'Le bénévole samad s\'est inscrit à la mission \'Intervention médicale d’urgence au Soudan du Sud\'.', 0, '2025-05-14 21:46:39.864266', 3),
(31, 'Le bénévole achraf s\'est inscrit à la mission \'Programme d\'urgence hivernal pour personnes sans-abris\'.', 0, '2025-05-20 20:46:23.634379', 4),
(32, 'Le bénévole achraf s\'est inscrit à la mission \'Programme d\'urgence hivernal pour personnes sans-abris\'.', 0, '2025-05-20 20:53:05.840158', 4);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs_utilisateur`
--

CREATE TABLE `utilisateurs_utilisateur` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `type_utilisateur` varchar(20) NOT NULL,
  `is_valid` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateurs_utilisateur`
--

INSERT INTO `utilisateurs_utilisateur` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `type_utilisateur`, `is_valid`) VALUES
(1, 'pbkdf2_sha256$1000000$B4rWdiodT8FE3sR0Kgb6H6$1vMoqjmr5KIhGTIqV5a2DUb9mKo5dp672a2LsG6K08k=', '2025-04-23 21:10:03.735863', 0, 'malak', '', '', 'malak@gmail.com', 0, 1, '2025-04-23 19:20:40.302572', 'benevole', 0),
(2, 'pbkdf2_sha256$1000000$vvUYcSevLFBnlbrLgqQER4$cHH0woz8esLobQLviAMzy1oHvlY3eqAV80jAsOjr62g=', '2025-05-20 20:55:51.787791', 1, 'chouchou', '', '', 'achraf@gmail.com', 1, 1, '2025-04-23 19:23:50.982024', '', 0),
(3, 'pbkdf2_sha256$1000000$CFLMroyZ67qn3biBOwUQBB$pW+4t3UALieAUyJuRJwetFOeYqM0WK84aOw50mceNTs=', '2025-04-30 09:26:29.541704', 0, 'Medecins_sans_frontieres', '', '', 'msf@gmail.com', 0, 1, '2025-04-23 19:34:50.316484', 'association', 1),
(4, 'pbkdf2_sha256$1000000$uMrAM98paYgfp0K4DsivMB$6DmLTQ8HjOQlP3V1hvVuO7goJJuxKzPXKUTuXQrEVfY=', '2025-05-20 20:53:54.108502', 0, 'Croix_Rouge', '', '', 'cr@gmail.com', 0, 1, '2025-04-23 19:38:12.566131', 'association', 1),
(5, 'pbkdf2_sha256$1000000$6NVunQ7Om8Z1CpxVaIxDkz$GMs7eT792HDPAw24a+vO6DCZhYmaMmwXhMheMgzZDVE=', '2025-05-15 22:08:21.485712', 0, 'samad', '', '', 'samad@gmail.com', 0, 1, '2025-04-23 19:38:55.030838', 'benevole', 0),
(6, 'pbkdf2_sha256$1000000$Gq7PKzYRwQpBVHpXLBOehp$/y9DZg5lD4JH25Iotc1taBL+6Wx5TDd88vbXEqwdR5g=', '2025-05-01 14:01:37.138003', 0, 'ayman', '', '', 'ayman@gmail.com', 0, 1, '2025-04-23 19:39:20.107921', 'benevole', 0),
(7, 'pbkdf2_sha256$1000000$LJo8NJT3vsX0UIFNIQSevQ$4ivtlnbjts5f1oTLm2GlQT/iyAFdadwBw0CX+z1zMb8=', '2025-05-20 20:52:20.801647', 0, 'achraf', '', '', 'achraf@gmail.com', 0, 1, '2025-04-23 19:39:52.533364', 'benevole', 0),
(8, 'pbkdf2_sha256$1000000$6qJmncXzqa0Hz6hkppbnjb$d824FYBQW9kfvvBeXEFvig1mx4d905nWRcZtol2OciM=', '2025-04-23 21:04:56.882579', 0, 'mehdi', '', '', 'mehdi@gmail.com', 0, 1, '2025-04-23 19:41:22.268777', 'benevole', 0),
(9, 'pbkdf2_sha256$1000000$P3pXZJlEv0cxXgAbqJmCnC$wW3YyGe4SPDH5RFywxyiJnprI8mIIvNDpans8ZrqCv4=', '2025-04-30 11:50:56.682881', 0, 'anas', '', '', 'anas@gmail.com', 0, 1, '2025-04-23 19:41:43.768967', 'benevole', 0),
(10, 'pbkdf2_sha256$1000000$JFWrmGMCO0p7nQdxEDfd5i$yKJ1RwaZ23Xc9CFLPxwK8El3kA8q0Y7QJFlaMBPkIEQ=', '2025-04-23 21:06:24.466744', 0, 'othmane', '', '', 'othmane@gmail.com', 0, 1, '2025-04-23 19:42:07.400147', 'benevole', 0),
(11, 'pbkdf2_sha256$1000000$fvCv5b3SCN4yIY1Ic6saZK$vBeFgqbaPXHXtLsKT4nRoJDVmo2MoIVENc4N4w0wRRg=', '2025-04-23 19:42:28.525065', 0, 'taha', '', '', 'taha@gmail.com', 0, 1, '2025-04-23 19:42:26.908432', 'benevole', 0),
(12, 'pbkdf2_sha256$1000000$Qd2dYV300UoMG1ZeUWI8bI$/P4YUb7T8uWLbtBPs3I5jl2UcOOjsSFLNRgSPt9hjno=', '2025-04-23 21:06:52.482018', 0, 'khalid', '', '', 'khalid@gmail.com', 0, 1, '2025-04-23 19:42:49.714373', 'benevole', 0),
(13, 'pbkdf2_sha256$1000000$TEYOt22Imx59x2yKERZSul$4lr8gNhnGKrw3jBpsm3HWYjR2fS6jsTOGu4nvyx8sw4=', '2025-04-23 21:08:09.088784', 0, 'yassine', '', '', 'yassine@gmail.com', 0, 1, '2025-04-23 19:45:54.091369', 'benevole', 0),
(14, 'pbkdf2_sha256$1000000$mf074lY4i7XhPemOWuWS4o$iHKzDs16B5IIOo09VSY5+jKsG7c5EaWc+5CqMZ4OrPk=', '2025-04-23 21:36:54.015708', 0, 'salma', '', '', 'salma@gmail.com', 0, 1, '2025-04-23 21:14:15.565372', 'benevole', 0),
(15, 'pbkdf2_sha256$1000000$IrN7VjYEWOp6CUX9ylgHNJ$0pVBXC7aP9MRK+4SLpgT1h746SDU9wN6H+n0aOW55nU=', '2025-04-23 21:37:30.397871', 0, 'maria', '', '', 'maria@gmail.com', 0, 1, '2025-04-23 21:18:16.050592', 'benevole', 0),
(16, 'pbkdf2_sha256$1000000$qF44krGtzXI6g0u8Di1zPo$+sVmrmhkkIj3VKW9bcDl78kjDX4BV7o+2iuArCFDyoc=', '2025-04-29 20:23:57.109171', 0, 'Moqawalaty', '', '', 'moqawalaty@gmail.com', 0, 1, '2025-04-29 20:23:54.442862', 'association', 0);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs_utilisateur_groups`
--

CREATE TABLE `utilisateurs_utilisateur_groups` (
  `id` bigint(20) NOT NULL,
  `utilisateur_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs_utilisateur_user_permissions`
--

CREATE TABLE `utilisateurs_utilisateur_user_permissions` (
  `id` bigint(20) NOT NULL,
  `utilisateur_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Index pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Index pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Index pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_utilisateurs_utilisateur_id` (`user_id`);

--
-- Index pour la table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Index pour la table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Index pour la table `missions_association`
--
ALTER TABLE `missions_association`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `missions_benevole`
--
ALTER TABLE `missions_benevole`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Index pour la table `missions_benevole_competences`
--
ALTER TABLE `missions_benevole_competences`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `missions_benevole_compet_benevole_id_competence_i_54087f3d_uniq` (`benevole_id`,`competence_id`),
  ADD KEY `missions_benevole_co_competence_id_731f8c9d_fk_missions_` (`competence_id`);

--
-- Index pour la table `missions_competence`
--
ALTER TABLE `missions_competence`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `missions_evaluation`
--
ALTER TABLE `missions_evaluation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `missions_evaluation_benevole_id_f6ebefc0_fk_utilisate` (`benevole_id`),
  ADD KEY `missions_evaluation_mission_id_ac50aa1b_fk_missions_mission_id` (`mission_id`);

--
-- Index pour la table `missions_historiqueparticipation`
--
ALTER TABLE `missions_historiqueparticipation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `missions_historiquep_mission_id_93610f7d_fk_missions_` (`mission_id`),
  ADD KEY `missions_historiquep_utilisateur_id_85b18b24_fk_utilisate` (`utilisateur_id`);

--
-- Index pour la table `missions_listeattente`
--
ALTER TABLE `missions_listeattente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `missions_listeattente_mission_id_benevole_id_4a32db6a_uniq` (`mission_id`,`benevole_id`),
  ADD KEY `missions_listeattent_benevole_id_d8a519fb_fk_utilisate` (`benevole_id`);

--
-- Index pour la table `missions_mission`
--
ALTER TABLE `missions_mission`
  ADD PRIMARY KEY (`id`),
  ADD KEY `missions_mission_association_id_ad574c0a_fk_utilisate` (`association_id`);

--
-- Index pour la table `missions_mission_inscrits`
--
ALTER TABLE `missions_mission_inscrits`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `missions_mission_inscrit_mission_id_utilisateur_i_50c2cb40_uniq` (`mission_id`,`utilisateur_id`),
  ADD KEY `missions_mission_ins_utilisateur_id_d5e6c0cd_fk_utilisate` (`utilisateur_id`);

--
-- Index pour la table `missions_signalement`
--
ALTER TABLE `missions_signalement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `missions_signalement_mission_id_eb14d2a1_fk_missions_mission_id` (`mission_id`),
  ADD KEY `missions_signalement_utilisateur_id_2a272497_fk_utilisate` (`utilisateur_id`);

--
-- Index pour la table `utilisateurs_message`
--
ALTER TABLE `utilisateurs_message`
  ADD PRIMARY KEY (`id`),
  ADD KEY `utilisateurs_message_destinataire_id_9c263bbf_fk_utilisate` (`destinataire_id`),
  ADD KEY `utilisateurs_message_expediteur_id_9e8715f1_fk_utilisate` (`expediteur_id`);

--
-- Index pour la table `utilisateurs_notification`
--
ALTER TABLE `utilisateurs_notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `utilisateurs_notific_utilisateur_id_bc88b045_fk_utilisate` (`utilisateur_id`);

--
-- Index pour la table `utilisateurs_utilisateur`
--
ALTER TABLE `utilisateurs_utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Index pour la table `utilisateurs_utilisateur_groups`
--
ALTER TABLE `utilisateurs_utilisateur_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `utilisateurs_utilisateur_utilisateur_id_group_id_954b1d5c_uniq` (`utilisateur_id`,`group_id`),
  ADD KEY `utilisateurs_utilisa_group_id_9cd3c896_fk_auth_grou` (`group_id`);

--
-- Index pour la table `utilisateurs_utilisateur_user_permissions`
--
ALTER TABLE `utilisateurs_utilisateur_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `utilisateurs_utilisateur_utilisateur_id_permissio_a16db5bb_uniq` (`utilisateur_id`,`permission_id`),
  ADD KEY `utilisateurs_utilisa_permission_id_42b32d4e_fk_auth_perm` (`permission_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT pour la table `missions_association`
--
ALTER TABLE `missions_association`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `missions_benevole`
--
ALTER TABLE `missions_benevole`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `missions_benevole_competences`
--
ALTER TABLE `missions_benevole_competences`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `missions_competence`
--
ALTER TABLE `missions_competence`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `missions_evaluation`
--
ALTER TABLE `missions_evaluation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `missions_historiqueparticipation`
--
ALTER TABLE `missions_historiqueparticipation`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `missions_listeattente`
--
ALTER TABLE `missions_listeattente`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `missions_mission`
--
ALTER TABLE `missions_mission`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `missions_mission_inscrits`
--
ALTER TABLE `missions_mission_inscrits`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `missions_signalement`
--
ALTER TABLE `missions_signalement`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `utilisateurs_message`
--
ALTER TABLE `utilisateurs_message`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `utilisateurs_notification`
--
ALTER TABLE `utilisateurs_notification`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT pour la table `utilisateurs_utilisateur`
--
ALTER TABLE `utilisateurs_utilisateur`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `utilisateurs_utilisateur_groups`
--
ALTER TABLE `utilisateurs_utilisateur_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `utilisateurs_utilisateur_user_permissions`
--
ALTER TABLE `utilisateurs_utilisateur_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Contraintes pour la table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Contraintes pour la table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_utilisateurs_utilisateur_id` FOREIGN KEY (`user_id`) REFERENCES `utilisateurs_utilisateur` (`id`);

--
-- Contraintes pour la table `missions_benevole`
--
ALTER TABLE `missions_benevole`
  ADD CONSTRAINT `missions_benevole_user_id_ab3975f4_fk_utilisate` FOREIGN KEY (`user_id`) REFERENCES `utilisateurs_utilisateur` (`id`);

--
-- Contraintes pour la table `missions_benevole_competences`
--
ALTER TABLE `missions_benevole_competences`
  ADD CONSTRAINT `missions_benevole_co_benevole_id_fdebf62f_fk_missions_` FOREIGN KEY (`benevole_id`) REFERENCES `missions_benevole` (`id`),
  ADD CONSTRAINT `missions_benevole_co_competence_id_731f8c9d_fk_missions_` FOREIGN KEY (`competence_id`) REFERENCES `missions_competence` (`id`);

--
-- Contraintes pour la table `missions_evaluation`
--
ALTER TABLE `missions_evaluation`
  ADD CONSTRAINT `missions_evaluation_benevole_id_f6ebefc0_fk_utilisate` FOREIGN KEY (`benevole_id`) REFERENCES `utilisateurs_utilisateur` (`id`),
  ADD CONSTRAINT `missions_evaluation_mission_id_ac50aa1b_fk_missions_mission_id` FOREIGN KEY (`mission_id`) REFERENCES `missions_mission` (`id`);

--
-- Contraintes pour la table `missions_historiqueparticipation`
--
ALTER TABLE `missions_historiqueparticipation`
  ADD CONSTRAINT `missions_historiquep_mission_id_93610f7d_fk_missions_` FOREIGN KEY (`mission_id`) REFERENCES `missions_mission` (`id`),
  ADD CONSTRAINT `missions_historiquep_utilisateur_id_85b18b24_fk_utilisate` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs_utilisateur` (`id`);

--
-- Contraintes pour la table `missions_listeattente`
--
ALTER TABLE `missions_listeattente`
  ADD CONSTRAINT `missions_listeattent_benevole_id_d8a519fb_fk_utilisate` FOREIGN KEY (`benevole_id`) REFERENCES `utilisateurs_utilisateur` (`id`),
  ADD CONSTRAINT `missions_listeattente_mission_id_fbd532b9_fk_missions_mission_id` FOREIGN KEY (`mission_id`) REFERENCES `missions_mission` (`id`);

--
-- Contraintes pour la table `missions_mission`
--
ALTER TABLE `missions_mission`
  ADD CONSTRAINT `missions_mission_association_id_ad574c0a_fk_utilisate` FOREIGN KEY (`association_id`) REFERENCES `utilisateurs_utilisateur` (`id`);

--
-- Contraintes pour la table `missions_mission_inscrits`
--
ALTER TABLE `missions_mission_inscrits`
  ADD CONSTRAINT `missions_mission_ins_mission_id_a2e22282_fk_missions_` FOREIGN KEY (`mission_id`) REFERENCES `missions_mission` (`id`),
  ADD CONSTRAINT `missions_mission_ins_utilisateur_id_d5e6c0cd_fk_utilisate` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs_utilisateur` (`id`);

--
-- Contraintes pour la table `missions_signalement`
--
ALTER TABLE `missions_signalement`
  ADD CONSTRAINT `missions_signalement_mission_id_eb14d2a1_fk_missions_mission_id` FOREIGN KEY (`mission_id`) REFERENCES `missions_mission` (`id`),
  ADD CONSTRAINT `missions_signalement_utilisateur_id_2a272497_fk_utilisate` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs_utilisateur` (`id`);

--
-- Contraintes pour la table `utilisateurs_message`
--
ALTER TABLE `utilisateurs_message`
  ADD CONSTRAINT `utilisateurs_message_destinataire_id_9c263bbf_fk_utilisate` FOREIGN KEY (`destinataire_id`) REFERENCES `utilisateurs_utilisateur` (`id`),
  ADD CONSTRAINT `utilisateurs_message_expediteur_id_9e8715f1_fk_utilisate` FOREIGN KEY (`expediteur_id`) REFERENCES `utilisateurs_utilisateur` (`id`);

--
-- Contraintes pour la table `utilisateurs_notification`
--
ALTER TABLE `utilisateurs_notification`
  ADD CONSTRAINT `utilisateurs_notific_utilisateur_id_bc88b045_fk_utilisate` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs_utilisateur` (`id`);

--
-- Contraintes pour la table `utilisateurs_utilisateur_groups`
--
ALTER TABLE `utilisateurs_utilisateur_groups`
  ADD CONSTRAINT `utilisateurs_utilisa_group_id_9cd3c896_fk_auth_grou` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `utilisateurs_utilisa_utilisateur_id_3264257e_fk_utilisate` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs_utilisateur` (`id`);

--
-- Contraintes pour la table `utilisateurs_utilisateur_user_permissions`
--
ALTER TABLE `utilisateurs_utilisateur_user_permissions`
  ADD CONSTRAINT `utilisateurs_utilisa_permission_id_42b32d4e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `utilisateurs_utilisa_utilisateur_id_604dcf80_fk_utilisate` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs_utilisateur` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
