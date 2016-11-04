<%@ page import="flying2.User" %>
<!doctype html>
<html lang="en" class="no-js">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <asset:link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
        <title><g:layoutTitle default="起飞影视传媒"/>-起飞影视传媒</title>
        <asset:stylesheet src="application.css"/>
        %{--<script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js" data-appid="101358221" data-redirecturi="http://www.iezhi.com/" charset="utf-8"></script>--}%
        <g:layoutHead/>
    </head>
    <body>
        <div id="container">
            <div id="body">
                <nav class="navbar navbar-default">
                    <div class="container">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <a class="navbar-brand" href="/">起飞航拍</a>
                        </div>
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li ${params.action=="index"?"class=active":""}><g:link controller="show" action="index">首页 <span class="sr-only">(current)</span></g:link></li>
                                <li ${params.action=="productList"&&params.type=="photo"?"class=active":""}><g:link controller="show" action="productList" params="[type: 'photo']">图片</g:link></li>
                                <li ${params.action=="productList"&&params.type=="video"?"class=active":""}><g:link controller="show" action="productList" params="[type: 'video']">视频</g:link></li>
                            </ul>
                            <ul class="nav navbar-nav navbar-right">
                                <g:if test="${session.user}">
                                    <li class="dropdown">
                                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
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
                                <g:if test="${params.action!="login"}">
                                    <g:if test="${params.action!="register"}">
                                        <li><a data-toggle="modal" data-target="#myModal" href="javascript:void(0)">登录</a></li>
                                    </g:if>
                                    <g:else>
                                        <li><a href="/login">登录</a></li>
                                    </g:else>
                                </g:if>
                                <li><a href="/register">注册</a></li>
                            </g:else>
                        </ul>
                        </div><!-- /.navbar-collapse -->
                    </div><!-- /.container-fluid -->
                </nav>

                <g:layoutBody/>
            </div>
            <div class="footer" id="footer">
                <!--<p><strong>Footer</strong> (always at the bottom). View more <a href="http://matthewjamestaylor.com/blog/-website-layouts">website layouts</a> and <a href="http://matthewjamestaylor.com/blog/-web-design">web design articles</a>.</p>-->
                <div class="container">
                    Copyright © 2015,www.yizhi.com ,All rights reserved 版权所有
                    <div class="contact-us">
                        <a href="tencent://message/?uin=963008227">QQ：963008882</a>
                <br>
                        <g:link controller="show" action="contactUs">关于我们</g:link>
                    </div>
                </div>
            </div>
            <g:if test="${!session.user&&params.action!="login"}">
                <div class="modal fade" id="myModal">
                    <div class="modal-dialog">
                        <div class="row">
                            <div class="col-md-offset-2 col-md-8">
                                <g:render template="/account/modalLogin"/>
                            </div>
                        </div>
                    </div>
                </div>
            </g:if>
    </div>
    <asset:javascript src="application.js"/>
    <g:if test="${!session.user&&params.action!="login"}">
        <asset:javascript src="login.js"/>
    </g:if>
    <g:applyLayout name="footerLayout">
        <asset:javascript src="jquery-validate-1.13.1/jquery.validate.js"/>
        <g:pageProperty name="page.footer" />
    </g:applyLayout>
    </body>
</html>
