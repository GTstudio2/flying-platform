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
    <title>${videoProduct.name}</title>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="col-md-offset-2 col-md-8">

            <h3>${videoProduct.name}</h3>
            <div class="video-content">
                <embed src="${videoProduct.video.url}" allowFullScreen="true" quality="high" width="700" height="500" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash"></embed>
            </div>
            <div>
                <h4>推荐</h4>
                <div class="row classify-pro classify-videos">
                    <div class="col-md-3 pro-box">
                        <a href="javascript:void(0)"><div class="play-mask"></div><img layer-src="../images/pro/80179ea4-8e75-421d-90fd-2cc9620b62e5.jpg" src="../images/pic/p1.jpg"></a>
                        <h5>河口日出</h5>
                    </div>
                    <div class="col-md-3 pro-box">
                        <a href="javascript:void(0)"><div class="play-mask"></div><img layer-src="../images/pic/539837a6-702c-46ea-b1d2-644baaf5ef01.jpg" src="../images/pic/p2.jpg"></a>
                        <h5>德阳东风电机场</h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<content tag="footer">
    <asset:javascript src="photoSwiper/photoswipe.min.js"/>
    <asset:javascript src="photoSwiper/photoswipe-ui-default.min.js"/>
</content>
</body>
</html>