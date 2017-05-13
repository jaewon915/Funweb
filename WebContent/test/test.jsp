<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
<script>
$(document).ready(function(){
    /* $("button").mouseover(function(){ */
    $("button").click(function(){
        $("p").slideToggle();
    });
});
</script>
</head>
<body>

<p>
This is a paragraph.<br>
This is a paragraph.<br>
This is a paragraph.<br>
This is a paragraph.<br>
</p>

<button>Toggle slideUp() and slideDown()</button>

</body>
</html>