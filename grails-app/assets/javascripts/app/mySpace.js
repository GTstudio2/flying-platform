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
})