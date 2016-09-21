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
    <title>主页展示方式</title>
</head>

<body>
    <div class="btn-group" data-toggle="buttons">
        <label class="btn btn-success" data-toggle="tab" href="#tab1">
            <input type="radio" name="options" id="option1" checked> 时间展示
        </label>
        <label class="btn btn-success" data-toggle="tab" href="#tab2">
            <input type="radio" name="options" id="option2"> 自定义展示
        </label>
    </div>
    <div class="tab-content margin-top">
        <div class="tab-pane active" id="tab1">
            个人主页展示已设置为时间展示，展示作品以时间从最近到以前的顺序排列
        </div>
        <div class="tab-pane" id="tab2">
            <button class="btn btn-default btn-xs pull-right" data-toggle="tooltip" data-placement="left" title="自定义展示为用户可以对进行上传后的作品选择指定的位置进行展示">?</button>
        </div>
    </div>
    <content tag="footer">
        <script>
            $(function () {
                $("[data-toggle='tooltip']").tooltip();
                buttonsInit()
            })
            function buttonsInit(){
                $('.btn-group input[type="radio"]:checked').parent().addClass('active')
            }
        </script>
    </content>
</body>
</html>