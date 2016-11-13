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
        User u =  User.get(session?.user?.id)
        if (u) {
            def attention = u.attentions.find{
                it.id == model.user.id
            }
            if (attention) {
                model.isAttention = 'attention'
            }
        }
        true
    }

    void afterView() {
        // no-op
    }
}
