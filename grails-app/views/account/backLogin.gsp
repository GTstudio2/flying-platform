<%--
  Created by IntelliJ IDEA.
  flying2.User: tarek
  date.Date: 2015/8/16
  Time: 12:08
--%>

<html>
<head>
    <meta name="layout" content="backendLayout">
    <title>后台登陆</title>
    <asset:stylesheet src="main.css"/>
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <g:if test="${params.isAlert}">
                    <div class="alert alert-danger margin-top">
                        请先登录!
                    </div>
                </g:if>
                <div class="panel panel-info b_white1 animated">
                    <div class="panel-heading"><b>登陆到后台管理</b></div>
                    <div class="panel-body">
                        <form id="loginForm" method="post" action="backLogin">
                            <div class="form-group">
                                <label for="username">用户名</label>
                                <input name="username" class="form-control" id="username" placeholder="请输入用户名" value="${params.username}">
                            </div>
                            <div class="form-group">
                                <label for="password">密码</label>
                                <input name="pwd" type="password" class="form-control" id="password" placeholder="请输入密码">

                                <g:if test="${status=="failed"}">
                                    <label class="error" for="password">用户名或密码错误</label>
                                </g:if>
                            </div>
                            <button type="submit" class="btn btn-info btn-block">登陆</button>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
</body>
</html>