-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: tweet_contents
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tweet_contents`
--

DROP TABLE IF EXISTS `tweet_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tweet_contents` (
  `url` text,
  `text` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tweet_contents`
--

LOCK TABLES `tweet_contents` WRITE;
/*!40000 ALTER TABLE `tweet_contents` DISABLE KEYS */;
INSERT INTO `tweet_contents` VALUES ('https://x.com/RedcarWorker/status/1884438611892002832','\'연두색 번호판\' 도입 이후, 고급 법인차 수요가 많이 줄은 건 사실입니다. 수입차 업계에서는 이게 상당히 큰 위기로 다가오는 듯 하더군요. 한국은 시장 규모에 비해 고급차 소비가 많았으니까요.'),('https://x.com/dcyu41/status/1833124532036809109','법인 차량은 전부 연두색 번호판을 달아야지 무슨 금액으로 구별하냐\n어느 미친 공무원이 그따위 안을 만들었나  징계하라'),('https://x.com/DrOMD/status/1884391832110666207','이 뉴스 너무 한국적인 기사다. 1억원 이상 고가 수입차 많은 사람들이 법인 용으로 타고 다니다가, 연두색 법인 번호판 부착 제도로 이제 안 탄대. 정말 웃프다.'),('https://x.com/unniecar/status/1799317501131759743','8천만원 이상 법인차는 번호판이 연두색으로 바뀌었는데, 차를 연두색으로 깔맞춤해 버린 장면이네요'),('https://x.com/jayinfrozen/status/1832312685893185879','연두색 번호판 외제고급차에 개큰편견있음'),('https://x.com/saemirae24/status/1819531443108041143','이거 아이디어 좋은데요?\n연두색 법인 번호판 자동차처럼\n결재 될 때마다 정체 말해주는 법 만들어주세요.'),('https://x.com/zesize/status/1770371301460656463','연두색 번호판 단 s650 봤는데 나름 또 힙함 ㅋㅋㅋ 보면 뭐 사업하는 사람인가보다 하지 ㅋㅋㅋ 다만 주말에 마주치면 신고하겠다고 각오다지는 사람 내 주변에 이미 많음 ㅋㅋㅋ');
/*!40000 ALTER TABLE `tweet_contents` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-11 12:02:26
