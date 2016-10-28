<%--
  Created by IntelliJ IDEA.
  flying2.User: nick
  Date: 2016/5/15
  Time: 16:29
--%>
<div>
    <div class="form-group">
        <label for="photoTitle">图片名称</label>
        <input type="text" class="form-control" name="name" id="photoTitle" value="${product.name}" placeholder="输入图片名称" required maxlength="19">
    </div>
    <div class="form-group">
        <label for="videoIntro">图片介绍</label>
        <textarea class="form-control" name="intro" id="videoIntro" placeholder="输入图片介绍" maxlength="225">${product.intro}</textarea>
    </div>
    <hr>
    <h4>图片作品</h4>
    <div class="form-group">
        <div>
            <div id="uploader-images">
                <!--用来存放item-->
                <div class="img-box" id="imgBox">
                    <g:each var="img" in="${product.photo.images}" status="i">
                        <div class="file-item thumbnail upload-state-done">
                            <div class="opt-box">
                                <button type="button" class="btn btn-danger btn-xs btn-remove"><span class="glyphicon glyphicon-remove"></span></button>
                            </div>
                            <input type="hidden" name="stepImg" value="${img.img}" >
                            <img src="/show/showImg?img=${product.folder+"/medium_"+img.img}"/>
                            <div class="info">${img.img}</div>
                        </div>
                    </g:each>
                </div>
                <div id="fileList" class="uploader-list"></div>
                <div id="filePicker">选择图片</div>
            </div>
        </div>
    </div>
</div>