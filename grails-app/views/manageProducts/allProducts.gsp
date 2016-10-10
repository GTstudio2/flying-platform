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
    <title>${session.user.username}的作品管理</title>
</head>

<body>
<div class="panel-heading">所有作品<span class="pull-right"><label class="label label-success">photo</label> ${photoCount}个，<label class="label label-danger">video</label> ${videoCount}个
</span></div>
<table class="table table-stripe">
    <g:each var="p" in="${products}">
        <tr>
            <td width="20%"><label class="label label-${p.type == "photo" ? "success" : "danger"}">${p.type}</label> ${p?.name}
            </td>
            <td>${p?.intro}</td>
            <td>
                <g:if test="${p.type = "photo"}">

                </g:if>
                <g:elseif test="${p.type == "video"}">
                    ${p.video?.url}
                </g:elseif>
            </td>
            <td width="20%" align="right">
                <button class="btn btn-danger btn-xs del" pid="${p.id}">删除</button>
            </td>
        </tr>
    </g:each>
</table>
<content tag="footer">
    <script>
        $(function () {

        })
    </script>
</content>
</body>
</html>