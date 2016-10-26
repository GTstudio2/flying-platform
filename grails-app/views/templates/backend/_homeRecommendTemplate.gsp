%{--<div class="panel panel-default">--}%
    %{--<div class="panel-heading">推荐内容--}%
        %{--<span class="pull-right" id="classifyFilter">--}%
        %{--<button class="btn btn-default btn-xs" data-classify="all">全部</button>--}%
        %{--<button class="btn btn-default btn-xs active" data-classify="photo">photo ${photoCount}个</button>--}%
        %{--<button class="btn btn-default btn-xs" data-classify="video">video ${videoCount}个</button>--}%

    %{--</span>--}%

    %{--</div>--}%

    <ul class="nav nav-pills nav-sm" id="classifyFilter">
        <li><a href="#" data-toggle="tab" data-classify="all">全部</a></li>
        <li class="active"><a href="#" data-toggle="tab" data-classify="photo">photo ${photoCount}个</a></li>
        <li><a href="#" data-toggle="tab" data-classify="video">video ${videoCount}个</a></li>
    </ul>
    <table class="table table-bordered" id="recommendTable">
        <thead>
        <tr>
            <th>名称</th>
            <th>推荐创建日期</th>
            <th width="30%">推荐理由</th>
            <th width="30%">日志</th>
            %{--<th>状态</th>--}%
            %{--<th>排序</th>--}%
            %{--<th class="text-right">操作</th>--}%
        </tr>
        </thead>
        %{--<g:each var="r" in="${recommends}">--}%
            %{--<tr>--}%
                %{--<td><label class="label label-${r.product.type=="photo"?"success":"danger"}">${r.product.type}</label> ${r.product.name}</td>--}%
                %{--<td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${r.createDate}"/></td>--}%
                %{--<td>${r.reason}</td>--}%
                %{--<td>--}%
                    %{--<button class="productStatus btn btn-xs btn-${r.status==0?"danger":"success"}" rid="${r.id}">${r.status==0?"待推荐":"推荐中"}</button>--}%
                %{--</td>--}%
                %{--<td>${r.orderId}</td>--}%
                %{--<td class="text-right">--}%
                    %{--<button class="btn btn-danger btn-xs del" rId="${r.id}">删除</button>--}%
                %{--</td>--}%
            %{--</tr>--}%
        %{--</g:each>--}%

    </table>