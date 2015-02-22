<?php

// var_dump(file_get_contents('php://input'));

if (isset($_REQUEST['a']) && file_exists($_REQUEST['a'].'.php')) { //trivial routing
    include( $_REQUEST['a']. '.php');
} else {
    // if (isset($_REQUEST['a'])) {
    //     echo '<span class=​"label label-warning">​Bad Request</span>​';
    // }
    include('view.php');
}
?>
