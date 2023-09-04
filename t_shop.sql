-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 17 juil. 2023 à 10:59
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `t_shop`
--

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

CREATE TABLE `commande` (
  `id` int(11) NOT NULL,
  `membre_id` int(11) NOT NULL,
  `quantite` int(11) NOT NULL,
  `montant` double NOT NULL,
  `etat` varchar(255) NOT NULL,
  `date_enregistrement` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`id`, `membre_id`, `quantite`, `montant`, `etat`, `date_enregistrement`) VALUES
(9, 3, 17, 272, 'en cours de traitement', '2023-07-16 17:56:01'),
(10, 3, 19, 379.81, 'en cours de traitement', '2023-07-17 06:35:39'),
(11, 3, 17, 339.83, 'en cours de traitement', '2023-07-17 06:36:07'),
(12, 3, 17, 339.83, 'en cours de traitement', '2023-07-17 06:37:58'),
(13, 3, 17, 339.83, 'en cours de traitement', '2023-07-17 06:39:04'),
(14, 3, 10, 199.9, 'en cours de traitement', '2023-07-17 06:40:21'),
(15, 3, 3, 59.97, 'en cours de traitement', '2023-07-17 06:41:06'),
(16, 3, 15, 299.85, 'en cours de traitement', '2023-07-17 06:42:44'),
(17, 3, 0, 0, 'en cours de traitement', '2023-07-17 06:42:45'),
(18, 3, 15, 299.85, 'en cours de traitement', '2023-07-17 06:43:13'),
(19, 3, 2, 39.98, 'en cours de traitement', '2023-07-17 06:43:53'),
(20, 3, 209, 4177.91, 'en cours de traitement', '2023-07-17 07:15:32'),
(21, 3, 24, 479.76, 'en cours de traitement', '2023-07-17 09:37:05');

-- --------------------------------------------------------

--
-- Structure de la table `commande_produit`
--

CREATE TABLE `commande_produit` (
  `commande_id` int(11) NOT NULL,
  `produit_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `commande_produit`
--

INSERT INTO `commande_produit` (`commande_id`, `produit_id`) VALUES
(10, 5),
(10, 6),
(11, 5),
(12, 7),
(13, 5),
(14, 6),
(15, 7),
(16, 6),
(18, 7),
(19, 8),
(20, 5),
(21, 6),
(21, 7);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230623073658', '2023-06-25 11:09:01', 291);

-- --------------------------------------------------------

--
-- Structure de la table `membre`
--

CREATE TABLE `membre` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) NOT NULL,
  `pseudo` varchar(255) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `civilite` varchar(255) NOT NULL,
  `date_enregistrement` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `membre`
--

INSERT INTO `membre` (`id`, `email`, `roles`, `password`, `pseudo`, `nom`, `prenom`, `civilite`, `date_enregistrement`) VALUES
(2, 'ferreiravincent115@gmail.com', '[\"ROLE_ADMIN\"]', '$2y$13$.gYG2S/B1ZS0MxGZejEnGOJbUchOnDHPRgaNX/OKKkPPCb.KaLWky', 'yoshiro', 'admin', 'admin', 'homme', '2023-07-12 11:19:33'),
(3, 'admin@admin.com', '[\"ROLE_ADMIN\"]', '$2y$13$.U/cnb5pI09GzT.q5Q3mAuXBDtUJ2eXicniZQeyp/.wb5YewJirlG', 'admin', 'admin', 'admin', 'homme', '2023-07-16 17:53:50');

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE `produit` (
  `id` int(11) NOT NULL,
  `titre` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `couleur` varchar(255) NOT NULL,
  `taille` varchar(255) NOT NULL,
  `collection` varchar(255) NOT NULL,
  `photo` varchar(255) NOT NULL,
  `prix` double NOT NULL,
  `stock` int(11) NOT NULL,
  `date_enregistrement` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id`, `titre`, `description`, `couleur`, `taille`, `collection`, `photo`, `prix`, `stock`, `date_enregistrement`) VALUES
(5, 'Minato', '<div>Minato</div>', 'blanc', 'M', 'homme', '1687727126-naruto-066568e34798f3f631c92d73040f1881b1c75de9.webp', 1999, 0, '2023-06-25 23:05:26'),
(6, 'Jiraya', '<div>A grenouille tu vas plus vite</div>', 'rouge', 'L', 'homme', '1687727175-naruto2-f89309d6f60c4072a186cd0c97b34c140be6b168.webp', 1999, 48, '2023-06-25 23:06:15'),
(7, 'Naruto run', '<div>Datemayo</div>', 'jaune', 'XL', 'homme', '1687727231-naruto4-e3771f6dffbeac6a80a01288e958e73e9683764c.webp', 1999, 5, '2023-06-25 23:07:11'),
(8, 'Kakashi', '<blockquote>Kakashi avait mal au ventre</blockquote>', 'bleu', 'M', 'homme', '1687727288-naruto3-f1875feb6e995fe20444308fc481b3819af21da5.webp', 1999, 8, '2023-06-25 23:08:08'),
(9, 'Marcel', '<div>jolie marcel</div>', 'bleu', 'S', 'femme', '1689565529-femme1-9af49593d494f5adb5d72cc281c89056d8f6b279.webp', 1999, 50, '2023-07-17 05:45:29'),
(10, 'Croc-top', '<div>jolie croc</div>', 'bleu', 'M', 'femme', '1689565567-femme3-b3680358fc51ccf66339855a1c548e6a90601615.webp', 1500, 48, '2023-07-17 05:46:07'),
(11, 'Croc-top Vert', '<div>jolie vert</div>', 'bleu', 'L', 'femme', '1689565608-femme4-317a338666478263159023bc085d44e8a9eb3d5a.webp', 1500, 40, '2023-07-17 05:46:48'),
(12, 'T-shirt Bleu', '<div><em>amazing</em></div>', 'bleu', 'M', 'femme', '1689565644-femme2-7a43680620e8867ccb11be9ae3a0c4c8130ea77a.webp', 5000, 48, '2023-07-17 05:47:24');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6EEAA67D6A99F74A` (`membre_id`);

--
-- Index pour la table `commande_produit`
--
ALTER TABLE `commande_produit`
  ADD PRIMARY KEY (`commande_id`,`produit_id`),
  ADD KEY `IDX_DF1E9E8782EA2E54` (`commande_id`),
  ADD KEY `IDX_DF1E9E87F347EFB` (`produit_id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `membre`
--
ALTER TABLE `membre`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_F6B4FB29E7927C74` (`email`);

--
-- Index pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Index pour la table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `commande`
--
ALTER TABLE `commande`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `membre`
--
ALTER TABLE `membre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `produit`
--
ALTER TABLE `produit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `FK_6EEAA67D6A99F74A` FOREIGN KEY (`membre_id`) REFERENCES `membre` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `commande_produit`
--
ALTER TABLE `commande_produit`
  ADD CONSTRAINT `FK_DF1E9E8782EA2E54` FOREIGN KEY (`commande_id`) REFERENCES `commande` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_DF1E9E87F347EFB` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
