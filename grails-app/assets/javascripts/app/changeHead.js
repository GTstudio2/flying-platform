/**
 * Created by Administrator on 2016/10/12 0012.
 */
var folder = $("#folder").val()
$(function () {
    var $singlePicker = $('#coverFilePicker')
    var uploadStatus = $singlePicker.parents('.cover-img-box').find('.uploadStatus')
    uploadStatus.hide()
    var uploader = WebUploader.create({
        auto: true,
        duplicate: true,
        compress: false,
//                    fileSizeLimit: 5242880,
        fileSingleSizeLimit: 5242880,
        swf: BASE_URL + '/webuploader-0.1.5/Uploader.swf',
        server: '/accountSettings/uploadImg',
        formData: {folder: folder},
        pick: {
            id: $singlePicker,
            multiple: false
        },
        accept: {
            title: 'Images',
            extensions: 'gif,jpg,jpeg,bmp,png',
            mimeTypes: 'image/*'
        }
    });
    uploader.on('beforeFileQueued', function (file) {
        uploadStatus.show()
        uploadStatus.text('准备中……')
    })
    uploader.on('fileQueued', function (file) {
    });
    uploader.on('uploadProgress', function (file, percentage) {
        uploadStatus.text('上传中……')
//                        var $li = $( '#'+file.id ),
//                                $percent = $li.find('.progress span');
//                        // 避免重复创建
//                        if ( !$percent.length ) {
//                            $percent = $('<p class="progress"><span></span></p>')
//                                    .appendTo($li)
//                                    .find('span');
//                        }
////                        console.log(percentage * 100 + '%--------')
//                        $percent.css( 'width', percentage * 100 + '%' );
    });
    // 文件上传成功，给item添加成功class, 用样式标记上传成功。
    uploader.on('uploadSuccess', function (file, response) {
        uploadStatus.text('上传成功')
        setTimeout(function () {
            uploadStatus.slideUp(300)
        }, 500)
        if (response._raw == "sizeNotReached") {
            alert(file.name + "   的尺寸不够")
            console.log(file.name + "   的尺寸不够")
            return
        }
        var imgUrl = '/show/headImg?img=' + folder + '/medium_' + response._raw
        modalCut(imgUrl, response._raw)
    });
    // 文件上传失败，显示上传出错（当文件上传出错时触发）。
    uploader.on('uploadError', function (file) {
        var $li = $('#' + file.id),
            $error = $li.find('div.error');
        // 避免重复创建
        if (!$error.length) {
            $error = $('<div class="error"></div>').appendTo($li);
        }
        $error.text('上传失败');
    });
    uploader.on('error', function (handler) {
        if (handler == 'F_EXCEED_SIZE') {
            alert('超出上传大小限制');
            console.log('超出上传大小限制');
        }
    });
    uploader.on('uploadComplete', function (file) {
        $('#' + file.id).find('.progress').remove();
    });
    $(".modal").on('shown.bs.modal', function () {
        $('#adjustImg').Jcrop({
            keySupport: false,
            aspectRatio: 1,
            allowSelect: false,
            onChange: showCoords,
            onSelect: showCoords,
            setSelect: [60, 70, 400, 300]
        })
    })

    $("#crop").click(function () {
        $("#coverFilePicker .webuploader-pick").text("更改图片")
        var cropParams = $("#cropParams").serialize()
        var adjustImg = $("#adjustImg")
        var imgName = adjustImg.attr("imgName")
        var iWidth = adjustImg.width()
        //var iHeight = adjustImg.height()
        cropParams += "&imgName=" + imgName + "&folder=" + folder + "&iWidth=" + iWidth
        $.post(
            "/accountSettings/cropHeadImg?" + cropParams,
            function (d) {
                $("#coverImg").attr("src", "/show/headImg?img=" + folder + "/" + d)
//                                console.log("cover img:  "+d)
                $("input[name='headImg']").val(d)
                $(".modal").modal("hide")
            }
        )
    })
})
function showCoords(c) {
    $('#x1').val(c.x);
    $('#y1').val(c.y);
    $('#x2').val(c.x2);
    $('#y2').val(c.y2);
    $('#w').val(c.w);
    $('#h').val(c.h);
}
function modalCut(data, imgName) {
    $(".modal").modal({backdrop: "static"})
    $("#myModalLabel").text("裁剪图片")
    $(".modalCrop").show()
    $("#cropCoverImg").html('<img id="adjustImg" show="cover">')
    $('#adjustImg').attr({
        src: data,
        imgName: imgName
    })
}