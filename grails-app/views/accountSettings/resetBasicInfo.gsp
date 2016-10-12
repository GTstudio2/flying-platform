<%--
  Created by IntelliJ IDEA.
  yizhijoke.User: nick
  Date: 2016/6/10
  Time: 15:42
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>${tip}</title>
    <asset:stylesheet src="main.css"/>
</head>

<body>
    <div class="container margin-top">
        <div class="alert alert-${status=="success"?"success":"danger"}" role="alert">
            <h4>${tip}！</h4>
            <g:link controller="mySpace" action="home"><span class="glyphicon glyphicon-user"></span> 我的空间</g:link>
        </div>
    </div>
</body>
</html>