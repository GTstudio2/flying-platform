<%--
  Created by IntelliJ IDEA.
  User: nick
  Date: 2016/6/14
  Time: 23:34
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="mySpace">
    <asset:stylesheet src="main.css"/>
    <title>TTG的关注</title>
</head>

<body>
<div class="container">
    <div class="panel panel-default">
        <div class="panel-heading">我关注的</div>

        <div class="panel-body">
            <g:if test="${user.attentions.size() > 0}">
                <div class="row">
                    <g:each var="attention" in="${user.attentions}">
                        <div class="col-md-3 col-sm-4 col-xs-6">
                            <div class="user-panel">
                                <div>
                                    <g:link action="home" id="${attention.id}">
                                        <g:if test="${attention.headImg}">
                                            <img class="big-thumb" src="/show/headImg?img=${attention.folder}/${attention.headImg}"/>
                                        </g:if>
                                        <g:else>
                                            <asset:image class="big-thumb" id="userHead" src="header.jpg"/>
                                        </g:else>
                                    </g:link>
                                </div>
                                <p><g:link action="home" id="${attention.id}">${attention.username}</g:link></p>
                                <div class="brief-text">
                                    ${attention.fansCount}个粉丝<span class="divider">|</span>${attention.productCount}个作品
                                </div>
                            </div>
                        </div>
                    </g:each>
                </div>
            </g:if>
            <g:else>
                <div class="text-center">还没任何关注</div>
            </g:else>
        </div>
    </div>

</div>
<content tag="footer">
    <asset:javascript src="jquery-match-height/jquery.matchHeight.js"/>
    <script>
        $(function () {
            $('.img-link').matchHeight({
                property: 'min-height'
            })
//            $.fn.matchHeight._afterUpdate = function(event, groups) {
//                $('.match-height-mask').css('opacity', 1)
//            }
        })
    </script>
</content>
</body>
</html>