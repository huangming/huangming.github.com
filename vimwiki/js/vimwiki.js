$(function(){
    $(window).scroll(function(){$(window).scrollTop()=="0"?$("#goTop").fadeOut("slow"):$("#goTop").fadeIn("slow")});
});
$('.nav li').hover(
    function() { $(this).children('.submenu').show() },
    function() { $(this).children('.submenu').hide() }
);

var kwiki = {
    getCSS: function(url) {
        var tag = '<link rel="stylesheet" href="' + url + '" />';
        $('body').append(tag);
    },
    insertCSS: function(url) {
        $.get(url, function(res) {
            var tag = '<style>' + res + '</stle>';
            $('body').append(tag);
        });
    },
    insertScript: function(url, bottle) {
        var tag = '<script src=' + url + '></script>';
        if (!bottle) bottle = 'head';
        $(bottle).append(tag);
    },
    loadCmt: function(provider) {

        $('#main').append(thread);

        var win = $(window);

        function load() {
            if (win.scrollTop() + win.height() > thread.offset().top - 250) {

                if (extraCSS) kwiki.getCSS(extraCSS);

                $.getScript(theJS);

                win.unbind('scroll');
            }
        }

        win.bind('scroll', load);
        load();
    }
};

var HOST_ROOT = 'http://huangming.org/',
kwiki_identifier = 'wiki' + window.location.pathname.replace(/\//g, '_')
    .replace('index.html', '')
    .replace('.html', '');

$(document).ready(function() {
    if (window.innerWidth >= 460) {
        var toggler = $('<div class="toggler" title="点击展开/收起，Shift+Z 隐藏或打开">目录</div>'),
        toc = $('.toc');
        toc.wrap('<div class="tocWrap">');

        $('.tocWrap').prepend(toggler)
        .delay(500)
        .fadeTo(500, '0.25')
        .hover(function() {
            $(this).stop().fadeTo(300, '0.9');
        }, function() {
            $(this).stop().fadeTo(300, '0.25');
        });

        $('html').keypress(function(e) {
            if (e.shiftKey && (e.charCode || e.keyCode) == '90') {
                e.preventDefault();
                $('div.tocWrap').toggle(200);
            }
        });

        toggler.click(function() {
            $('div.toc').slideToggle(300);
        });
    }

    //外链处理
    $('a[href]').each(function() {
        if (this.href.indexOf(window.location.host) == -1) $(this).attr({target: '_blank', title: this.href });
    });

    $('a[href^=#][href!=#]').click(function() {

        var target = document.getElementById(this.hash.slice(1));

        if (!target) return;

        var targetOffset = $(target).offset().top;
        $('html,body').animate({scrollTop: targetOffset}, 400);

        return false;
    });

    //lesser
    $('div.lesser .hd').click(function() { $(this).next().slideToggle(300); });

    //把< 转为html实体>

    //Google自定义搜索
    $.getScript('http://www.google.com/jsapi', function() {
        google.load('search', '1', {language: 'zh-CN', 'callback': cseloaded });
    });

    function cseloaded() {
        var customSearchControl = new google.search.CustomSearchControl('014150542580939738606:4fi4ontqzx0');
        customSearchControl.setResultSetSize(4);
        customSearchControl.setNoResultsString('哎哟喂，找不到这个东东呢……');

        var options = new google.search.DrawOptions();
        options.setAutoComplete(true);
        customSearchControl.draw('cse');

        var input = document.querySelector('input.gsc-input');
        input.style.cssText = '';
        input.className = 'gsc-input cesbg';
        input.onfocus = function() {
            if (input.className.indexOf('cesbg') >= 0) input.className = 'gsc-input';
        };
        input.onblur = function() {
            if (input.value == '') input.className = 'gsc-input cesbg';
        };
    };


    //代码高亮
    var syntaxHighlight = function() {
        kwiki.getCSS('http://huangming.org/vimwiki/syntaxhighlighter/styles/shThemeDefault.css');
        $.getScript('http://huangming.org/vimwiki/syntaxhighlighter/scripts/shCore.js', function() {
            $.getScript('http://huangming.org/vimwiki/syntaxhighlighter/scripts/shAutoloader.js', function(){
                SyntaxHighlighter.config.strings.expandSource = '+ 展开源码';
                SyntaxHighlighter.config.strings.viewSource = '新窗口查看源码';
                SyntaxHighlighter.config.strings.copyToClipboard = '复制到剪贴板';
                SyntaxHighlighter.config.strings.copyToClipboardConfirmation = '已经复制源码到剪切板';
                SyntaxHighlighter.config.strings.print = '打印';
                SyntaxHighlighter.config.strings.help = '';
                SyntaxHighlighter.config.strings.alert = '语法高亮器&lt;br /&gt;';
                SyntaxHighlighter.config.strings.noBrush = '找不到下列语言的渲染器: ';
                SyntaxHighlighter.autoloader(
                  'js jscript javascript  http://huangming.org/vimwiki/syntaxhighlighter/scripts/shBrushJScript.js',
                  'php http://huangming.org/vimwiki/syntaxhighlighter/scripts/shBrushPhp.js',
                  'css CSS Css http://huangming.org/vimwiki/syntaxhighlighter/scripts/shBrushCss.js',
                  'c cpp http://huangming.org/vimwiki/syntaxhighlighter/scripts/shBrushCpp.js',
                  'Bash bash http://huangming.org/vimwiki/syntaxhighlighter/scripts/shBrushBash.js'
                );
                 
                SyntaxHighlighter.all();
            });
        });
    };
    syntaxHighlight();
});

//Google 统计
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-29876307-1']);
_gaq.push(['_trackPageview']);

$.getScript('http://www.google-analytics.com/ga.js');



