<?php
declare(strict_types=1);

require_once(__DIR__ . '/../utils/session.php');
$session = new Session();

require_once(__DIR__ . '/../database/connection.db.php');
require_once(__DIR__ . '/../database/chatroom.class.php');
require_once(__DIR__ . '/../database/message.class.php');
require_once(__DIR__ . '/../database/user.class.php');

$dbh = get_database_connection();
$chatroom = Chatroom::get_chatroom_by_id($dbh, intval($_GET['chatroom_id']), intval($_SESSION['user_id']));
$seller = $chatroom->seller;
$sender = $seller->user_id === intval($_SESSION['user_id']) ? $chatroom->buyer->user_id : $seller->user_id;
$messages = Message::read_messages($dbh, intval($_GET['chatroom_id']), $sender);
echo json_encode($messages);
