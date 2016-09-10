<div class="panel panel-default">
    <div class="panel-heading">推荐内容<span class="pull-right"><label class="label label-success">photo</label> ${photoCount}个，<label class="label label-danger">video</label> ${videoCount}个</span></div>

    <table class="table table-striped" id="recommend">
        <tr>
            <th>名称</th>
            <th>推荐创建日期</th>
            <th width="30%">推荐理由</th>
            <th>状态</th>
            <th>排序</th>
            <th class="text-right">操作</th>
        </tr>
        <g:each var="r" in="${recommends}">
            <tr>
                <td><label class="label label-${r.product.type=="photo"?"success":"danger"}">${r.product.type}</label> ${r.product.name}</td>
                <td><g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${r.createDate}"/></td>
                <td>${r.reason}</td>
                <td>
                    <button class="productStatus btn btn-xs btn-${r.status==0?"danger":"success"}" rid="${r.id}">${r.status==0?"待推荐":"推荐中"}</button>
                </td>
                <td>${r.orderId}</td>
                <td class="text-right">
                    <button class="btn btn-danger del" rId="${r.id}">删除</button>
                </td>
            </tr>
        </g:each>

    </table>
</div>