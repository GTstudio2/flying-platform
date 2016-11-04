<div class="panel panel-success margin-top">
    <div class="panel-heading">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <b>登录</b>
    </div>
    <div class="panel-body">
        <form id="loginForm" ${params.action=="login"?action="/account/login":""}>
            <div class="form-group">
                <label for="username">用户名</label>
                <input name="username" class="form-control" id="username" value="${params.username}">
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input name="pwd" type="password" class="form-control" id="password">
            </div>
            <div class="checkbox">
                <g:link class="pull-right" controller="account" action="resetPwd">忘记密码？</g:link>
                <label>
                    <input type="checkbox" name="isAutoLogin"> 自动登录
                </label>
            </div>
            <div class="form-group">
                <span class="text-danger" id="errorBox"></span>
            </div>
            <hr>
            <div class="form-group">
                <span>其它账号登录</span>
                <a href="#" onclick='toLogin()' title="QQ登录">
                    <asset:image src="img/qq_logo.png"/>
                </a>
            </div>

            <button type="submit" class="btn btn-success btn-block">登录</button>
        </form>
    </div>
</div>