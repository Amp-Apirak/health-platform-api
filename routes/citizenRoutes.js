const express = require("express");
const router = express.Router();
const db = require("../db");
const { v4: uuidv4 } = require("uuid"); // นำเข้า library uuid

// ดึงข้อมูลผู้รับบริการทั้งหมด (พร้อม pagination และ record count)
router.get("/", async (req, res) => {
  try {
    const page = parseInt(req.query.page) || 1; // หน้าปัจจุบัน (default: 1)
    const limit = parseInt(req.query.limit) || 10; // จำนวน record ต่อหน้า (default: 10)
    const offset = (page - 1) * limit; // offset สำหรับ query

    // ดึงข้อมูลผู้รับบริการแบบแบ่งหน้า
    const [rows] = await db.query("SELECT * FROM citizens LIMIT ? OFFSET ?", [
      limit,
      offset,
    ]);

    // นับจำนวน record ทั้งหมด
    const [countResult] = await db.query(
      "SELECT COUNT(*) AS count FROM citizens"
    );
    const total = countResult[0].count;

    res.json({
      data: rows,
      currentPage: page,
      totalPages: Math.ceil(total / limit),
      totalRecords: total,
    });
  } catch (error) {
    console.error("Error fetching citizens:", error); // log error
    res.status(500).json({ message: "เกิดข้อผิดพลาดในการดึงข้อมูล" }); // response error
  }
});

// ดึงข้อมูลผู้รับบริการตาม ID
router.get("/:id", async (req, res) => {
  try {
    const [rows] = await db.query("SELECT * FROM citizens WHERE id = ?", [
      req.params.id,
    ]);
    if (rows.length === 0) {
      return res.status(404).json({ message: "ไม่พบข้อมูลผู้รับบริการ" });
    }
    res.json(rows[0]);
  } catch (error) {
    console.error("Error fetching citizen:", error); // log error
    res.status(500).json({ message: "เกิดข้อผิดพลาดในการดึงข้อมูล" }); // response error
  }
});

// เพิ่มข้อมูลผู้รับบริการใหม่
router.post("/", async (req, res) => {
  try {
    // validation (ตัวอย่าง)
    const { national_id } = req.body;
    // 1. หากมีค่าว่างให้แจ้งเตือน
    if (!national_id) {
      return res
        .status(400)
        .json({ message: "กรุณากรอกเลขบัตรประชาชน/พาสปอร์ต" });
    }

    // 2. หากมีตัวอักษรหรืออักขระพิเศษ ให้แจ้งเตือน
    if (/[^0-9]/.test(national_id)) {
      return res
        .status(400)
        .json({ message: "คุณกรอกเลขบัตรประชาชน/พาสปอร์ตไม่ถูกต้อง" });
    }

    // 3. หากกรอกเลขบัตรประชาชนไม่ครบ 13 หลัก (หรือ 6 หลักสำหรับพาสปอร์ต)
    if (national_id.length < 6) {
      return res
        .status(400)
        .json({ message: "คุณกรอกเลขบัตรประชาชน/พาสปอร์ตไม่ครบ" });
    }

    // สร้าง UUID และลบอักขระพิเศษออก
    const id = uuidv4().replace(/[^a-zA-Z0-9]/g, "");

    // เพิ่ม id ใน req.body และ map ชื่อตัวแปร
    const newCitizen = {
      id,
      national_id: req.body.national_id,
      title: req.body.title,
      first_name: req.body.first_name,
      last_name: req.body.last_name,
      nickname: req.body.nickname,
      gender: req.body.gender,
      date_of_birth: req.body.date_of_birth,
      blood_type: req.body.blood_type,
      religion: req.body.religion,
      nationality: req.body.nationality,
      ethnicity: req.body.ethnicity,
      marital_status: req.body.marital_status,
      phone_number: req.body.phone_number,
      email: req.body.email,
      line_id: req.body.line_id,
      emergency_contact_name: req.body.emergency_contact_name,
      emergency_contact_phone: req.body.emergency_contact_phone,
      profile_image: req.body.profile_image,
      organization_id: req.body.organization_id,
      created_at: req.body.created_at,
      updated_at: req.body.updated_at,
      household_id: req.body.household_id,
    };

    const [result] = await db.query("INSERT INTO citizens SET ?", newCitizen);

    res.status(201).json({ id: id, ...req.body });
  } catch (error) {
    console.error("Error creating citizen:", error); // log error
    res.status(400).json({ message: "เกิดข้อผิดพลาดในการสร้างข้อมูล" }); // response error
  }
});

// แก้ไขข้อมูลผู้รับบริการ
router.put("/:id", async (req, res) => {
  try {
    const citizenId = req.params.id; // รับ ID ของผู้รับบริการจาก URL parameter
    console.log("citizenId:", citizenId); // เพิ่ม console.log

    // ตรวจสอบว่าผู้รับบริการมีอยู่ในระบบหรือไม่
    const [existingCitizen] = await db.query(
      "SELECT * FROM citizens WHERE id = ?",
      [citizenId]
    );

    console.log("existingCitizen:", existingCitizen); // เพิ่ม console.log
    
    if (existingCitizen.length === 0) {
      return res.status(404).json({ message: "ไม่พบข้อมูลผู้รับบริการ" });
    }

    // อัพเดตข้อมูลผู้รับบริการ
    const updatedCitizen = {
      ...req.body, // รับข้อมูลที่ต้องการอัพเดตจาก request body
      updated_at: new Date(), // อัพเดตเวลาแก้ไข
    };
    await db.query("UPDATE citizens SET ? WHERE id = ?", [
      updatedCitizen,
      citizenId,
    ]);

    res.json({ message: "แก้ไขข้อมูลผู้รับบริการเรียบร้อยแล้ว" });
  } catch (error) {
    console.error("Error updating citizen:", error); // log error
    res.status(400).json({ message: "เกิดข้อผิดพลาดในการแก้ไขข้อมูล" }); // response error
  }
});


// ลบข้อมูลผู้รับบริการ
router.delete("/:id", async (req, res) => {
  try {
    const citizenId = req.params.id; // รับ ID ของผู้รับบริการจาก URL parameter

    // ลบข้อมูลผู้รับบริการ
    await db.query("DELETE FROM citizens WHERE id = ?", [citizenId]);

    res.json({ message: "ลบข้อมูลผู้รับบริการเรียบร้อยแล้ว" });
  } catch (error) {
    console.error("Error deleting citizen:", error); // log error
    res.status(500).json({ message: "เกิดข้อผิดพลาดในการลบข้อมูล" }); // response error
  }
});

module.exports = router;
