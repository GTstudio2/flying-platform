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
</head>

<body>
    <div class="container">
        <h3>找回密码</h3>
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-offset-4 col-md-4">
                        <form role="form">
                            <div class="form-group">
                                <label for="username">用户名</label>
                                <input class="form-control" id="username" placeholder="用户名">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputEmail1">请输入邮箱地址</label>
                                <input type="email" class="form-control" id="exampleInputEmail1" placeholder="邮箱地址">
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">获取验证码</button>
                        </form>

                        <form class="margin-top" role="form">
                            <div class="form-group">
                                <label for="verificationCode">输入获取的验证码</label>
                                <input class="form-control" id="verificationCode" placeholder="验证码">
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">下一步</button>
                        </form>

                        <form class="margin-top" role="form">
                            <div class="form-group">
                                <label for="pwd">新密码</label>
                                <input class="form-control" id="pwd" placeholder="输入新密码">
                            </div>
                            <div class="form-group">
                                <label for="pwdAgain">再次输入新密码</label>
                                <input class="form-control" id="pwdAgain" placeholder="再次输入新密码">
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">确认修改</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <content tag="footer">
        <asset:javascript src="jquery-validate-1.13.1/jquery.validate.js"/>
        <asset:javascript src="backLogin.js"/>
    </content>
</body>
</html>