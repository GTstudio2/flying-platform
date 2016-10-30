var commentMaxCount = 300
$(function () {
    $('#attentionTo').click(function () {
        $.post(
            '/user/attentionTo',
            {attentionId: attentionId},
            function (d) {
                if(d.status=='success') {
                    if(d.action=='add'){
                        $('#attentionTo').addClass('active')
                    }else{
                        $('#attentionTo').removeClass('active')
                    }
                }else{
                    if(d.tip=='noUser') {
                        layer.msg('请先登录')
                    }
                }
            }
        )
    })
    $('#comment').simplyCountable({
        counter: '#releaseCounter',
        maxCount:commentMaxCount,
        strictMax: true
    })

    $('#release').click(function () {
        var comment = $('#comment').val()
        if(comment.length>0){
            $.post(
                '/comment/addComment',
                {productId: productId, comment: comment},
                function (d) {
                    if(d.status=='success'){
                        var content = [{
                            id: d.id,
                            username: $('#userName').text(),
                            userHeadUrl: $('#userHead').attr('src'),
                            comment: comment
                        }]
                        $('#commentTmpl').tmpl({comments: content}).prependTo('#commentList')
                        $('#comment').val('')
                        $('#releaseCounter').text(commentMaxCount)
                    }else{
                        alert(d.tips)
                    }
                }
            )
        }else{
            layer.msg('请输入评论')
        }
//                var $comments = $("#comments")
//                publishComment($("#commentBox"), $comments)
    })
    paginationComment()
})
function paginationComment() {
    $.get(
        '/comment/getComments',
        {productId: productId, pageNo: 1},
        function (d) {
            var content = []
            $.each(d.comments, function (i, item) {
                var comment = {
                    id: d.id,
                    userId: item.user.id,
                    username: $('#userName').text(),
                    userHeadUrl: $('#userHead').attr('src'),
                    comment: item.content
                }
                content.push(comment)
            })
            $('#commentList').html($('#commentTmpl').tmpl({comments: content}))

            var commentCount = d.totalComment
            var totalPages = commentCount % 10 == 0 ? commentCount / 10 : Math.ceil(commentCount / 10) ;
            if(!totalPages) totalPages = 1
            var options = {
                bootstrapMajorVersion: 3,
                currentPage:1,
                totalPages: totalPages,
                tooltipTitles: function() {
                    return ""
                },
                pageUrl: function(type, page, current){
                    return "javascript:void(0)";
                },
                itemTexts: function (type, page, current) {
                    switch (type) {
                        case "first":
                            return "首页";
                        case "prev":
                            return "上一页";
                        case "next":
                            return "下一页";
                        case "last":
                            return "末页";
                        case "page":
                            return page;
                    }
                },
                onPageClicked: function(e,originalEvent,type,page) {
                    getComments(page)
                }
            }

            $('#pagination').bootstrapPaginator(options)
        }
    )
}
function getComments(pageNo) {
    $.get(
        '/comment/getComments',
        {productId: productId, pageNo: pageNo},
        function (d) {
            var content = []
            $.each(d.comments, function (i, item) {
                var comment = {
                    id: d.id,
                    username: $('#userName').text(),
                    userHeadUrl: $('#userHead').attr('src'),
                    comment: item.content
                }
                content.push(comment)
            })
            $('#commentList').html($('#commentTmpl').tmpl({comments: content}))
        }
    )
}