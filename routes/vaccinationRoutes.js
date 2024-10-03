const express = require('express');
const router = express.Router();
const db = require('../db');

// ดึงข้อมูลการฉีดวัคซีนทั้งหมด
router.get('/', async (req, res) => {
  try {
    // ใช้ SQL query เพื่อดึงข้อมูลทั้งหมดจากตาราง vaccinations
    const [rows] = await db.query('SELECT * FROM vaccinations');
    res.json(rows);
  } catch (error) {
    // ถ้าเกิดข้อผิดพลาด ส่งรหัส 500 และข้อความแสดงข้อผิดพลาด
    res.status(500).json({ message: error.message });
  }
});

// ดึงข้อมูลการฉีดวัคซีนตาม ID
router.get('/:id', async (req, res) => {
  try {
    // ใช้ SQL query เพื่อดึงข้อมูลจากตาราง vaccinations ตาม ID ที่ระบุ
    const [rows] = await db.query('SELECT * FROM vaccinations WHERE id = ?', [req.params.id]);
    if (rows.length === 0) {
      // ถ้าไม่พบข้อมูล ส่งรหัส 404 และข้อความแจ้งเตือน
      return res.status(404).json({ message: 'ไม่พบข้อมูลการฉีดวัคซีน' });
    }
    res.json(rows[0]);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// เพิ่มข้อมูลการฉีดวัคซีนใหม่
router.post('/', async (req, res) => {
  try {
    const { citizen_id, vaccine_name, dose_number, vaccination_date } = req.body;
    // ใช้ SQL query เพื่อเพิ่มข้อมูลใหม่ลงในตาราง vaccinations
    const [result] = await db.query(
      'INSERT INTO vaccinations (citizen_id, vaccine_name, dose_number, vaccination_date) VALUES (?, ?, ?, ?)',
      [citizen_id, vaccine_name, dose_number, vaccination_date]
    );
    // ส่งข้อมูลที่เพิ่มเข้าไปกลับมาพร้อมรหัส 201 (Created)
    res.status(201).json({ id: result.insertId, ...req.body });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// อัปเดตข้อมูลการฉีดวัคซีน
router.put('/:id', async (req, res) => {
  try {
    const { citizen_id, vaccine_name, dose_number, vaccination_date } = req.body;
    // ใช้ SQL query เพื่ออัปเดตข้อมูลในตาราง vaccinations ตาม ID ที่ระบุ
    await db.query(
      'UPDATE vaccinations SET citizen_id = ?, vaccine_name = ?, dose_number = ?, vaccination_date = ? WHERE id = ?',
      [citizen_id, vaccine_name, dose_number, vaccination_date, req.params.id]
    );
    res.json({ id: req.params.id, ...req.body });
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// ลบข้อมูลการฉีดวัคซีน
router.delete('/:id', async (req, res) => {
  try {
    // ใช้ SQL query เพื่อลบข้อมูลจากตาราง vaccinations ตาม ID ที่ระบุ
    await db.query('DELETE FROM vaccinations WHERE id = ?', [req.params.id]);
    res.json({ message: 'ลบข้อมูลการฉีดวัคซีนเรียบร้อยแล้ว' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;