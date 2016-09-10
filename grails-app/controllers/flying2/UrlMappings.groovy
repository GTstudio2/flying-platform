class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
        "/$type"(controller: "show", action: "productList")
        "/"(controller: "show", action:  "index")

        "/register"(controller: "account", action: "register")
//        "/registerNow"(controller: "account", action: "registerNow")
        "/login"(controller: "account", action: "login")

        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
