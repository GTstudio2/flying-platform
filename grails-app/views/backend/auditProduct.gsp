<%--
  Created by IntelliJ IDEA.
  flying2.User: nick
  Date: 2016/5/19
  Time: 21:49
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <asset:stylesheet src="webuploader-0.1.5/webuploader.css"/>
    <asset:stylesheet src="jquery-dataTables/dataTables.bootstrap.css"/>
    <asset:stylesheet src="Jcrop/css/jquery.Jcrop.min.css"/>
    <asset:stylesheet src="layer/skin/layer.css"/>
    <asset:stylesheet src="main.css"/>
    <style>
.modal-body>h3,
.panel-body>h4{
        margin-top: 0;
    }
    #auditReason{
        display: none;
    }
    .list-group{
        margin-bottom: 0;
    }
</style>
    <meta name="layout" content="backendLayout"/>
    <title>作品审批-</title>
</head>

<body>
    <div class="container">
        <ul class="nav nav-pills nav-sm" id="classifyFilter">
            <li><a href="#" data-toggle="tab" data-classify="all">全部</a></li>
            <li class="active"><a href="#" data-toggle="tab" data-classify="notAudit">未审核</a></li>
            <li><a href="#" data-toggle="tab" data-classify="appeal">申述</a></li>
            <li><a href="#" data-toggle="tab" data-classify="auditLater">稍后审核</a></li>
            <li><a href="#" data-toggle="tab" data-classify="auditFailed">审核失败</a></li>
            <li><a href="#" data-toggle="tab" data-classify="auditProhibit">已屏蔽</a></li>
            <li><a href="#" data-toggle="tab" data-classify="userDeleted">用户删除</a></li>
            <li><a href="#" data-toggle="tab" data-classify="auditSuccess">审核成功(已发布)</a></li>
        </ul>
        <table class="table table-bordered" id="allProductsTable">
            <thead>
            <tr>
                %{--<th></th>--}%
                %{--<th width="50">作者</th>--}%
                <th width="150">名称</th>
                <th>描述</th>
                <th width="80">发布时间</th>
                <th width="40">状态</th>
                <th width="100">操作</th>
            </tr>
            </thead>
        </table>
    </div>

    <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">审核 <small class="text-success" id="auditUsername"></small></h4>
                </div>
                <div class="modal-body" id="modalBody">

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="auditNow">确定</button>
                </div>
            </div>
        </div>
    </div>
<script id="productPreviewTmpl" type="text/x-jquery-tmpl">
    %{--<%='${product.type}'%>--}%
        {%if audits.length%}
            <div class="panel panel-info">
                <div class="panel-body">
                    <h4>审核历史</h4>
                    <ul class="list-group">
                        {%each(i, audit) audits%}
                          <li class="list-group-item">
                            <span class="pull-right"><%= '${audit.createDate}' %></span>
                            {%if audit.status=='1'%}
                            <span class="text-success"><span class="glyphicon glyphicon-ok"></span> 成功</span>
                            {%elseif audit.status=='5'%}
                            <span class="label label-info">申述</span><%= '${audit.reason}' %>
                            {%elseif audit.status=='3'%}
                            <span class="label label-danger">审核不通过</span><%= '${audit.reason}' %>
                            {%else%}
                                <%= '${audit.reason}' %>
                            {%/if%}
                          </li>
                        {%/each%}
                    </ul>
                </div>
            </div>
        {%/if%}

    {%if product.type=='photo'%}
        <h3 class="title"><%= '${product.name}' %></h3>
        <p><%= '${product.intro}' %></p>
        <div class="img-content">
            {%each images%}
                <img src="<%='${images[$index]}'%>">
            {%/each%}
        </div>
    {%elseif product.type=='video'%}
        <h3 class="title"><%= '${product.name}' %></h3>
        <p><%= '${product.intro}' %></p>
        <iframe id='videoFrame' height='498' width='100%' src='<%= '${product.video.url}' %>' frameborder=0 'allowfullscreen'></iframe>
    {%/if%}
    <div class="text-center margin-top agreementOptBox">
        <div class="form-group">
            <div class="btn-group" data-toggle="buttons" id="agreementBtn">
                <label class="btn btn-default">
                    <input type="radio" name="agreement" value="1"> 通过
                </label>
                <label class="btn btn-default">
                    <input type="radio" name="agreement" value="0"> 不通过
                </label>
                <label class="btn btn-default">
                    <input type="radio" name="agreement" value="6"> 禁止发布
                </label>
            </div>
        </div>
        <div class="row">
        <div class="col-sm-offset-3 col-sm-6">
            <textarea class="form-control" name="reason" id="auditReason" rows="3" maxlength="225" placeholder="请输入不同意的理由"></textarea>
        </div>
        </div>
    </div>
</script>
<content tag="footer">
        <asset:javascript src="webuploader-0.1.5/webuploader.js"/>
        <asset:javascript src="jquery-dataTables/jquery.dataTables.min.js"/>
        <asset:javascript src="jquery-dataTables/dataTables.bootstrap.js"/>
        <asset:javascript src="jquery-dataTables/table.js"/>
        <asset:javascript src="jquery-tmpl/jquery.tmpl.js"/>
        <asset:javascript src="moment.js"/>
        <asset:javascript src="layer/layer.js"/>
        <script>
            var productTable,
                    pId,
                    status
            $(function () {
                allProductsInit()
                $('#allProductsTable').delegate('.auditOpt', 'click', function () {
                    pId = $(this).data('pid')
                    status = $(this).parents('tr').find('.status').val()
                    $('#myModal').modal()
                })
                $('#myModal').on('shown.bs.modal', function () {
                    $.get(
                            '/backend/getProduct',
                            {isAjax: 1, id: pId},
                            function (d) {
                                if(d.product.user) {
                                    $('#auditUsername').text(d.product.user.username)
                                    var images = []
                                    if(d.product.type=='photo') {
                                        if(d.product.photo) {
                                            $.each(d.product.photo, function (i, item) {
                                                var img = '/show/showImg?img='+d.product.folder+'/medium_'+item.img
                                                images.push(img)
                                            })
                                            $.each(d.audits, function (i, item) {
                                                item.createDate = moment(item.createDate).format('YYYY-MM-DD HH:mm')
                                            })
                                            d.images = images
                                        }else{
                                            layer.msg('没有图片！')
                                        }
                                    }else{
                                        $('#videoFrame').attr('src', d.product.video.url)
                                    }
                                    $('#modalBody').html($('#productPreviewTmpl').tmpl(d))
                                }else{
                                    layer.msg('请重新登录')
                                }
                            }
                    )
                })
                $('#myModal').on('hidden.bs.modal', function () {
                    $('#modalBody').html('')
                })
                auditInit()
            })
            function auditInit() {
                $('#modalBody').delegate('[name="agreement"]', 'change', function () {
                    var agreement = $('[name="agreement"]:checked').val()
                    if(agreement==0||agreement==6) {
                        $('#auditReason').show().focus()
                    }else{
                        $('#auditReason').hide()
                    }
                })
                $('#auditNow').click(function () {
                    var agreement = $('[name="agreement"]:checked').val()
                    var reason
                    if(!agreement) {
                        layer.msg('请选择通过或者不通过')
                        return
                    }else if(agreement==0||agreement==6) {
                        reason = $.trim($('#auditReason').val())
                        if(!reason) {
                            layer.msg('请填写不通过的理由')
                            return
                        }
                    }
                    $.post(
                            '/audit/auditNow',
                            {pId: pId, agreement: agreement,reason: reason},
                            function (d) {
                                if(d.status=='success') {
                                   $('#myModal').modal('hide')
                                    productTable.draw()
                                    layer.msg('修改成功')
                                }else{
                                    alert(d.tip)
                                }
                            }
                    )
                })
            }
            function allProductsInit() {
                productTable = $('#allProductsTable').DataTable({
                    responsive: true,
//                    info: false,
                    "lengthChange": false,
                    "searching": false,
                    "order": [[ 2, 'desc' ]],
    //                    "paging": true,
    //                    "pageLength": 10,
                    "processing": true,
                    "serverSide": true,
                    "ajax": {
                        "url": "/backend/getAllProducts",
                        "type": "POST",
                        "data": function ( d ) {
                            var p = {p: JSON.stringify(d)}
                            p.status = $('#classifyFilter li.active a').data('classify')
                            return p
                        }
                    },
                    "columns": [
    //                        {
    //                            "data": null,
    //                            "orderable": false,
    //                            className: "row-select",
    //                            "render": function ( data, type, full, meta ) {
    //                                var str =
    ////                                        '<input type="checkbox">' +
    //                                        '<input class="pId" type="hidden" value="'+data.id+'">'
    //                                return str
    //                            }
    //                        },
                        {
                            "orderable": false,
                            "data": null,
                            "render": function ( data, type, full, meta ) {
                                var str =
                                        '<input class="pId" type="hidden" value="'+data.id+'">'+
                                        '<input class="status" type="hidden" value="'+data.status+'">'
                                if(data.type=='photo'){
                                    str += '<span class="label label-success">photo</span> '
                                }else if(data.type=='video'){
                                    str += '<span class="label label-danger">video</span> '
                                }
                                if(data.status!=6&&data.status!=7) {
                                    str = str+ '<a class="auditOpt" data-pid='+data.id+' href="#">'+data.name+'</a>'
                                }else{
                                    str = str + data.name
                                }
                                return str
                            }
                        },
                        {
                            "orderable": false,
                            "data": "intro"
                        },
                        {
                            "data": "createDate",
                            "render": function (data, type, full, meta) {
                                var date = new Date(data)
                                return date.getFullYear()+'-'+date.getMonth()+'-'+date.getDate()
                            }
                        },
                        {
                            "data": "status",
                            "visible": false,
                            "render": function (data, type, full, meta) {
                                switch (data){
                                    case 0:
                                        data = '待审核'
                                        break
                                    case 1:
                                        data = '<span class="text-success">已发布</span>'
                                        break
                                    case 2:
                                        data = '待审核'
                                        break
                                    case 3:
                                        data = '<span class="text-danger">发布失败</span>'
                                        break
                                    case 4:
                                        data = '待审核'
                                        break
                                    case 5:
                                        data = '申述中'
                                        break
                                    case 6:
                                        data = '<span class="text-danger">已屏蔽</span>'
                                        break
                                    case 7:
                                        data = '<span class="text-danger">用户删除</span>'
                                        break
                                }
                                return data
                            }
                        },
                        {
                            "data": null,
                            "orderable": false,
                            "render": function (data, type, full, meta) {
                                var str = ''
                                if(data.status!=6&&data.status!=7) {
                                    str +=
                                            '<button type="button" class="btn btn-danger btn-xs btn-xs auditOpt" data-pid='+data.id+'>审核</button>'
                                }
                                return str
                            }
                        }
                    ]
                })
                $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                    var classify = $(e.target).data('classify')
                    if(classify=='all') {
                        productTable.column(3).visible(true);
                        productTable.column(4).visible(true);
                    }else{
                        productTable.column(3).visible(false);
                    }
                    if(classify=='auditProhibit'||classify=='userDeleted') {
                        productTable.column(4).visible(false);
                    }else {
                        productTable.column(4).visible(true);
                    }
                    productTable.draw()
                })
            }
        </script>
    </content>
</body>
</html>