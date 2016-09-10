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
        <label for="videoUrl">视频地址</label>
        <input type="text" class="form-control" name="url" id="videoUrl" placeholder="输入视频地址" required maxlength="255">
    </div>
</div>