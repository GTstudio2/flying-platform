package flying2

class Recommend {
    Date createDate = new Date()
    String modifiedLog
    int status = 1 //1为推荐|0为不再推荐
    int orderId
    String reason
    Product product
    static constraints = {
        product nullable: true
        reason nullable: true
        modifiedLog maxSize: 1000
    }
}
