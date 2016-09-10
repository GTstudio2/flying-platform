package flying2

class RecommendHistory {
    Date createDate
    Date delDate = new Date()
    int status = 0 //0为待推荐 1为推荐
    int orderId
    String reason
    String productName
    static constraints = {
        reason nullable: true
    }
}
