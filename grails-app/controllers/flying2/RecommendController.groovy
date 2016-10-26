package flying2

import grails.converters.JSON

class RecommendController {

    def getRecommends() {
        params.max = 10
        def tableParams = JSON.parse(params.p)
        def type
        if (params.type == "photo" || params.type == "video") {
            type = params.type
        }else{
            type="all"
        }
        def sorts = []
        tableParams.columns.each { col ->
            sorts << col
        }
        def sort = tableParams.order[0].dir
        def orderIndex = tableParams.order[0].column
        ArrayList<Recommend> recommendTemp = Recommend.createCriteria().list([offset: tableParams.start, max: tableParams.length]){
            if(type!="all"){
                product{
                    eq("type", type)
                }
            }
            order(sorts[orderIndex].data, sort)
        }
        def m = [:]
        def recommends = recommendTemp.collect{ recommend->
            return [
                    id: recommend.id,
                    status: recommend.status,
                    createDate: recommend.createDate,
                    product: recommend.product,
                    reason: recommend.reason,
                    modifiedLog: JSON.parse(recommend.modifiedLog as String)
            ]
        }
//        println recommends
//        def products = Product.findAllByStatus(status ,[offset: tableParams.start, max: tableParams.length, sort: sorts[orderIndex].data, order: sort])
//        def recordsTotal = Product.countByStatus(status)
        def recordsTotal = Recommend.createCriteria().get{
            projections {
                count('id')
            }
            if(type!="all"){
                product{
                    eq("type", type)
                }
            }
        }
        m.recordsTotal = recordsTotal
        m.data = recommends
        m.recordsFiltered = recordsTotal
//        m.data = recommends
        render m as JSON
    }
}
