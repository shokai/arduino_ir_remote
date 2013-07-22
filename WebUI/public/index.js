var io = new RocketIO().connect();

io.on("connect", function(){
  $("#status .rocketio").text("connect ("+io.type+")");
});

io.on("disconnect", function(){
  $("#status .rocketio").text("disconnect");
});

io.on("status", function(text){
  $("#status .text").text(text);
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
    $("#ir .status").text("sending..").fadeIn(2000).fadeOut(2000);
  });
});
