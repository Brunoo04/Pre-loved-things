<?php
declare(strict_types=1);
require_once(__DIR__ . '/../templates/common.tpl.php');
function draw_user_details($user) { ?>
    <section class="user">
        <img src="../images/<?=$user->photoPath?>" class="profile-pic" alt="profile picture">
        <div class="user-details">
            <h2 class="name"><?=$user->name?></h2>
            <p class="username"><?=$user->username?></p>
            <p class="phone"><?=$user->phone?></p>
            <p class="email"><?=$user->email?></p>
        </div>
    </section>
    <?php
}

function draw_edit_profile($user) { ?>
    <article class="edit-profile">
        <h2>Edit profile</h2>
        <form action="../actions/action_edit_profile.php" method="POST" enctype="multipart/form-data">
            <label for="name"> Name </label>
            <input type="text" id="name" name="name" value="<?=$user->name?>">
            <label for="username"> Username </label>
            <input type="text" id="username" name="username" value="<?=$user->username?>">
            <label for="email"> Email </label>
            <input type="text" id="email" name="email" value="<?=$user->email?>">
            <label for="phone"> Phone </label>
            <input type="text" id="phone" name="phone" value="<?=$user->phone?>">
            <label for="pf">Profile photo</label>
            <input type="file" id="pf" name="profilePhoto" accept="image/*">
            <button type="submit">Submit</button>
        </form>
    </article>
    <?php
}

function draw_user_feedback(PDO $db, $user, $feedback, $session_id) { ?>
    <section class="feedback">
        <h2>Feedback</h2>
            <div class ="comment-box">
                <?php
                    if (empty($feedback)) { ?>
                        <p>There are no reviews for this user yet.</p>
                    <?php }
                    foreach ($feedback as $comment) { ?>
                    <article class="comment">
                        <img src="../images/<?= User::get_user($db, $comment['userc'])->photoPath?>" class="profile-pic" alt="profile picture">
                        <p class="uname"><?=$comment['userc']?></p>
                        <time><?=$comment['date']?></time>
                        <p class="content"><?=$comment['text']?></p>
                    </article>
                        <?php
                    } ?>
            </div>
        <?php if ($user->user_id!=$session_id) echo("<p>+ Add your review</p>"); ?>
    </section>
<?php } ?>

<?php function draw_profile_details($user) {
    ?>
    <section class="user">
        <img src="../images/profile.png" class="profile-pic" alt="profile picture">
        <div class="user-details">
            <h2 class="name"><?=$user->name?></h2>
            <p class="phone"><?=$user->phone?></p>
            <p class="email"><?=$user->email?></p>
            <a href="../actions/action_logout.php" class="logout"><i class="material-symbols-outlined bold">logout</i>Log out</a>
            <a href="edit_profile.php">Edit profile</a>
        </div>
    </section>
<?php } ?>

<?php function draw_cart(PDO $db, array $items, Session $session) { ?>
    <article class="cartPage">
        <h2>Your cart</h2>
        <?php
        $user = null;
        $num_items = 0;
        $sum = 0;
        if (empty($items)) { ?>
            <p>You have no items</p>
            </article>
        <?php
        return;
        }
        foreach ($items as $item) {
            if ($user != $item->creator && $user != null) { ?>
                </article>
                    <div class="sum">
                        <p class="num-items">Number items: <?=$num_items?></p>
                        <div class="sum-price">
                            <p>Total: </p>
                            <p class="total"><?=$sum?></p>
                        </div>
                        <form class="checkout-item" action="../actions/action_checkout.php" method="post">
                            <input type="hidden" value="<?=$user?>" name="user_items">
                            <label>
                                <button class="checkout" type="submit">Buy now!</button>
                            </label>
                        </form>
                    </div>
                </section>
        <?php
                $num_items = 0;
                $sum = 0;
            }
            if ($user != $item->creator) { ?>
                <section class="seller">
                    <a href="../pages/user.php?user_id=<?=$item->creator?>" class="seller-info">
                        <img src="../images/<?=User::get_user($db, $item->creator)->photoPath?>" class="profile-pic" alt="profile-photo">
                        <p><?=User::get_user($db, $item->creator)->name?></p>
                    </a>
                    <article class="seller-items">
            <?php }
            draw_item($item);
            $num_items += 1;
            $sum += $item->price;
            $user = $item->creator;
        } ?>
            </article>
            <div class="sum">
                <p class="num-items">Number items: <?=$num_items?></p>
                <div class="sum-price">
                    <p>Total: </p>
                    <p class="total"><?=$sum?></p>
                </div>
                <form class="checkout-item" action="../actions/action_checkout.php" method="post">
                    <input type="hidden" value="<?=$user?>" name="user_items">
                    <label>
                        <button class="checkout" type="submit">Buy now!</button>
                    </label>
                </form>
            </div>
        </section>
    </article>
<?php } ?>

<?php function draw_checkout_form() { ?>
    <form class="checkout">
        <ul class="state">
            <li>
                <button type="button" class="collapsible">Shipping information</button>
                <div class="buy-form">
                    <label> Address
                        <input type="text" name="address">
                    </label>
                    <label> City
                        <input type="text" name="city">
                    </label>
                    <label> Postal code
                        <input type="text" name="city">
                    </label>
                    <button type="button" class="next">Next</button>
                </div>
            </li>
            <li>
                <button type="button" class="collapsible">Billing information</button>
                <div class="buy-form">
                    <label> Name
                        <input type="text" name="address">
                    </label>
                    <label> NIF
                        <input type="text" name="address">
                    </label>
                    <label> Address
                        <input type="text" name="address">
                    </label>
                    <label> City
                        <input type="text" name="city">
                    </label>
                    <label> Postal code
                        <input type="text" name="city">
                    </label>
                    <button type="button" class="next">Next</button>
                </div>
            </li>
            <li>
                <button type="button" class="collapsible">Payment information</button>
                <div class="buy-form">
                    <div class="options">
                        <label> Credit card
                            <input class="option" type="radio" name="option" id="credit-card" checked>
                        </label>
                        <label> Mbway
                            <input class="option" type="radio" name="option" id="mbway">
                        </label>
                        <label> Paypal
                            <input class="option" type="radio" name="option" id="paypal">
                        </label>
                    </div>
                    <div id="credit-card" class="payment-form">
                        <label> Card number
                            <input type="text" name="card-number">
                        </label>
                        <label> CVC
                            <input type="text" name="cvc">
                        </label>
                        <label> Expiration date
                            <input type="date" name="expire">
                        </label>
                    </div>
                    <div id="mbway" class="payment-form">
                        <label> Phone number
                            <input type="text" name="phone">
                        </label>
                    </div>
                    <button type="submit" class="confirm">Confirm payment</button>
                </div>
            </li>
        </ul>
    </form>
<?php } ?>

<?php function draw_checkout_summary(array $items) {?>
    <div class="checkoutSum">
        <p class="num-items">Number items: <?=count($items)?></p>
        <?php
        $sum = 0;
        foreach ($items as $item) { ?>
            <div class="item-info">
                <p class="name"><?=$item->name?></p>
                <p class="price"><?=$item->price?></p>
            </div>
        <?php
            $sum +=$item->price;
        } ?>
        <div class="sum-price">
            <p>Total: </p>
            <p class="total"><?=$sum?></p>
        </div>
    </div>
<?php } ?>

<?php  function draw_user_options(PDO $db, Session $session) { ?>
    <section class="display-item">
        <a href="../pages/new.php" class="new-item"> New item </a>
        <button type="button" class="collapsible">Pending purchases</button>
        <section class="items">
            <?php
            $items = TrackItem::get_purchased_items($db, $session->getId());
            foreach ($items as $item) {
                draw_item_to_track($item->tracking);
            } ?>
            </section>
        <button type="button" class="collapsible">Pending sales</button>
        <section class="items">
            <?php
            $items = TrackItem::get_selling_items($db, $session->getId());
            foreach ($items as $item) {
                draw_item_to_track($item->tracking);
            } ?>
            </section>
        <button type="button" class="collapsible">My items</button>
            <?php draw_items(Item::get_user_items($db, $session->getId())); ?>
    </section>
<?php } ?>
