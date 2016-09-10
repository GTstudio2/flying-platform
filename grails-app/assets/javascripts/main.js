/**
 * Created by nick on 2016/5/8.
 */
var BASE_URL = "/assets"
$(function() {
    var assetsPath = "/assets"
    dropdownOpen()
    $("img").error(function() {
        $(this).attr("src", assetsPath+"/wrong.jpg")
    })
})
function dropdownOpen() {
    var $dropdownLi = $('li.dropdown');
    $dropdownLi.mouseover(function() {
        $(this).addClass('open');
    }).mouseout(function() {
        $(this).removeClass('open');
    });
}
