<%--
  Created by IntelliJ IDEA.
  flying2.User: nick
  Date: 2016/5/15
  Time: 17:56
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <asset:stylesheet src="main.css"/>
    <title>提示</title>
</head>

<body>
    <div class="container margin-top">
        <g:if test="${tip.status=="success"}">
            <div class="alert alert-success" role="alert">
                <h4>上传成功！</h4>
                <g:link controller="manageProducts" action="allProducts"><span class="glyphicon glyphicon-inbox"></span> 作品管理</g:link>
            </div>
        </g:if>
        <g:else>
            <div class="alert alert-danger" role="alert">上传失败！</div>
        </g:else>
    </div>
</body>
</html>