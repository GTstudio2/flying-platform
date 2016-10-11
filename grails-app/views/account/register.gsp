<%--
  Created by IntelliJ IDEA.
  yizhijoke.User: nick
  Date: 2016/6/7
  Time: 22:47
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <asset:stylesheet src="main.css"/>
    <title>注册</title>
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <g:if test="${params.status}">
                    <div class="alert alert-danger margin-top">
                        ${params.tip}
                    </div>
                </g:if>
                <div class="panel panel-info margin-top">
                    <div class="panel-heading"><b>注册</b></div>
                    <div class="panel-body">
                        <form id="registerForm" method="post" action="/account/registerNow">
                            <div class="form-group">
                                <label for="username">用户名</label>
                                <input name="username" class="form-control" id="username" value="${params.username}">
                            </div>
                            <div class="form-group">
                                <label for="email">email</label>
                                <input type="email" name="email" class="form-control" id="email" value="${params.email}">
                            </div>
                            <div class="form-group">
                                <label for="password">密码</label>
                                <input name="pwd" type="password" class="form-control" id="password">
                            </div>
                            <div class="form-group">
                                <label for="password2">再次输入密码</label>
                                <input name="confirm_password" type="password" class="form-control" id="password2">
                            </div>
                            <div class="form-group">
                                <label class="radio-inline">
                                    <input type="radio" name="sex" id="inlineRadio1" value="1" checked> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="sex" id="inlineRadio2" value="2"> 女
                                </label>
                            </div>
                            <button type="submit" class="btn btn-info btn-block">注册</button>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <content tag="footer">
        %{--<asset:javascript src="jquery-validate-1.13.1/jquery.validate.js"/>--}%
        <asset:javascript src="register.js"/>
    </content>
</body>
</html>