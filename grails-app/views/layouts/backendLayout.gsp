<!doctype html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title><g:layoutTitle default="起飞影视后台"/>起飞影视后台</title>
        <asset:stylesheet src="application.css"/>
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
                            <a class="navbar-brand" href="/backend/allProductions">起飞航拍</a>
                        </div>
                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li ${params.action=="allProductions"?"class=active":""}><g:link controller="backend" action="allProductions">所有作品</g:link></li>
                                %{--<li class="dropdown">--}%
                                    %{--<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">创建作品 <span class="caret"></span></a>--}%
                                    %{--<ul class="dropdown-menu">--}%
                                        %{--<li ${params.action=="createProduct"&&params.type=="photo"?"class=active":""}><g:link controller="backend" action="createProduct" params="[type: 'photo']">创建图片</g:link></li>--}%
                                        %{--<li ${params.action=="createProduct"&&params.type=="video"?"class=active":""}><g:link controller="backend" action="createProduct" params="[type: 'video']">创建视频</g:link></li>--}%
                                    %{--</ul>--}%
                                %{--</li>--}%
                                <li ${params.action=="homeManage"?"class=active":""}><g:link controller="backend" action="homeManage">首页管理</g:link></li>
                            </ul>
                            <!--<ul class="nav navbar-nav navbar-right">-->
                            <!--<li><a href="#">视频</a></li>-->
                            <!--</ul>-->
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
                    </div>
                </div>
            </div>
    </div>
    <asset:javascript src="application.js"/>
    <asset:javascript src="jquery-validate-1.13.1/jquery.validate.js"/>
    <g:applyLayout name="footerLayout">
        <g:pageProperty name="page.footer" />
    </g:applyLayout>
    </body>
</html>
