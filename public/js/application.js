$(document).ready(function () {

$('a.screen_name').mouseenter(showProfileDiv);
$('.profile-card').mouseleave(closeProfileDiv);
$('.close-profile').click(closeProfileDiv);

var tId;

function showProfileDiv (event) {
  var profileCard = $(event.target).parents('.profile-cell').children('.profile-card');
  profileCard.show(500);
  tId = setTimeout(hideIfNotHovered, 1500, profileCard);
}

function hideIfNotHovered (profileCard) {
  clearTimeout(tId);
  if (!profileCard.is(':hover')) {
    profileCard.hide(500);
  }
}

function closeProfileDiv (event) {
  event.preventDefault();
  var profileCard;
  if (event.target.classList[0] === "profile-card") {
    profileCard = $(event.target);
  } else{
    profileCard = $(event.target).parents('.profile-card');
  }
    profileCard.hide(500);
}


});
