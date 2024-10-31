<?php
session_start();
error_reporting(0);
include_once('includes/dbconnection.php');

// Check if the user is logged in
if (strlen($_SESSION['orcmsuid']) == 0) {
    header('location:logout.php');
    exit();
}

// Get the order number from URL
$orderno = isset($_GET['order']) ? $_GET['order'] : null;
if (!$orderno) {
    echo "<script>alert('No order found.');</script>";
    echo "<script>window.location.href='cart.php'</script>";
    exit();
}

// Retrieve the order details from the database
$userid = $_SESSION['orcmsuid'];

$query1 = mysqli_query($con, "SELECT tblfood.ItemName, tblfood.ItemPrice, tblorders.FoodQty FROM tblorders JOIN tblfood ON tblfood.ID=tblorders.FoodId WHERE tblorders.UserId='$userid' AND tblorders.OrderNumber='$orderno' ");


if (!$query1) {
    die("Database query failed: " . mysqli_error($con));
}

// Check the number of rows returned
$num_rows = mysqli_num_rows($query1);


$line_items = [];
$grandtotal = 0;

while ($row = mysqli_fetch_array($query1)) {
    $quantity = $row['FoodQty'];
    $unit_amount = $row['ItemPrice'] * 100; // Stripe requires amount in cents
    $foodname = $row['ItemName'];

    // Add each item to the $line_items array
    $line_items[] = [
        "quantity" => $quantity,
        "price_data" => [
            "currency" => "aud",
            "unit_amount" => $unit_amount,
            "product_data" => [
                "name" => $foodname
            ]
        ]
    ];
    $grandtotal += ($quantity * $row['ItemPrice']); // Calculate grand total
}



    // Stripe integration
    require 'vendor/autoload.php'; // Make sure you have the Stripe PHP library installed
    \Stripe\Stripe::setApiKey('sk_test_wsFx86XDJWwmE4dMskBgJYrt'); // Replace with your secret key

    try {
        // Create Stripe Checkout Session
        $checkout_session = \Stripe\Checkout\Session::create([
            'payment_method_types' => ['card'],
            'line_items' => $line_items,
            'mode' => 'payment',
            "locale" => "auto",
            'success_url' => 'https://spenceandlarder.com.au/orcms/success.php?session_id={CHECKOUT_SESSION_ID}&order=' . $orderno,
            'cancel_url' => 'https://yourdomain.com/cancel.php?order=' . $orderno,
        ]);
    } catch (\Stripe\Exception\ApiErrorException $e) {
        echo "Error: " . $e->getMessage();
        exit();
    }
    http_response_code(303);
header("Location: " . $checkout_session->url);
?>

<!--<!DOCTYPE html>-->
<!--<html lang="en">-->
<!--<head>-->
<!--    <meta charset="UTF-8">-->
<!--    <meta http-equiv="X-UA-Compatible" content="IE=edge">-->
<!--    <meta name="viewport" content="width=device-width, initial-scale=1.0">-->
<!--    <title>Checkout - ORCMS</title>-->
<!--    <link rel="stylesheet" href="assets/css/bootstrap.min.css">-->
<!--    <link rel="stylesheet" href="assets/css/main.css">-->
<!--</head>-->
<!--<body>-->

<!--    <div class="container mt-5">-->
<!--        <h1>Checkout</h1>-->
<!--        <p>Order Number: <?php echo $orderno; ?></p>-->
<!--        <p>Grand Total: $<?php echo number_format($grandtotal, 2); ?></p>-->

        <!-- Stripe Checkout Button -->
<!--        <button id="checkout-button" class="btn btn-primary">Pay with Stripe</button>-->
<!--    </div>-->

<!--    <script src="https://js.stripe.com/v3/"></script>-->
<!--    <script type="text/javascript">-->
        <!--var stripe = Stripe('pk_test_L1f0e3XAzjsG7jtp4uN7L9ql'); // Replace with your publishable key-->

<!--        document.getElementById('checkout-button').addEventListener('click', function () {-->
<!--            stripe.redirectToCheckout({-->
<!--                sessionId: '<?php echo $session->id; ?>'-->
<!--            }).then(function (result) {-->
<!--                if (result.error) {-->
<!--                    alert(result.error.message);-->
<!--                }-->
<!--            });-->
<!--        });-->
<!--    </script>-->
<!--</body>-->
<!--</html>-->
