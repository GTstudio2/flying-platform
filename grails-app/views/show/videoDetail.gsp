<%--
  Created by IntelliJ IDEA.
  flying2.User: nick
  Date: 2016/5/14
  Time: 17:26
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <asset:stylesheet src="photoSwiper/photoswipe.css"/>
    <asset:stylesheet src="photoSwiper/default-skin/default-skin.css"/>
    <asset:stylesheet src="main.css"/>
    <asset:stylesheet src="app/detail.css"/>
    <meta name="layout" content="main"/>
    <title>${product.name}</title>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="col-md-offset-2 col-md-8">

            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="pull-right" title="浏览${product.viewer}次"><span class="glyphicon glyphicon-eye-open"></span> ${product.viewer}</div>
                    <h3 class="title">${product.name}</h3>
                    <p>${product.intro}</p>
                    <div class="video-content">
                        <iframe height=498 width=100% src='${product.video.url}' frameborder=0 allowfullscreen></iframe>
                    </div>
                </div>
            </div>

            %{--<div>--}%
                %{--<h4>推荐</h4>--}%
                %{--<div class="row classify-pro classify-videos">--}%
                    %{--<div class="col-md-3 pro-box">--}%
                        %{--<a href="javascript:void(0)"><div class="play-mask"></div><img layer-src="../images/pro/80179ea4-8e75-421d-90fd-2cc9620b62e5.jpg" src="../images/pic/p1.jpg"></a>--}%
                        %{--<h5>河口日出</h5>--}%
                    %{--</div>--}%
                    %{--<div class="col-md-3 pro-box">--}%
                        %{--<a href="javascript:void(0)"><div class="play-mask"></div><img layer-src="../images/pic/539837a6-702c-46ea-b1d2-644baaf5ef01.jpg" src="../images/pic/p2.jpg"></a>--}%
                        %{--<h5>德阳东风电机场</h5>--}%
                    %{--</div>--}%
                %{--</div>--}%
            %{--</div>--}%
            <div class="interactive-panel margin-bottom">
                <div class="interactive-body">
                    <g:link controller="mySpace" action="home" id="${product.user.id}">
                        <g:if test="${product.user.headImg}">
                            <img class="middle-thumb"
                                 src="/show/headImg?img=${product.user.folder}/${product.user.headImg}"/>
                        </g:if>
                        <g:else>
                            <asset:image class="middle-thumb" id="userHead" src="header.jpg"/>
                        </g:else>
                    </g:link>
                    <h4 class="brief-text">${product.user.username}</h4>
                    <g:if test="${isAttention=="attention"||!isAttention}">
                        <button class="attention-btn opt-btn ${isAttention?"active":""}" id="attentionTo">
                            <span class="not-attention"><span class="glyphicon glyphicon-plus"></span> <span class="text">关注</span></span>
                            <span class="attention"><span class="glyphicon glyphicon-ok"></span> <span class="text">已关注</span></span>
                        </button>
                    </g:if>
                    <g:elseif test="${isAttention=="manage"}">
                        <g:link controller="manageProducts" action="allProducts" class="attention attention-btn opt-btn active"><span class="glyphicon glyphicon-inbox"></span> <span class="text">创作中心</span></g:link>
                    </g:elseif>
                </div>
            </div>

            <div class="panel panel-default margin-top">
                <div class="panel-body">
                    <div class="media">
                        <div class="media-left">
                            <g:if test="${user?.headImg}">
                                <g:link controller="mySpace" action="home" id="${user.id}">
                                    <img class="middle-thumb" id="userHead" src="/show/headImg?img=${user.folder}/${user.headImg}"/>
                                </g:link>
                            </g:if>
                            <g:else>
                                <a href="javascript:void(0)">
                                    <asset:image class="middle-thumb" id="userHead" src="header.jpg"/>
                                </a>
                            </g:else>
                        </div>
                        <div class="media-body">
                            <span class="comment-limit">可输入<span id="releaseCounter"></span>个字符</span>
                            <h4 class="media-heading" id="userName">${user?.username}</h4>
                            <textarea class="form-control comment-area" name="comment" id="comment" rows="3" placeholder="发表评论" maxlength="300"></textarea>
                            <div class="row margin-top5">
                                <div class="col-md-offset-10 col-md-2">
                                    <button class="btn btn-primary btn-sm btn-block" id="release">发布</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="comment-list" id="commentList">

                        %{--<div class="media">--}%
                        %{--<div class="media-left">--}%
                        %{--<a href="#">--}%
                        %{--<asset:image class="middle-thumb" src="header.jpg"/>--}%
                        %{--</a>--}%
                        %{--</div>--}%
                        %{--<div class="media-body">--}%
                        %{--<a class="pull-right" href="#">回复</a>--}%
                        %{--<h4 class="media-heading">nick</h4>--}%
                        %{--fasdfasdfsdf--}%
                        %{--</div>--}%
                        %{--</div>--}%
                    </div>
                    <nav class="text-center">
                        <ul class="pagination" id="pagination"></ul>
                    </nav>
                </div>

            </div>
        </div>


    </div>
</div>
<script id="commentTmpl" type="text/x-jquery-tmpl">
    {%each(i,comment) comments%}
    <div class="media">
        <div class="media-left">
            <a href="/mySpace/home/<%= '${userId}' %>">
                <img class="middle-thumb" src="<%='${userHeadUrl}'%>">
            </a>
        </div>
        <div class="media-body">
            %{--<a class="pull-right" href="#">回复</a>--}%
            <h4 class="media-heading"><%= '${username}' %></h4>
            <%= '${comment}' %>
        </div>
    </div>
    {%/each%}
</script>
<content tag="footer">
    <asset:javascript src="photoSwiper/photoswipe.min.js"/>
    <asset:javascript src="photoSwiper/photoswipe-ui-default.min.js"/>
    <asset:javascript src="bootstrap-paginator/bootstrap-paginator.min.js"/>
    <asset:javascript src="jquery-simply-countable/jquery.simplyCountable.js"/>
    <asset:javascript src="layer/layer.js"/>
    <asset:javascript src="jquery-tmpl/jquery.tmpl.js"/>
    <asset:javascript src="app/productDetail.js"/>
    <script>
        var productId = "${product.id}"
        var attentionId = "${product.user.id}"
    </script>
</content>
</body>
</html>