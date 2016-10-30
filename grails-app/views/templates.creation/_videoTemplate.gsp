<%--
  Created by IntelliJ IDEA.
  flying2.User: nick
  Date: 2016/5/15
  Time: 16:29
--%>
<div>
    <div class="form-group">
        <label for="videoTitle">视频标题</label>
        <input type="text" class="form-control" name="name" id="videoTitle" placeholder="输入视频标题" required maxlength="19">
    </div>
    <div class="form-group">
        <label for="videoIntro">视频介绍</label>
        <textarea class="form-control" name="intro" id="videoIntro" placeholder="输入视频介绍" maxlength="255"></textarea>
    </div>
    <div class="form-group">
        <label for="videoUrl">视频地址 <small class="text-info">(视频地址请复制优酷视频播放页面，点开分享下拉，点击复制“通用代码”)</small> <button type="button" class="btn btn-success btn-xs previewVideo hide">预览</button></label>
        <input type="text" class="form-control videoUrl" name="url" id="videoUrl" placeholder="输入视频地址" required maxlength="255">
    </div>
</div>