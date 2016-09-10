package flying2


class ShowInterceptor {
    ShowInterceptor() {
        match(controllder: "show", action:"productList")
    }

    boolean before() {
        true
    }

    boolean after() {
        if (params.action=="productList") {
            String title = "图片作品"
            params.type!="photo"?title="视频作品":""
            model.title = title
        }
        true
    }

    void afterView() {
        // no-op
    }

}
