/*===========================
	DataTable Custom Function
==========================*/
var tableLanguage = {
	"emptyTable":     "",
    "info":           "显示第 _START_ 至 _END_ 项，共 _TOTAL_ 项",
    "infoEmpty":      "显示第 0 至 0 项结果，共 0 项",
    "infoFiltered":   "",//"(由 _MAX_ 项结果过滤)",
    "infoPostFix":    "",
    "thousands":      ",",
    "lengthMenu":     "每页显示 _MENU_ 条记录",
    "loadingRecords": "正在加载...",
    "processing":     "加载中...",
    "search":         "查 询：",
    "zeroRecords":    "没有匹配结果",
    "paginate": {
        "first":      "第一页",
        "last":       "最后一页",
        "next":       "下一页",
        "previous":   "上一页"
    },
    "aria": {
        "sortAscending":  ": activate to sort column ascending",
        "sortDescending": ": activate to sort column descending"
    }
};
 
$.extend(true, $.fn.dataTable.defaults, {
	"language" : tableLanguage		
});

$.fn.dataTableExt.oApi.fnSelectAllRow = function(oSetting , selected){
	var css = oSetting.oInit.sRowSelect_CssName;
	$(oSetting.aoData).each(function (){
		if (selected) {
			if (!$(this.nTr).hasClass(css)) $(this.nTr).addClass(css);
		} else {
			$(this.nTr).removeClass(css);
		}
		$(this.nTr.firstChild.firstChild).prop('checked',selected);		
	});		 	
};

$.fn.dataTableExt.oApi.fnSelecteRow = function(oSetting, iRow){
	var css = oSetting.oInit.sRowSelect_CssName;
	if (oSetting.aoData.length == 0) return;

	$(oSetting.aoData).each(function (i, e){
		if (i == iRow) {
			var b = $(this.nTr).hasClass(css);
			if (!b) {
				$(this.nTr).addClass(css);
				$(this.nTr.firstChild.firstChild).prop('checked',true);
			}
		}
	});		
};

$.fn.dataTableExt.oApi.fnGetAllSelected = function(oSetting){
	var aSelecteds = [];
	$(oSetting.aoData).each(function (){
		if ($(this.nTr).hasClass(oSetting.oInit.sRowSelect_CssName)) 
			aSelecteds.push($(this.nTr));
	});	
	return aSelecteds;	 	
};

$.fn.dataTableExt.oApi.fnGetAllSelectedData = function(oSetting){
	var aSelecteds = [];
	$(oSetting.aoData).each(function (){
		if ($(this.nTr).hasClass(oSetting.oInit.sRowSelect_CssName)) 
			aSelecteds.push(this._aData);
	});	
	return aSelecteds;	 	
};

$.fn.dataTableExt.oApi.fnGetSelected = function(oSetting){
	var aSelected = null;
	$(oSetting.aoData).each(function (){
		if ($(this.nTr).hasClass(oSetting.oInit.sRowSelect_CssName)) {
			aSelected = this.nTr;
			return false;
		}
	});	
	return aSelected;	 	
};

$.fn.dataTableExt.oApi.fnGetSelectedCount = function(oSetting){
	var cnt = 0;
	$(oSetting.aoData).each(function (){
		if ($(this.nTr).hasClass(oSetting.oInit.sRowSelect_CssName)) 
		cnt++;
	});	
	return cnt; 	
};

$.fn.dataTableExt.oApi.fnGetAllIds = function (oSetting){
	var ids = [];
	$(oSetting.aoData).each(function (){
		ids.push(this._aData.code);
	});	
	return ids;		
};

$.fn.dataTableExt.oApi.fnGetAllSelectedIds = function (oSetting){
	var ids = [];
	$(oSetting.aoData).each(function (){
		if ($(this.nTr).hasClass(oSetting.oInit.sRowSelect_CssName)){ 
			ids.push(this._aData.id);
		}
	});	
	return ids;		
};

$.fn.dataTableExt.oApi.fnGetRowByIndex = function(oSetting,iRow){
	return oSetting.aoData[iRow].nTr;
};

$.fn.dataTableExt.oApi.fnGetRowIndexById = function (oSetting,id){
	var idx = 0;
	$(oSetting.aoData).each(function (i){
		if (this._aData.id == id) {
			idx = i;
			return false;
		}
	});	
	return idx;	
};

$.fn.dataTableExt.oApi.fnGetRowIndexByName = function (oSetting,name){
	var idx = 0;
	$(oSetting.aoData).each(function (i){
		if (this._aData.name == name) {
			idx = i;
			return false;
		}
	});	
	return idx;	
};



