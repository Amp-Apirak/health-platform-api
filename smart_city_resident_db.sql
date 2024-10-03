-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 03, 2024 at 07:29 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smart_city_resident_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสที่อยู่ (UUID)',
  `citizen_id` varchar(36) NOT NULL COMMENT 'รหัสประชาชน (เชื่อมโยงกับตาราง citizens)',
  `address_type` enum('ที่อยู่ตามทะเบียนบ้าน','ที่อยู่ปัจจุบัน','ที่ทำงาน') NOT NULL COMMENT 'ประเภทที่อยู่',
  `house_no` varchar(20) DEFAULT NULL COMMENT 'บ้านเลขที่',
  `village_no` varchar(10) DEFAULT NULL COMMENT 'หมู่ที่',
  `lane` varchar(100) DEFAULT NULL COMMENT 'ซอย',
  `road` varchar(100) DEFAULT NULL COMMENT 'ถนน',
  `sub_district` varchar(100) DEFAULT NULL COMMENT 'ตำบล/แขวง',
  `district` varchar(100) DEFAULT NULL COMMENT 'อำเภอ/เขต',
  `province` varchar(100) DEFAULT NULL COMMENT 'จังหวัด',
  `postal_code` varchar(5) DEFAULT NULL COMMENT 'รหัสไปรษณีย์',
  `is_current` tinyint(1) DEFAULT 1 COMMENT 'เป็นที่อยู่ปัจจุบันหรือไม่',
  `latitude` decimal(10,8) DEFAULT NULL COMMENT 'ละติจูด',
  `longitude` decimal(11,8) DEFAULT NULL COMMENT 'ลองจิจูด',
  `nearby_landmarks` text DEFAULT NULL COMMENT 'บริเวณใกล้เคียงจุดสังเกต',
  `residence_type` varchar(100) DEFAULT NULL COMMENT 'ลักษณะที่อยู่อาศัย',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด',
  `is_registered_address` tinyint(1) DEFAULT 0 COMMENT 'เป็นที่อยู่ตามทะเบียนบ้านหรือไม่'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลที่อยู่ของประชาชน';

-- --------------------------------------------------------

--
-- Table structure for table `address_images`
--

CREATE TABLE `address_images` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสรูปภาพ (UUID)',
  `address_id` varchar(36) NOT NULL COMMENT 'รหัสที่อยู่ (เชื่อมโยงกับตาราง addresses)',
  `image_path` varchar(255) NOT NULL COMMENT 'ที่อยู่ไฟล์รูปภาพ',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บรูปภาพที่อยู่';

-- --------------------------------------------------------

--
-- Table structure for table `allergies`
--

CREATE TABLE `allergies` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสข้อมูลการแพ้ (UUID)',
  `citizen_id` varchar(36) NOT NULL COMMENT 'รหัสประชาชน (เชื่อมโยงกับตาราง citizens)',
  `allergy_type` enum('อาหาร','ยา','ผลิตภัณฑ์','อื่นๆ') NOT NULL COMMENT 'ประเภทการแพ้',
  `allergy_name` varchar(200) NOT NULL COMMENT 'ชื่อสิ่งที่แพ้',
  `symptoms` text DEFAULT NULL COMMENT 'อาการ',
  `severity` enum('เล็กน้อย','ปานกลาง','รุนแรง') DEFAULT NULL COMMENT 'ระดับความรุนแรง',
  `treatment` text DEFAULT NULL COMMENT 'การรักษา',
  `hospital` varchar(200) DEFAULT NULL COMMENT 'โรงพยาบาลที่รักษา',
  `doctor` varchar(200) DEFAULT NULL COMMENT 'แพทย์ประจำตัว',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลการแพ้ของประชาชน';

-- --------------------------------------------------------

--
-- Table structure for table `birth_records`
--

CREATE TABLE `birth_records` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสข้อมูลการเกิด (UUID)',
  `citizen_id` varchar(36) NOT NULL COMMENT 'รหัสประชาชน (เชื่อมโยงกับตาราง citizens)',
  `birth_certificate_no` varchar(20) DEFAULT NULL COMMENT 'เลขที่สูติบัตร',
  `place_of_birth` varchar(200) DEFAULT NULL COMMENT 'สถานที่เกิด',
  `birth_weight` decimal(5,2) DEFAULT NULL COMMENT 'น้ำหนักแรกเกิด (กิโลกรัม)',
  `birth_height` decimal(5,2) DEFAULT NULL COMMENT 'ความยาวแรกเกิด (เซนติเมตร)',
  `father_id` varchar(36) DEFAULT NULL COMMENT 'รหัสประชาชนของบิดา',
  `mother_id` varchar(36) DEFAULT NULL COMMENT 'รหัสประชาชนของมารดา',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลการเกิดของประชาชน';

-- --------------------------------------------------------

--
-- Table structure for table `citizens`
--

CREATE TABLE `citizens` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสประจำตัวในระบบ (UUID)',
  `national_id` varchar(13) NOT NULL COMMENT 'เลขบัตรประชาชน',
  `title` varchar(20) DEFAULT NULL COMMENT 'คำนำหน้าชื่อ',
  `first_name` varchar(100) NOT NULL COMMENT 'ชื่อ',
  `last_name` varchar(100) NOT NULL COMMENT 'นามสกุล',
  `nickname` varchar(50) DEFAULT NULL COMMENT 'ชื่อเล่น',
  `gender` enum('ชาย','หญิง','อื่นๆ') NOT NULL COMMENT 'เพศ',
  `date_of_birth` date NOT NULL COMMENT 'วันเดือนปีเกิด',
  `blood_type` enum('A','B','AB','O') DEFAULT NULL COMMENT 'กรุ๊ปเลือด',
  `religion` varchar(50) DEFAULT NULL COMMENT 'ศาสนา',
  `nationality` varchar(50) DEFAULT NULL COMMENT 'สัญชาติ',
  `ethnicity` varchar(50) DEFAULT NULL COMMENT 'เชื้อชาติ',
  `marital_status` enum('โสด','สมรส','หย่าร้าง','หม้าย') DEFAULT NULL COMMENT 'สถานภาพสมรส',
  `phone_number` varchar(20) DEFAULT NULL COMMENT 'เบอร์โทรศัพท์',
  `email` varchar(100) DEFAULT NULL COMMENT 'อีเมล',
  `line_id` varchar(50) DEFAULT NULL COMMENT 'ไลน์ไอดี',
  `emergency_contact_name` varchar(200) DEFAULT NULL COMMENT 'ชื่อผู้ติดต่อฉุกเฉิน',
  `emergency_contact_phone` varchar(20) DEFAULT NULL COMMENT 'เบอร์โทรผู้ติดต่อฉุกเฉิน',
  `profile_image` varchar(255) DEFAULT NULL COMMENT 'ที่อยู่ไฟล์รูปโปรไฟล์',
  `organization_id` varchar(36) DEFAULT NULL COMMENT 'รหัสหน่วยงาน/องค์กรที่ดูแล',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด',
  `household_id` varchar(36) DEFAULT NULL COMMENT 'รหัสครัวเรือน (เชื่อมโยงกับตาราง households)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลประชาชน/ผู้รับบริการในระบบ';

--
-- Dumping data for table `citizens`
--

INSERT INTO `citizens` (`id`, `national_id`, `title`, `first_name`, `last_name`, `nickname`, `gender`, `date_of_birth`, `blood_type`, `religion`, `nationality`, `ethnicity`, `marital_status`, `phone_number`, `email`, `line_id`, `emergency_contact_name`, `emergency_contact_phone`, `profile_image`, `organization_id`, `created_at`, `updated_at`, `household_id`) VALUES
('2f740f8373ba40faaaf386beba0edb59', '1164053324444', 'นาย', 'อภิรักษ์', 'บางพุก', 'แอมป์', 'ชาย', '1990-04-05', 'A', 'พุทธ', 'ไทย', 'ไทย', 'โสด', '0812345678', 'apirak.ba@gmail.com', 'apirak', 'สมหญิง ใจดี', '0898765432', 'apirak.jpg', NULL, '2024-10-03 17:03:09', '2024-10-03 17:05:16', NULL),
('dbf98fe143d243d5a38aa491429c82e4', '1164053324579', 'นาย', 'สมชาย', 'ใจดี', 'amp', 'ชาย', '1990-01-01', 'A', 'พุทธ', 'ไทย', 'ไทย', 'โสด', '0812345678', 'somchai@example.com', 'somchai', 'สมหญิง ใจดี', '0898765432', 'somchai.jpg', NULL, '2024-10-03 16:09:02', '2024-10-03 16:09:02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `disabilities`
--

CREATE TABLE `disabilities` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสข้อมูลความพิการ (UUID)',
  `citizen_id` varchar(36) NOT NULL COMMENT 'รหัสประชาชน (เชื่อมโยงกับตาราง citizens)',
  `disability_type` varchar(100) DEFAULT NULL COMMENT 'ประเภทความพิการ',
  `disability_details` text DEFAULT NULL COMMENT 'รายละเอียดความพิการ',
  `disability_level` enum('เล็กน้อย','ปานกลาง','รุนแรง') DEFAULT NULL COMMENT 'ระดับความพิการ',
  `disability_certificate_no` varchar(20) DEFAULT NULL COMMENT 'เลขที่บัตรประจำตัวคนพิการ',
  `issue_date` date DEFAULT NULL COMMENT 'วันที่ออกบัตร',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลความพิการของประชาชน';

-- --------------------------------------------------------

--
-- Table structure for table `education`
--

CREATE TABLE `education` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสข้อมูลการศึกษา (UUID)',
  `citizen_id` varchar(36) NOT NULL COMMENT 'รหัสประชาชน (เชื่อมโยงกับตาราง citizens)',
  `education_level` enum('ประถมศึกษา','มัธยมศึกษาตอนต้น','มัธยมศึกษาตอนปลาย','อาชีวศึกษา','ปริญญาตรี','ปริญญาโท','ปริญญาเอก','อื่นๆ') DEFAULT NULL COMMENT 'ระดับการศึกษา',
  `institution_name` varchar(200) DEFAULT NULL COMMENT 'ชื่อสถาบันการศึกษา',
  `major` varchar(100) DEFAULT NULL COMMENT 'สาขาวิชา',
  `graduation_year` year(4) DEFAULT NULL COMMENT 'ปีที่สำเร็จการศึกษา',
  `gpa` decimal(3,2) DEFAULT NULL COMMENT 'เกรดเฉลี่ย',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลการศึกษาของประชาชน';

-- --------------------------------------------------------

--
-- Table structure for table `family_members`
--

CREATE TABLE `family_members` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสสมาชิกครอบครัว (UUID)',
  `citizen_id` varchar(36) NOT NULL COMMENT 'รหัสประชาชน (เชื่อมโยงกับตาราง citizens)',
  `relationship` enum('บิดา','มารดา','คู่สมรส','บุตร','พี่น้อง','อื่นๆ') NOT NULL COMMENT 'ความสัมพันธ์',
  `first_name` varchar(100) NOT NULL COMMENT 'ชื่อสมาชิกครอบครัว',
  `last_name` varchar(100) NOT NULL COMMENT 'นามสกุลสมาชิกครอบครัว',
  `date_of_birth` date DEFAULT NULL COMMENT 'วันเกิดสมาชิกครอบครัว',
  `occupation` varchar(100) DEFAULT NULL COMMENT 'อาชีพสมาชิกครอบครัว',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลสมาชิกครอบครัวของประชาชน';

-- --------------------------------------------------------

--
-- Table structure for table `genetic_diseases`
--

CREATE TABLE `genetic_diseases` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสข้อมูลโรคทางพันธุกรรม (UUID)',
  `citizen_id` varchar(36) NOT NULL COMMENT 'รหัสประชาชน (เชื่อมโยงกับตาราง citizens)',
  `disease_name` varchar(200) NOT NULL COMMENT 'ชื่อโรค',
  `relation` enum('ตนเอง','บิดา','มารดา','พี่น้อง','ญาติ') NOT NULL COMMENT 'ความสัมพันธ์กับผู้ป่วย',
  `details` text DEFAULT NULL COMMENT 'รายละเอียดเพิ่มเติม',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลโรคทางพันธุกรรมของประชาชนและญาติ';

-- --------------------------------------------------------

--
-- Table structure for table `households`
--

CREATE TABLE `households` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสครัวเรือน (UUID)',
  `house_registration_no` varchar(20) NOT NULL COMMENT 'เลขที่ทะเบียนบ้าน',
  `address_id` varchar(36) DEFAULT NULL COMMENT 'รหัสที่อยู่ (เชื่อมโยงกับตาราง addresses)',
  `household_head_id` varchar(36) DEFAULT NULL COMMENT 'รหัสประชาชนของหัวหน้าครัวเรือน',
  `household_members_count` int(11) DEFAULT 1 COMMENT 'จำนวนสมาชิกในครัวเรือน',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลครัวเรือนและทะเบียนบ้าน';

-- --------------------------------------------------------

--
-- Table structure for table `insurance_info`
--

CREATE TABLE `insurance_info` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสข้อมูลประกัน (UUID)',
  `citizen_id` varchar(36) NOT NULL COMMENT 'รหัสประชาชน (เชื่อมโยงกับตาราง citizens)',
  `insurance_type` enum('ประกันสังคม','บัตรทอง','ประกันสุขภาพเอกชน','สวัสดิการข้าราชการ','อื่นๆ') NOT NULL COMMENT 'ประเภทประกัน',
  `insurance_number` varchar(20) DEFAULT NULL COMMENT 'เลขที่บัตรประกัน',
  `provider` varchar(100) DEFAULT NULL COMMENT 'ผู้ให้บริการประกัน',
  `start_date` date DEFAULT NULL COMMENT 'วันที่เริ่มความคุ้มครอง',
  `end_date` date DEFAULT NULL COMMENT 'วันที่สิ้นสุดความคุ้มครอง',
  `coverage_details` text DEFAULT NULL COMMENT 'รายละเอียดความคุ้มครอง',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลประกันของประชาชน';

-- --------------------------------------------------------

--
-- Table structure for table `medical_history`
--

CREATE TABLE `medical_history` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสประวัติการรักษา (UUID)',
  `citizen_id` varchar(36) NOT NULL COMMENT 'รหัสประชาชน (เชื่อมโยงกับตาราง citizens)',
  `hospital_number` varchar(20) DEFAULT NULL COMMENT 'เลขประจำตัว HN',
  `treatment_type` enum('ทั่วไป','ผ่าตัด') DEFAULT NULL COMMENT 'ประเภทการรักษา',
  `diagnosis` varchar(200) DEFAULT NULL COMMENT 'การวินิจฉัยโรค',
  `treatment_date` date DEFAULT NULL COMMENT 'วันที่เข้ารับการรักษา',
  `treatment_details` text DEFAULT NULL COMMENT 'รายละเอียดการรักษา',
  `doctor_name` varchar(200) DEFAULT NULL COMMENT 'ชื่อแพทย์ผู้รักษา',
  `hospital_name` varchar(200) DEFAULT NULL COMMENT 'ชื่อโรงพยาบาล/สถานพยาบาล',
  `follow_up_date` date DEFAULT NULL COMMENT 'วันนัดติดตามอาการ',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บประวัติการรักษาของประชาชน';

-- --------------------------------------------------------

--
-- Table structure for table `occupations`
--

CREATE TABLE `occupations` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสข้อมูลอาชีพ (UUID)',
  `citizen_id` varchar(36) NOT NULL COMMENT 'รหัสประชาชน (เชื่อมโยงกับตาราง citizens)',
  `job_title` varchar(100) DEFAULT NULL COMMENT 'ตำแหน่งงาน',
  `company_name` varchar(200) DEFAULT NULL COMMENT 'ชื่อบริษัท/หน่วยงาน',
  `industry` varchar(100) DEFAULT NULL COMMENT 'อุตสาหกรรม',
  `employment_type` enum('เต็มเวลา','พาร์ทไทม์','สัญญาจ้าง','ฟรีแลนซ์','อื่นๆ') DEFAULT NULL COMMENT 'ประเภทการจ้างงาน',
  `start_date` date DEFAULT NULL COMMENT 'วันที่เริ่มงาน',
  `end_date` date DEFAULT NULL COMMENT 'วันที่สิ้นสุดการทำงาน',
  `monthly_income` decimal(10,2) DEFAULT NULL COMMENT 'รายได้ต่อเดือน',
  `job_description` text DEFAULT NULL COMMENT 'รายละเอียดงาน',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลอาชีพของประชาชน';

-- --------------------------------------------------------

--
-- Table structure for table `organizations`
--

CREATE TABLE `organizations` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสหน่วยงาน/องค์กร (UUID)',
  `name` varchar(200) NOT NULL COMMENT 'ชื่อหน่วยงาน/องค์กร',
  `description` text DEFAULT NULL COMMENT 'รายละเอียดหน่วยงาน/องค์กร',
  `contact_person` varchar(200) DEFAULT NULL COMMENT 'ชื่อผู้ติดต่อ',
  `contact_email` varchar(100) DEFAULT NULL COMMENT 'อีเมลผู้ติดต่อ',
  `contact_phone` varchar(20) DEFAULT NULL COMMENT 'เบอร์โทรผู้ติดต่อ',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลหน่วยงาน/องค์กรที่ดูแลประชาชน';

-- --------------------------------------------------------

--
-- Table structure for table `residency_history`
--

CREATE TABLE `residency_history` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสประวัติการย้ายที่อยู่ (UUID)',
  `citizen_id` varchar(36) NOT NULL COMMENT 'รหัสประชาชน (เชื่อมโยงกับตาราง citizens)',
  `previous_address_id` varchar(36) DEFAULT NULL COMMENT 'รหัสที่อยู่เดิม (เชื่อมโยงกับตาราง addresses)',
  `new_address_id` varchar(36) DEFAULT NULL COMMENT 'รหัสที่อยู่ใหม่ (เชื่อมโยงกับตาราง addresses)',
  `move_in_date` date DEFAULT NULL COMMENT 'วันที่ย้ายเข้า',
  `move_out_date` date DEFAULT NULL COMMENT 'วันที่ย้ายออก',
  `reason_for_move` text DEFAULT NULL COMMENT 'เหตุผลในการย้าย',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บประวัติการย้ายที่อยู่ของประชาชน';

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสข้อมูลทักษะ (UUID)',
  `citizen_id` varchar(36) NOT NULL COMMENT 'รหัสประชาชน (เชื่อมโยงกับตาราง citizens)',
  `skill_name` varchar(100) DEFAULT NULL COMMENT 'ชื่อทักษะ',
  `proficiency_level` enum('เริ่มต้น','ปานกลาง','ชำนาญ','เชี่ยวชาญ') DEFAULT NULL COMMENT 'ระดับความชำนาญ',
  `years_of_experience` int(11) DEFAULT NULL COMMENT 'จำนวนปีประสบการณ์',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลทักษะและความสามารถพิเศษของประชาชน';

-- --------------------------------------------------------

--
-- Table structure for table `vaccinations`
--

CREATE TABLE `vaccinations` (
  `id` varchar(36) NOT NULL COMMENT 'รหัสการฉีดวัคซีน (UUID)',
  `citizen_id` varchar(36) NOT NULL COMMENT 'รหัสประชาชน (เชื่อมโยงกับตาราง citizens)',
  `vaccine_name` varchar(100) NOT NULL COMMENT 'ชื่อวัคซีน',
  `vaccine_type` varchar(50) DEFAULT NULL COMMENT 'ประเภทวัคซีน (เช่น mRNA, เชื้อตาย)',
  `manufacturer` varchar(100) DEFAULT NULL COMMENT 'บริษัทผู้ผลิตวัคซีน',
  `dose_number` int(11) NOT NULL COMMENT 'เข็มที่',
  `vaccination_date` date NOT NULL COMMENT 'วันที่ฉีดวัคซีน',
  `lot_number` varchar(50) DEFAULT NULL COMMENT 'หมายเลขล็อตวัคซีน',
  `vaccination_site` varchar(200) DEFAULT NULL COMMENT 'สถานที่ฉีดวัคซีน',
  `healthcare_provider` varchar(200) DEFAULT NULL COMMENT 'ผู้ให้บริการฉีดวัคซีน',
  `next_dose_date` date DEFAULT NULL COMMENT 'วันนัดฉีดครั้งถัดไป (ถ้ามี)',
  `side_effects` text DEFAULT NULL COMMENT 'ผลข้างเคียงที่พบ (ถ้ามี)',
  `vaccination_certificate_no` varchar(50) DEFAULT NULL COMMENT 'เลขที่ใบรับรองการฉีดวัคซีน',
  `vaccination_status` enum('ฉีดครบ','รอฉีดเข็มถัดไป','ยังไม่ครบตามกำหนด') NOT NULL COMMENT 'สถานะการฉีดวัคซีน',
  `notes` text DEFAULT NULL COMMENT 'หมายเหตุเพิ่มเติม',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'วันที่สร้างข้อมูล',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่อัปเดตข้อมูลล่าสุด'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ตารางเก็บข้อมูลการฉีดวัคซีนของประชาชน';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizen_id` (`citizen_id`);

--
-- Indexes for table `address_images`
--
ALTER TABLE `address_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `address_id` (`address_id`);

--
-- Indexes for table `allergies`
--
ALTER TABLE `allergies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizen_id` (`citizen_id`);

--
-- Indexes for table `birth_records`
--
ALTER TABLE `birth_records`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `citizen_id` (`citizen_id`),
  ADD UNIQUE KEY `birth_certificate_no` (`birth_certificate_no`),
  ADD KEY `father_id` (`father_id`),
  ADD KEY `mother_id` (`mother_id`);

--
-- Indexes for table `citizens`
--
ALTER TABLE `citizens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `national_id` (`national_id`),
  ADD KEY `household_id` (`household_id`);

--
-- Indexes for table `disabilities`
--
ALTER TABLE `disabilities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizen_id` (`citizen_id`);

--
-- Indexes for table `education`
--
ALTER TABLE `education`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizen_id` (`citizen_id`);

--
-- Indexes for table `family_members`
--
ALTER TABLE `family_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizen_id` (`citizen_id`);

--
-- Indexes for table `genetic_diseases`
--
ALTER TABLE `genetic_diseases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizen_id` (`citizen_id`);

--
-- Indexes for table `households`
--
ALTER TABLE `households`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `house_registration_no` (`house_registration_no`),
  ADD KEY `address_id` (`address_id`),
  ADD KEY `household_head_id` (`household_head_id`);

--
-- Indexes for table `insurance_info`
--
ALTER TABLE `insurance_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizen_id` (`citizen_id`);

--
-- Indexes for table `medical_history`
--
ALTER TABLE `medical_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizen_id` (`citizen_id`);

--
-- Indexes for table `occupations`
--
ALTER TABLE `occupations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizen_id` (`citizen_id`);

--
-- Indexes for table `organizations`
--
ALTER TABLE `organizations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `residency_history`
--
ALTER TABLE `residency_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizen_id` (`citizen_id`),
  ADD KEY `previous_address_id` (`previous_address_id`),
  ADD KEY `new_address_id` (`new_address_id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizen_id` (`citizen_id`);

--
-- Indexes for table `vaccinations`
--
ALTER TABLE `vaccinations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `citizen_id` (`citizen_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `address_images`
--
ALTER TABLE `address_images`
  ADD CONSTRAINT `address_images_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `allergies`
--
ALTER TABLE `allergies`
  ADD CONSTRAINT `allergies_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `birth_records`
--
ALTER TABLE `birth_records`
  ADD CONSTRAINT `birth_records_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `birth_records_ibfk_2` FOREIGN KEY (`father_id`) REFERENCES `citizens` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `birth_records_ibfk_3` FOREIGN KEY (`mother_id`) REFERENCES `citizens` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `citizens`
--
ALTER TABLE `citizens`
  ADD CONSTRAINT `citizens_ibfk_1` FOREIGN KEY (`household_id`) REFERENCES `households` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `disabilities`
--
ALTER TABLE `disabilities`
  ADD CONSTRAINT `disabilities_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `education`
--
ALTER TABLE `education`
  ADD CONSTRAINT `education_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `family_members`
--
ALTER TABLE `family_members`
  ADD CONSTRAINT `family_members_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `genetic_diseases`
--
ALTER TABLE `genetic_diseases`
  ADD CONSTRAINT `genetic_diseases_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `households`
--
ALTER TABLE `households`
  ADD CONSTRAINT `households_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `households_ibfk_2` FOREIGN KEY (`household_head_id`) REFERENCES `citizens` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `insurance_info`
--
ALTER TABLE `insurance_info`
  ADD CONSTRAINT `insurance_info_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `medical_history`
--
ALTER TABLE `medical_history`
  ADD CONSTRAINT `medical_history_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `occupations`
--
ALTER TABLE `occupations`
  ADD CONSTRAINT `occupations_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `residency_history`
--
ALTER TABLE `residency_history`
  ADD CONSTRAINT `residency_history_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `residency_history_ibfk_2` FOREIGN KEY (`previous_address_id`) REFERENCES `addresses` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `residency_history_ibfk_3` FOREIGN KEY (`new_address_id`) REFERENCES `addresses` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `skills`
--
ALTER TABLE `skills`
  ADD CONSTRAINT `skills_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vaccinations`
--
ALTER TABLE `vaccinations`
  ADD CONSTRAINT `vaccinations_ibfk_1` FOREIGN KEY (`citizen_id`) REFERENCES `citizens` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
