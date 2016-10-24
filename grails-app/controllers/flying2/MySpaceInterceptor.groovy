package flying2


class MySpaceInterceptor {

    boolean before() {
//        if (!session.user) {
//            redirect(controller: 'account', action: 'login')
//            return false
//        }
        true
    }

    boolean after() {
        User u =  User.get(session.user.id)
        def attention = u.attentions.find{
            it.id == model.user.id
        }
        println attention
        if (attention) {
            model.isAttention = 'attention'
        }
        println model
        true
    }

    void afterView() {
        // no-op
    }
}
