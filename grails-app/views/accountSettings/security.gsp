<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/9/20 0020
  Time: 22:12
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="accountSettingsLayout">
    <asset:stylesheet src="main.css"/>
    <title>安全设置</title>
</head>

<body>
    <div class="row">
        <div class="col-md-offset-4 col-md-4">
            <form role="form">
                <div class="form-group">
                    <label for="username">原密码</label>
                    <input type="email" class="form-control" id="username" placeholder="输入新的用户名">
                </div>
                <div class="form-group">
                    <label for="birthday">新密码</label>
                    <input class="form-control" id="birthday">
                </div>
                <div class="form-group">
                    <label for="addr">再次输入新密码</label>
                    <input class="form-control" id="addr">
                </div>
                <button type="submit" class="btn btn-primary btn-block">确认修改</button>
            </form>
        </div>
    </div>
    <content tag="footer">

    </content>
</body>
</html>