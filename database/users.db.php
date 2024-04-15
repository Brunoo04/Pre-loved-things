<?php

declare(strict_types=1);
require_once('database/connection.db.php');

function register_user(PDO $dbh, string $username, string $password, string $email)
{
  $stmt = $dbh->prepare('INSERT INTO users VALUES (?, ?, NULL, ?, NULL)');
  $stmt->execute(array($username, sha1($password), $email));
}

function verify_user(PDO $dbh, string $username, string $password): bool
{
  $stmt = $dbh->prepare('SELECT * FROM users WHERE username = ? AND password = ?');
  $stmt->execute(array($username, sha1($password)));

  return $stmt->fetch() !== false;
}
