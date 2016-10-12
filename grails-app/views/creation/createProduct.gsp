<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <asset:stylesheet src="app/createProduct.css"/>
    <asset:stylesheet src="webuploader-0.1.5/webuploader.css"/>
    <asset:stylesheet src="Jcrop/css/jquery.Jcrop.min.css"/>
    <asset:stylesheet src="main.css"/>
    <title>创建产品-</title>
</head>

<body>
<div class="container">
    <h3>创建${params.type == "photo" ? "图片" : "视频"}</h3>
    <hr>

    <form id="${params.type == "photo" ? "photoForm" : "videoForm"}" action="doCreate">
        <h4>封面图</h4>

        <div class="cover-img-box">
            <input type="hidden" name="coverImg"/>
            <asset:image class="cover-img" id="coverImg" src="pic/p1.jpg"/>
            <p class="uploadStatus"></p>

            <div class="cover-file-picker" id="coverFilePicker">选择封面图片</div>
        </div>
        <hr>
        <input type="hidden" id="folder" name="folder" value="${folder}">
        <input type="hidden" name="type" value="${params.type}">
        <g:if test="${params.type == "photo"}">
            <g:render template="/templates.creation/photoTemplate"/>
        </g:if>
        <g:elseif test="${params.type == "video"}">
            <g:render template="/templates.creation/videoTemplate"/>
        </g:elseif>
        <button type="submit" class="btn btn-success btn-lg">提交作品</button>
    </form>
</div>
<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">裁剪图片</h4>
            </div>

            <div class="modal-body">
                <div class="modalCrop">
                    <form id="cropParams" class="hidden">
                        <input type="hidden" size="4" id="x1" name="x1"/>
                        <input type="hidden" size="4" id="y1" name="y1"/>
                        <input type="hidden" size="4" id="x2" name="x2"/>
                        <input type="hidden" size="4" id="y2" name="y2"/>
                        <input type="hidden" size="4" id="w" name="w"/>
                        <input type="hidden" size="4" id="h" name="h"/>
                    </form>

                    <div id="cropCoverImg"></div>
                </div>
            </div>

            <div class="modal-footer">
                <button id="crop" type="button" class="btn btn-success">确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<content tag="footer">
    <asset:javascript src="webuploader-0.1.5/webuploader.js"/>
    <asset:javascript src="Jcrop/js/jquery.Jcrop.min.js"/>
    <asset:javascript src="jquery-validate-1.13.1/jquery.validate.js"/>
    <g:if test="${params.type == "photo"}">
        <asset:javascript src="app/createProductPhotos.js"/>
    </g:if>
    <script>
        var folder = $("#folder").val()
        $(function () {
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
                        required: "请输入视频地址"
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
//                    $("#coverFilePicker, #filePicker").click(function() {
//                        curFilePicker = $(this).attr("id")
//                    })
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
                server: '/creation/uploadImg',
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
                var imgUrl = '/show/showImg?img=' + folder + '/medium_' + response._raw
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
                    aspectRatio: 4 / 3,
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
                        "/creation/cropCoverImg?" + cropParams,
                        function (d) {
                            $("#coverImg").attr("src", "/show/showImg?img=" + folder + "/" + d)
//                                console.log("cover img:  "+d)
                            $("input[name='coverImg']").val(d)
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
    </script>
</content>
</body>
</html>