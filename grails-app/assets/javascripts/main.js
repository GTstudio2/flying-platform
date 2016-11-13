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
function toLogin(){
    //以下为按钮点击事件的逻辑。注意这里要重新打开窗口
    //否则后面跳转到QQ登录，授权页面时会直接缩小当前浏览器的窗口，而不是打开新窗口
    //var A = window.open("/OAuth/index","TencentLogin",
    //    "width=450,height=320,menubar=0,scrollbars=1,resizable=1,status=1,titlebar=0,toolbar=0,location=1");
    var regex = /OAuth\/afterLogin/
    var afterLoginUrl = ''
    if(!regex.test(window.location)) {
        afterLoginUrl = window.location
    }
    window.location.href = '/OAuth/index?afterLoginUrl='+afterLoginUrl
}
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
