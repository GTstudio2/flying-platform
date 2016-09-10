<%--
  Created by IntelliJ IDEA.
  flying2.User: nick
  Date: 2016/5/15
  Time: 11:13
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="backendLayout"/>
    <asset:stylesheet src="layer/skin/layer.css"/>
    <asset:stylesheet src="main.css"/>
    <title>所有作品-</title>
</head>

<body>
    <div class="container margin-top">
        <div class="panel panel-default">
            <div class="panel-heading">所有作品<span class="pull-right"><label class="label label-success">photo</label> ${photoCount}个，<label class="label label-danger">video</label> ${videoCount}个</span></div>
            <table class="table table-stripe">
                <g:each var="p" in="${products}">
                    <tr>
                        <td width="20%"><label class="label label-${p.type=="photo"?"success":"danger"}">${p.type}</label> ${p?.name}</td>
                        <td>${p?.intro}</td>
                        <td>
                            <g:if test="${p.type="photo"}">

                            </g:if>
                            <g:elseif test="${p.type=="video"}">
                                ${p.video?.url}
                            </g:elseif>
                        </td>
                        <td width="20%" align="right">
                            <button class="btn btn-danger del" pid="${p.id}">删除</button>
                            <g:if test="${!recommends.find{it.productId==p.id}}">
                                <button class="btn btn-success addToRecommend" pid="${p.id}">加入首页推荐</button>
                            </g:if>

                        </td>
                    </tr>
                </g:each>
            </table>
        </div>
    </div>
    <input type="hidden" id="curPid">
    <div class="modal fade" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">推荐理由</h4>
                </div>
                <div class="modal-body">
                    <textarea class="form-control" id="reason" placeholder="请输入推荐原因"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary confirm" classify="recommend">确定</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <content tag="footer">
        <asset:javascript src="layer/layer.js"/>
        <script>
            $(function() {
                $("#myModal").on('shown.bs.modal', function () {
                    $("#reason").val("")
                })
                $(".confirm").click(function() {
                    var pid = $("#curPid").val()
                    var reason = $("#reason").val()
                    var classify = $(this).attr("classify")
                    if(classify=="recommend") {
                        $.post(
                            "addToPreRecommend",
                            {pid: pid, reason: reason},
                            function(d) {
                                if(d.status=="ok") {
                                    var str = ""
                                    if(d.recommendStatus==1) {
                                        str = "已加入推荐"
                                    }else{
                                        str = "已加入待推荐"
                                    }
                                    $("#myModal").modal("hide")
                                    layer.msg(str)
                                    $(".addToRecommend[pid='"+pid+"']")
                                            .text("已加入推荐")
                                            .prop("disabled", true)
                                }else{
                                    alert("错误")
                                }
                            }
                        );
                    }
                })
                $(".del").click(function() {
                    if(confirm("确定删除？")) {
                        var curDel = $(this)
                        var pid = $(this).attr("pid")
                        $.post(
                                "delProduct",
                                {pid: pid},
                                function(d) {
                                    if(d.status=="ok") {
                                        layer.msg("删除成功")
                                        curDel.parents("tr").remove()
                                    }else if(d.status=="recommend") {
                                        layer.alert("首页推荐中，请先删除推荐！")
                                    }else{
                                        layer.msg("删除失败")
                                    }
                                }
                        )
                    }
                })
                $(".addToRecommend").click(function() {
                    $("#curPid").val($(this).attr("pid"))
                    $("#myModal").modal()
                })
            })
        </script>
    </content>
</body>
</html>