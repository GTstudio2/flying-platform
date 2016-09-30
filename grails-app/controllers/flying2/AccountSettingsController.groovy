package flying2

import grails.converters.JSON

class AccountSettingsController {

    /**
     * 基本信息
     */
    def basicInfo() {
    }

    /**
     * 安全设置
     */
    def security() {}

    /**
     * 空间首页展示方式
     */
    def homeDisplayWay() {
        def u = User.get(session.user?.id)
        def products = Product.findAllByUser(u, [max: 10])
        [products: products, user: u]
    }

    def userHomeShow() {
        def u = User.get(session.user?.id)
        def userHomeShowList = UserHomeShow.findAllByUser(u)
        def show = userHomeShowList.collect{ show->
            return [product: show.product]
        }
        def products = []
        show.each {
            products << it.product
        }
        println products
//        JSON.use('deep'){
//            render product as JSON
//        }
//        JSON.registerObjectMarshaller(UserHomeShow){ return Product of product}
        render products as JSON
    }

    def updateUserHomeShow() {
        def user = User.get(session.user?.id)
        def m = [:]
        if(!user){
            m.status = "failed"
            m.msg = "noUser"
            render m as JSON
            return
        }
        def product = Product.get(params.pId)
        if (params.shown!="true") {
            def count = UserHomeShow.countByProduct(product)
            if (!count) {
                new UserHomeShow(product: product, user: user).save()
                product.homeShow = 1
                m.status = "success"
            }else{
                def show = UserHomeShow.findByProduct(product)
                show.delete()
                product.homeShow = 0
                m.status = "success"
            }
        }else{
            def show = UserHomeShow.findByProduct(product)
            if (show) {
                show.delete()
                product.homeShow = 0
                m.status = "success"
            }else{
                m.stauts = "failed"
                m.msg = "未找到作品！"
            }
        }
        render m as JSON
    }

    def allProducts() {
        def tableParams = JSON.parse(params.p)
        def createDateSort = "asc"
        if(tableParams.columns[3].orderable){
            createDateSort = tableParams.order[0].dir
        }
        def products = Product.findAllByStatus(1, [offset: tableParams.start, max: tableParams.length, sort: "createDate", order: createDateSort])
        def recordsTotal = Product.countByStatus(1)
        def m = [:]
        m.recordsTotal = recordsTotal
        m.recordsFiltered = recordsTotal
        m.data = products
        render m as JSON
    }
}
