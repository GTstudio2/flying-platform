<%--
  Created by IntelliJ IDEA.
  flying2.User: nick
  Date: 2016/5/15
  Time: 16:29
--%>
<div>
    <div class="form-group">
        <label for="photoTitle">图片名称</label>
        <input type="text" class="form-control" name="name" id="photoTitle" placeholder="输入图片名称" required maxlength="19">
    </div>
    <div class="form-group">
        <label for="videoIntro">图片介绍</label>
        <textarea class="form-control" name="intro" id="videoIntro" placeholder="输入视频介绍" maxlength="225"></textarea>
    </div>
    <hr>
    <h4>图片作品</h4>
    <div class="form-group">
        <div>
            <div id="uploader-images">
                <!--用来存放item-->
                <div class="img-box" id="thumb"></div>
                <div id="fileList" class="uploader-list"></div>
                <div id="filePicker">选择图片</div>
            </div>
        </div>
    </div>
</div>