<?php
session_start();
include_once('includes/dbconnection.php');

// Load Stripe PHP library
require 'vendor/autoload.php';
\Stripe\Stripe::setApiKey('sk_test_wsFx86XDJWwmE4dMskBgJYrt'); // Replace with your secret key

// Check if the session ID and order number are provided
if (!isset($_GET['session_id']) || !isset($_GET['order'])) {
    echo "<script>alert('No session or order found.'); window.location.href='error.php';</script>";
    exit();
}

// Retrieve the session ID and order number from the URL
$session_id = $_GET['session_id'];
$orderno = trim($_GET['order']); // Trim any whitespace

// Retrieve the session from Stripe
try {
    $session = \Stripe\Checkout\Session::retrieve($session_id);
} catch (\Stripe\Exception\ApiErrorException $e) {
    echo "Error: " . $e->getMessage();
    exit();
}

// Check if the payment was successful
if ($session->payment_status === 'paid') {
    // Here, update the order in your database
    $userid = $_SESSION['orcmsuid']; // Get user ID from session

    // Use prepared statements to prevent SQL injection
    $query = "UPDATE tblorders SET IsOrderPlaced=1 WHERE UserId=? AND OrderNumber=?";
    $stmt = mysqli_prepare($con, $query);

    if ($stmt) {
        // Bind parameters (s = string)
        mysqli_stmt_bind_param($stmt, "ss", $userid, $orderno);

        // Execute the statement
        if (mysqli_stmt_execute($stmt)) {
            // Email confirmation code
            $toemail = $_SESSION['uemail'];
            $subj = "Order Confirmation";       
            $headers = "MIME-Version: 1.0" . "\r\n";
            $headers .= 'Content-type: text/html; charset=iso-8859-1' . "\r\n";
            $headers .= 'From: ORCMS <noreply@yourdomain.com>' . "\r\n"; // Update with your sender email

            $msgec = "<html><body>";
            $msgec .= "<div><div>Hello,</div><br/><br/>";
            $msgec .= "<div style='padding-top:8px;'> Your order has been placed successfully <br />";
            $msgec .= "<strong>Order Number:</strong> $orderno <br/></div>";
            $msgec .= "<div>Thank you for your purchase!</div></div></body></html>";

            // Send email
            if (mail($toemail, $subj, $msgec, $headers)) {
                // Display success message
                ?>
                <!DOCTYPE html>
                <html lang="en">
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Payment Success - Online Railway Catering Management System</title>
                    <link rel="stylesheet" href="assets/css/icons.min.css">
                    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
                    <link rel="stylesheet" href="assets/css/main.css">
                    <link rel="stylesheet" href="assets/css/red-color.css">
                    <link rel="stylesheet" href="assets/css/yellow-color.css">
                    <link rel="stylesheet" href="assets/css/responsive.css">
                </head>
                <body>
                <?php include_once('includes/header.php'); ?>
                <section>
                    <div class="block gray-bg top-padd30">
                        <div class="container">
                            <h2>Payment Successful!</h2>
                            <p>Thank you for your order!</p>
                            <p>Your payment was successful, and your order has been placed.</p>
                            <p><strong>Order Number: </strong><?php echo htmlspecialchars($orderno); ?></p>
                            <p>You will receive an email confirmation shortly.</p>
                            <p><a href="index.php" class="btn btn-primary">Continue Shopping</a></p>
                        </div>
                    </div>
                </section>
                <?php include_once('includes/footer.php'); ?>
                <script src="assets/js/jquery.min.js"></script>
                <script src="assets/js/bootstrap.min.js"></script>
                <script src="assets/js/plugins.js"></script>
                <script src="assets/js/main.js"></script>
                </body>
                </html>
                <?php
            } else {
                // Handle email sending failure
                echo '<script>alert("Order placed, but failed to send confirmation email.");</script>';
                echo "<script>window.location.href='checkout.php?order=$orderno'</script>";
            }
        } else {
            // Error executing the statement
            echo "Error updating order status: " . mysqli_error($con);
        }

        // Close the statement
        mysqli_stmt_close($stmt);
    } else {
        echo "Failed to prepare statement: " . mysqli_error($con);
    }
} else {
    // Handle the case where the payment wasn't successful
    echo "<script>alert('Payment was not successful. Please try again.'); window.location.href='error.php';</script>";
    exit();
}
?>
