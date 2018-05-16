/**
 * Created by Administrator on 2017/11/3.
 */
if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function(elt /*, from*/)
    {
        var len = this.length >>> 0;
        var from = Number(arguments[1]) || 0;
        from = (from < 0)
            ? Math.ceil(from)
            : Math.floor(from);
        if (from < 0)
            from += len;
        for (; from < len; from++)
        {
            if (from in this &&
                this[from] === elt)
                return from;
        }
        return -1;
    };
}

var my = {
    url: null,
    concreteUseList: null,
    overviewUse1: null,
    getSoftWareList: function(){
        $(".waiting-modal").show();
        var param = my.overviewUse1;
        $.ajax({
         url: "./onlineLog/compGprsBillInfo?phoneNo="+param.phoneNo+"&startTime="+param.startTime+"&endTime="+param.endTime+"&flow="+param.flow+"&loginUserId="+param.loginUserId+"&chargeId="+param.chargeId+"&billNo="+param.billNo,
         type: "get",
         dataType: "json",
         cache:false,
         success: function(res){
             $(".waiting-modal").hide();
             if( res.code != 0 ){
                 alert(res.msg);
                 return;
             }
             var list = res.data.concreteUseList;
             var groupCount = res.data.groupCount;
             var $wrap = $(".mid-inner-mid .rows-wrap");

             my.concreteUseList = list;
             $wrap.html("");
             $("#totalAppNum").text(groupCount);

            for( var i=0;i<list.length;i++){
                 var html = "";
                 var appItem = list[i];
                 html +=     '<div class="row clearfix" data-appid="'+appItem.busiId+'">'+
                             '<div class="row-lt-box">'+
                             '<span class="app-icon-default"></span>'+
                             '</div>'+
                             '<div class="row-rt-box">'+
                             '<ul class="item item-top clearfix">'+
                             '<li class="s-first-child">'+
                             '<b data-key="busiName">'+appItem.busiName+'</b>'+
                             '<span class="app-group">'+appItem.appType+'</span>'+
                             '</li>'+
                             '<li>'+
                             '<span class="flow-box orange">'+
                             '<b data-key="aliasFlow">'+appItem.aliasFlow+'</b>'+
                             '<b>MB</b>'+
                             '</span>'+
                             '</li>'+
                             '</ul>'+
                             '<ul class=" item item-bottom clearfix">'+
                             '<li class="s-first-child">'+
                             '<span>上网时间：</span>'+
                             '<span data-key="timeRange">'+my.formateDate(appItem.minTime)+ "-" + my.formateDate(appItem.maxTime) +'</span>'+
                             '<span class="margin-left-5">终端：</span>'+
                             '<span data-key="termModelCode">'+appItem.termModelCode+'</span>'+
                             '</li>'+
                             '<li>'+
                             '<span>占比：</span>'+
                             '<span data-key="percent">'+appItem.percent+'</span>'+
                             '<span>%</span>'+
                             '</li>'+
                             '</ul>'+
                             '</div>'+
                             '</div>';

                 $wrap.append(html);
                 var $template = $wrap.find("[data-appid='"+appItem.busiId+"']");
                 $template.data("groupDetail",appItem.explain);
                 if( i == 0 || i == 1 || i== 2 ){
                    $template.find(".app-icon-default").addClass("app-icon");
                 }
                 if( i%2 != 0 ){
                    $template.addClass("even");
                 }
             }
             $wrap.find(".row:first-child").trigger("click");
         },
         error: function(jqXHR,textStatus,errorThrown){
             $(".waiting-modal").hide();
             if( textStatus != "abort" ){
                 alert("获取信息失败");
             }
            }
         });

        //start测试
        /*var res={
            "code": 0,
            "data": {
                "concreteUseList": [
                    {
                        "busiId": "10-7020",
                        "groupRecordCount": "198",
                        "busiName": "第一弹",
                        "aliasFlow": "985179.166",
                        "appExtFlag": null,
                        "maxTime": "20171101130939070",
                        "minTime": "20171101204119066",
                        "termModelId": "",
                        "termModelCode": "苹果 iPhone SE A1723",
                        "appType": "视频类",
                        "explain": "这就是第一弹的详细信息",
                        "percent": "12.5"
                    },
                   {
                        "busiId": "10-7021",
                        "groupRecordCount": "198",
                        "busiName": "北京移动",
                        "aliasFlow": "125.518",
                        "appExtFlag": null,
                        "maxTime": "20171101130939070",
                        "minTime": "20171101204119066",
                        "termModelId": "",
                        "termModelCode": "苹果 iPhone SE A1723",
                        "appType": "视频类",
                        "explain": "这就是北京移动的详细信息",
                        "percent": 4.36
                    },
                    {
                        "busiId": "10-7022",
                        "groupRecordCount": "198",
                        "busiName": "测试1",
                        "aliasFlow": "985179.166",
                        "appExtFlag": null,
                        "maxTime": "20171101130939070",
                        "minTime": "20171101204119066",
                        "termModelId": "",
                        "termModelCode": "苹果 iPhone SE A1723",
                        "appType": "视频类",
                        "explain": "这就是第一弹的详细信息",
                        "percent": ""
                    },
                    {
                        "busiId": "10-7023",
                        "groupRecordCount": "198",
                        "busiName": "测试2",
                        "aliasFlow": "125.518",
                        "appExtFlag": null,
                        "maxTime": "20171101130939070",
                        "minTime": "20171101204119066",
                        "termModelId": "",
                        "termModelCode": "苹果 iPhone SE A1723",
                        "appType": "视频类",
                        "explain": "这就是测试2的详细信息",
                        "percent": ""
                    },
                    {
                        "busiId": "10-7024",
                        "groupRecordCount": "198",
                        "busiName": "测试3",
                        "aliasFlow": "985179.166",
                        "appExtFlag": null,
                        "maxTime": "20171101130939070",
                        "minTime": "20171101204119066",
                        "termModelId": "",
                        "termModelCode": "苹果 iPhone SE A1723",
                        "appType": "视频类",
                        "explain": "这就是第一弹的详细信息",
                        "percent": ""
                    },
                    {
                        "busiId": "10-7025",
                        "groupRecordCount": "198",
                        "busiName": "测试4",
                        "aliasFlow": "125.518",
                        "appExtFlag": null,
                        "maxTime": "20171101130939070",
                        "minTime": "20171101204119066",
                        "termModelId": "",
                        "termModelCode": "苹果 iPhone SE A1723",
                        "appType": "视频类",
                        "explain": "这就是第一弹的详细信息",
                        "percent": ""
                    },
                    {
                        "busiId": "10-7026",
                        "groupRecordCount": "198",
                        "busiName": "测试5",
                        "aliasFlow": "985179.166",
                        "appExtFlag": null,
                        "maxTime": "20171101130939070",
                        "minTime": "20171101204119066",
                        "termModelId": "",
                        "termModelCode": "苹果 iPhone SE A1723",
                        "appType": "视频类",
                        "explain": "这就是第一弹的详细信息",
                        "percent": ""
                    },
                    {
                        "busiId": "10-7027",
                        "groupRecordCount": "198",
                        "busiName": "测试6",
                        "aliasFlow": "125.518",
                        "appExtFlag": null,
                        "maxTime": "20171101130939070",
                        "minTime": "20171101204119066",
                        "termModelId": "",
                        "termModelCode": "苹果 iPhone SE A1723",
                        "appType": "视频类",
                        "explain": "这就是第一弹的详细信息",
                        "percent": ""
                    },
                    {
                        "busiId": "10-7028",
                        "groupRecordCount": "198",
                        "busiName": "测试7",
                        "aliasFlow": "985179.166",
                        "appExtFlag": null,
                        "maxTime": "20171101130939070",
                        "minTime": "20171101204119066",
                        "termModelId": "",
                        "termModelCode": "苹果 iPhone SE A1723",
                        "appType": "视频类",
                        "explain": "这就是第一弹的详细信息",
                        "percent": ""
                    },
                    {
                        "busiId": "10-7029",
                        "groupRecordCount": "198",
                        "busiName": "测试8",
                        "aliasFlow": "125.518",
                        "appExtFlag": null,
                        "maxTime": "20171101130939070",
                        "minTime": "20171101204119066",
                        "termModelId": "",
                        "termModelCode": "苹果 iPhone SE A1723",
                        "appType": "",
                        "explain": "这就是第一弹的详细信息",
                        "percent": ""
                    },
                   {
                        "busiId": "10-7030",
                        "groupRecordCount": "198",
                        "busiName": "测试9",
                        "aliasFlow": "985179.166",
                        "appExtFlag": null,
                        "maxTime": "20171101130939070",
                        "minTime": "20171101204119066",
                        "termModelId": "",
                        "termModelCode": "苹果 iPhone SE A1723",
                        "appType": "",
                        "explain": "这就是第一弹的详细信息",
                        "percent": ""
                    },
                    {
                        "busiId": "10-7031",
                        "groupRecordCount": "198",
                        "busiName": "测试10",
                        "aliasFlow": "125.518",
                        "appExtFlag": null,
                        "maxTime": "20171101130939070",
                        "minTime": "20171101204119066",
                        "termModelId": "",
                        "termModelCode": "苹果 iPhone SE A1723",
                        "appType": "",
                        "explain": "这就是第一弹的详细信息",
                        "percent": ""
                    },
                    {
                        "busiId": "10-7032",
                        "groupRecordCount": "198",
                        "busiName": "测试11",
                        "aliasFlow": "985179.166",
                        "appExtFlag": null,
                        "maxTime": "20171101130939070",
                        "minTime": "20171101204119066",
                        "termModelId": "",
                        "termModelCode": "苹果 iPhone SE A1723",
                        "appType": "",
                        "explain": "这就是第一弹的详细信息",
                        "percent": ""
                    }
                ],
                "groupCount": 13
            },
            "msg": "成功"
        };

        var list = res.data.concreteUseList;
        var groupCount = res.data.groupCount;
        var $wrap = $(".mid-inner-mid .rows-wrap");

        $wrap.html("");
        $("#totalAppNum").text(groupCount);
        for( var i=0;i<list.length;i++){
            var html = "";
            var appItem = list[i];
            html +=     '<div class="row clearfix" data-appid="'+appItem.busiId+'">'+
                            '<div class="row-lt-box">'+
                            '<span class="app-icon-default"></span>'+
                            '</div>'+
                            '<div class="row-rt-box">'+
                            '<ul class="item item-top clearfix">'+
                            '<li class="s-first-child">'+
                            '<b data-key="busiName">'+appItem.busiName+'</b>'+
                            '<span class="app-group">'+appItem.appType+'</span>'+
                            '</li>'+
                            '<li>'+
                            '<span class="flow-box orange">'+
                            '<b data-key="aliasFlow">'+appItem.aliasFlow+'</b>'+
                            '<b>MB</b>'+
                            '</span>'+
                            '</li>'+
                            '</ul>'+
                            '<ul class=" item item-bottom clearfix">'+
                            '<li class="s-first-child">'+
                            '<span>上网时间：</span>'+
                            '<span data-key="timeRange">'+my.formateDate(appItem.minTime)+ "-" + my.formateDate(appItem.maxTime) +'</span>'+
                            '<span class="margin-left-5">终端：</span>'+
                            '<span data-key="termModelCode">'+appItem.termModelCode+'</span>'+
                            '</li>'+
                            '<li>'+
                            '<span>占比：</span>'+
                            '<span data-key="percent">'+appItem.percent+'</span>'+
                            '<span>%</span>'+
                            '</li>'+
                            '</ul>'+
                            '</div>'+
                            '</div>';

            $wrap.append(html);
            var $template = $wrap.find("[data-appid='"+appItem.busiId+"']");
            $template.data("groupDetail",appItem.explain);
            if( i == 0 || i == 1 || i== 2 ){
                $template.find(".app-icon-default").addClass("app-icon");
            }
            if( i%2 != 0 ){
                $template.addClass("even");
            }
        }
        $wrap.find(".row:first-child").trigger("click");
        $(".waiting-modal").hide();*/
        //end测试
    },
    setScrollPanelHeight: function(){
        //var windowH = $(window).height();
        var windowH = document.body.scrollHeight;
        var $scrollBox = $(".mid-inner-mid");
        var $fixed = $(".fixed-foot");
        var scrollH = windowH - 34;
        $("body").css("height",windowH+"px");
        $scrollBox.css("height",scrollH + "px");
    },
    getDisagreeList: function(){
        $.ajax({
            url: "./onlineLog/queryReasonInfo",
            type: "get",
            dataType: "json",
            cache: false,
            success: function (res) {
                if( res.code != 0 ){
                    alert(res.msg);
                    return
                }
                var data = res.data;
                var html = "",
                    i = -1;
                for( var k in data ){
                    i++;
                    html += '<li>';
                    html +=     i == 0?'<input type="radio" id="'+k+'" value="'+k+'" name="reasons" checked/>':'<input type="radio" id="'+k+'" value="'+k+'" name="reasons"/>';
                    html +=     '<label for="'+k+'">'+data[k].situation+'</label>';
                    html +=     '<p class="float-box">'+data[k].reason+'</p>';
                    html += '</li>';
                }
                $(".popup-ul").html(html);
            },
            error: function () {
                alert("获取数据失败！")
            }
        })

       //start测试
       /*var disagreeList = {
            "code": 0,
            "msg": "失败",
            "data": {
                "1": {
                    "reasonName": "客户不认可改时间段有上网行为",
                    "situation": "你好，现在只能手机功能很强大，很多情况都可以导致连接网络，比如手机内置软件自动更新或者升级都可以产生流量，为了昌盛不必要的流量，使用手机时记得关闭自动更新程序，好吗？"
                },
                "2": {
                    "reasonName": "客户质疑短时间内有多个上网记录",
                    "situation": "你好，使用手机时记得关闭自动更新程序，好吗？"
                },
                "3": {
                    "reasonName": "客户质疑上网流量使用太快",
                    "situation": "你好，现在只能手机功能很强大，很多情况都可以导致连接网络，比如手机内置软件自动更新或者升级都可以产生流量，为了昌盛不必要的流量，使用手机时记得关闭自动更新程序，好吗？"
                },
                "4": {
                    "reasonName": "客户不认可系统提供的应用名称及网站标标识",
                    "situation": "你好，现在只能手机功能很强大，很多情况都可以导致连接网络，比如手机内置软件自动更新或者升级都可以产生流量，为了昌盛不必要的流量，使用手机时记得关闭自动更新程序，好吗？"
                },
                "5": {
                    "reasonName": "客户质疑使用了WIFI，但产生了上网流量",
                    "situation": "你好，现在只能手机功能很强大，很多情况都可以导致连接网络，比如手机内置软件自动更新或者升级都可以产生流量，为了昌盛不必要的流量，使用手机时记得关闭自动更新程序，好吗？"
                },
                "6": {
                    "reasonName": "系统无法甄别，网站及应用无法显示",
                    "situation": "你好，现在只能手机功能很强大，很多情况都可以导致连接网络，比如手机内置软件自动更新或者升级都可以产生流量，为了昌盛不必要的流量，使用手机时记得关闭自动更新程序，好吗？"
                }
            }
        }
        var data = disagreeList.data;
        var html = "",
            i = -1;
        for( var k in data ){
            i++;
            html += '<li>';
            html +=     i == 0?'<input type="radio" id="'+k+'" value="'+k+'" name="reasons" checked/>':'<input type="radio" id="'+k+'" value="'+k+'" name="reasons"/>';
            html +=     '<label for="'+k+'">'+data[k].reasonName+'</label>';
            html +=     '<p class="float-box">'+data[k].situation+'</p>';
            html += '</li>';
        }
        $(".popup-ul").html(html);*/
        //end测试
    },
    getUrlParams: function() {
                    var url = window.location.search,
                        urlParams = {};
                    my.url = url;
                    if (url.indexOf("?") != -1) {
                        var str = url.substr(1),
                            arr = str.split("&");
                        for( var i=0;i<arr.length;i++ ){
                            var p = arr[i].split("=");
                            if( p[1] ){
                                if( p[0] == "ailk_autoLogin_userId" ){
                                    urlParams["loginUserId"] = p[1];
                                }else if( p[0] == "charge_id"){
                                    urlParams["chargeId"] = p[1];
                                }else{
                                    urlParams[p[0]] = p[1];
                                }
                            }
                        }
                    }
                    return urlParams;
                },
    getDecryptUserInfo: function(){
       var params = my.getUrlParams();
        $.ajax({
            url:"./onlineLog/compGprsBill",
            type: "post",
            data:JSON.stringify(params),
            contentType:"application/json;charset=UTF-8",
            async: false,
            cache: false,
            success:function(res){
                if( res.code != 0 ){
                    alert(res.msg);
                    return;
                };
                var data = res.data.overviewUse1;
                my.overviewUse1 = data;
                for( var k in data ){
                    var $elem = $("#"+k);
                    if( $elem.length ){
                        if( k == "flow" ){
                            $elem.text(data[k]?data[k]:0);
                        }else{
                            $elem.attr("type") == "hidden"?$elem.val(data[k]):$elem.text(data[k]);
                        }
                    }
                }
            },
            error: function(){
                alert("请求失败！");
            }
        });

        //start测试
        /*var info = {
            "code": 0,
            "msg": "成功",
            "data": {
                "overviewUse1": {
                    "phoneNo": "18280054566",
                    "loginUserId": "zakfOS",
                    "startTime": "2017/01/20 00:00:00",
                    "endTime": "2017/01/25 23:59:59",
                    "billNo": "multiSystem",
                    "chargeId": "aakfgm",
                    "flow": ""
                }
            }
        };
        var data = info.data.overviewUse1;
        for( var k in data ){
            var $elem = $("#"+k);
         if( $elem.length ){
         if( k == "flow" ){
         $elem.text(data[k]?data[k]:0);
         }else{
         $elem.attr("type") == "hidden"?$elem.val(data[k]):$elem.text(data[k]);
         }
         }
        }*/
        //end 测试
    },
    formateDate: function (str) {
        var date = str.substring(0,4)+"/"+str.substring(4,6)+"/"+str.substring(6,8)+" "
        +str.substring(8,10)+":"+str.substring(10,12)+":"+str.substring(12,14);
        return date;
    }
}

$(function(){
    //展开全部
    $(".j-loadAll").on("click",function(){
        var $midFoot = $(this).parent();
        $midFoot.hide();
        $(".mid-inner-mid").addClass("inner-midbox-scroll");
    });
    //点击“不认可”按钮
    $(".j-disagree").on("click",function(){
        var $popup = $(".popupBox");
        $popup.show();
    });
    //确定、取消按钮
    $(".j-ensure").on("click",function(){
        $(".popupBox").hide();
        var id = $("#disAgreeReasons").find("li input:checked").val();
        var param = {};
        param.overviewUse = my.overviewUse1;
        param.id = id;
        param.concreteUseList = my.concreteUseList;
        $.ajax({
            url: "./onlineLog/saveReansonInfo",
            type: "post",
            data:JSON.stringify(param),
            contentType: "application/json;charset=UTF-8",
            cache: false,
            success:function (res) {
                if( res.code != 0 ){
                    alert(res.msg);
                    return
                }
                alert("提交成功")
            },
            error: function(){
                alert("提交失败")
            }
        })

    });
    $(".j-cancel").on("click",function(){
        $(".popupBox").hide();
    })
    //点击展示某个软件详细介绍
    $(".rows-wrap").on("click",".row",function(){
        var $this = $(this);
        var $detailPanel = $(".righter");
        var $icon = $this.find(".app-icon-default");
        var appName = $this.find("[data-key='busiName']").text();
        var groupDetail = $this.data("groupDetail");

        $this.addClass("selected").siblings(".selected").removeClass("selected");
        if( $icon.hasClass("app-icon") ){
            $detailPanel.find(".app-icon-default").addClass("app-icon");
        }else{
            $detailPanel.find(".app-icon-default").removeClass("app-icon");
        }
        $detailPanel.find(".detail-name").text(appName);
        $detailPanel.find(".righter-content>p").text(groupDetail);
    });
    //不认可原因 列表，鼠标滑动，显示悬浮框
    $(".popup-ul").on({
        mouseenter: function(){
            var $this = $(this),
                $parent = $this.parent();
            $this.next("p.float-box").show();
            $parent.css("z-index","88");
        },
        mouseleave:function(){
            var $this = $(this),
                $parent = $this.parent();;
            $this.next("p.float-box").hide();
            $parent.css("z-index","77");
        }
    },"label");
    //回退老系统
    $(".j-back-link").on("click",function(e){
        e.preventDefault();
        window.open("http://10.113.133.240:13028/tas/aibi_tas/comp/compGprsBill.jsp"+my.url);
    })
});

window.onload = my.setScrollPanelHeight;
window.onresize = my.setScrollPanelHeight;

$(document).ready(function(){
    my.getDecryptUserInfo();  //同步
    my.getSoftWareList();
    my.getDisagreeList();
});
