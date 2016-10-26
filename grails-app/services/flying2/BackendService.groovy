package flying2

import file.FileUtil
import flying2.Recommend
import grails.converters.JSON
import grails.transaction.Transactional
import img.ImageOperation
import net.minidev.json.JSONArray

@Transactional
class BackendService {

    def addToPreRecommend(params) {
        def p = Product.get(params.pid)
        int count = Recommend.findAll{
            product.type == p.type
        }.size()
        int status = 1
        if (count >= 8) status = 0
        def modifiedLog = new JSON([[status: 1,date: new Date()]])
        def recommend = new Recommend(product: p, reason: params.reason, orderId: count, status: status, modifiedLog: modifiedLog as String)
        if (!recommend.save()) {
            status = 2
        }
        status
    }
}
