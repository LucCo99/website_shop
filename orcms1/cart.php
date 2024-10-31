<?php
session_start();
error_reporting(0);
include_once('includes/dbconnection.php');
   if (strlen($_SESSION['orcmsuid']==0)) {
  header('location:logout.php');
  } else{
      
      if (isset($_POST['update_qty'])) {
    $food_id = $_POST['food_id'];
    $new_qty = $_POST['new_qty'];
    $userid = $_SESSION['orcmsuid']; // Ensure session is started and user ID is available

    // Update query to modify quantity
    $update_query = "UPDATE tblorders SET FoodQty='$new_qty' WHERE FoodId='$food_id' AND UserId='$userid' ";
    $result = mysqli_query($con, $update_query);

    if ($result) {
        echo '<script>alert("Quantity updated successfully!");</script>';
        echo "<script>window.location.href='cart.php'</script>";
    } else {
        echo '<script>alert("Failed to update quantity. Please try again.");</script>';
    }
}

if(isset($_POST['placeorder'])){

   // Getting catering order information
    $fullname = $_POST['fullname'];
    $phone = $_POST['phone'];
    $email = $_POST['email'];
    $event_datetime = $_POST['event_datetime'];
    $location = $_POST['location'];
    $event_type = $_POST['event_type'];
    $special_requests = $_POST['special_requests'];


$foodtype=$_POST['foodtype'];

 $userid = $_SESSION['orcmsuid'];
    // Generating order number
    $orderno = mt_rand(100000000, 999999999);
    
$query="update tblorders set OrderNumber='$orderno',IsOrderPlaced='0' where UserId='$userid' and IsOrderPlaced is null;";
$query.="INSERT INTO tblorderaddresses (UserId, Ordernumber, fullname, phone, email, event_datetime, location, event_type, special_requests) 
                    VALUES ('$userid', '$orderno', '$fullname', '$phone', '$email', '$event_datetime', '$location', '$event_type', '$special_requests');";


$result = mysqli_multi_query($con, $query);
if ($result) {
//Code for email
$toemail=$_SESSION['uemail'];
$subj="Order Confirmation";       
$heade .= "MIME-Version: 1.0"."\r\n";
$heade .= 'Content-type: text/html; charset=iso-8859-1'."\r\n";
$heade .= 'From:ORCMS<noreply@yourdomain.com>'."\r\n";    // Put your sender email here
$msgec.="<html></body><div><div>Hello,</div></br></br>";
$msgec.="<div style='padding-top:8px;'> Your order has been placed successfully <br />
<strong> Order Number: </strong> $orderno </br>
</div><div></div></body></html>";
mail($toemail,$subj,$msgec,$heade);
 // Showing alert and redirecting to checkout for payment
        echo '<script>alert("Your order was placed successfully. Order number is '.$orderno.'");</script>';
        echo "<script>window.location.href='checkout.php?order=$orderno'</script>";

}
}   

//Code deletion
if(isset($_GET['delid'])) {
$rid=$_GET['delid'];
$query=mysqli_query($con,"delete from tblorders where ID='$rid'");
echo '<script>alert("Food item deleted")</script>';
echo "<script>window.location.href='cart.php'</script>";

}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    
    <title>Online Railway Catering Management System | Cart Page</title>

    <link rel="stylesheet" href="assets/css/icons.min.css">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/main.css">
    <link rel="stylesheet" href="assets/css/red-color.css">
    <link rel="stylesheet" href="assets/css/yellow-color.css">
    <link rel="stylesheet" href="assets/css/responsive.css">
</head>
<body itemscope>
<?php include_once('includes/header.php');?>


        <section>
            <div class="block">
				<div class="fixed-bg" style="background-image: url(assets/images/topbg.jpg);"></div>
                <div class="page-title-wrapper text-center">
					<div class="col-md-12 col-sm-12 col-lg-12">
						<div class="page-title-inner">
							<h1 itemprop="headline">Cart</h1>
						
				
						</div>
					</div>
                </div>
            </div>
        </section>

        <div class="bread-crumbs-wrapper">
            <div class="container">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="index.php" title="" itemprop="url">Home</a></li>
                    <li class="breadcrumb-item active">My Cart</li>
                </ol>
            </div>
        </div>

        <section>
            <div class="block gray-bg bottom-padd210 top-padd30">
                
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12">
                            <div class="sec-box">
    							<div class="sec-wrapper">

    							



    <div class="col-md-12 col-sm-12 col-lg-12">

<div class="booking-table">
<table>
<thead>
<tr>
    <th></th>
    <th>Food Item</th>
    <th>Qty</th>
    <th>Per Unit Price</th>
       <th>Total</th>
          <th>Action</th>
</tr>
</thead>
<tbody>
    <?php 
$userid= $_SESSION['orcmsuid'];
$query=mysqli_query($con,"select tblorders.ID as frid,tblfood.Image,tblfood.ItemName,tblfood.ItemDes,tblfood.ItemPrice,tblfood.ItemQty,tblorders.FoodId,tblorders.FoodQty from tblorders join tblfood on tblfood.ID=tblorders.FoodId where tblorders.UserId='$userid' and tblorders.IsOrderPlaced is null");
$num=mysqli_num_rows($query);
if($num>0){
while ($row=mysqli_fetch_array($query)) {
 

?>
<tr>
    <td><img src="admin/itemimages/<?php echo $row['Image']?>" width="100" height="80" alt="<?php echo $row['ItemName']?>"></td>
<td>
    <a href="food-detail.php?fid=<?php echo $row['FoodId'];?>" title="" itemprop="url"><?php echo $row['ItemName']?></a>
</td>
<!--<td><?php echo $qty=$row['FoodQty']?></td>-->
   <td>
        <!-- Form to update quantity -->
        <form method="post" action="cart.php" style="display: inline-flex; align-items: center;">
            <input type="hidden" name="food_id" value="<?php echo $row['FoodId']; ?>">
            <input type="number" name="new_qty" value="<?php echo $qty=$row['FoodQty']; ?>" min="1" style="width: 50px; margin-right: 5px;">
            <button type="submit" name="update_qty" class="btn btn-primary btn-sm">Update</button>
        </form>
    </td>
    <td><?php echo $ppu=$row['ItemPrice']?></td>
<td><?php echo $total=$qty*$ppu;?></td>
<td><a href="cart.php?delid=<?php echo $row['frid'];?>" onclick="return confirm('Do you really want to delete?');";><i class="fa fa-trash" aria-hidden="true" title="Delete this food item"></i><a/></span></td>
</tr>

<?php $grandtotal+=$total;}?>
<thead>
<tr>
    <th colspan="4" style="text-align:center;">Grand Total</th>
<th style="text-align:center;"><?php echo $grandtotal;?></th>
<th></th>
</tr>
</thead>
<form method="post">
<tr>
                                   
<tr>
    <td colspan="3">
        <!-- Full Name -->
        <input type="text" name="fullname" placeholder="Enter Full Name" class="form-control" required="true">
    </td>
    <td colspan="3">
        <!-- Phone Number -->
        <input type="text" name="phone" placeholder="Enter Phone Number" class="form-control" required="true">
    </td>
</tr>
<tr>
    <td colspan="3">
        <!-- Email Address -->
        <input type="email" name="email" placeholder="Enter Email Address" class="form-control" required="true">
    </td>

    <td colspan="3">
        <!-- Event Date and Time -->
        <input type="datetime-local" id="event_datetime" name="event_datetime" placeholder="Select Event Date and Time" class="form-control" required="true">
    </td>


</tr>
<tr>
    <td colspan="3">
        <!-- Event Location or Pickup -->
        <input type="text" name="location" placeholder="Enter Event Location or Pickup Address" class="form-control" required="true">
    </td>
    <td colspan="3">
        <!-- Event Type -->
        <input type="text" name="event_type" placeholder="Enter Event Type (e.g., Wedding, Birthday)" class="form-control" required="true">
    </td>
</tr>
<tr>
    <td colspan="6">
        <!-- Special Requests/Instructions (including food allergies) -->
        <textarea name="special_requests" placeholder="Any specific requests or delivery details, parking instructions, food allergies" class="form-control" rows="3"></textarea>
    </td>
</tr>


<!--<td colspan="3"> -->
<!--    <select class="form-control" name="foodtype">-->
<!--        <option value="">Choose Food Type</option>-->
<!--        <option value="Breakfast">Breakfast</option>-->
<!--        <option value="Lunch">Lunch</option>-->
<!--        <option value="Dinner">Dinner</option>-->
<!--    </select>-->
<!--</td>-->
</tr>
<tr>

</tr>
<tr>
    <td colspan="3">
       <button   type="submit" name="placeorder" class="btn theme-btn btn-lg"   action="checkout.php" >Place order</button>
   </td></tr>
   </form>

<?php } else {?>
    <tr>
        <td colspan="6" style="color:red">You cart is empty</td>
    </tr>
<?php } ?>
</tbody>
</table>
</div>
                                    </div>

    							</div>
                            </div>
                        </div>
                    </div>
                </div><!-- Section Box -->
            </div>
        </section>

    <!-- red section -->
    <?php include_once('includes/footer.php');
include_once('includes/signin.php');
include_once('includes/signup.php');
      ?>
    </main><!-- Main Wrapper -->

    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
    <script src="assets/js/google-map-int2.js"></script>
    <script src="assets/js/plugins.js"></script>
    <script src="assets/js/main.js"></script>
</body>	

</html>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const eventDateInput = document.getElementById('event_datetime');
        const now = new Date();
        const currentHours = now.getHours();
        let minDate;

        // Get today's date
        let today = new Date();
        today.setHours(0, 0, 0, 0); // Set to midnight to avoid selecting today

        // Get tomorrow's date
        let tomorrow = new Date(today);
        tomorrow.setDate(tomorrow.getDate() + 1); // Move to next day

           // Check if the current time is after 2 PM today
        if (currentHours >= 14 || (currentHours === 14 && currentMinutes > 0)) {
            // If after 2 PM, orders for tomorrow are not allowed
            tomorrow.setDate(tomorrow.getDate() + 2); // Move to the day after tomorrow
        }

        // Set min attribute to tomorrow's date if past 2 PM today, else allow tomorrow
        eventDateInput.min = tomorrow.toISOString().slice(0, 16);

        // Prevent selecting today or earlier
        eventDateInput.addEventListener('input', function() {
            const selectedDate = new Date(eventDateInput.value);
            if (selectedDate <= minDate) {
                alert("You cannot select today or earlier, or tomorrow after 2 PM if it's past 2 PM today.");
                eventDateInput.value = ""; // Clear invalid date
            }
        });
    });
</script>
<?php } ?>