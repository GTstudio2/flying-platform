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
            <g:if test="${params.status=="failed"}">
                <div class="alert alert-danger">${params.tip}！</div>
            </g:if>
            <form id="form1" role="form" action="resetPwdByOldPwd">
                <div class="form-group">
                    <label for="oldPwd">原密码</label>
                    <input type="password" class="form-control" name="oldPwd" id="oldPwd" placeholder="请输入原密码" maxlength="20">
                </div>
                <div class="form-group">
                    <label for="pwd">新密码</label>
                    <input type="password" class="form-control" name="pwd" id="pwd" maxlength="20" placeholder="请输入新密码">
                </div>
                <div class="form-group">
                    <label for="pwd2">再次输入新密码</label>
                    <input type="password" class="form-control" name="confirm_password" id="pwd2" maxlength="20" placeholder="再次输入新密码">
                </div>
                <button type="submit" class="btn btn-primary btn-block">确认修改</button>
            </form>
        </div>
    </div>
    <content tag="footer">
        <asset:javascript src="app/security.js"/>
    </content>
</body>
</html>