$(document).ready(function () {

$('a.screen_name').mouseenter(showProfileDiv);
// .mouseleave(hideProfileDiv);

function showProfileDiv (event) {
  var profileCard = $(event.target).parent('td').children('.profile-card')
  profileCard.show();
}

$('.close-profile').click(closeProfileDiv);

function closeProfileDiv (event) {
  event.preventDefault;
  var profileCard = $(event.target).parents('.profile-card');
  profileCard.hide();
}



function hideProfileDiv (event) {
  var profileCard = $(event.target).parents('td').children('.profile-card');
  profileCard.mouseleave(closeProfileDiv);
}


});
