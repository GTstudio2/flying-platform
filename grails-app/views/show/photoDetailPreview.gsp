<%--
  Created by IntelliJ IDEA.
  flying2.User: nick
  Date: 2016/5/14
  Time: 16:23
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <asset:stylesheet src="photoSwiper/photoswipe.css"/>
    <asset:stylesheet src="photoSwiper/default-skin/default-skin.css"/>
    <asset:stylesheet src="main.css"/>
    %{--<asset:stylesheet src="app/detail.css"/>--}%
    <meta name="layout" content="main"/>
    <title>${product.name}</title>
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-md-offset-2 col-md-8">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="pull-right" title="浏览${product.viewer}次"><span class="glyphicon glyphicon-eye-open"></span> ${product.viewer}</div>
                        <h3 class="title">${product.name}</h3>
                        <p>${product.intro}</p>
                        <div class="img-content" id="imgContent">
                            <div class="my-gallery" itemscope>
                                <g:each var="img" in="${product.photo.images}">
                                    <figure itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
                                        <a href="/show/showImg?img=${product.folder+"/large_"+img.img}" data-size="${img.largeWidth+"x"+img.largeHeight}" itemprop="contentUrl">
                                            <img src="/show/showImg?img=${product.folder+"/medium_"+img.img}" itemprop="thumbnail" alt="Image description" />
                                        </a>
                                    </figure>
                                </g:each>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="interactive-panel margin-bottom">
                    <div class="interactive-body">
                        <g:link controller="mySpace" action="home" id="${product.user.id}">
                            <g:if test="${product.user.headImg}">
                                <img class="middle-thumb"
                                     src="/show/headImg?img=${product.user.folder}/${product.user.headImg}"/>
                            </g:if>
                            <g:else>
                                <asset:image class="middle-thumb" id="userHead" src="header.jpg"/>
                            </g:else>
                        </g:link>
                        <h4 class="brief-text">${product.user.username}</h4>
                            <button class="attention-btn opt-btn">
                                <span class="not-attention"><span class="glyphicon glyphicon-plus"></span> <span class="text">关注</span></span>
                                <span class="attention"><span class="glyphicon glyphicon-ok"></span> <span class="text">已关注</span></span>
                            </button>
                    </div>
                </div>

                <div class="panel panel-default margin-top">
                    <div class="panel-body">
                        <div class="media">
                            <div class="media-left">
                                <g:if test="${user?.headImg}">
                                    <g:link controller="mySpace" action="home" id="${user.id}">
                                        <img class="middle-thumb" id="userHead" src="/show/headImg?img=${user.folder}/${user.headImg}"/>
                                    </g:link>
                                </g:if>
                                <g:else>
                                    <a href="javascript:void(0)">
                                        <asset:image class="middle-thumb" id="userHead" src="header.jpg"/>
                                    </a>
                                </g:else>
                            </div>
                            <div class="media-body">
                                <span class="comment-limit">可输入<span id="releaseCounter"></span>个字符</span>
                                <h4 class="media-heading" id="userName">${user?.username}</h4>
                                <textarea class="form-control comment-area" name="comment" id="comment" rows="3" placeholder="发表评论" maxlength="300"></textarea>
                                <div class="row margin-top5">
                                    <div class="col-md-offset-10 col-md-2">
                                        <button class="btn btn-primary btn-sm btn-block" id="release">发布</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="comment-list" id="commentList">

                            %{--<div class="media">--}%
                                %{--<div class="media-left">--}%
                                    %{--<a href="#">--}%
                                        %{--<asset:image class="middle-thumb" src="header.jpg"/>--}%
                                    %{--</a>--}%
                                %{--</div>--}%
                                %{--<div class="media-body">--}%
                                    %{--<a class="pull-right" href="#">回复</a>--}%
                                    %{--<h4 class="media-heading">nick</h4>--}%
                                    %{--fasdfasdfsdf--}%
                                %{--</div>--}%
                            %{--</div>--}%
                        </div>
                        <nav class="text-center">
                            <ul class="pagination" id="pagination"></ul>
                        </nav>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Root element of PhotoSwipe. Must have class pswp. -->
    <div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">
    <!-- Background of PhotoSwipe.
         It's a separate element as animating opacity is faster than rgba(). -->
    <div class="pswp__bg"></div>
    <!-- Slides wrapper with overflow:hidden. -->
    <div class="pswp__scroll-wrap">
        <!-- Container that holds slides.
            PhotoSwipe keeps only 3 of them in the DOM to save memory.
            Don't modify these 3 pswp__item elements, data is added later on. -->
        <div class="pswp__container">
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
        </div>
        <!-- Default (PhotoSwipeUI_Default) interface on top of sliding area. Can be changed. -->
        <div class="pswp__ui pswp__ui--hidden">
            <div class="pswp__top-bar">
                <!--  Controls are self-explanatory. Order can be changed. -->
                <div class="pswp__counter"></div>
                <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>
                <!--<button class="pswp__button pswp__button--share" title="Share"></button>-->
                <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>
                <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>
                <!-- Preloader demo http://codepen.io/dimsemenov/pen/yyBWoR -->
                <!-- element will get class pswp__preloader--active when preloader is running -->
                <div class="pswp__preloader">
                    <div class="pswp__preloader__icn">
                        <div class="pswp__preloader__cut">
                            <div class="pswp__preloader__donut"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                <div class="pswp__share-tooltip"></div>
            </div>
            <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)"></button>
            <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)"></button>
            <div class="pswp__caption">
                <div class="pswp__caption__center"></div>
            </div>
        </div>

    </div>
</div>
<content tag="footer">
    <asset:javascript src="photoSwiper/photoswipe.min.js"/>
    <asset:javascript src="photoSwiper/photoswipe-ui-default.min.js"/>
    <asset:javascript src="bootstrap-paginator/bootstrap-paginator.min.js"/>
    <asset:javascript src="jquery-simply-countable/jquery.simplyCountable.js"/>
    <asset:javascript src="layer/layer.js"/>
    <asset:javascript src="jquery-tmpl/jquery.tmpl.js"/>
    <asset:javascript src="main.js"/>
    <script>
    var productId = "${product.id}"
    var attentionId = "${product.user.id}"
    var commentMaxCount = 300
        $(function () {
            var initPhotoSwipeFromDOM = function(gallerySelector) {
                // parse slide data (url, title, size ...) from DOM elements
                // (children of gallerySelector)
                var parseThumbnailElements = function(el) {
                    var thumbElements = el.childNodes,
                            numNodes = thumbElements.length,
                            items = [],
                            figureEl,
                            linkEl,
                            size,
                            item;
                    for(var i = 0; i < numNodes; i++) {
                        figureEl = thumbElements[i]; // <figure> element
                        // include only element nodes
                        if(figureEl.nodeType !== 1) {
                            continue;
                        }
                        linkEl = figureEl.children[0]; // <a> element
                    size = linkEl.getAttribute('data-size').split('x');
                        // create slide object
//                        var img = new Image();
//                        img.src = $(linkEl).find("img").attr("src")
//                        var curWidth = img.width
//                        var curHeight = img.height
//                        var curWidth = 1920
//                        var curHeight = 1080
                        item = {
                            src: linkEl.getAttribute('href'),
                            w: parseInt(size[0], 10),
                            h: parseInt(size[1], 10)
//                            w: curWidth,
//                            h: curHeight
                        };
                        if(figureEl.children.length > 1) {
                            // <figcaption> content
                            item.title = figureEl.children[1].innerHTML;
                        }
                        if(linkEl.children.length > 0) {
                            // <img> thumbnail element, retrieving thumbnail url
                            item.msrc = linkEl.children[0].getAttribute('src');
                        }
                        item.el = figureEl; // save link to element for getThumbBoundsFn
                        items.push(item);
                    }
                    return items;
                };
                // find nearest parent element
                var closest = function closest(el, fn) {
                    return el && ( fn(el) ? el : closest(el.parentNode, fn) );
                };
                // triggers when user clicks on thumbnail
                var onThumbnailsClick = function(e) {
                    e = e || window.event;
                    e.preventDefault ? e.preventDefault() : e.returnValue = false;
                    var eTarget = e.target || e.srcElement;
                    // find root element of slide
                    var clickedListItem = closest(eTarget, function(el) {
                        return (el.tagName && el.tagName.toUpperCase() === 'FIGURE');
                    });
                    if(!clickedListItem) {
                        return;
                    }
                    // find index of clicked item by looping through all child nodes
                    // alternatively, you may define index via data- attribute
                    var clickedGallery = clickedListItem.parentNode,
                            childNodes = clickedListItem.parentNode.childNodes,
                            numChildNodes = childNodes.length,
                            nodeIndex = 0,
                            index;
                    for (var i = 0; i < numChildNodes; i++) {
                        if(childNodes[i].nodeType !== 1) {
                            continue;
                        }
                        if(childNodes[i] === clickedListItem) {
                            index = nodeIndex;
                            break;
                        }
                        nodeIndex++;
                    }
                    if(index >= 0) {
                        // open PhotoSwipe if valid index found
                        openPhotoSwipe( index, clickedGallery );
                    }
                    return false;
                };
                // parse picture index and gallery index from URL (#&pid=1&gid=2)
                var photoswipeParseHash = function() {
                    var hash = window.location.hash.substring(1),
                            params = {};
                    if(hash.length < 5) {
                        return params;
                    }
                    var vars = hash.split('&');
                    for (var i = 0; i < vars.length; i++) {
                        if(!vars[i]) {
                            continue;
                        }
                        var pair = vars[i].split('=');
                        if(pair.length < 2) {
                            continue;
                        }
                        params[pair[0]] = pair[1];
                    }
                    if(params.gid) {
                        params.gid = parseInt(params.gid, 10);
                    }
                    return params;
                };
                var openPhotoSwipe = function(index, galleryElement, disableAnimation, fromURL) {
                    var pswpElement = document.querySelectorAll('.pswp')[0],
                            gallery,
                            options,
                            items;
                    items = parseThumbnailElements(galleryElement);
                    // define options (if needed)
                    options = {
                        // define gallery index (for URL)
                        galleryUID: galleryElement.getAttribute('data-pswp-uid'),
                        getThumbBoundsFn: function(index) {
                            // See Options -> getThumbBoundsFn section of documentation for more info
                            var thumbnail = items[index].el.getElementsByTagName('img')[0], // find thumbnail
                                    pageYScroll = window.pageYOffset || document.documentElement.scrollTop,
                                    rect = thumbnail.getBoundingClientRect();
                            return {x:rect.left, y:rect.top + pageYScroll, w:rect.width};
                        }
                    };
                    // PhotoSwipe opened from URL
                    if(fromURL) {
                        if(options.galleryPIDs) {
                            // parse real index when custom PIDs are used
                            // http://photoswipe.com/documentation/faq.html#custom-pid-in-url
                            for(var j = 0; j < items.length; j++) {
                                if(items[j].pid == index) {
                                    options.index = j;
                                    break;
                                }
                            }
                        } else {
                            // in URL indexes start from 1
                            options.index = parseInt(index, 10) - 1;
                        }
                    } else {
                        options.index = parseInt(index, 10);
                    }
                    // exit if index not found
                    if( isNaN(options.index) ) {
                        return;
                    }
                    if(disableAnimation) {
                        options.showAnimationDuration = 0;
                    }
                    // Pass data to PhotoSwipe and initialize it
                    gallery = new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, items, options);
                    gallery.init();
                };
                // loop through all gallery elements and bind events
                var galleryElements = document.querySelectorAll( gallerySelector );
                for(var i = 0, l = galleryElements.length; i < l; i++) {
                    galleryElements[i].setAttribute('data-pswp-uid', i+1);
                    galleryElements[i].onclick = onThumbnailsClick;
                }
                // Parse URL and open gallery if it contains #&pid=3&gid=1
                var hashData = photoswipeParseHash();
                if(hashData.pid && hashData.gid) {
                    openPhotoSwipe( hashData.pid ,  galleryElements[ hashData.gid - 1 ], true, true );
                }
            };
            initPhotoSwipeFromDOM('.my-gallery');


            loadFirstImgHeight()

            $('#comment').simplyCountable({
                counter: '#releaseCounter',
                maxCount:commentMaxCount,
                strictMax: true
            })

        })

        function loadFirstImgHeight() {
            var loadWidth = $('#imgContent .my-gallery').eq(0).width()
            var firstImgLink = $('#imgContent a').eq(0)
            var imgSize = firstImgLink.attr('data-size').split('x')
            var imgWidth = imgSize[0]
            var imgHeight = imgSize[1]

            var scale = imgWidth/imgHeight
            var $firstImg = firstImgLink.find('img').height(loadWidth/scale)
            $firstImg[0].onload = function () {
                $firstImg.css('height', 'auto')
            }
        }

    </script>

</content>
</body>
</html>