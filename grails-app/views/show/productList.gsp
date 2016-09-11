<%--
  Created by IntelliJ IDEA.
  flying2.User: nick
  Date: 2016/5/15
  Time: 10:13
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <asset:stylesheet src="main.css"/>
    <meta name="layout" content="main"/>
    <title>${title}-</title>
</head>

<body>
<div class="container">
    <div class="row margin-top classify-pro${params.type=="video"?" classify-videos":""}" id="layer-images">
        <g:if test="${params.type=="photo"}">
            <g:each var="p" in="${products}">
                <div class="col-md-3 col-sm-6">
                    <div class="pro-box">
                        <g:link class="img-link" controller="show" action="photoDetail" id="${p.id}">
                            <img src="/show/showImg?img=${p.folder}/${p.coverImg}">
                        </g:link>
                        <h5><g:link controller="show" action="photoDetail" id="${p.id}">${p?.name}</g:link></h5>
                    </div>
                </div>
            </g:each>
        </g:if>
        <g:elseif test="${params.type=="video"}">
            <g:each var="p" in="${products}">
                <div class="col-md-3 col-sm-6">
                    <div class="pro-box">
                        <g:link class="img-link" controller="show" action="videoDetail" id="${p.id}">
                            <div class="play-mask"></div>
                            <img src="/show/showImg?img=${p.folder}/${p.coverImg}">
                        </g:link>
                        <h5><g:link controller="show" action="videoDetail" id="${p.id}">${p?.name}</g:link></h5>
                    </div>
                </div>
            </g:each>
        </g:elseif>
        %{--<div class="col-md-3 col-sm-6">--}%
            %{--<div class="pro-box">--}%
                %{--<a href="javascript:void(0)"><img src="/images/pic/p2.jpg"></a>--}%
                %{--<h5>德阳东风电机场</h5>--}%
            %{--</div>--}%
        %{--</div>--}%
        %{--<div class="col-md-3 col-sm-6">--}%

            %{--<div class="pro-box">--}%
                %{--<a href="javascript:void(0)"><img src="/images/pic/p3.jpg"></a>--}%
                %{--<h5>德阳东风电机场</h5>--}%
            %{--</div>--}%
        %{--</div>--}%
        %{--<div class="col-md-3 col-sm-6">--}%
            %{--<div class="pro-box">--}%
                %{--<a href="javascript:void(0)"><img src="/images/pic/p4.jpg"></a>--}%
                %{--<h5>德阳东风电机场</h5>--}%
            %{--</div>--}%
        %{--</div>--}%
        %{--<div class="col-md-3 col-sm-6">--}%
            %{--<div class="pro-box">--}%
                %{--<a href="javascript:void(0)"><img src="/images/pic/p5.jpg"></a>--}%
                %{--<h5>德阳东风电机场</h5>--}%
            %{--</div>--}%
        %{--</div>--}%
        %{--<div class="col-md-3 col-sm-6">--}%
            %{--<div class="pro-box">--}%
                %{--<a href="javascript:void(0)"><img src="/images/pic/p6.jpg"></a>--}%
                %{--<h5>德阳东风电机场</h5>--}%
            %{--</div>--}%
        %{--</div>--}%
        %{--<div class="col-md-3 col-sm-6">--}%
            %{--<div class="pro-box">--}%
                %{--<a href="javascript:void(0)"><img src="/images/pic/p7.jpg"></a>--}%
                %{--<h5>德阳东风电机场</h5>--}%
            %{--</div>--}%
        %{--</div>--}%
        %{--<div class="col-md-3 col-sm-6">--}%
            %{--<div class="pro-box">--}%
                %{--<a href="javascript:void(0)"><img src="/images/pic/p8.jpg"></a>--}%
                %{--<h5>德阳东风电机场</h5>--}%
            %{--</div>--}%
        %{--</div>--}%
    </div>
    <div class="pagination">
        <g:paginate controller="show" action="productList" params="[type: 'photo']" total="${productsCount}"/>
    </div>

    <content tag="footer">
        <asset:javascript src="jquery-match-height/jquery.matchHeight.js"/>
        <script>
            $(function () {
                $('.img-link').matchHeight({
                    property: 'min-height'
                })
            })
        </script>
    </content>
</div>
</body>
</html>