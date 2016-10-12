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
    <asset:stylesheet src="webuploader-0.1.5/webuploader.css"/>
    <asset:stylesheet src="Jcrop/css/jquery.Jcrop.min.css"/>
    <asset:stylesheet src="main.css"/>
    <title>修改头像</title>
</head>

<body>
    <input type="hidden" id="folder" name="folder" value="${folder}">
    <div class="cover-img-box">
        <input type="hidden" name="coverImg"/>
        <asset:image class="cover-img" id="coverImg" src="pic/p1.jpg"/>
        <p class="uploadStatus"></p>

        <div class="cover-file-picker" id="coverFilePicker">选择封面图片</div>
    </div>

    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">裁剪图片</h4>
                </div>

                <div class="modal-body">
                    <div class="modalCrop">
                        <form id="cropParams" class="hidden">
                            <input type="hidden" size="4" id="x1" name="x1"/>
                            <input type="hidden" size="4" id="y1" name="y1"/>
                            <input type="hidden" size="4" id="x2" name="x2"/>
                            <input type="hidden" size="4" id="y2" name="y2"/>
                            <input type="hidden" size="4" id="w" name="w"/>
                            <input type="hidden" size="4" id="h" name="h"/>
                        </form>

                        <div id="cropCoverImg"></div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button id="crop" type="button" class="btn btn-success">确定</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
    <content tag="footer">
        <asset:javascript src="webuploader-0.1.5/webuploader.js"/>
        <asset:javascript src="Jcrop/js/jquery.Jcrop.min.js"/>
        <asset:javascript src="jquery-validate-1.13.1/jquery.validate.js"/>
        <asset:javascript src="app/changeHead.js"/>
    </content>
</body>
</html>