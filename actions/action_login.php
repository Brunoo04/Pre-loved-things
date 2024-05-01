<?php

    declare(strict_types=1);

    require_once(__DIR__ . '/../utils/session.php');
    $session = new Session();

    require_once(__DIR__ . '/../database/user.class.php');
    require_once(__DIR__ . '/../database/connection.db.php');

    $dbh = get_database_connection();

    if ( !$_POST['email'] || !$_POST['password']) {
        $session->addMessage('error', 'empty fields');
        die(header('Location: ' . $_SERVER['HTTP_REFERER']));
    }

    $user = User::verify_user($dbh, $_POST['email'], $_POST['password']);
    $checkout = isset($_GET['checkout']);

    if ($user !== null) {
      $session->setId($user->user_id);
      $session->setCurrency(User::get_currency($dbh, $user->user_id));

      if ($session->hasItemsCart()) User::add_to_cart($dbh, $session->getCart(), $user->user_id);

      $session->addMessage('success', 'Login successful!');
      header('Location: '. ($checkout? '../pages/checkout.php':'../index.php'));

    } else {
        $session->addMessage('error', 'Wrong password or email!');
        header('Location: ../pages/login.php'. ($checkout? '?checkout':''));
    }
