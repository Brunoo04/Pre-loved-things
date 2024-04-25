<?php

declare(strict_types=1);

require_once(__DIR__ . '/../utils/session.php');
$session = new Session();

require_once(__DIR__ . '/../database/user.class.php');
require_once(__DIR__ . '/../database/connection.db.php');

$dbh = get_database_connection();
$checkout = isset($_GET['checkout']);
$email_available = !User::verify_email($dbh, $_POST['email']);
$username_available = !User::verify_username($dbh, $_POST['username']);
if ($email_available && $username_available) {
    $session->setId(User::register_user($dbh, $_POST['password'], $_POST['username'], $_POST['email'], $_POST['name'], $_POST['phone']));
    if ($session->hasItemsCart()) User::add_to_cart($dbh, $session->getCart(), $session->getId());
    $session->addMessage('success', 'Account successfully created.');
    header('Location: ' . ($checkout ? '../pages/checkout.php':'../index.php'));
}
else {
    $session->addMessage('error', $email_available? 'Username already taken' : 'Email already registered.');
    header('Location: ../pages/login.php' . ($checkout ? "?checkout" : ""));
}
