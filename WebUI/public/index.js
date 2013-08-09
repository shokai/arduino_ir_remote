var io = new RocketIO().connect();

io.on("connect", function(){
  $("#status .rocketio").text("connect ("+io.type+")");
});

io.on("disconnect", function(){
  $("#status .rocketio").text("disconnect");
});

io.on("temp", function(temp){
  $("#status .temp").text("temperature : "+temp);
});

io.on("log", function(text){
  $("#logs").prepend(
    $("<p>").text(text).fadeIn(600)
  );
});

$(function(){
  $(".btn_ir_write").click(function(e){
    var name = e.target.value;
    io.push("ir_write", name);
    $("#ir .status").text("writing ["+name+"]").fadeIn(600).fadeOut(2000);
  });
});
