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
<div class="container match-height-mask">
    <div class="panel panel-default">
        <div class="panel-heading">我关注的</div>

        <div class="panel-body">
            <g:if test="${user.attentions.size() > 0}">
                <div class="row">
                        <g:each var="attention" in="${user.attentions}">
                            <div class="col-md-3 col-sm-6">
                                <div>
                                    ${attention.username}
                                    |
                                    ${attention.fansCount}
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
            $.fn.matchHeight._afterUpdate = function(event, groups) {
                $('.match-height-mask').css('opacity', 1)
            }
        })
    </script>
</content>
</body>
</html>