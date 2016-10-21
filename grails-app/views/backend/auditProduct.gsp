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
    <meta name="layout" content="backendLayout"/>
    <title>作品审批-</title>
</head>

<body>
    <div class="container">
        <ul class="nav nav-pills nav-sm">
            <li class="active"><a href="#">未审核</a></li>
            <li><a href="#">稍后审核</a></li>
            <li><a href="#">审核失败</a></li>
            <li><a href="#">审核成功(已发布)</a></li>
        </ul>
        <table class="table table-bordered" id="allProductsTable">
            <thead>
            <tr>
                %{--<th></th>--}%
                <th width="120">名称</th>
                <th>描述</th>
                <th width="80">发布时间</th>
                <th width="40">状态</th>
                <th width="100">操作</th>
            </tr>
            </thead>
        </table>
    </div>

    <content tag="footer">
        <asset:javascript src="webuploader-0.1.5/webuploader.js"/>
        <asset:javascript src="jquery-dataTables/jquery.dataTables.min.js"/>
        <asset:javascript src="jquery-dataTables/dataTables.bootstrap.js"/>
        <asset:javascript src="jquery-dataTables/table.js"/>
        <asset:javascript src="Jcrop/js/jquery.Jcrop.min.js"/>
        <asset:javascript src="layer/layer.js"/>
        <script>
            var productTable
            $(function () {
                allProductsInit()
            })
            function allProductsInit() {
                productTable = $('#allProductsTable').DataTable({
                    responsive: true,
                    info: false,
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
                                var str = '<input class="pId" type="hidden" value="'+data.id+'">'
                                if(data.type=='photo'){
                                    str += '<span class="label label-success">photo</span> ' + data.name
                                }else if(data.type=='video'){
                                    str += '<span class="label label-danger">video</span> ' + data.name
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
                            "render": function (data, type, full, meta) {
                                return data
                            }
                        },
                        {
                            "data": null,
                            "orderable": false,
                            "render": function (data, type, full, meta) {
                                var str = ''
                                str +=
                                        '<button type="button" class="btn btn-danger btn-xs btn-xs del">删除</button>'
                                return str
                            }
                        }
                    ]
                })
            }
        </script>
    </content>
</body>
</html>