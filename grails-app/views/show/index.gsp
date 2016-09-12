<!doctype html>
<html>
    <head>
        <asset:stylesheet src="swiper/css/swiper.min.css"/>
        <asset:stylesheet src="main.css"/>
        <meta name="layout" content="main"/>
        <title></title>
        %{--<link href="css/index.css"/>--}%
        %{--<link type="text/css" href="${resource(dir: 'css', file: 'index.css')}" />--}%
    </head>
    <body>

    <!-- Swiper -->
    <div class="banner-box">
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <div class="swiper-slide" style="background: url('${assetPath(src: 'pro/mtw.JPG')}')"></div>
                <div class="swiper-slide" style="background: url('${assetPath(src: 'pro/yeye.JPG')}')"></div>
                <div class="swiper-slide" style="background: url('${assetPath(src: 'pro/men.JPG')}')"></div>
                <div class="swiper-slide" style="background: url('${assetPath(src: 'pro/night.JPG')}')"></div>
            </div>
            <div class="swiper-pagination"></div>
            <div class="flip-opt swiper-button-prev"></div>
            <div class="flip-opt swiper-button-next"></div>
        </div>
    </div>

    <div class="container match-height-mask">
        <h3>图片</h3>
        <div class="row classify-pro" id="layer-images">
            <g:each var="r" in="${photoRecommends}">
                <div class="col-md-3 col-sm-6">
                    <div class="pro-box">
                        <g:link class="img-link" controller="show" action="photoDetail" id="${r.product.id}">
                            <img src="/show/showImg?img=${r.product.folder}/${r.product.coverImg}">
                        </g:link>
                        <h5><g:link controller="show" action="photoDetail" id="${r.product.id}">${r.product?.name}</g:link></h5>
                    </div>
                </div>
            </g:each>
        </div>

        <h3>视频</h3>
        <div class="row classify-pro classify-videos" id="layer-videos">
            <g:each var="r" in="${videoRecommends}">
                <div class="col-md-3 col-sm-6">
                    <div class="pro-box">
                        <g:link class="img-link" controller="show" action="videoDetail" id="${r.product.id}">
                            <div class="play-mask"></div>
                            <img src="/show/showImg?img=${r.product.folder}/${r.product.coverImg}">
                        </g:link>
                        <h5><g:link controller="show" action="videoDetail" id="${r.product.id}">${r.product?.name}</g:link></h5>
                    </div>
                </div>
            </g:each>
        </div>
    </div>
    <content tag="footer">
        <asset:javascript src="swiper/js/swiper.jquery.min.js"/>
        <asset:javascript src="jquery-match-height/jquery.matchHeight.js"/>
        <script>
            $(function() {
                $('.img-link').matchHeight({
                    property: 'min-height'
                })
                $.fn.matchHeight._afterUpdate = function(event, groups) {
                    $('.match-height-mask').css('opacity', 1)
                }
                var swiper = new Swiper('.swiper-container', {
                    pagination: '.swiper-pagination',
                    paginationClickable: true,
                    nextButton: '.swiper-button-next',
                    prevButton: '.swiper-button-prev'
                });
            })
        </script>
    </content>
    </body>
</html>
