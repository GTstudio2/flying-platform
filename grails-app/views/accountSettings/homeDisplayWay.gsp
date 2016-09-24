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
    %{--<asset:stylesheet src="jquery-ui-1.12.1/jquery-ui.css"/>--}%
    <title>主页展示方式</title>
    <style>
        #sortable,
        #sortable>div{
            border: 1px solid transparent;
        }
    </style>
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
            <p class="clearfix">
                <button class="btn btn-default btn-xs pull-right" data-toggle="tooltip" data-placement="left" title="自定义展示为用户可以对进行上传后的作品选择指定的位置进行展示">?</button>
            </p>
            <div class="row classify-pro classify-videos" id="sortable">
                <g:each var="product" in="${products}">
                    <div class="col-md-3 col-sm-6">
                        <div class="pro-box">
                            <span class="label label-${product.type=="photo"?"success":"danger"}">${product.type}</span>
                            <g:if test="${product.type=="photo"}">
                                <g:link class="img-link" controller="show" action="photoDetail" id="${product.id}" target="_blanck">
                                    <g:if test="${product.type=="video"}"><div class="play-mask"></div></g:if>
                                    <img src="/show/showImg?img=${product.folder}/${product.coverImg}">
                                </g:link>
                            </g:if>
                            <g:if test="${product.type=="video"}">
                                <g:link class="img-link" controller="show" action="videoDetail" id="${product.id}" target="_blanck">
                                    <div class="play-mask"></div>
                                    <img src="/show/showImg?img=${product.folder}/${product.coverImg}">
                                </g:link>
                            </g:if>
                            <h5><g:link controller="show" action="photoDetail" id="${product.id}">${product?.name}</g:link></h5>
                        </div>
                    </div>
                </g:each>
            </div>
        </div>
    </div>
    <content tag="footer">
        <asset:javascript src="jquery-match-height/jquery.matchHeight.js"/>
        <asset:javascript src="jquery-ui-1.12.1/jquery-ui.js"/>
        <script>
            $(function () {
                $('.img-link').matchHeight({
                    property: 'min-height'
                })
                $("[data-toggle='tooltip']").tooltip();
                buttonsInit()
                $( "#sortable" ).sortable({
//                    handle: ".pro-box",
                    activate: function( event, ui ) {
                        console.log('activate')
                    },
                    beforeStop: function( event, ui ) {
                        console.log('beforeStop')
                    }
                });
                $("#sortable2").sortable()
            })
            function buttonsInit(){
                $('.btn-group input[type="radio"]:checked').parent().addClass('active')
            }
        </script>
    </content>
</body>
</html>