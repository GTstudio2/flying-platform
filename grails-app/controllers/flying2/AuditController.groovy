package flying2

import grails.converters.JSON

class AuditController {

    def auditNow() {
        Product product = Product.get(params.pId)
        BackUser backUser = BackUser.get(session.backUser.id)
//        println 'backUser is'+backUser
        def m = [:]
        if (product) {
            if(params.agreement=='0'){
                params.agreement = 3
            }
//            println "params.agreement is:"+params.agreement
            product.status = params.agreement as Integer
            if (product.save()) {
                def audit = new Audit(auditUser: backUser, product: product, reason: params.reason, status: params.agreement)
                if (audit.save()) {
                    m.status = 'success'
                }else{
                    m.status = 'failed'
                    m.tip = '审核未保存'
                }
            }else{
                m.status = 'failed'
                m.tip = '作品未保存'
            }
        }else{
            m.status = 'failed'
            m.tip = '未找到作品'
        }
        render m as JSON
    }
}
