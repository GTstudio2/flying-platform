<%@ page import="flying2.User" %>
<!doctype html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <asset:link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
    <title><g:layoutTitle/>  空间</title>
    <meta name="keywords" content="${keywords}">
    <meta name="description" content="${description}">
    <asset:stylesheet src="application.css"/>
    %{--<asset:stylesheet src="app/mySpace/mySpace.css"/>--}%
    <g:layoutHead/>
</head>

<body>
<div id="container">
    <div id="body">
        <nav class="navbar navbar-default fly-nav">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="/">起飞摄影</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    %{--<ul class="nav navbar-nav">--}%
                        %{--<li ${params.action == "index" && params.type == "" ? "class=active" : ""}><a--}%
                                %{--href="/index">最新</a></li>--}%
                        %{--<li ${params.action == "index" && params.type == "Gif" ? "class=active" : ""}><a--}%
                                %{--href="/indexGif">动图</a></li>--}%
                        %{--<li><a href="/photoVs">起飞表情</a></li>--}%
                    %{--</ul>--}%
                    <ul class="nav navbar-nav navbar-right">
                        <g:if test="${session.user}">
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                                   aria-haspopup="true" aria-expanded="false">
                                    ${flying2.User.get(session.user?.id).username}
                                    <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu">
                                    <li class="${params.action=="home"?"active":""}"><g:link controller="mySpace" action="home"><span class="glyphicon glyphicon-user"></span> 我的空间</g:link></li>
                                    <li><g:link controller="creation" action="createProduct" params="[type: 'photo']"><span class="glyphicon glyphicon-picture"></span> 创建图片</g:link></li>
                                    <li><g:link controller="creation" action="createProduct" params="[type: 'video']"><span class="glyphicon glyphicon-film"></span> 创建视频</g:link></li>
                                    <li><g:link controller="account" action="logOut"><span class="glyphicon glyphicon-log-out"></span> 退出</g:link></li>
                                </ul>
                            </li>
                        </g:if>
                        <g:else>
                            <g:if test="${params.action != "login"}">
                                <g:if test="${params.action != "register"}">
                                    <li><a data-toggle="modal" data-target="#myModal" href="javascript:void(0)">登录</a>
                                    </li>
                                </g:if>
                                <g:else>
                                    <li><a href="/login">登录</a></li>
                                </g:else>
                            </g:if>
                            <li><a href="/register">注册</a></li>
                        </g:else>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="user-brief-box">
            <div class="container">
                <div class="media margin-bottom">
                    <div class="media-left">
                        <a href="javascript:void(0)">
                            <g:if test="${user.headImg}">
                                <img class="big-thumb" src="/show/headImg?img=${user.folder}/${user.headImg}"/>
                            </g:if>
                            <g:else>
                                <asset:image class="big-thumb" src="header.jpg"/>
                            </g:else>
                        </a>
                    </div>
                    <div class="media-body">
                        <h4 class="media-heading">${user?.username}</h4>
                        <g:if test="${user?.intro}">
                            ${user?.intro}
                        </g:if>
                        <g:else>
                            该用户还没有任何介绍
                        </g:else>
                    </div>
                    <g:if test="${session.user}">
                        <div class="media-right text-right">
                            <g:link class="btn btn-default btn-sm margin-bottom-xs" controller="accountSettings" action="basicInfo" title="个人设置"><span class="glyphicon glyphicon-cog"></span> 个人设置</g:link>
                        %{--<a class="btn btn-default btn-sm margin-bottom-xs" href="http://www.baidu.com" title="个人设置"></a>--}%
                            %{--<a class="btn btn-default btn-sm" href="http://www.baidu.com">--}%
                            %{--</a>--}%
                            <g:link class="btn btn-default btn-sm" controller="manageProducts" action="allProducts"><span class="glyphicon glyphicon-inbox"></span> 作品管理</g:link>
                        </div>
                    </g:if>
                </div>
                <ul class="nav nav-tabs bottom-nav margin-bottom">
                    <li role="presentation" ${params.action == "home" ? "class=active" : ""}><g:link
                            controller="mySpace" action="home" id="${user?.id}">个人主页</g:link></li>
                    <li role="presentation" ${params.classify == "photo" ? "class=active" : ""}><g:link
                            controller="mySpace" action="products" id="${user?.id}" params="[classify: 'photo']">照片</g:link></li>
                    <li role="presentation" ${params.classify == "video" ? "class=active" : ""}><g:link
                            controller="mySpace" action="products" id="${user?.id}" params="[classify: 'video']">视频</g:link></li>
                    <li role="presentation" ${params.action == "attentions" ? "class=active" : ""}><g:link
                            controller="mySpace" action="attentions" id="${user?.id}">关注</g:link></li>
                    %{--<li role="presentation"><a href="#" data-toggle="tab">讨论区</a></li>--}%
                    %{--<li role="presentation"><a href="#" data-toggle="tab">讨论区</a></li>--}%
                </ul>
            </div>
        </div>
        <g:layoutBody/>
    </div>

    <div class="footer" id="footer">
        <!--<p><strong>Footer</strong> (always at the bottom). View more <a href="http://matthewjamestaylor.com/blog/-website-layouts">website layouts</a> and <a href="http://matthewjamestaylor.com/blog/-web-design">web design articles</a>.</p>-->
        <div class="container">
            Copyright © 2015,www.yizhi.com ,All rights reserved 版权所有
        </div>
    </div>
    <g:if test="${!session.user && params.action != "login"}">
        <div class="modal fade" id="myModal">
            <div class="modal-dialog">
                <div class="row">
                    <div class="col-md-offset-2 col-md-8">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <g:render template="/account/login"/>
                    </div>
                </div>
            </div>
        </div>
    </g:if>
</div>
<asset:javascript src="application.js"/>
<asset:javascript src="jquery-validate-1.13.1/jquery.validate.js"/>
<g:if test="${!session.user && params.action != "login"}">
    <asset:javascript src="app/show/login.js"/>
</g:if>
<g:applyLayout name="footerLayout">
    <g:pageProperty name="page.footer"/>
</g:applyLayout>
</body>
</html>
