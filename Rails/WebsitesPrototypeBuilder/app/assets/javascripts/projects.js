function showpopup() {
  $(".popup-darkbackground").fadeIn(400);
  $(".popup-createProject").fadeIn(400);
}

function hidepopup() {
  $(".popup-darkbackground").fadeOut(500);
  $(".popup-createProject").fadeOut(500);
}

$(document).ready(function(){
 
 $('.popup-darkbackground').on('click', function ()
  {
    $(".popup-darkbackground").fadeOut(500);
    $(".popup-createProject").fadeOut(500);
  });
  $('.project-div').hover(function()
  {
    $(this).css("cursor","pointer");
    $(this).children('.x-button').fadeIn();
  }, function()
  {
    $(this).css("cursor","pointer");
    $(this).children('.x-button').fadeOut();
  });

  $('.project-div').on('click', function ()
  {
    var projectid = $(this).attr("ProjectId");
    var projectname = $(this).attr("ProjectName");
    $ ("#projectName").text(projectname);
    $("#Design").attr("href","projects/design/" + projectid);
    $("#Task").attr("href","tasks/index/" + projectid);
    $("#sidebar").show("medium");
    $('#content').animate({
      "margin-left": '-9%'
    }, "medium");
  });

  $('#arrow').on('click', function ()
  {
    $("#sidebar").hide("medium");
     $('#content').animate({
      "margin-left": '0%'
    }, "medium");
  });
});
