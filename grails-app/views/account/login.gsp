<%--
  Created by IntelliJ IDEA.
  yizhijoke.User: tarek
  date.Date: 2015/8/16
  Time: 12:08
--%>

<html>
<head>
    <meta name="layout" content="main">
    <title>登录</title>
    <asset:stylesheet src="main.css"/>
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-md-offset-4 col-md-4">
                <g:render template="login"/>
            </div>
        </div>
    </div>
    <content tag="footer">
        <asset:javascript src="jquery-validate-1.13.1/jquery.validate.js"/>
        <asset:javascript src="backLogin.js"/>
    </content>
</body>
</html>