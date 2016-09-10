package flying2

class Recommend {
    Date createDate = new Date()
    int status = 0 //0为待推荐 1为推荐
    int orderId
    String reason
    Product product
    static constraints = {
        product nullable: true
        reason nullable: true
    }
}
