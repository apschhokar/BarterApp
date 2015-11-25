<!DOCTYPE html>

<html>    
    
<head>
<title>GeoJSON example</title>
<style>
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
    
}

.hr-style
{
    clear:both;
}
.each_row_0
{
    clear:both;
    background-color: linen;
}
.each_row_0 div
{
    
    
}
.each_row_1 div
{
    
    
}
.each_row_1{
    clear:both;
    background-color: lightblue;
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
<div class="each_row_<?php echo $count?>" id="node_id_<?php echo $value['nid'];?>">
    <!--<div class="a">Id<?php echo $value['nid'];?></div>
    <div class="b">Id<?php echo $value['title'];?></div>
    <br>
-->    
        
    <h1 style="display:inline; float:left">    
</h1> 
    <!--<input type="button" value="LogOut" style="vertical-align:top; float: right"/>-->
<h3> <?php echo $counter?>) Book Name: <?php echo $value['title'];?></h3>

<div class="column-one">
<img src="http://dev-my-barter-site.pantheon.io/sites/default/files/<?php echo $value['image_url'];?>" alt="Twilight cover page" width="128" height="128" > 
</div> 
<div class="column-two">
<p><?php echo $value['book_description'];?></p>
<span> Purchase Date: <?php echo $value['purchase_date'];?></span>
<span> Author: <?php echo $value['author'];?></span>
<span> Tags: <?php echo $value['tags'];?></span>
<span> Amazon link: <a href="<?php echo $value['amazon_link'];?>">Click Here</a> </span>
</div>
    <div class="column-three">
    <div><button type="button" class="approve" id="approve_<?php echo $value['nid'];?>" node_id_button_info="<?php echo $value['nid'];?>">Approve</button></div>
    <div><button type="button" class="reject" id="reject_<?php echo $value['nid'];?>" node_id_button_info="<?php echo $value['nid'];?>">Reject</button></div>
</div>
    
    <!--<input type="button" value="POST" /> &nbsp; &nbsp;
  
    <input type="button" value="REJECT " style="vertical-align:middle; float: center-right"/> </p>
-->

<hr class="hr-style">

</div>
    
    
    
    
    
    
    <?php
    
    }?>
<script>
    $=jQuery;
    
    
    
    
    
    
    
   $( document ).ready(function() {
    console.log( "ready!" );
    
        $('.reject').click(function(){
  var id=$(this)[0].getAttribute('node_id_button_info');
  var element=document.getElementById('node_id_'+id);          
  element.remove();
  
  jQuery.ajax({
                    type: 'POST',
                    url: '/foo/ajax/reject_books',
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
 
  
        
    $('.approve').click(function(){
  //do something
  console.log($(this)[0]);
  console.log($(this)[0].getAttribute('node_id_button_info'));
  var id=$(this)[0].getAttribute('node_id_button_info');
  var element=document.getElementById('node_id_'+id);
  element.remove();
  console.log(element);
 
 
 jQuery.ajax({
                    type: 'POST',
                    url: '/foo/ajax/approve_books',
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