<%--
  Created by IntelliJ IDEA.
  User: nick
  Date: 2016/6/14
  Time: 23:34
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="manageProducts">
    <asset:stylesheet src="main.css"/>
    <asset:stylesheet src="jquery-dataTables/dataTables.bootstrap.css"/>
    <title>${session.user.username}的作品管理</title>
</head>

<body>
<div class="panel-heading">所有作品<span class="pull-right"><label class="label label-success">photo</label> ${photoCount}个，<label class="label label-danger">video</label> ${videoCount}个
</span></div>
%{--<table class="table table-stripe">--}%
    %{--<g:each var="p" in="${products}">--}%
        %{--<tr>--}%
            %{--<td width="20%"><label class="label label-${p.type == "photo" ? "success" : "danger"}">${p.type}</label> ${p?.name}--}%
            %{--</td>--}%
            %{--<td>${p?.intro}</td>--}%
            %{--<td>--}%
                %{--<g:if test="${p.type = "photo"}">--}%

                %{--</g:if>--}%
                %{--<g:elseif test="${p.type == "video"}">--}%
                    %{--${p.video?.url}--}%
                %{--</g:elseif>--}%
            %{--</td>--}%
            %{--<td width="20%" align="right">--}%
                %{--<button class="btn btn-danger btn-xs del" pid="${p.id}">删除</button>--}%
            %{--</td>--}%
        %{--</tr>--}%
    %{--</g:each>--}%
%{--</table>--}%
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
<content tag="footer">
    <asset:javascript src="jquery-dataTables/jquery.dataTables.min.js"/>
    <asset:javascript src="jquery-dataTables/dataTables.bootstrap.js"/>
    <asset:javascript src="jquery-dataTables/table.js"/>
    <script>
        var productTable
        $(function () {
            $('#allProductsTable').delegate('.del', 'click', function () {
                if(confirm('确认删除吗？')){
                    var pId = $(this).parents('tr').find('.pId').val()
                    $.post(
                            '/manageProducts/delProduct',
                            {pId: pId},
                            function (d) {
                                productTable.draw()
                            }
                    )
                }
            })
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
                    "url": "/manageProducts/getAllProducts",
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