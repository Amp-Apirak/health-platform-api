// app.js
const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');

// โหลดค่าจากไฟล์ .env
dotenv.config();

// สร้าง Express app
const app = express();

// ใช้ middleware
app.use(cors()); // อนุญาตการเรียก API จากโดเมนอื่น
app.use(express.json()); // แปลง JSON ในร้องขอ

// กำหนดพอร์ตจากไฟล์ .env หรือใช้ 3000 ถ้าไม่ได้กำหนด
const PORT = process.env.PORT || 3000;

// นำเข้า routes
const citizenRoutes = require('./routes/citizenRoutes');

// ใช้งาน routes
app.use('/api/citizens', citizenRoutes);

// เริ่มต้น server
app.listen(PORT, () => {
  console.log(`Server กำลังทำงานที่พอร์ต ${PORT}`);
});