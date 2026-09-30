# Game Party - Flutter

ตัวอย่างแอปชวนหาตี้เล่นเกมตามโจทย์ Social Network ข้อ 2

## วิธีใช้งาน

1. ติดตั้ง Flutter และ Android Studio/VS Code
2. เปิด Terminal ในโฟลเดอร์นี้
3. รัน:

```bash
flutter pub get
flutter run
```

ถ้ายังไม่มี platform folders ให้สร้างโปรเจกต์ Flutter ก่อน:

```bash
flutter create .
flutter pub get
flutter run
```

จากนั้นเลือก emulator หรือมือถือที่เชื่อมต่อไว้

## ฟีเจอร์ Demo

- Feed โพสต์หาเพื่อนเล่นเกม
- สร้าง/ลบโพสต์
- Like / Comment
- เข้าร่วมตี้
- ค้นหาโพสต์
- กลุ่ม / สร้างกลุ่ม / ออกจากกลุ่ม
- แชต 1-1 แบบ Demo
- โปรไฟล์ / แก้ไขโปรไฟล์
- Report / Delete menu

หมายเหตุ: เวอร์ชันนี้เก็บข้อมูลใน memory เพื่อให้รันง่ายและไม่ต้องตั้ง backend
ถ้าต้องการทำตามข้อ j ของงาน ให้ต่อ Firebase Authentication + Cloud Firestore ภายหลัง
