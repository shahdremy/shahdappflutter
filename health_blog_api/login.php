<?php
header("Content-Type: application/json");

// إعداد الاتصال بقاعدة البيانات
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "user_db";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "فشل الاتصال بقاعدة البيانات"]));
}

// استلام البريد الإلكتروني وكلمة المرور من التطبيق
$email = $_POST['email'];
$password = $_POST['password'];

// تشفير كلمة المرور
$hashed_password = password_hash($password, PASSWORD_DEFAULT);

// إدخال البيانات في قاعدة البيانات مباشرةً
$sql_insert = "INSERT INTO users (email, password) VALUES (?, ?)";
$stmt_insert = $conn->prepare($sql_insert);
$stmt_insert->bind_param("ss", $email, $hashed_password);

if ($stmt_insert->execute()) {
    echo json_encode(["status" => "success", "message" => "تمت إضافة البيانات بنجاح"]);
} else {
    echo json_encode(["status" => "error", "message" => "فشل إضافة البيانات"]);
}

$stmt_insert->close();
$conn->close();
?>