$(function () {
    jQuery.validator.addMethod("videoUrl", function(value, element) {
        var $videoUrl = $('#videoUrl')
        var videoUrl = $videoUrl.val()
        var finalUrl = getVideoUrl(videoUrl)
        var videoReg = /^https?.+$/
        var flag = false
        if(finalUrl||videoReg.test(videoUrl)){
            if(finalUrl){
                $videoUrl.val(finalUrl)
            }
            flag = true
            $('.previewVideo').removeClass('hide')
        }else{
            $('.previewVideo').addClass('hide')
        }
        return this.optional(element) || flag;
    }, "请输入可用的优酷视频地址");

    $('.previewVideo').click(function () {
        var videoUrl = $('#videoUrl').val()
        if(videoUrl) {
            window.open(videoUrl)
        }else{
            layer.msg('请输入视频地址')
        }
    })
    $("#videoForm").validate({
        rules: {
            name: "required",
            url: "required"
        },
        messages: {
            name: {
                required: "请输入名称"
            },
            url: {
                required: "请输入优酷视频地址"
            }
        },
        submitHandler: function () {
            if ($("[name='coverImg']").val().length > 0) {
                return true
            } else {
                alert("请上传封面图")
                return false
            }
        }
    });

})