/**
 * Created by Administrator on 2016/8/28 0028.
 */
$(function () {
    $("#photoForm").validate({
        rules: {
            name: "required"
        },
        messages: {
            name: {
                required: "请输入名称"
            }
        },
        submitHandler: function() {
            if($("[name='stepImg']").size()<1){
                alert("至少上传1张作品图片")
                return false
            }
            if($("[name='coverImg']").val().length>0){
                return true
            }else{
                alert("请上传封面图")
                return false
            }
        }
    });
    var uploader2 = WebUploader.create({
        auto: true,
        duplicate: true,
        compress: false,
//                    fileSizeLimit: 5242880,
        fileSingleSizeLimit: 5242880,
        swf: BASE_URL + '/webuploader-0.1.5/Uploader.swf',
        server: '/creation/uploadImg',
        formData: {folder: folder},
        pick: {
            id: "#filePicker"
        },
        accept: {
            title: 'Images',
            extensions: 'gif,jpg,jpeg,bmp,png',
            mimeTypes: 'image/*'
        }
    });
    uploader2.on('beforeFileQueued', function(file){
    })
    uploader2.on( 'fileQueued', function( file ) {
        var $li = $(
            '<div id="' + file.id + '" class="file-item thumbnail">' +
            '<p class="uploadStatus"></p>' +
            '</div>'
        )
        $("#thumb").append( $li );
    });
    uploader2.on( 'uploadProgress', function( file, percentage ) {

        var $li = $( '#'+file.id )
//                                ,
//                                $percent = $li.find('.progress span');
        $li.find('.uploadStatus').text('上传中……，完成'+percentage+'%')
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
    uploader2.on( 'uploadSuccess', function( file, response ) {
        if(response._raw=="sizeNotReached"){
            alert(file.name+"   的尺寸不够")
            console.log(file.name+"   的尺寸不够")
            return
        }
        var imgUrl = '/show/showImg?img='+folder+'/medium_'+response._raw
        var $li = $(
            '<input type="hidden" name="stepImg" value="'+response._raw+'">' +
            '<img src="'+imgUrl+'">' +
            '<div class="info">' + file.name + '</div>'
        )
        $('#'+file.id).html( $li )
            .addClass('upload-state-done');
    });
    // 文件上传失败，显示上传出错（当文件上传出错时触发）。
    uploader2.on( 'uploadError', function( file ) {
        var $li = $( '#'+file.id ),
            $error = $li.find('div.error');
        // 避免重复创建
        if ( !$error.length ) {
            $error = $('<div class="error"></div>').appendTo( $li );
        }
        $error.text('上传失败');
    });
    uploader2.on( 'error', function( handler ) {
        if(handler=='F_EXCEED_SIZE'){
            alert('超出上传大小限制');
            console.log('超出上传大小限制');
        }
    });
    uploader2.on( 'uploadComplete', function( file ) {
//                        $( '#'+file.id ).find('.progress').remove();
    });
})