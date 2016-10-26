<%--
  Created by IntelliJ IDEA.
  flying2.User: nick
  Date: 2016/5/19
  Time: 21:49
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <asset:stylesheet src="jquery-dataTables/dataTables.bootstrap.css"/>
    <asset:stylesheet src="webuploader-0.1.5/webuploader.css"/>
    <asset:stylesheet src="Jcrop/css/jquery.Jcrop.min.css"/>
    <asset:stylesheet src="layer/skin/layer.css"/>
    <asset:stylesheet src="main.css"/>
    <meta name="layout" content="backendLayout"/>
    <title>首页管理-</title>
</head>

<body>
    <div class="container">
        <div class="row margin-top">
            <div class="col-md-2">
                <div class="list-group">
                    <a href="homeManage?type=banner" class="list-group-item ${params.type=="banner"?"active":""}">banner显示</a>
                    <a href="homeManage?type=recommend" class="list-group-item ${params.type=="recommend"?"active":""}">首页内容推荐</a>
                </div>
            </div>
            <div class="col-md-10">
                <g:if test="${params.type=="banner"}">
                    <g:render template="/templates/backend/homeBannerTemplate" />
                </g:if>
                <g:elseif test="${params.type=="recommend"}">
                    <g:render template="/templates/backend/homeRecommendTemplate" />
                </g:elseif>
            </div>
        </div>
    </div>

    <content tag="footer">
        <asset:javascript src="webuploader-0.1.5/webuploader.js"/>
        <asset:javascript src="Jcrop/js/jquery.Jcrop.min.js"/>
        <asset:javascript src="layer/layer.js"/>

        <g:if test="${params.type=="banner"}">
            <script>
                $(function() {
                    var uploader = initFileUploader("#filePicker")
                    uploader.on('beforeFileQueued', function(file){
//                    console.log("file id is:"+file.id+"  and file name is:"+file.name)
                    })
                    // 当有文件添加进来的时候

                    // 文件上传过程中创建进度条实时显示。
//                uploader.on( 'uploadProgress', function( file, percentage ) {
//                    var $li = $( '#'+file.id ),
//                            $percent = $li.find('.progress span');
//                    // 避免重复创建
//                    if ( !$percent.length ) {
//                        $percent = $('<p class="progress"><span></span></p>')
//                                .appendTo( $li )
//                                .find('span');
//                    }
////                        console.log(percentage * 100 + '%--------')
//                    $percent.css( 'width', percentage * 100 + '%' );
//                });
                    // 文件上传成功，给item添加成功class, 用样式标记上传成功。
                    uploader.on( 'uploadSuccess', function( file, response ) {
                        if(response._raw=="sizeNotReached"){
                            alert(file.name+"   的尺寸不够")
                            console.log(file.name+"   的尺寸不够")
                            return
                        }
                        var imgUrl = '/show/bannerShowImg?img=homeBanner_'+response._raw
//                    console.log(response)
                        var $li = $(
                                '<div id="' + file.id + '" class="file-item thumbnail">' +
                                '<input type="hidden" name="stepImg" value="'+response._raw+'">' +
                                '<img src="'+imgUrl+'">' +
                                '<div class="info">' + file.name + '</div>' +
                                '</div>'
                        )
                        var $list = $("#thumb")
//                     $list为容器jQuery实例
                        $list.append( $li );
                        $( '#'+file.id ).addClass('upload-state-done');
                    });
                    // 文件上传失败，显示上传出错（当文件上传出错时触发）。
                    uploader.on( 'uploadError', function( file ) {
                        console.log("---------uploadError---------")
                        var $li = $( '#'+file.id ),
                                $error = $li.find('div.error');
                        // 避免重复创建
                        if ( !$error.length ) {
                            $error = $('<div class="error"></div>').appendTo( $li );
                        }
                        $error.text('上传失败');
                        console.log('上传失败')
                    });
                    //当validate不通过时，会以派送错误事件的形式通知调用者。
                    uploader.on( 'error', function( handler ) {
                        if(handler=='F_EXCEED_SIZE'){
                            alert('超出上传大小限制');
                            console.log('超出上传大小限制');
                        }
                    });
                    // 完成上传完了，成功或者失败，先删除进度条。
                    uploader.on( 'uploadComplete', function( file ) {
//                    console.log(file.name+"------------")
                        $( '#'+file.id ).find('.progress').remove();
                    });

                })

                function initFileUploader(filePicker) {
                    var multiple = false
                    if(filePicker=="#filePicker")
                        multiple = true

                    var BASE_URL = "/assets"
                    // 初始化Web Uploader
                    var uploaderObj = WebUploader.create({
                        // 选完文件后，是否自动上传。
                        auto: true,
                        duplicate: true,
                        compress: false,
                        //验证文件总数量, 超出则不允许加入队列。
//                    fileSizeLimit: 5242880,
                        //验证单个文件大小是否超出限制, 超出则不允许加入队列。
                        fileSingleSizeLimit: 5242880,
                        // swf文件路径
                        swf: BASE_URL + '/webuploader-0.1.5/Uploader.swf',
                        // 文件接收服务端。
                        server: '/backend/uploadBannerImg',
                        // 选择文件的按钮。可选。
                        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
                        pick: {
                            id: filePicker,
                            multiple: multiple
                        },
                        // 只允许选择图片文件。
                        accept: {
                            title: 'Images',
                            extensions: 'gif,jpg,jpeg,bmp,png',
                            mimeTypes: 'image/*'
                        }
                    });
                    return uploaderObj
                }
                function showCoords(c){
                    $('#x1').val(c.x);
                    $('#y1').val(c.y);
                    $('#x2').val(c.x2);
                    $('#y2').val(c.y2);
                    $('#w').val(c.w);
                    $('#h').val(c.h);
                };
            </script>
        </g:if>
        <g:elseif test="${params.type=="recommend"}">
            <asset:javascript src="moment.js"/>
            <asset:javascript src="jquery-dataTables/jquery.dataTables.min.js"/>
            <asset:javascript src="jquery-dataTables/dataTables.bootstrap.js"/>
            <asset:javascript src="jquery-dataTables/table.js"/>
            <script>
                var recommendTable
                $(function () {
                    allRecommendsInit()
                })

                function allRecommendsInit() {
                    recommendTable = $('#recommendTable').DataTable({
                        responsive: true,
                        "lengthChange": false,
                        "searching": false,
                        "order": [[ 2, 'desc' ]],
                        //                    "paging": true,
                        //                    "pageLength": 10,
                        "processing": true,
                        "serverSide": true,
                        "ajax": {
                            "url": "/recommend/getRecommends",
                            "type": "POST",
                            "data": function ( d ) {
                                var p = {p: JSON.stringify(d)}
                                p.type = $('#classifyFilter li.active a').data('classify')
                                return p
                            }
                        },
                        "columns": [
                            {
                                "orderable": false,
                                "data": null,
                                "render": function ( data, type, full, meta ) {
                                    var str =
                                            '<input class="pId" type="hidden" value="'+data.id+'">'+
                                            '<input class="type" type="hidden" value="'+data.type+'">'
                                    if(data.type=='photo'){
                                        str += '<span class="label label-success">photo</span> '
                                    }else if(data.type=='video'){
                                        str += '<span class="label label-danger">video</span> '
                                    }
                                    str = str+ '<a class="auditOpt" data-pid='+data.id+' href="#">'+data.product.name+'</a>'
                                    return str
                                }
                            },
                            {
                                "visible": false,
                                "orderable": false,
                                "data": "product.type",
//                                "render": function (data, type, full, meta) {
//                                    return data.product.type
//                                }
                            },
                            {
                                "data": "createDate",
                                "render": function (data, type, full, meta) {
                                    var date = new Date(data)
                                    return date.getFullYear()+'-'+date.getMonth()+'-'+date.getDate()
                                }
                            },
                            {
                                "orderable": false,
                                "data": "reason"
                            },
                            {
                                "orderable": false,
                                "data": "modifiedLog",
                                "render": function (data, type, full, meta) {
                                    var str = []
                                    $.each(data, function (i, item) {
                                        var action = '<span class="text-danger">待推荐</span>'
                                        if(item.status==1) {
                                            action = '<span class="text-success">推荐中</span>'
                                        }
                                        str.push('<li>动作：'+action+'  日期：'+moment(item.date).format('YYYY-MM-DD HH:mm')+'</li>')
                                    })
                                    str.reverse()
                                    return '<ul>'+str.join('')+'</ul>'
                                }
                            },
//                            {
//                                "data": "status",
//                                "visible": false,
//                                "render": function (data, type, full, meta) {
//                                    switch (data){
//                                        case 0:
//                                            data = '待审核'
//                                            break
//                                        case 1:
//                                            data = '<span class="text-success">已发布</span>'
//                                            break
//                                        case 2:
//                                            data = '待审核'
//                                            break
//                                        case 3:
//                                            data = '<span class="text-danger">发布失败</span>'
//                                            break
//                                        case 4:
//                                            data = '待审核'
//                                            break
//                                        case 5:
//                                            data = '申述中'
//                                            break
//                                        case 6:
//                                            data = '<span class="text-danger">已屏蔽</span>'
//                                            break
//                                    }
//                                    return data
//                                }
//                            },
                            {
                                "data": null,
                                "orderable": false,
                                "render": function (data, type, full, meta) {
                                    var str = '',
                                            btnStatus = 'success',
                                            btnStr = '推荐中'

                                    if(data.status==0) {
                                        btnStatus = 'danger'
                                        btnStr = '待推荐'
                                    }
                                    str +=
                                            '<button class="productStatus btn btn-xs btn-'+btnStatus+'" rid="'+data.id+'">'+btnStr+'</button>'
                                    return str
                                }
                            }
                        ]
                    })
                    $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                        var classify = $(e.target).data('classify')
                        var col
                        if(classify=='all') {
                            col = 1
                            var column = recommendTable.column(col);
                            column.visible(true);
                        }else{
                            var column = recommendTable.column(1);
                            column.visible(false);
                        }
                        recommendTable.draw()
                    })
                }
                $("#recommendTable").delegate(".productStatus", "click", function() {
                    var thisObj = $(this)
                    var rId = $(this).attr("rId")
                    var isRecommend = $(this).hasClass("btn-success") //有btn-success表示推进中
                    $.post(
                        "changeRecommendStatus",
                        {rId: rId, isRecommend: isRecommend},
                        function(d) {
                            if(d.status=="ok") {
                                var str = ""
                                if(d.recommendStatus==0) {
                                    str = "待推荐"
                                    thisObj.removeClass("btn-success")
                                            .addClass("btn-danger")
                                            .text(str)
                                }else if(d.recommendStatus==2) {
                                    str = "超过最大展示数"
                                }else{
                                    str = "推荐中"
                                    thisObj.removeClass("btn-danger")
                                            .addClass("btn-success")
                                            .text(str)
                                }
                                layer.msg("已设置为"+str)
                                recommendTable.draw()
                            }else{
                                alert("错误")
                            }
                        }
                    )
                })

                $(".del").click(function() {
                    if(confirm("确认删除？")) {
                        var curDel = $(this)
                        var rId = $(this).attr("rId")
                        $.post(
                                "delRecommend",
                                {rId: rId},
                                function(d) {
                                    if(d.status=="ok") {
                                        layer.msg("删除成功")
                                        curDel.parents("tr").remove()
                                    }else{
                                        layer.msg("删除失败")
                                    }
                                    recommendTable.draw()
                                }
                        )
                    }
                })
            </script>
        </g:elseif>

    </content>
</body>
</html>