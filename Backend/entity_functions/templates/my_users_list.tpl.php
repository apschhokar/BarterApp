<!DOCTYPE html>

<html>    
    
<head>
<title>GeoJSON example</title>
<style>

.role
{
    cursor: pointer;
    background-size: 105px 35px;
    width: 128px;
    background-image: url("http://dev-my-barter-site.pantheon.io/sites/default/files/off.jpg");
    height: 63px;
    background-repeat:no-repeat;
}
    
.role.moderator
{
    cursor: pointer;
    background-size: 105px 35px;
    width: 128px;
    background-image: url("http://dev-my-barter-site.pantheon.io/sites/default/files/on.jpg");
    height: 63px;
    background-repeat:no-repeat;
}
body {
    
}
.column-two{
    font-size:7px;
    
}

.column-one{
    width: 23%;
    float: left;
}

.column-two
{
        font-size: 8px;
    width: 58%;
    float: left;
    
}
.column-two span
{
    display:block;
}

.column-three
{
    float: left;
    width: 15%;
    margin-top:-40px;
    
}

.hr-style
{
    margin-bottom: 13px;
    clear:both;
}
.each_row_0
{
    clear:both;
    //background-color: linen;
}
.each_row_0 div
{
    
    
}
.each_row_1 div
{
    
    
}
.each_row_1{
    clear:both;
    //background-color: lightblue;
    //background-color: blue;
}

.approve{
    cursor: pointer;
    
    background: #5CCD00;
    background: -moz-linear-gradient(top,#5CCD00 0%,#4AA400 100%);
    background: -webkit-gradient(linear,left top,left bottom,color-stop(0%,#5CCD00),color-stop(100%,#4AA400));
    background: -webkit-linear-gradient(top,#5CCD00 0%,#4AA400 100%);
    background: -o-linear-gradient(top,#5CCD00 0%,#4AA400 100%);
    background: -ms-linear-gradient(top,#5CCD00 0%,#4AA400 100%);
    background: linear-gradient(top,#5CCD00 0%,#4AA400 100%);
    filter: progid: DXImageTransform.Microsoft.gradient( startColorstr='#5CCD00', endColorstr='#4AA400',GradientType=0);
    padding: 2px 15px;
    color: #fff;
    font-family: 'Helvetica Neue',sans-serif;
    font-size: 16px;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border: 1px solid #459A00;
}
.reject
{
    cursor: pointer;
        /* font-size: 2px; */
    /* height: 21px; */
    margin-top: 5px;
    min-width: 93px;
    background: red;
    background: -moz-linear-gradient(top,#5CCD00 0%,#4AA400 100%);
    background: -webkit-gradient(linear,left top,left bottom,color-stop(0%,red),color-stop(100%,red));
    background: -webkit-linear-gradient(top,red 0%,red 100%);
    background: -o-linear-gradient(top,#5CCD00 0%,#4AA400 100%);
    background: -ms-linear-gradient(top,#5CCD00 0%,#4AA400 100%);
    background: linear-gradient(top,#5CCD00 0%,#4AA400 100%);
    filter: progid: DXImageTransform.Microsoft.gradient( startColorstr='#5CCD00', endColorstr='#4AA400',GradientType=0);
    padding: 3px 16px;
    color: #fff;
    font-family: 'Helvetica Neue',sans-serif;
    font-size: 16px;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border: 1px solid red;
    
}

</style>

</head>


<body>
    <?php $count=0; $counter=0; foreach($output as $value)
        
        {
        $counter++;
        
        if($count==0)
        {
            $count=1;
        }
        else
        {
            $count=0;
        }
        
        ?> 
<div class="each_row_<?php echo $count?>" id="node_id_<?php echo $value['uid'];?>">
    <!--<div class="a">Id<?php echo $value['uid'];?></div>
    <div class="b">Id<?php echo $value['mail'];?></div>
    <br>
-->    
        
    <h1 style="display:inline; float:left">    
</h1> 
    <!--<input type="button" value="LogOut" style="vertical-align:top; float: right"/>-->
<h2> <?php echo $counter?>) User Info: <?php echo $value['mail'];?></h2>
<h2> <?php //echo $counter?>  <?php echo $value['first_name']." ".$value['last_name'];?></h2>

<div class="column-one">
<!--<img src="http://dev-my-barter-site.pantheon.io/sites/default/files/<?php //echo $value['image_url'];?>" alt="Twilight cover page" width="128" height="128" > 
-->
</div> 
<div class="column-two">
<p><?php //echo $value['first_name'];?></p>
<!--
<span> Purchase Date: <?php //echo $value['first_name'];?></span>
<span> Author: <?php //echo $value['first_name'];?></span>
<span> Tags: <?php //echo $value['first_name'];?></span>
<span> Amazon link: <a href="<?php //echo $value['first_name'];?>">Click Here</a> </span>
-->
</div>
    <div class="column-three">
    <!--<div><button type="button" class="approve" id="approve_<?php echo $value['uid'];?>" node_id_button_info="<?php echo $value['uid'];?>">Approve</button></div>-->
    <?php
    $userl=user_load($value['uid']);
    
    $is_role_moderator=in_array('moderator'  , $userl->roles , $strict = FALSE);
    if($is_role_moderator)
    {?>
        <div><div class="role moderator" id="reject_<?php echo $value['uid'];?>" node_id_button_info="<?php echo $value['uid'];?>"></div></div>
<?php
    }
    else
    {?>
        <div><div class="role" id="reject_<?php echo $value['uid'];?>" node_id_button_info="<?php echo $value['uid'];?>"></div></div>
<?php
    }
?>    
        
        
    </div>
    
    <!--<input type="button" value="POST" /> &nbsp; &nbsp;
  
    <input type="button" value="REJECT " style="vertical-align:middle; float: center-right"/> </p>
-->

<hr class="hr-style">

</div>
    
    
    
    
    
    
    <?php
    
    }
    if($counter==0)
    {?>
    <div class="no-user"><h3>No User Exists</h3></div>
    <?php
    
    }
    ?>
<script>
    $=jQuery;
    
    
    
    
    
    
    
   $( document ).ready(function() {
    console.log( "ready!" );
    
        $('.role').click(function(){
  var id=$(this)[0].getAttribute('node_id_button_info');
  var element=document.getElementById('node_id_'+id);
  //element.slideUp();
  //element.remove();
  thissave=$(this);
  jQuery.ajax({
                    type: 'POST',
                    url: '/foo/ajax/reject_user',
                    dataType: 'json',
      
success: function(longlatarr) { 
    
 thissave.toggleClass('moderator');



//alert('sent successfully');
    },
                    error: function() { alert(" An error occurred  "); },
                    // Might want to use 'ui' instead of jQuery('#slider').
                    data: 'id='+id
                });
 
 
 
});
 
  
        
    $('.moderator').click(function(){
  //do something
  console.log($(this)[0]);
  console.log($(this)[0].getAttribute('node_id_button_info'));
  var id=$(this)[0].getAttribute('node_id_button_info');
  var element=document.getElementById('node_id_'+id);
  //$('#node_id_100').slideUp();
  //$( "#node_id_56" ).slideUp( 600 ).delay( 1600 ).fadeOut( 800 );
    //    element.remove();
  console.log(element);
 
 
 jQuery.ajax({
                    type: 'POST',
                    url: '/foo/ajax/approve_user',
                    dataType: 'json',
      
success: function(longlatarr) { 
    console.log(longlatarr);
    
//alert('sent successfully');
    },
                    error: function() { alert(" An error occurred  "); },
                    // Might want to use 'ui' instead of jQuery('#slider').
                    data: 'id='+id
                });

});    
});
   
   
</script>
</body>
</html>