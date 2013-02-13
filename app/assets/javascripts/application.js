// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(function() {
 $(".user_follow").click(function(e) {
    var follow_id = $("#follow_id").val();
    $.post("/users/follow", { 'id' : follow_id }, function() {
      var flw = $(".user_follow");
      flw.toggleClass("btn-primary");
      if(flw.hasClass("btn-primary")) {
        flw.find(".flw_txt").html('unfollow');  
      } else {
        flw.find(".flw_txt").html('follow');
      }
    });
  }); 

 $(".domain_follow").click(function(e) {
    var follow_id = $("#follow_id").val();
    $.post("/domains/follow", { 'id' : follow_id }, function() {
      var flw = $(".domain_follow");
      flw.toggleClass("btn-primary");
      if(flw.hasClass("btn-primary")) {
        flw.find(".flw_txt").html('unfollow');  
      } else {
        flw.find(".flw_txt").html('follow');
      }
    });
  }); 
});
