$(document).ready(function () {

$('a.screen_name').mouseenter(showProfileDiv);
$('.profile-card').mouseleave(closeProfileDiv);

function showProfileDiv (event) {
  var profileCard = $(event.target).parent('td').children('.profile-card')
  profileCard.show();
}

$('.close-profile').click(closeProfileDiv);

function closeProfileDiv (event) {
  event.preventDefault;
  if (event.target.classList[0] === "profile-card") {
    var profileCard = $(event.target);
  } else{
    var profileCard = $(event.target).parents('.profile-card');
    profileCard.hide();
  }
}



});
