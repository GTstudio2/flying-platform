package flying2

import file.FileUtil
import flying2.Recommend
import grails.transaction.Transactional
import img.ImageOperation

@Transactional
class BackendService {

    def addToPreRecommend(params) {
        def p = Product.get(params.pid)
        int count = Recommend.findAll{
            product.type == p.type
        }.size()
        int status = 1
        if (count >= 8) status = 0
        new Recommend(product: p, reason: params.reason, orderId: count, status: status).save()
        status
    }
}
