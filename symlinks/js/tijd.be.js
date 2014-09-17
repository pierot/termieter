$('.m-leaderboard').remove();
$("#bumpOverlay").remove();
$("#topadvertorialwrap").remove();
$("#bumpModal, .bumpModal").remove();
$(".bumpy").remove();
$(".add_textAd").remove();
$('.header.grid').remove();
$('#splashOverlay').remove();
$('.splashBlock').remove();
$('.abobutton').remove();
$('#schuldenklok').remove();
$('#leaderboard').remove();
$('.sitebrand').remove();
$('#header, #headerInner .wrap').css('background-color', '#fff');
$('#newsteaser').remove();
$('.tv_player_small').remove();
$('#contentteaser, #contentTeaserItemsWrapper, #contentteaser div').css('height', '0px');

$('body, .artContent p').css('font-size', '16px');
$('body, .artContent p').css('line-height', '1.4em');

$('.articledetail .content').css('text-align', 'left');

setTimeout(function() {
  $('a[title="undefined"]').parent().parent().remove();
}, 2000);

dotjs_erase_cookie('ftuuid');
dotjs_erase_cookie('fbcount');
dotjs_erase_cookie('adschedCap');
