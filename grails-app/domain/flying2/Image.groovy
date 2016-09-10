package flying2
class Image {
    String img
    int largeWidth
    int largeHeight
    static belongsTo = [photo: Photo]

    static constraints = {
    }
}
