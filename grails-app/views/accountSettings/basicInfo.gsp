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
    <asset:stylesheet src="bootstrap-datetimepicker/css/bootstrap-datetimepicker.css"/>
    <asset:stylesheet src="main.css"/>
    <title>基本信息</title>
</head>

<body>
    <div class="row">
        <div class="col-md-offset-4 col-md-4">
            <form role="form">
                <div class="form-group">
                    <label for="username">用户名</label>
                    <input type="email" class="form-control" id="username" placeholder="输入新的用户名">
                </div>
                <div class="form-group">
                    <label for="birthday">生日</label>
                    <input class="form-control" id="birthday" readonly>
                </div>
                <div class="form-group">
                    <label for="addr">所在地区</label>
                    <input class="form-control" id="addr">
                </div>
                <button type="submit" class="btn btn-primary btn-block">确认修改</button>
            </form>
        </div>
    </div>
    <content tag="footer">
        <asset:javascript src="bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"/>
        <asset:javascript src="bootstrap-datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"/>
        <script>
            $('#birthday').datetimepicker({
                format: 'yyyy-mm-dd',
                language:  'zh-CN',
                autoclose: 1,
                minView:2
            });
    </script>
    </content>
</body>
</html>