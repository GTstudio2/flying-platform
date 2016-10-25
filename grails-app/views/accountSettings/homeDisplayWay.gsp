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
    <asset:stylesheet src="jquery-dataTables/dataTables.bootstrap.css"/>
    %{--<asset:stylesheet src="jquery-dataTables/responsive.bootstrap.css"/>--}%
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
%{--<div id="tmplContent">2</div>--}%

    <div class="btn-group" data-toggle="buttons">
        <label class="btn btn-success" data-toggle="tab" href="#tab1">
            <input type="radio" name="options" id="option1" checked> 时间展示
        </label>
        %{--<label class="btn btn-success" data-toggle="tab" href="#tab2">--}%
            %{--<input type="radio" name="options" id="option2"> 自定义展示--}%
        %{--</label>--}%
    </div>
    <div class="tab-content margin-top">
        <div class="tab-pane active" id="tab1">
            个人主页展示已设置为时间展示，展示作品以时间从最近到以前的顺序排列
        </div>
        <div class="tab-pane" id="tab2">
            <p class="clearfix">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">选择作品</button>
                <button class="btn btn-default btn-xs pull-right" data-toggle="tooltip" data-placement="left" title="自定义展示为用户可以对进行上传后的作品选择指定的位置进行展示">?</button>
            </p>
            <div class="row classify-pro classify-videos" id="sortable">
                %{--<g:each var="product" in="${products}">--}%
                    %{--<div class="col-md-3 col-sm-6">--}%
                        %{--<div class="pro-box">--}%
                            %{--<span class="label label-${product.type=="photo"?"success":"danger"}">${product.type}</span>--}%
                            %{--<g:if test="${product.type=="photo"}">--}%
                                %{--<g:link class="img-link" controller="show" action="photoDetail" id="${product.id}" target="_blanck">--}%
                                    %{--<g:if test="${product.type=="video"}"><div class="play-mask"></div></g:if>--}%
                                    %{--<img src="/show/showImg?img=${product.folder}/${product.coverImg}">--}%
                                %{--</g:link>--}%
                            %{--</g:if>--}%
                            %{--<g:if test="${product.type=="video"}">--}%
                                %{--<g:link class="img-link" controller="show" action="videoDetail" id="${product.id}" target="_blanck">--}%
                                    %{--<div class="play-mask"></div>--}%
                                    %{--<img src="/show/showImg?img=${product.folder}/${product.coverImg}">--}%
                                %{--</g:link>--}%
                            %{--</g:if>--}%
                            %{--<h5><g:link controller="show" action="photoDetail" id="${product.id}">${product?.name}</g:link></h5>--}%
                        %{--</div>--}%
                    %{--</div>--}%
                %{--</g:each>--}%
            </div>
        </div>
    </div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" id="myModalLabel">选择作品</h4>
                </div>
                <div class="modal-body">
                    <h4>已选择<span class="text-success" id="selectedShow"></span></h4>
                        %{--<div class="table-responsive">--}%
                            <table class="table table-bordered" id="allProductsTable">
                                <thead>
                                <tr>
                                    %{--<th></th>--}%
                                    <th width="120">名称</th>
                                    <th>描述</th>
                                    <th width="80">发布时间</th>
                                    <th width="100">操作</th>
                                </tr>
                                </thead>
                            </table>
                        %{--</div>--}%
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <script id="firstTmpl" type="text/x-jquery-tmpl">
        %{--<%='${products}'%>--}%
        {%each(i,product) products%}
            <div class="col-md-3 col-sm-6">
                <div class="pro-box">
                    {%if product.type=='photo'%}
                        <span class="label label-success">photo</span>
                    {%else%}
                        <span class="label label-danger">video</span>
                    {%/if%}
                    {%if product.type=='photo'%}
                        <a href="/show/photoDetail/12" class="img-link" target="_blanck">
                            <img src="/show/showImg?img=<%='${product.folder}'%>/<%='${product.coverImg}'%>">
                        </a>
                        <h5><a href="/show/photoDetail/12"><%='${product.name}'%></a></h5>
                    {%elseif product.type=='video'%}
                        <a href="/show/photoDetail/12" class="img-link" target="_blanck">
                            <div class="play-mask"></div>
                            <img src="/show/showImg?img=<%='${product.folder}'%>/<%='${product.coverImg}'%>">
                        </a>
                        <h5><a href="/show/photoDetail/12"><%='${product.name}'%></a></h5>
                    {%/if%}
                </div>
            </div>
        {%/each%}
    </script>
    <content tag="footer">
        <asset:javascript src="jquery-match-height/jquery.matchHeight.js"/>
        <asset:javascript src="jquery-ui-1.12.1/jquery-ui.js"/>
        <asset:javascript src="jquery-dataTables/jquery.dataTables.min.js"/>
        <asset:javascript src="jquery-dataTables/dataTables.bootstrap.js"/>
        %{--<asset:javascript src="jquery-dataTables/dataTables.responsive.js"/>--}%
        <asset:javascript src="layer/layer.js"/>
        <asset:javascript src="jquery-tmpl/jquery.tmpl.js"/>
        <script>
            var allProductsTable
            var shownItem = 0
//            var selectedShow = {},
//                    selectedShowSize = 0
            $(function () {
//                console.log($('#firstTmpl').tmpl(movie).appendTo('#tmplContent'))
//                $('#tmplContent').html($('#firstTmpl').tmpl({title: 'biggg'}))

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
//                $('#myModal').modal()
                userHomeShow()
//                $.ajax({
//                    url: '/accountSettings/allProducts',
//                    dataType: 'json',
//                    success: function (d) {
//                        console.log(d)
//                    }
//                })
                $('#myModal').on('shown.bs.modal', function () {
                    if(!allProductsTable) {
                        modalInit()
                    }
                }).on('hide.bs.modal', function () {
                    userHomeShow()
                })
                $('#allProductsTable').delegate('.btnAdd', 'click', function () {
                    var $btnAdd = $(this)
                    var shown = false
                    if($btnAdd.hasClass('shown')){
                        shown = true
                    }
                    if(!shown&&shownItem>=20){
                        layer.msg('做多展示20个作品')
                        return
                    }
                    var pId = $btnAdd.parents('tr').find('.pId').val()
                    $.post(
                            '/accountSettings/updateUserHomeShow',
                            {pId: pId, shown: shown},
                            function (d) {
                                if(d.status=='success') {
                                    console.log(shown)
                                    if(shown) {
                                        $btnAdd.removeClass('shown')
                                                .addClass('btn-default')
                                                .removeClass('btn-success')
                                                .text('展示')
                                        shownItem--
                                    }else{
                                        $btnAdd.addClass('shown')
                                                .addClass('btn-success')
                                                .removeClass('btn-default')
                                                .text('展示中')
                                        shownItem++
                                    }
                                }else{
                                    alert(d.msg)
                                }
                            }
                    )
                })
            })
            function userHomeShow() {
                $.ajax({
                    url: '/accountSettings/userHomeShow',
                    dataType: 'json',
                    success: function (d) {
//                        $.each(d, function (i, v) {
//                            console.log(v.name)
//                        })
                        $('#sortable').html($('#firstTmpl').tmpl({products: d}))
                        shownItem = $('#sortable .pro-box').length
                    }
                })
            }
            function modalInit() {
                allProductsTable = $('#allProductsTable').DataTable({
                    responsive: true,
                    info: false,
                    "lengthChange": false,
                    "searching": false,
                    "order": [[ 3, 'desc' ]],
//                    "paging": true,
//                    "pageLength": 10,
                    "processing": true,
                    "serverSide": true,
                    "ajax": {
                        "url": "/accountSettings/allProducts",
                        "type": "POST",
                        "data": function ( d ) {
                            var p = {p: JSON.stringify(d)}
                            return p
                        }
                    },
                    language: {
                        paginate: {
                            previous: "上一页",
                            next: "下一页",
                            first: "第一页",
                            last: "最后"
                        }
                    },
                    "columns": [
//                        {
//                            "data": null,
//                            "orderable": false,
//                            className: "row-select",
//                            "render": function ( data, type, full, meta ) {
//                                var str =
////                                        '<input type="checkbox">' +
//                                        '<input class="pId" type="hidden" value="'+data.id+'">'
//                                return str
//                            }
//                        },
                        {
                            "orderable": false,
                            "data": null,
                            "render": function ( data, type, full, meta ) {
                                var str = '<input class="pId" type="hidden" value="'+data.id+'">'
                                if(data.type=='photo'){
                                    str += '<span class="label label-success">photo</span> ' + data.name
                                }else if(data.type=='video'){
                                    str += '<span class="label label-danger">video</span> ' + data.name
                                }
                                return str
                            }
                        },
                        {
                            "orderable": false,
                            "data": "intro"
                        },
                        {
                            "data": "createDate",
                            "render": function (data, type, full, meta) {
                                var date = new Date(data)
                                return date.getFullYear()+'-'+date.getMonth()+'-'+date.getDate()
                            }
                        },
                        {
                            "data": null,
                            "orderable": false,
                            "render": function (data, type, full, meta) {
                                var str = ''
                                var isHomeShow = '',
                                        showText = ''
                                if(data.homeShow){
                                    isHomeShow = 'btn-success shown'
                                    showText = '展示中'
                                }else{
                                    isHomeShow = 'btn-default'
                                    showText = '展示'
                                }
                                str +=
                                        '<button type="button" class="btn btn-xs btnAdd '+isHomeShow+'">'+showText+'</button>'
                                return str
                            }
                        }
                    ]
                })
//                        .on( 'click', '.row-select', function () {
//                        var $curRow = $(this).parent('tr')
//                        var pId = $curRow.find('.pId').val()
//                        if ($curRow.hasClass('selected') ) {
//                            $curRow.removeClass('selected');
//                            $curRow.find('input:checkbox').prop('checked', false)
//                            delete selectedShow['pId'+pId]
//                            selectedShowSize--
//                        }else {
//                            if(selectedShowSize!=20){
//                                $curRow.addClass('selected');
//                                $curRow.find('input:checkbox').prop('checked', true)
//                                selectedShow['pId'+pId] = pId
//                                selectedShowSize++
//                            }else{
//                                layer.msg('首页最多展示20个')
//                            }
//                        }
//                        $('#selectedShow').text(selectedShow.length)
//                        $('#selectedShow').text(selectedShowSize)
//                });

//                allProductsTable.on( 'draw', function ( e, settings, json ) {
////                    console.log( 'Ajax event occurred. Returned data: ', json );
////                    $.each(selectedShow, function (k, pId) {
////                        var $curRow = $('#allProductsTable').find('.pId[value="'+pId+'"]').parents('tr')
////                        $curRow.find('input:checkbox').prop('checked', true)
////                        $curRow.addClass('selected')
////                    })
//                } );
            }
            function buttonsInit(){
                $('.btn-group input[type="radio"]:checked').parent().addClass('active')
            }
        </script>
    </content>
</body>
</html>