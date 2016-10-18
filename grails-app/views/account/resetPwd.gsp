<%--
  Created by IntelliJ IDEA.
  yizhijoke.User: tarek
  date.Date: 2015/8/16
  Time: 12:08
--%>

<html>
<head>
    <meta name="layout" content="main">
    <title>找回密码</title>
    <asset:stylesheet src="main.css"/>
    <style>
        #form2,
        #form3,
        #usernameAndEmailError,
        #resetSuccess,
        #resetFailed{
            display: none;
        }
        .alert>h3{
            margin-top: 0;
        }
    </style>
</head>

<body>
    <div class="container">
        <h3>找回密码</h3>
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-offset-4 col-md-4">
                        <form role="form" id="form1">
                            <div class="form-group">
                                <label for="username">用户名</label>
                                <input class="form-control" id="username" name="username" required placeholder="用户名" minlength="4" maxlength="10">
                            </div>
                            <div class="form-group">
                                <label for="email">请输入邮箱地址</label>
                                <input type="email" name="email" class="form-control" required id="email" placeholder="邮箱地址" maxlength="20">
                            </div>
                            <div class="alert alert-danger" id="usernameAndEmailError">用户名和邮箱地址不匹配</div>
                            <button type="submit" class="btn btn-primary btn-block nextStep">下一步</button>
                        </form>

                        <form class="margin-top" role="form" id="form2">
                            <div class="alert alert-info">我们已向你的邮箱(<span id="emailText"></span>)发送了一封验证码邮件，请查看并在此输入验证码</div>
                            <div class="form-group">
                                <label for="verificationCode">输入获取的验证码</label>
                                <input class="form-control" name="verificationCode" id="verificationCode" required minlength="6" maxlength="6" placeholder="验证码">
                            </div>
                            <button type="submit" class="btn btn-primary btn-block nextStep">下一步</button>
                        </form>

                        <form class="margin-top" role="form" id="form3">
                            <div class="form-group">
                                <label for="pwd">新密码</label>
                                <input type="password" name="pwd" class="form-control" id="pwd" maxlength="20" placeholder="请输入新密码">
                            </div>
                            <div class="form-group">
                                <label for="pwdAgain">再次输入新密码</label>
                                <input type="password" name="confirm_password" class="form-control" id="pwdAgain" maxlength="20" placeholder="再次输入新密码">
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">确认修改</button>
                        </form>

                        <div class="alert alert-success text-center" id="resetSuccess">
                            <h3><span class="glyphicon glyphicon-ok"></span> 密码重置成功</h3>
                            <g:link class="loginLink" controller="account" action="login"><span class="glyphicon glyphicon-circle-arrow-right"></span> 马上登录</g:link>
                        </div>
                        <div class="alert alert-danger text-center" id="resetFailed">
                            <h3><span class="glyphicon glyphicon-remove"></span> 密码重置失败</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <content tag="footer">
        <asset:javascript src="jquery-validate-1.13.1/jquery.validate.js"/>
        <asset:javascript src="app/resetPwd.js"/>
    </content>
</body>
</html>