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
        if(tableParams.columns[2].orderable){
            createDateSort = tableParams.order[0].dir
        }
        def products = Product.list([offset: tableParams.start, max: tableParams.length, sort: "createDate", order: createDateSort])
        def recordsTotal = Product.count()
        def m = [:]
        m.recordsTotal = recordsTotal
        m.recordsFiltered = recordsTotal
        m.data = products
        render m as JSON
    }

    def delProduct() {
//        session.user.id
        def product = Product.findByUserAndId(User.get(session.user.id), params.pId)
        if (product) {
            product.delete()
            render 'success'
        }else{
            render 'failed'
        }
    }
}
