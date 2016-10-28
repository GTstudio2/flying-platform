package flying2

import grails.converters.JSON

class ManageProductsController {
    def allProducts() {
        int photoCount = Product.countByType("photo")
        int videoCount = Product.countByType("video")
        [photoCount: photoCount, videoCount: videoCount]
    }

    def getAllProducts() {
        params.max = 8
        def tableParams = JSON.parse(params.p)
        def createDateSort = "asc"
        def sorts = []
        tableParams.columns.each { col ->
            sorts << col
        }
        def sort = tableParams.order[0].dir
        def orderIndex = tableParams.order[0].column
        User user = User.get(session.user.id)
        final REMOVE_STATUS = 7
        def products = Product.findAllByUserAndStatusNotEqual(user, REMOVE_STATUS, [offset: tableParams.start, max: tableParams.length, sort: sorts[orderIndex].data, order: sort])
//        def products = Product.list([offset: tableParams.start, max: tableParams.length, sort: sorts[orderIndex].data, order: sort])
        def recordsTotal = Product.countByUserAndStatusNotEqual(user, REMOVE_STATUS)
        def m = [:]
        m.recordsTotal = recordsTotal
        m.recordsFiltered = recordsTotal
        m.data = products
        render m as JSON
    }

    def delProduct() {
//        session.user.id
        def product = Product.findByUserAndId(User.get(session.user.id), params.pId)
        def m = [:]
        if (product) {
            product.status = 7
            product.removeDate = new Date()
            if (product.save()) {
                m.status = 'success'
            } else {
                m.status = 'failed'
                m.tip = '删除失败'
            }
        }else{
            m.status = 'failed'
            m.tip = '未找到产品'
        }
        render m as JSON
    }

    def appealNow() {
        Product product = Product.get(params.pId)
        product.status = 5
        def m = [:]
        if (product.save()) {
            def audit = new Audit(product: product, reason: params.reason, status: 5)
            if (audit.save()) {
                m.status = 'success'
            }else{
                m.status = 'failed'
                m.tip = '审核未保存'
            }
        }else{
            m.status = 'failed'
            m.tip = '未找到作品'
        }
        render m as JSON
    }
}
