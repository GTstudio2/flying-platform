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
            ${tip}
            <g:if test="${status=="success"}">
                ,
                <g:if test="${locale=="zh_CN"}">
                    你可以
                </g:if>
                <g:link controller="account" action="login" params="[username: username]">登录</g:link>
            </g:if>
        </div>
    </div>
</body>
</html>