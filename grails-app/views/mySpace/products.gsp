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
    <title>我的空间</title>
</head>

<body>
<div class="container match-height-mask">
    <div class="panel panel-default">
        <div class="panel-heading">作品<span class="text-danger">(${productCount}个)</span></div>

        <div class="panel-body">
            <div class="row classify-pro classify-videos">
                <g:each var="product" in="${products}">
                    <div class="col-md-3 col-sm-6">
                        <div class="pro-box">
                            <span class="label label-${product.type=="photo"?"success":"danger"}">${product.type}</span>
                            <g:if test="${product.type=="photo"}">
                                <g:link class="img-link" controller="show" action="photoDetail" id="${product.id}">
                                    <g:if test="${product.type=="video"}"><div class="play-mask"></div></g:if>
                                    <img src="/show/showImg?img=${product.folder}/${product.coverImg}">
                                </g:link>
                            </g:if>
                            <g:if test="${product.type=="video"}">
                                <g:link class="img-link" controller="show" action="videoDetail" id="${product.id}">
                                    <div class="play-mask"></div>
                                    <img src="/show/showImg?img=${product.folder}/${product.coverImg}">
                                </g:link>
                            </g:if>
                            <h5><g:link controller="show" action="photoDetail" id="${product.id}">${product?.name}</g:link></h5>
                        </div>
                    </div>
                </g:each>
            </div>
            %{--<table class="table">--}%
                %{--<tr>--}%
                    %{--<th>中文名称</th>--}%
                    %{--<th>英语名称</th>--}%
                    %{--<th>创建日期</th>--}%
                    %{--<th>作品图片数</th>--}%
                    %{--<th>状态</th>--}%
                    %{--<th>操作</th>--}%
                %{--</tr>--}%
                %{--<g:each var="product" in="${products}">--}%
                    %{--<tr>--}%
                        %{--<td width="20%">--}%
                            %{--<g:link controller="show" action="detail" id="${product.id}"--}%
                                    %{--params="[classify: product.type]" target="_blank">--}%
                                %{--<g:each var="intro" in="${product.intro}">--}%
                                    %{--<g:if test="${intro.lang == 'zh_CN'}">--}%
                                        %{--${intro.name}--}%
                                    %{--</g:if>--}%
                                %{--</g:each>--}%
                            %{--</g:link>--}%
                        %{--</td>--}%
                        %{--<td width="20%">--}%
                            %{--<g:link controller="show" action="detail" params="[id: product.id, classify: product.type]"--}%
                                    %{--target="_blank">--}%
                                %{--<g:each var="intro" in="${product.intro}">--}%
                                    %{--<g:if test="${intro.lang == 'en'}">--}%
                                        %{--${intro.name}--}%
                                    %{--</g:if>--}%
                                %{--</g:each>--}%
                            %{--</g:link>--}%
                        %{--</td>--}%
                        %{--<td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${product.createDate}"/></td>--}%
                        %{--<td>${product.photo?.images?.size()}</td>--}%
                        %{--<td><button class="btn btn-${product.status == 0 ? "danger" : "success"} btn-xs optBtn"--}%
                                    %{--pId="${product.id}" optType="status">${product.status == 0 ? "待发布" : "已发布"}</button>--}%
                        %{--</td>--}%
                        %{--<td>--}%
                        %{--<button class="btn btn-danger optBtn" pId="${product.id}" optType="del">删除</button>--}%
                        %{--</td>--}%
                    %{--</tr>--}%
                %{--</g:each>--}%
            %{--</table>--}%
        </div>
    </div>

    <div class="pagination">
        <g:paginate controller="mySpace" action="products" params="${params}" total="${productCount}"/>
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