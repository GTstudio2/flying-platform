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
function getVideoUrl(videoUrl) {
    var reg = /[\'|\"]http(\w*):\/\/[^\s]+[\'|\"]/
    var result = reg.exec(videoUrl)
    if(result) {
        result = result[0]
        return result.substring(1, result.length-1)
    }else{
        return false
    }
}
