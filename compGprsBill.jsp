<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.asiainfo.biframe.utils.date.DateUtil"%>
<%@ include file="../../aibi_tas/include.jsp"%>
<%@page errorPage="/aibi_tas/common/exception.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.asiainfo.biframe.unilog.log.publish.LogDetailUtil"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.asiainfo.biframe.utils.string.DES" %>
<%@ page import = "java.util.Calendar"%>

<%@ taglib uri="http://www.asiainfo-linkage.com/tas" prefix="dim"%>
<%@page import="net.sf.json.JSONArray"%>
 
<%
String charge_id=request.getParameter("charge_id");
String user=request.getParameter("ailk_autoLogin_userId");
String phoneNo =request.getParameter("phoneNo");
String startTime=request.getParameter("startTime");
String endTime=request.getParameter("endTime");
String flow=request.getParameter("flow");
String billNo=request.getParameter("billNo");

//System.out.println("传入新参数=====:");
//System.out.println("charge_id====="+charge_id);
//System.out.println("user====="+user);
//System.out.println("phoneNo====="+phoneNo);
//System.out.println("startTime====="+startTime);
//System.out.println("endTime====="+endTime);
//System.out.println("flow====="+flow);
//System.out.println("billNo====="+billNo);

//System.out.println("1-------billNo====="+ DES.encrypt("13808187080"));
//System.out.println("1-------billNo====="+ DES.encrypt("2015-12-20 00:00:01"));
//System.out.println("1-------billNo====="+ DES.encrypt("2015-12-20 23:59:01"));
//System.out.println("1-------billNo====="+ DES.encrypt("10240"));

if(phoneNo!=null&&startTime!=null&&endTime!=null){
	phoneNo=DES.decrypt(phoneNo);
	startTime=DES.decrypt(startTime);
	endTime=DES.decrypt(endTime);

if(null!=user){
	user=DES.decrypt(user);
};
if(null!=billNo){
	billNo=DES.decrypt(billNo);
};
if(null!=charge_id){
	charge_id=DES.decrypt(charge_id);
};
if(null!=flow){
	flow=DES.decrypt(flow);
};

//计算结束日期(根据开始时间和时长)
//SimpleDateFormat fmt =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
SimpleDateFormat fmt =new SimpleDateFormat("yyyy-MM-dd");
if ("2012-10-09 00:00:00".equals(startTime)){
      Calendar calendar = Calendar.getInstance();
       calendar.add(5, -1);
      startTime = fmt.format(calendar.getTime());
      endTime = startTime +" 23:59:59";
      startTime = startTime +" 00:00:00";
}
Map parmer = new HashMap();
parmer.put("charge_id",charge_id);
parmer.put("phoneNo",phoneNo);
parmer.put("startTime",startTime);
parmer.put("endTime",endTime);
parmer.put("user",user);
parmer.put("flow",flow);
parmer.put("billNo",billNo);
if (billNo==null || billNo.equals("")){
   billNo="GPRS";
}

//System.out.println("billNo2====="+billNo);
try{
  //操作类型  资源类型 资源id 未定
 // LogDetailUtil.log("0", "0", "0", "流量经营投诉专题", "GPRS详单查询"+parmer.toString(), null, null);
} catch (Exception e) {
  System.out.println("5z====BOSS跳转过来时，写日志异常！");
  e.printStackTrace();
}

String des_request_string="charge_id="+charge_id+"&userId="+user+"&phoneNo="+phoneNo+"&startTime="+startTime+"&endTime="+endTime+"&flow="+flow+"&billNo="+billNo+"&t=";
des_request_string = DES.encrypt(des_request_string);

%>
<html>
	<head>
	 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>上网流量详情</title>
		
		<%
			//这里放css和js脚本的引用。引用在assets.jsp里面定义的变量地址
		%>
		
		<script language="javaScript" src="${js_my97}"></script>
		<link rel="stylesheet" href="${css_ailk_base}" type="text/css">	
		
		<link rel="stylesheet" type="text/css" href="${ctx}/aibi_tas/assets/js/easyUI/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="${ctx}/aibi_tas/assets/js/easyUI/themes/icon.css">
		<script type="text/javascript" src="${ctx}/aibi_tas/assets/js/easyUI/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${ctx}/aibi_tas/assets/js/easyUI/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="${ctx}/aibi_tas/assets/js/popupdiv.js"></script>
		
		<style type="text/css">
		.current_Month{
				padding:3px 15px;
				text-align:center;
				color: #00448b;
				border: 1px solid #2178BD;
				background-color: #a7daf5;
				
			}
			.all_Period{
				padding:3px 15px;
				margin-right:1em;
				text-align:center;
				color:#444444;
				border: 1px solid #9B9B9B;
				background-color: #DFDFDF;
			}
			.phoneNo_td{
				padding:3px 16px;
				background-color: #a7daf5;
				width: 90px;
				height:29px;
				color: #00448b;
				text-align: center;
				border: 1px solid #2178BD;
			}
			.font_input{
				height: 20px;
			}
			.tas_tab ul li{width:100px;display:inline;padding:0 20px;}
			.app_collect_table {
				text-align: center;
			}
			.app_collect_table tr th{
				height: 28px;
				font-weight: bolder;
				background: #f0fbff;
				border: 1px #4977A6 solid;
			}
			.app_collect_table tr td{
				height: 26px;
				border: 1px #4977A6 solid;
			}
			table.detail_busi {
				border: 1px #4977A6 solid;
				text-align: center;
			}
			table.detail_busi tr th{
				height: 28px;
				border: 1px #4977A6 solid;
				font-weight: bolder;
				background: #f0fbff;
			}
			table.detail_busi tr td{
				height: 26px;
				border: 1px #4977A6 solid;
			}
			.searchBtn {
				padding:0px 15px;
				color: #00448b;
				border: 1px solid #2178BD;
				background-color: #a7daf5;
			}
      .trHover{
       	color:#098B14;
       	background:#CCEBFF;
      }
      
		.overlay{position:fixed;top:0;right:0;bottom:0;left:0;z-index:9989;width:100%;height:100%;_padding:0 20px 0 0;background:#f6f4f5;display:none;}
		.showbox{position:fixed;top:0;left:50%;z-index:99999;opacity:0;filter:alpha(opacity=0);margin-left:-80px;}
		*html,*html body{background-image:url(about:blank);background-attachment:fixed;}
		*html .showbox,*html .overlay{position:absolute;top:expression(eval(document.documentElement.scrollTop));}
		#AjaxLoading{border:0px;color:#37a;font-size:12px;}
		#AjaxLoading{width:100%;height:50px;line-height:50px;border:0px solid #D6E7F2;margin-top:200px;}
		.hotspot {color:#900; padding-bottom:1px; border-bottom:1px dotted #900; cursor:pointer}
		
		
#tt {position:absolute; display:block; background:url(images/tt_left.gif) top left no-repeat}
 
 
		</style>
		<script type="text/javascript" >
	 
		var detailFlag=0;
		
		  var save_obj;
		  var save_tag_flag;
		  var save_appId;
		  var save_totalFlow;
		  var save_app_Name;
		  var save_termId;
		  var save_termBrandName;
		  var save_times;
		  var save_is_accept;
		  var save_siteId;
		  var save_no;
		  
		  var dealflag = 1;
		  
		$(document).ready(function(){ 
		
			/*本月时间赋初值，url传递的开始时间：格式yyyy-MM-dd*/
			var st = "<%=startTime%>";
			$("#txtSearchTimeBegin").val(st);
			
			$("#TotalFlow").empty();
			$("#TotalFlow").html(fmoney($("#flow").val()/1024,2));
			
			 showMultiDetailApp();
		});

	function beginLoading(){
		var h = $(document).height();
		$(".overlay").css({"height": h });
		$(".overlay").css({'display':'block','opacity':'0.8'});
		$(".showbox").stop(true).animate({'margin-top':'300px','opacity':'1'},200);
	}

	function endLoading(){
		$(".showbox").stop(true).animate({'margin-top':'250px','opacity':'0'},400);
		$(".overlay").css({'display':'none','opacity':'0'});
	}

		/*url过长截取显示方式*/
		function subString(str,lentgh){
	         var result=str.substring(0,lentgh);
	         if(str.length>lentgh)result=result+"..."
	         return result;
		}

		/*日期一位补零格式*/
		function getDateWithZero(obj){
			if(obj<10)
				return true;
			}

//数字格式化 s 数字 n保留小数位数
function fmoney(s, n)   
{   
	
	 if (s=="" || s==null){return "0";}
	 
   n = n > 0 && n <= 20 ? n : 2;   
   s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";   
   var l = s.split(".")[0].split("").reverse(),   
   r = s.split(".")[1];   
   t = "";   
   for(i = 0; i < l.length; i ++ )   
   {   
      t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : "");   
   }   
   return t.split("").reverse().join("") + "." + r;   
} 
	var allArr1 = "";
	//luojm add	 查应用级
	function showMultiDetailApp(){
			    var rowNum = $("#rowNum").val();
			    var pageRowNum = $("#ApppageRowNum").val();
			    var currentPage = $("#currentPage").val();
			    
			    var trno = "1";

			    var phoneNo = $("#phoneNo").val();
			    var charge_id = $("#charge_id").val();
			   // var bill_No_Name = $("#bill_No_Name").val();
			    var userId = $("#userId").val();
			    var startTime=$('#txtSearchTimeBegin').val();
				  var endTime=$('#txtSearchTimeEnd').val();
          var flow=$('#flow').val();
          var source=$('#source').val();
          //console.log("userId: "+userId);
          
			    var multi_busi_collect_div_cont ="";
			    var url = "complainAction!showDetailApp.ai2do?";
				  var  param="billNo=&charge_id="+charge_id+"&phoneNo="+phoneNo+"&startTime="+startTime+"&endTime="+endTime+"&flow="+flow+"&userId="+userId+"&rowNum="+rowNum+"&pageRowNum="+pageRowNum+"&source="+source+"&t="+Math.random();
				  var  paramAll="billNo=&charge_id="+charge_id+"&phoneNo="+phoneNo+"&startTime="+startTime+"&endTime="+endTime+"&flow="+flow+"&userId="+userId+"&rowNum=1&pageRowNum=1000000&source="+source+"&t="+Math.random();
				  var allArr = "";
				  
				    
		          beginLoading();
		                
						$.ajax({
					  		type: 'GET',
					  		url: url+encodeURIComponent(paramAll),
					  		data: paramAll,
					  		async: false,
					  		success: function(data){
					  			
					  			if(data!=null && data != ""){
					  				  
					  				$(data).each(function(i,item){
							  			if(i==1){
							  				
							  				var feeFlow = (flow/1024).toFixed(2);
											for(var j=0;j<item.length;j++){
											 	   var app_flow_div = (item[j].addTotalFlow/1024/1024).toFixed(2);
												   //if (feeFlow==0){app_flow_div=0; feeFlow=1;}
												   var obj = ""+ item[j].busiId+","+app_flow_div+","+item[j].busiName+","+item[j].termBrandName+","+item[j].minDateStr+","+j+"|"
													 
												 	allArr+=obj;
											}
												
								  		}
					  				});
					  			}
					  			else{
					  				//var args = window.dialogArguments; 
					  			    window.returnValue = "3"; //3-找不到上网日志
					  			}
					  		}
						});
					//console.log(allArr1);
         var url_power_right = "complainAction!getPower_right.ai2do?";
				    var  param_power_right="userId="+userId;
				    //console.log(param_power_right);
				    var power_right = 1;//<16 show
					
						$.ajax({
					  		type: 'GET',
					  		url: url_power_right+encodeURIComponent(param_power_right),
					  		data: param_power_right,
					  		async: false,
					  		success: function(data){
					  		   power_right = data;
					  		}
						});
			    //console.log(power_right);  
			    var div_cont = "";
			    if(power_right >=16){
			        div_cont = "<table id='app_collect_table_ "+trno+"'  class='detail_busi' style='margin-left:1%;width:98%;margin-top:12px;margin-bottom:20px;border: 1px white solid;'>"+
	                   "<tr style='background-color: #ebfefc'>"+
	                   "<th style='height:22px;text-align:center;padding-top:10px;font-weight:normal;border: 1px white solid;background-color: #333333;color:white;'>序号</th>"+
	                   "<th  style='height:22px;text-align:center;padding-top:10px;font-weight:normal;border: 1px white solid;background-color: #333333;color:white;'>上网时间</th>"+
	                   "<th  style='height:22px;text-align:center;padding-top:10px;font-weight:normal;border: 1px white solid;background-color: #333333;color:white;'>终端</th>"+
	                   "<th  style='height:22px;text-align:center;padding-top:10px;font-weight:normal;border: 1px white solid;background-color: #333333;color:white;'>流量(MB)</th>"+
	                   "<th  style='height:22px;text-align:center;padding-top:10px;font-weight:normal;border: 1px white solid;background-color: #333333;color:white;'>占比</th>"+
	                   "<th  style='height:22px;text-align:center;padding-top:10px;font-weight:normal;border: 1px white solid;background-color: #333333;color:white;'>应用名称</th>"+
	                   "<th  style='height:22px;text-align:center;padding-top:10px;font-weight:normal;border: 1px white solid;background-color: #333333;color:white;'><span id='dealappflag_acceptAll'><a href='#' id='app' style='color:#2A7FD2' onclick='showMultiAppTagFlagAll(this,11,\""+allArr+"\")'><img src='${ctx}/aibi_tas/assets/css/images/AA01.png'/></a></span>看看多少用户不认可</th>"+
	                  "</tr>";
			    }else{
			    	
			    div_cont = "<table id='app_collect_table_ "+trno+"'  class='detail_busi' style='margin-left:1%;width:98%;margin-top:12px;margin-bottom:20px;border: 1px white solid;'>"+
			                   "<tr style='background-color: #ebfefc'>"+
			                   "<th style='height:22px;text-align:center;padding-top:10px;font-weight:normal;border: 1px white solid;background-color: #333333;color:white;'>序号</th>"+
			                   "<th  style='height:22px;text-align:center;padding-top:10px;font-weight:normal;border: 1px white solid;background-color: #333333;color:white;'>上网时间</th>"+
			                   "<th  style='height:22px;text-align:center;padding-top:10px;font-weight:normal;border: 1px white solid;background-color: #333333;color:white;'>终端</th>"+
			                   "<th  style='height:22px;text-align:center;padding-top:10px;font-weight:normal;border: 1px white solid;background-color: #333333;color:white;'>占比</th>"+
			                   "<th  style='height:22px;text-align:center;padding-top:10px;font-weight:normal;border: 1px white solid;background-color: #333333;color:white;'>应用名称</th>"+
			                   "<th  style='height:22px;text-align:center;padding-top:10px;font-weight:normal;border: 1px white solid;background-color: #333333;color:white;'><span id='dealappflag_acceptAll'><a href='#' id='app' style='color:#2A7FD2' onclick='showMultiAppTagFlagAll(this,11,\""+allArr+"\")'><img src='${ctx}/aibi_tas/assets/css/images/AA01.png'/></a></span>看看多少用户不认可</th>"+
			                  "</tr>";
			    }
		
				$.ajax({
			  		type: 'GET',
			  		url: url+encodeURIComponent(param),
			  		data: param,
			  		async: true,
			  		success: function(data){
			  			if(data!=null && data != ""){
			  				var busiArr = new Array();
			  				var totalCount = 0;
			  				var totalpage = 0;
			  				$(data).each(function(i,item){
			  					if(i==0){
			  						totalCount = item.groupCount; 
			  						totalpage = Math.ceil(parseInt(totalCount)/parseInt(pageRowNum));
			  						//$("#TotalFlow").html((item.totalFlow/1).toFixed(2)+" KB" );
			  					}
					  			if(i==1){

					  				var multi_div_cont ="";
					  				var totalAppFlow = 0;
					  				var feeFlow = (flow/1024).toFixed(2);
									for(var j=0;j<item.length;j++){
										   totalAppFlow+=item[j].addTotalFlow;
										
										   var app_flow = fmoney(item[j].addTotalFlow/1024/1024,2);
										   var app_flow_div = (item[j].addTotalFlow/1024/1024).toFixed(2);
										   if (feeFlow==0){app_flow_div=0; feeFlow=1;}
										   //
										    if(power_right >=16){
											   multi_div_cont+="<tr><td class='muti_busi_flag' style='display:none;height:22px;'>"+item[j].busiId+"</td>"+
												 "<td class='trnoflag' style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'>"+(j+1)+"</td>"+
												 "<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'>"+item[j].minDateStr+item[j].maxDateStr+"</td>"+
												 "<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'>"+item[j].termBrandName+"</td>"+
												 "<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'><font style='color:#098b14;font-weight:bold;font-size:14px;'>"+ app_flow+"</font></td>";
										    }else{
												 multi_div_cont+="<tr><td class='muti_busi_flag' style='display:none;height:22px;'>"+item[j].busiId+"</td>"+
												 "<td class='trnoflag' style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'>"+(j+1)+"</td>"+
												 "<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'>"+item[j].minDateStr+item[j].maxDateStr+"</td>"+
												 "<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'>"+item[j].termBrandName+"</td>";
										    }	
										     if (flow=="" || flow=="0"){
                             multi_div_cont+="<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;color:#098b14;font-weight:bold;font-size:14px;'>0%</td>";
                         }else{//font-weight:bold;
	                           multi_div_cont+="<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'><font style='color:#098b14;font-weight:bold;font-size:14px;'>"+Math.round(app_flow_div/feeFlow*100)+"%</font></td>";                    
	                      }
	                       multi_div_cont+="<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #E7F5FF;'><a href='#' style='color:#2A7FD2;' onclick='showMultiDetailUrl(1,\""+item[j].busiId+"\",\""+item[j].minDateStr+"\","+(item[j].addTotalFlow/1024).toFixed(2)+",\""+item[j].busiName+"\")'>"+item[j].busiName+"</a></td>";

                       if (item[j].busiName=='其它'){
                       	multi_div_cont +="<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'></td>";
                      }else{
   											multi_div_cont +="<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'><span id='dealappflag_noaccept"+j+"' onmouseover='showMultiAppTagMsg(this,4,\""+item[j].busiId+"\","+app_flow_div+",\""+item[j].busiName+"\",\"\",\""+item[j].termBrandName+"\",\""+item[j].minDateStr+"\")' onmouseout='showUrlTasTotalOff(this);' ><a href='#' id='app' style='color:#2A7FD2' onclick='showMultiAppTagFlag(this,12,\""+item[j].busiId+"\","+app_flow_div+",\""+item[j].busiName+"\",\"\",\""+item[j].termBrandName+"\",\""+item[j].minDateStr+"\","+j+")'><img src='${ctx}/aibi_tas/assets/css/images/BB01.png'/></a></span></td>";
                      }
										   	multi_div_cont+="</tr>";
										 
										var key = ""+item[j].termBrandId + item[j].termModelId + item[j].busiId;
										busiArr.push(key);
									}
									
										multi_div_cont+="</table><table style='margin-left:1%;width:98%;height:35px;margin-top:-20px;margin-bottom:20px;border: 1px white solid;'>";
										
									//分页====================
									multi_div_cont+='<tr><td colspan="6" style="border: 1px white solid;padding-top:10px;text-align:left;background-color:#D7D7D7;">&nbsp;&nbsp;&nbsp;&nbsp;'
									if (parseInt(currentPage)>1){
									  multi_div_cont+=' <a href="javascript:getCurrentPage(1)"><img src="${ctx}/aibi_tas/assets/css/images/page_first_a.gif" alt="第一页" /></a>&nbsp;&nbsp;'
									  multi_div_cont+=' <a href="javascript:getCurrentPage('+(parseInt(currentPage)-1)+')"><img src="${ctx}/aibi_tas/assets/css/images/page_pre_a.gif" alt="上一页" /></a>&nbsp;&nbsp;'
								  }else{
										multi_div_cont+=' <a href="#"><img src="${ctx}/aibi_tas/assets/css/images/page_first_b.gif" alt="第一页" /></a>&nbsp;&nbsp;'
									  multi_div_cont+=' <a href="#"><img src="${ctx}/aibi_tas/assets/css/images/page_pre_b.gif" alt="上一页" /></a>&nbsp;&nbsp;'
								  }
								  multi_div_cont+='<img src="${ctx}/aibi_tas/assets/css/images/line.gif"/>&nbsp;&nbsp;第&nbsp;&nbsp;';
								  multi_div_cont+= currentPage +'&nbsp;&nbsp;页/&nbsp;&nbsp;共&nbsp;&nbsp;'+totalpage+'&nbsp;&nbsp;页&nbsp;&nbsp;';
								  multi_div_cont+='<img src="${ctx}/aibi_tas/assets/css/images/line.gif"/>&nbsp;&nbsp;';
								    
							  if (totalpage>parseInt(currentPage)){
									  multi_div_cont+=' <a href="javascript:getCurrentPage('+(parseInt(currentPage)+1)+')"><img src="${ctx}/aibi_tas/assets/css/images/page_next_a.gif" alt="下一页" /></a>&nbsp;&nbsp;'
									  multi_div_cont+=' <a  href="javascript:getCurrentPage('+totalpage+')"><img src="${ctx}/aibi_tas/assets/css/images/page_last_a.gif" alt="最后一页" /></a>&nbsp;&nbsp;'
								  }else{
										multi_div_cont+=' <a href="#"><img src="${ctx}/aibi_tas/assets/css/images/page_next_b.gif" alt="下一页" /></a>&nbsp;&nbsp;'
									  multi_div_cont+=' <a href="#"><img src="${ctx}/aibi_tas/assets/css/images/page_last_b.gif" alt="最后一页" /></a>&nbsp;&nbsp;'
								  }
									multi_div_cont+='</td></tr>';
				          //==========================
				         // multi_div_cont+='测试用--本页合计：'+(totalAppFlow/1024).toFixed(2)+" KB";
				          
									div_cont= div_cont+  multi_div_cont;
								
							    $('#phoneBill_div').empty();
									$("#phoneBill_div").append(div_cont);
									
								 //app明显
			           var tableHover = ".detail_busi";
			           $(tableHover).find("tr").hover(function(){ $(this).addClass("trHover")}, function(){$(this).removeClass("trHover") });
			 
									//$("#TotalFlow").html((totalAppFlow/1024).toFixed(2)+" KB" );
									
						  		}
						  		if(i==2){//已废除

							  	}

						  		
			  				});
			  			}else{
				  				div_cont+="<tr><td colspan='6' style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'>未查询到符合条件的上网信息</td></tr></table>";
					  		 	$('#phoneBill_div').empty();
									$("#phoneBill_div").append(div_cont);
			  				}		
			  				 endLoading();  						  			
			  			}
			  			
				});
  			 
		  }
		  
		 //luojm add
		/*以dialog的形式显示某应用最细粒度的信息*/
	function showMultiHighPriDetailApp(obj){
			var trno_flag = $(obj).parent().parent().find(".trnoflag").text();
			var busi_flag = $(obj).parent().parent().find(".muti_busi_flag").text();
			var tbid=trno_flag+busi_flag;

			var sname = tbid.replace(/[ ]/g,""); //去除空格
			$("#multi_detail_busi_"+trno_flag).dialog({modal:true, title:'<font color="white">&nbsp;&nbsp;上网明细</font>', width:900, height:430, resizable:false, draggable:false, zIndex:1000, overlay:{background: 'red',opacity: 0.5},onClose:function(){
       if (detailFlag==1){ 
       	  showMultiDetailApp();			
       	  detailFlag = 0;  
       	  $(this).dialog('destroy'); 
       	 }
      }});

		}	  
	//luojm add
	function showMultiDetailTagFlag(obj,tag_flag,appId,totalFlow,app_Name,termId,termBrandName,siteId,no){
	 
			  var siteName = $(obj).parent().parent().find(".siteFlag").text();
			  var phoneNo = $("#phoneNo").val();
			  var userId = $("#userId").val();
			  
			   var DetailAppId = $("#DetailAppId").val();
			   var detailMinTime = $("#detailMinTime").val();
			   var detailMaxTime = $("#detailMaxTime").val();
			   
			   var is_accept = -1;
			   if (tag_flag==11){
			   	   tag_flag =2;
			   	   is_accept =1;
			   	   showMultiDetailTagFlag_execute(obj,tag_flag,appId,totalFlow,app_Name,termId,termBrandName,siteId,is_accept,"0",no);
			  }else if (tag_flag==12){
			  	   tag_flag =2;
			   	   is_accept =0;
			   	   
			   	   save_obj = obj;
			   	   save_tag_flag = tag_flag;
			   	   save_appId=appId;
			   	   save_totalFlow = totalFlow;
			   	   save_app_Name = app_Name;
			   	   save_termId = termId;
			   	   save_termBrandName = termBrandName;
			   	   save_siteId = siteId
			   	   save_is_accept = is_accept;
			   	   save_no = no;
			   	   dealflag = 2;//detail
			   	   
			   	   closeAllt("fileid");
			   	   allt(obj,'fileid_tas');
			  }
			  
	
		  }

function showMultiDetailTagFlag_execute(obj,tag_flag,appId,totalFlow,app_Name,termId,termBrandName,siteId,is_accept,notre_cause,no){
			  var siteName = $(obj).parent().parent().find(".siteFlag").text();
			  var phoneNo = $("#phoneNo").val();
			  var userId = $("#userId").val();
			  
			   var DetailAppId = $("#DetailAppId").val();
			   var detailMinTime = $("#detailMinTime").val();
			   var detailMaxTime = $("#detailMaxTime").val();
	
			  var url = "complainAction!showDetailAppByRowNum.ai2do?";
				var param="startTime="+detailMinTime+"&endTime="+detailMaxTime+"&phoneNo="+phoneNo+"&tag_flag="+tag_flag+"&totalFlow="+totalFlow+"&userId="+userId+"&appName="+siteName+"&term_id="+termId+"&term_name="+termBrandName+"&appId="+DetailAppId+"&siteId="+siteId+"&is_accept="+is_accept+"&notre_cause="+notre_cause+"&t="+Math.random();

				$.ajax({
			  		type: 'GET',
			  		url: url+encodeURIComponent(param),
			  		data: param,
			  		async: false,
			  		success: function(data){

			  			var successflag = data[0];
			  			var count = data[1];
			  			if(data!=null && successflag!=""){
			   
			  			  $("#dealurlflag_noaccept"+no).html("<img src='${ctx}/aibi_tas/assets/css/images/BB02.png'/>");
								$("#dealurlflag_accept"+no).html("<img src='${ctx}/aibi_tas/assets/css/images/AA02.png' />");

			  			}else{
			  				alert("打标失败！");
			  			}
			  	 
			  			 closeAllt("fileid_tas");
			  			 $("#notre_cause1").attr("checked","true");
			  	}	
				});
				
		  }
		  
function showMultiDetailTagMsg(obj,tag_flag,appId,totalFlow,app_Name,termId,termBrandName,siteId){

			  var siteName = $(obj).parent().parent().find(".siteFlag").text();
			  var phoneNo = $("#phoneNo").val();
			  var userId = $("#userId").val();
			  
			   var DetailAppId = $("#DetailAppId").val();
			   var detailMinTime = $("#detailMinTime").val();
			   var detailMaxTime = $("#detailMaxTime").val();
			  
			  var url = "complainAction!showDetailAppByRowNum.ai2do?";
				var param="startTime="+detailMinTime+"&endTime="+detailMaxTime+"&phoneNo="+phoneNo+"&tag_flag="+tag_flag+"&totalFlow="+totalFlow+"&userId="+userId+"&appName="+siteName+"&term_id="+termId+"&term_name="+termBrandName+"&appId="+DetailAppId+"&siteId="+siteId+"&is_accept=-1"+"&t="+Math.random();

				$.ajax({
			  		type: 'GET',
			  		url: url+encodeURIComponent(param),
			  		data: param,
			  		async: false,
			  		success: function(data){
			  		 	$('#popupcontent').empty();
			  			if(data!=null && data!=""){
	              $("#popupcontent").html("该网址本月有&nbsp;&nbsp;<span style='color:#FF8201;font-size:18px'>"+data+"</span>&nbsp;&nbsp;个用户不认可!&nbsp;&nbsp;");
		            allt(obj,'fileid');
			  			}else{
			  				$("#popupcontent").html("查询用户不认可数失败!&nbsp;&nbsp;");
		            allt(obj,'fileid');
			  			}

			  	}	
				});
				
		  }
		  
//luojm add
	function showMultiAppTagMsg(obj,tag_flag,appId,totalFlow,app_Name,termId,termBrandName,times){
			  var rowNum = $(obj).parent().parent().find(".rowNum_flag").text();
			  var trno = $(obj).parent().parent().find(".trnoflag").text();
			  var phoneNo = $("#phoneNo").val();
			  var userId = $("#userId").val();
		  
		        
			   var MinTime = times.substring(0,19);
			   var MaxTime = times.substring(22,41);

			  var url = "complainAction!showDetailAppByRowNum.ai2do?";
				var param="startTime="+MinTime+"&endTime="+MaxTime+"&phoneNo="+phoneNo+"&tag_flag="+tag_flag+"&totalFlow="+totalFlow+"&userId="+userId+"&appName="+app_Name+"&term_id="+termId+"&term_name="+termBrandName+"&appId="+appId+"&is_accept=-1"+"&t="+Math.random();

				$.ajax({
			  		type: 'GET',
			  		url: url+encodeURIComponent(param),
			  		data: param,
			  		async: false,
			  		success: function(data){
			  		 	$('#popupcontent').empty();
			  			if(data!=null && data!=""){
	              $("#popupcontent").html("该应用本月有&nbsp;&nbsp;<span style='color:#FF8201;font-size:18px'>"+data+"</span>&nbsp;&nbsp;个用户不认可!&nbsp;&nbsp;");
		            allt(obj,'fileid');
			  			}else{
			  				$("#popupcontent").html("查询用户不认可数失败!&nbsp;&nbsp;");
		            allt(obj,'fileid');
			  			}
			  	}	
				});
				
		  }
		  function showMultiAppTagFlagAll(obj,tag_flag,allArr){
			  window.returnValue = "1";//1-认可
			  //onsole.log(allArr1);
			   var is_accept = -1;
			   if (tag_flag==11){
			   	   tag_flag =1;
			   	   is_accept =1;
			   	  /* 
				   	for(var i=0;i<allArr.length;i++){
				   		 console.log(allArr[i].busiId);
				   		obj = obj;
				   		tag_flag = tag_flag;
				   		var appId = allArr[i].busiId;
				   		var totalFlow = allArr[i].app_flow_div;
				   		var app_Name = allArr[i].busiName;
				   		var termId = "";
				   		var termBrandName = allArr[i].termBrandName;
				   		var times = allArr[i].minDateStr;
				   		var no = i;
				   		
			   	        showMultiAppTagFlag_execute(obj,tag_flag,appId,totalFlow,app_Name,termId,termBrandName,times,is_accept,"0",no);
					}*/
				   	showMultiAppTagFlag_executeAll(obj,tag_flag,"",is_accept,"0",allArr);
			  } 
		 	
		  }
		  
			function showMultiAppTagFlag_executeAll(obj,tag_flag,termId,is_accept,notre_cause,allArr){

				  var phoneNo = $("#phoneNo").val();
				  var userId = $("#userId").val();
				  //console.log(allArr);
				   
			     var times =  allArr.split("&")[0].split(",")[4];  
			     //var times = "2016-03-22 12:39:58 - 2016-03-23 12:17:03" 
				   var MinTime = times.substring(0,19);
				   var MaxTime = times.substring(22,41);
	
				  var url = "complainAction!showDetailAppByRowNum.ai2do?";
					var param="startTime="+MinTime+"&endTime="+MaxTime+"&phoneNo="+phoneNo+"&tag_flag="+tag_flag+"&userId="+userId+"&term_id="+termId+"&allArr="+allArr+"&is_accept="+is_accept+"&notre_cause="+notre_cause+"&t="+Math.random();
          
                    beginLoading(); 
					$.ajax({
				  		type: 'GET',
				  		url: url+encodeURIComponent(param),
				  		data: param,
				  		async: false,
				  		success: function(data){
				  			var successflag = data[0];
				  			var count = data[1];
				  			if(data!=null && successflag!=""){

				  					$("#dealappflag_acceptAll").html("<img src='${ctx}/aibi_tas/assets/css/images/AA02.png' />");
				  				   for(var i=0;i<allArr.split("|").length;i++){
								   		var no = i;
				  			            $("#dealappflag_noaccept"+no).html("<img src='${ctx}/aibi_tas/assets/css/images/BB02.png'/>");
									  }
				  		    //allArr1= [];
				  			}else{
				  				alert("打标失败！");
				  			}
				  			 closeAllt("fileid_tas");
				  			 $("#notre_cause1").attr("checked","true");

				  			endLoading();    
				  	}	
					});
					
			  }
		  
		  function showMultiAppTagFlag(obj,tag_flag,appId,totalFlow,app_Name,termId,termBrandName,times,no){

			   var is_accept = -1;
			   if (tag_flag==11){
			   	   tag_flag =1;
			   	   is_accept =1;
			   	   showMultiAppTagFlag_execute(obj,tag_flag,appId,totalFlow,app_Name,termId,termBrandName,times,is_accept,"0",no);
			  }else if (tag_flag==12){
				  //window.returnValue = "2-不认可";
				   tag_flag =1;
			   	   is_accept =0;
			   	   
			   	   save_obj = obj;
			   	   save_tag_flag = tag_flag;
			   	   save_appId=appId;
			   	   save_totalFlow = totalFlow;
			   	   save_app_Name = app_Name;
			   	   save_termId = termId;
			   	   save_termBrandName = termBrandName;
			   	   save_times = times;
			   	   save_is_accept = is_accept;
			   	   save_no = no;
			   	   
			   	   dealflag = 1;//app
			   	   
			   	   closeAllt("fileid");
			   	   allt(obj,'fileid_tas');
			  }
		 	
		  }
		  
		  
		function showMultiAppTagFlag_execute(obj,tag_flag,appId,totalFlow,app_Name,termId,termBrandName,times,is_accept,notre_cause,no){

			  var phoneNo = $("#phoneNo").val();
			  var userId = $("#userId").val();
		        
			   var MinTime = times.substring(0,19);
			   var MaxTime = times.substring(22,41);
			  
			  var url = "complainAction!showDetailAppByRowNum.ai2do?";
				var param="startTime="+MinTime+"&endTime="+MaxTime+"&phoneNo="+phoneNo+"&tag_flag="+tag_flag+"&totalFlow="+totalFlow+"&userId="+userId+"&appName="+app_Name+"&term_id="+termId+"&term_name="+termBrandName+"&appId="+appId+"&is_accept="+is_accept+"&notre_cause="+notre_cause+"&t="+Math.random();

				$.ajax({
			  		type: 'GET',
			  		url: url+encodeURIComponent(param),
			  		data: param,
			  		async: false,
			  		success: function(data){
			  			var successflag = data[0];
			  			var count = data[1];
			  			if(data!=null && successflag!=""){
			  				 if (tag_flag==11){  
			  					//$("#dealappflag_accept"+no).html("<img src='${ctx}/aibi_tas/assets/css/images/AA02.png' />");
				  				 $("#dealappflag_acceptAll").html("<img src='${ctx}/aibi_tas/assets/css/images/AA02.png' />");
				  			    $("#dealappflag_noaccept"+no).html("<img src='${ctx}/aibi_tas/assets/css/images/BB02.png'/>");
				  		
			  				 }else{
			  					//$("#dealappflag_accept"+no).html("<img src='${ctx}/aibi_tas/assets/css/images/AA02.png' />");
				  			    $("#dealappflag_noaccept"+no).html("<img src='${ctx}/aibi_tas/assets/css/images/BB02.png'/>");
				  		
			  				 }	 
			  		
			  			}else{
			  				alert("打标失败！");
			  			}
			  			 closeAllt("fileid_tas");
			  			 $("#notre_cause1").attr("checked","true");

			  			    
			  	}	
				});
				
		  }
		  
var this_dialog=0;
//luojm add	 查明细级
	function showMultiDetailUrl(interflag,appId,detailTime,flow,appName){
		
		      beginLoading();
		 
		      if (interflag==1){
		      	$("#DetailrowNum").val("1");
		      	$("#DetailcurrentPage").val("1");
		      	$('#detailMinTime').val(detailTime.substring(0,19));
		      	$('#detailMaxTime').val(detailTime.substring(22,41));
		        $("#DetailFlowSum").val(flow);
		        $("#DetailappName").val(appName);
		      }
			    var DetailrowNum = $("#DetailrowNum").val();
			    var pageRowNum = $("#pageRowNum").val();
			    var DetailcurrentPage = $("#DetailcurrentPage").val();
			     
			    $("#DetailAppId").val(appId);
	       
	 
			    var phoneNo = $("#phoneNo").val();
			    var charge_id = $("#charge_id").val();
			    var bill_No_Name = $("#bill_No_Name").val();
			    var userId = $("#userId").val();
			    //var startTime=$('#txtSearchTimeBegin').val();
				  //var endTime=$('#txtSearchTimeEnd').val();
				  var startTime=$('#detailMinTime').val();
				  var endTime=$('#detailMaxTime').val();
          var flow=$('#DetailFlowSum').val();
       
			    var url = "complainAction!showDetailUrl.ai2do?";
				  var  param="appId="+appId+"&billNo="+$("#bill_No").val()+"&charge_id="+charge_id+"&phoneNo="+phoneNo+"&startTime="+startTime+"&endTime="+endTime+"&flow="+flow+"&userId="+userId+"&rowNum="+DetailrowNum+"&pageRowNum="+pageRowNum+"&t="+Math.random();

  
				$.ajax({
			  		type: 'GET',
			  		url: url+encodeURIComponent(param),
			  		data: param,
			  		async: true,
			  		success: function(data){ 

			  			if(data!=null && data != ""){
			  				var busiArr = new Array();
			  				var DetailtotalCount = 0;
			  				var Detailtotalpage = 0;
			  			
			  				$(data).each(function(i,item){
			  					if (item==null){
			  						alert("未查询到详细明细信息。");
			  						return false;
			  					}
			  				  if(i==0){
			  						DetailtotalCount = item[i].groupCount; 
			  						Detailtotalpage = Math.ceil(parseInt(DetailtotalCount)/parseInt(pageRowNum));
			  					}
			  					
						  		if(i==1){
						  					
						  		 var totalDetailAppFlow = 0;
			  				   		var detail_busi_cont = "";
			  											  			 
								   detail_busi_cont += "<div id='multi_detail_busi'><table  id='multi_detail_url' class='detail_busi' style='border: 1px white solid;'><tr style='background-color: #ebfefc'>"+
								      "<th style='height:22px;text-align:center;padding-top:10px;font-weight:normal;padding-top:10px;border: 1px white solid;background-color:#71B0E3;color:white;width:60px;'>序号</th>"+
									 //"<th style='height:22px;text-align:center;padding-top:10px;font-weight:normal;padding-top:10px;border: 1px white solid;background-color:#71B0E3;color:white;'>上网时间</th>"+ 
									  	"<th style='height:22px;text-align:center;padding-top:10px;font-weight:normal;padding-top:10px;border: 1px white solid;background-color:#71B0E3;color:white;'>流量(KB)</th>"+
									  	"<th style='height:22px;text-align:center;padding-top:10px;font-weight:normal;padding-top:10px;border: 1px white solid;background-color:#71B0E3;color:white;'>流量类型</th>"+
									  	"<th style='height:22px;text-align:center;padding-top:10px;font-weight:normal;padding-top:10px;border: 1px white solid;background-color:#71B0E3;color:white;'>网站标识</th>"+
									  	//"<th style='height:22px;text-align:center;padding-top:10px;font-weight:normal;padding-top:10px;border: 1px white solid;background-color:#71B0E3;color:white;'>URL</th>"+
									  	"<th style='height:22px;text-align:center;padding-top:10px;font-weight:normal;padding-top:10px;border: 1px white solid;background-color:#71B0E3;color:white;'>看看多少用户不认可</th></tr>";
						  			
										for(var k=0;k<item.length;k++){
											var detailTotalFlow = parseFloat(item[k]['flow']);
											if (item[k]['flow']=='null') detailTotalFlow = 0;
											var siteFlag = item[k]['siteFlag'];
											if (siteFlag=='未知网站') siteFlag="--";
											totalDetailAppFlow+=detailTotalFlow;
											detail_busi_cont += "<tr><td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'>"+(k+1)+"</td>"+
											//"<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'>"+item[k]['startTime']+"</td>"+
											"<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'>"+fmoney(detailTotalFlow/1,2)+"</td>"+
											"<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'>"+bill_No_Name+"</td>";
											detail_busi_cont +="<td class='siteFlag' style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'>"+siteFlag+"</td>";
										//	"<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'>"+subString(item[k]['detailURL'],30)+"</td>";
							                                                                                                                                                                       
											 detail_busi_cont +="<td style='height:22px;padding-top:7px;border: 1px white solid;background-color: #f2f2f2;'><span id='dealurlflag_accept"+k+"'><a href='#' id='app' style='color:#2A7FD2' onclick='showMultiDetailTagFlag(this,11,\"\","+detailTotalFlow*1024+",\"\",\"\",\"\",\""+item[k]['siteId']+"\","+k+")'><img src='${ctx}/aibi_tas/assets/css/images/AA01.png'/></a></span>&nbsp;&nbsp;&nbsp;&nbsp;<span id='dealurlflag_noaccept"+k+"' onmouseover='showMultiDetailTagMsg(this,3,\"\","+detailTotalFlow*1024+",\"\",\"\",\"\",\""+item[k]['siteId']+"\")'  onmouseout='showUrlTasTotalOff(this);' ><a href='#' id='app2' style='color:#2A7FD2' onclick='showMultiDetailTagFlag(this,12,\"\","+detailTotalFlow*1024+",\"\",\"\",\"\",\""+item[k]['siteId']+"\","+k+")'>                                                     <img src='${ctx}/aibi_tas/assets/css/images/BB01.png'/></a></span></td>";
										    
											detail_busi_cont +="</tr>";
										}
					
					
										detail_busi_cont +="</table><table class='detail_busi' style='border: 1px white solid;height:35px;'>";
										
									//分页====================
									detail_busi_cont+='<tr><td colspan="7" style="border: 1px white solid;padding-top:10px;text-align:left;background-color:#D7D7D7;">&nbsp;&nbsp;&nbsp;&nbsp;';
									if (parseInt(DetailcurrentPage)>1){
									  detail_busi_cont+=' <a href="javascript:getUrlCurrentPage(1)"><img src="${ctx}/aibi_tas/assets/css/images/page_first_a.gif" alt="第一页" /></a>&nbsp;&nbsp;'
									  detail_busi_cont+=' <a href="javascript:getUrlCurrentPage('+(parseInt(DetailcurrentPage)-1)+')"><img src="${ctx}/aibi_tas/assets/css/images/page_pre_a.gif" alt="上一页" /></a>&nbsp;&nbsp;'
								  }else{
										detail_busi_cont+=' <a href="#"><img src="${ctx}/aibi_tas/assets/css/images/page_first_b.gif" alt="第一页" /></a>&nbsp;&nbsp;'
									  detail_busi_cont+=' <a href="#"><img src="${ctx}/aibi_tas/assets/css/images/page_pre_b.gif" alt="上一页" /></a>&nbsp;&nbsp;'
								  }
								  detail_busi_cont+='<img src="${ctx}/aibi_tas/assets/css/images/line.gif"/>&nbsp;&nbsp;第&nbsp;&nbsp;';
								  detail_busi_cont+= DetailcurrentPage +'&nbsp;&nbsp;页/&nbsp;&nbsp;共&nbsp;&nbsp;'+Detailtotalpage+'&nbsp;&nbsp;页&nbsp;&nbsp;';
								  detail_busi_cont+='<img src="${ctx}/aibi_tas/assets/css/images/line.gif"/>&nbsp;&nbsp;';
								    
							  if (Detailtotalpage>parseInt(DetailcurrentPage)){
									  detail_busi_cont+=' <a href="javascript:getUrlCurrentPage('+(parseInt(DetailcurrentPage)+1)+')"><img src="${ctx}/aibi_tas/assets/css/images/page_next_a.gif" alt="下一页" /></a>&nbsp;&nbsp;'
									  detail_busi_cont+=' <a  href="javascript:getUrlCurrentPage('+Detailtotalpage+')"><img src="${ctx}/aibi_tas/assets/css/images/page_last_a.gif" alt="最后一页" /></a>&nbsp;&nbsp;'
								  }else{
										detail_busi_cont+=' <a href="#"><img src="${ctx}/aibi_tas/assets/css/images/page_next_b.gif" alt="下一页" /></a>&nbsp;&nbsp;'
									  detail_busi_cont+=' <a href="#"><img src="${ctx}/aibi_tas/assets/css/images/page_last_b.gif" alt="最后一页" /></a>&nbsp;&nbsp;'
								  }
									detail_busi_cont+='</td></tr>';
				          //==========================
				          
										detail_busi_cont +="</table></div>";
							  
							  		if (this_dialog!=null && this_dialog!=0){
							  			$(this_dialog).dialog('destroy');
							  			}
							
							  	  $('#multi_dialog_div').empty();
							  		$("#multi_dialog_div").append(detail_busi_cont);
			 
			              var tableHoverUrl = "#multi_detail_url";
			              $(tableHoverUrl).find("tr").hover(function(){ $(this).addClass("trHover")}, function(){$(this).removeClass("trHover") });
			
									//  $("#multi_detail_busi").dialog({modal:true, title:'<font color="white">&nbsp;&nbsp;上网明细</font>'+"--测试本页合计:"+(totalDetailAppFlow/1).toFixed(2)+" KB", width:870, height:463, resizable:false, draggable:false,onClose:function(){
       					    $("#multi_detail_busi").dialog({modal:true, title:'<font color="white">&nbsp;&nbsp;上网明细--'+$("#DetailappName").val()+'</font>', width:720, height:403, resizable:false, draggable:false,onClose:function(){
       					    if (detailFlag==1){ 		
       	               detailFlag = 0;  
       	               $(this).dialog('destroy');
       	               this_dialog = null; 
       	            }
       	             closeAllt("fileid_tas");
                    },
                    onOpen:function(){
       					         this_dialog = this;
                    }
                    });
                  
      
							  	}
	
						  		
			  				});
			  			}else{
				  					alert("查询明细出现异常!");
			  				}
			  			
			  			endLoading(); 
			  									  			
			  			}
			  			
				});
  			 
		  }		
		  
//应用分页		  
function getCurrentPage(PageNum){
	if (PageNum=="1"){
		$("#rowNum").val("1");
	}else{
		var pageRowNum = $("#ApppageRowNum").val();
		$("#rowNum").val(parseInt(pageRowNum)*(parseInt(PageNum)-1)+1);
	}
	$("#currentPage").val(PageNum);
	$("#source").val("1");
	showMultiDetailApp();
}  

//明细分页
function getUrlCurrentPage(PageNum){
	if (PageNum=="1"){
		$("#DetailrowNum").val("1");
	}else{
		var pageRowNum = $("#pageRowNum").val();
		$("#DetailrowNum").val(parseInt(pageRowNum)*(parseInt(PageNum)-1)+1);
	}
	$("#DetailcurrentPage").val(PageNum);
	showMultiDetailUrl(2,$("#DetailAppId").val(),'','','');
}

function showTishiMsg(obj,id){
	 
	var text1 = "<span style='color:#FF8201;'>您好，现在智能手机功能很强大，很多</br>情况都可以导致连接网络，比如手机内</br>置软件自动更新或升级都会产生流量，</br>为了避免产生不必要的流量，使用手机</br>时记得关闭自动更新程序，好吗？</span>";
	var text2 = "<span style='color:#FF8201;'>您好，同一时段存在多个上网地址出现</br>是正常的，因为手机同时会有多个应用</br>软件在运行，如您在看新闻的同时也会</br>接收微信的信息、QQ的信息、后台软</br>件更新提示等，都会同时产生流量。</span>";
	var text3 = "<span style='color:#FF8201;'>您有这样感觉是因为上网不是按时间扣</br>费而是根据您浏览的内容计费，另一方</br>面也可能有后台程序或一些恶意软件在</br>您不知情的情况下连接了网络，您可以</br>关闭后台软件或进行恶意软件查杀避免</br>产生不必要的流量，谢谢！</span>";
	var text4 = "<span style='color:#FF8201;'>您好，目前我们系统中记录是您流量产</br>生的应用端，如果使用期间通过链接跳</br>转到其他应用网页或程序并产生流量就</br>会出现您感觉未安装但有使用的情况</br>比如您可通过微博、微信等社交平台观</br>看别人分享的优酷等视频网站内容建议</br>您可通过CXLL发送10086查询流量情况</span>";
	var text5 = "<span style='color:#FF8201;'>尊敬的客户，你好！由于互联网业务种</br>类繁多且更新频繁，因此存在无法匹配</br>上网业务类型的情况，我们将不断完善</br>和增加可识别应用，感谢您的关注与</br>使用。</span>";
	var text6 = "<span style='color:#FF8201;'>您好，连接WIFI后，若WIFI信号</br>不好或锁屏待机的情况下，WIFI会</br>自动断开连接GPRS产生流量，建议</br>您WIFI登录时关闭数据开关，谢谢！</span>";

	 $('#tip').empty();
	 if(id == 1){	$("#tip").html(text1); }
	 if(id == 2){	$("#tip").html(text2); }
	 if(id == 3){	$("#tip").html(text3); }
	 if(id == 4){	$("#tip").html(text4); }
	 if(id == 5){	$("#tip").html(text5); }
	 if(id == 6){	$("#tip").html(text6); }
   
   allt(obj,'fileidTip');
			  					  
}
function showTishiMsgClose(){
	 
	  closeAllt("fileidTip");
			  					  
}

function showUrlTasTotalOff(obj){
	 
	  closeAllt("fileid");
			  					  
}
function selectTasCause(){
	var selectvalue = $('input:radio[name="notre_cause"]:checked').val();
	var returnMoti = "客户不认可该时间段有上网行为";
	if(selectvalue == 1){
		returnMoti = "客户不认可该时间段有上网行为";
	}
	if(selectvalue == 2){
		returnMoti = "客户质疑短时间内有多个上网记录";
	}
	if(selectvalue == 3){
		returnMoti = "客户质疑上网流量使用太快";
	}
	if(selectvalue == 4){
		returnMoti = "客户不认可系统提供的应用名称及网站标识";
	}
	if(selectvalue == 5){
		returnMoti = "系统无法甄别，网站及应用无法显示";
	}
	if(selectvalue == 6){
		returnMoti = "客户质疑使用的WIFI，但产生了上网流量";
	}
	window.returnValue = "2-不认可原因："+returnMoti;//2-不认可
	if (selectvalue==null){
		alert("请选择不认可原因。");
	}else{
	 if (dealflag == 1){
	    showMultiAppTagFlag_execute(save_obj,save_tag_flag,save_appId,save_totalFlow,save_app_Name,save_termId,save_termBrandName,save_times,save_is_accept,selectvalue,save_no);
	}else{
	    showMultiDetailTagFlag_execute(save_obj,save_tag_flag,save_appId,save_totalFlow,save_app_Name,save_termId,save_termBrandName,save_siteId,save_is_accept,selectvalue,save_no);
	 }
	}
}

</script>

	</head>
	<body leftmargin=0 topmargin=0  style="background: url(complainAction!waterMark.ai2do?userId=<%=user%>) repeat 0 0;">
		<input type="hidden" id="timeIndex" name="timeIndex" value="R"/>
		<input type="hidden" id="charge_id" name="charge_id" value="<%=charge_id%>"/>
		<input type="hidden" id="flow" name="flow" value="<%=flow%>"/>
		<input type="hidden" id="bill_No" name="bill_No" value="<%=billNo%>"/>
		<input type="hidden" id="bill_No_Name" name="bill_No_Name" value="<%=billNo%>"/>
		<input type="hidden" id="userId" name="userId" value="<%=user%>"/>
		<input type="hidden" id="txtSearchTimeBegin" name="txtSearchTimeBegin" value="<%=startTime%>"/>
		<input type="hidden" id="txtSearchTimeEnd" name="txtSearchTimeEnd" value="<%=endTime%>"/>
		<!--app-->
		<input type="hidden" id="rowNum" name="rowNum" value="1"/>
		<input type="hidden" id="ApppageRowNum" name="APPpageRowNum" value="15"/>
		<input type="hidden" id="currentPage" name="currentPage" value="1"/>
		<input type="hidden" id="source" name="source" value=""/>
		<!---->
		
		<!--detail-->
		<input type="hidden" id="pageRowNum" name="pageRowNum" value="10"/>
		<input type="hidden" id="DetailrowNum" name="DetailrowNum" value="1"/>
		<input type="hidden" id="DetailcurrentPage" name="DetailcurrentPage" value="1"/>
		<input type="hidden" id="DetailAppId" name="DetailAppId" value=""/>
		<input type="hidden" id="DetailappName" name="DetailappName" value=""/>
		<input type="hidden" id="DetailFlowSum" name="DetailFlowSum" value=""/>
		<input type="hidden" id="detailMinTime" name="detailMinTime" value=""/>
		<input type="hidden" id="detailMaxTime" name="detailMaxTime" value=""/>
		<!---->
		
		  <div >
		 	 <table  style="background:url(images/search_bg.png) #225783 repeat-x 50% 50%;border: 1px white solid;">
		 	 <tr>
		 	 	
		 	 	<td width="100%" height="32px;"  style="padding: 8px 0px 2px 0px;>
					<span class="phoneNo_td" style="margin-left:30px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;<font style="color:white;">电话号码：</font>&nbsp;</span>
					<input id="phoneNo" name="phoneNo" type="text" class="font_input" readonly style="background-color:#FF953F;color:white;border: 1px #9E9E9E solid;height:22px; line-height:22px;" value="<%=phoneNo%>" />
		 	 		<span  style="margin-left:20px;color:white;">时间段：&nbsp;</span>
		 	 			<span id="startTime" style='color:#F0F61C'>
							   <%=startTime%>
					  </span>
					  <span style='color:#F0F61C;margin-top:-22px;'>&nbsp;--&nbsp;</span>
		 	 			<span id="endTime" style='color:#F0F61C'>
							   <%=endTime%>
					  </span>
					  <span  style="margin-left:20px;color:white;">计费流量：&nbsp;</span>
					  <span id="TotalFlow" style='color:#F0F61C'><!--显示计费侧传来的值-->
							     0
					  </span><font color="#F0F61C">&nbsp;MB</font>
					  <span  style="margin-left:20px;color:white;">流量类型：&nbsp;</span>
					  <span id="divSearchTimeBegin" style='color:#F0F61C'>
							   <%if(billNo.equals("gg"))%>2G忙时流量
							  　<%if(billNo.equals("ga"))%>2G闲时流量
							  <%if(billNo.equals("gh"))%>３G忙时流量
							  <%if(billNo.equals("gb"))%>３G闲时流量
							  <%if(billNo.equals("gi"))%>４G忙时流量
							  <%if(billNo.equals("gc"))%>４G闲时流量
							  <%if(billNo.equals("multiSystem"))%>多种数据流量
					  </span>
						</td>
				</tr>
				</table>
				
		   </div>
		<div id="container" style="text-align:center;"><!--background-color: #FFFFFF;-->
			<div id="phoneBill_div" style="width:99.25%;text-align:center;">
			</div>
			
			<div id="busi_collect_div" style="display: none;">
				
			</div>

			<div id="dialog_div" style="display: none;">
				
			</div>
			
			<div id="multi_dialog_div" style="display: none;border: 1px white solid;"></div>
			
		</div>


		<!-- 弹出框 -->
	<div class="tabBlock">
  <div class="toolbar">&nbsp;
     <div id="fileid" style="z-index:9999; display:none;position:absolute; background-color:#F2F2F2; border:#DBDBDB 1px solid; white-space:nowrap; padding:10px;">
        <div id="popupcontent"></div>
      
       
    </div>
  </div>
</div>

 				<div class="overlay" > <div id="AjaxLoading" class="loadingWord" style="text-align:center;"><img src="${ctx}/aibi_tas/assets/css/images/waiting.gif" style="margin-top:8px;">&nbsp;&nbsp;数据加载中，请稍候...</div></div>

	<!-- 弹出框 -->

<div class="tabBlock">
  <div class="toolbar">&nbsp;
  	  <div id="fileidTip" style="z-index:29999; display:none;position:absolute; background-color:#FFFFFF; border:#DBDBDB 1px solid; white-space:nowrap; padding:10px;margin-left:65px;margin-top:10px;width:200px;height: 99px;font-size:14px;">
        <div id="tip"></div>
      
    </div>
      <div id="fileid_tas" style="z-index:9999; display:none;position:absolute; background-color:#F2F2F2; border:#DBDBDB 1px solid; white-space:nowrap; padding:10px;width:250px;font-size:14px;">
        <div style="background-color:#D7D7D7;height:34px;line-height:34px;font-size:14px;margin-top:-10px;margin-left:-10px;margin-right:-10px;">
        	<span style="font-size:14px;">不认可原因</span> 
        	<span style="margin-top:5px;margin-right:5px;float:right;">
        		<img src="${ctx}/aibi_tas/assets/css/images/close.gif" width="16" height="16" onclick="closeAllt('fileid_tas')" />
          </span> 
       </div>
       <table style="margin-left:8px;margin-top:20px;text-align: left;">
       <tr  style="height: 30px;"><td ><input type="radio" id="notre_cause1"  name="notre_cause" checked value="1"/>&nbsp;&nbsp;<span onmouseover="showTishiMsg(this,1);" onmouseout="showTishiMsgClose();">客户不认可该时间段有上网行为</span></td></tr>
        <tr  style="height: 30px;" ><td><input type="radio"  id="notre_cause2"  name="notre_cause" value="2"/>&nbsp;&nbsp;<span onmouseover="showTishiMsg(this,2);" onmouseout="showTishiMsgClose();">客户质疑短时间内有多个上网记录</span></td></tr>
        <tr  style="height: 30px;" ><td><input type="radio"  id="notre_cause3"  name="notre_cause" value="3"/>&nbsp;&nbsp;<span onmouseover="showTishiMsg(this,3);" onmouseout="showTishiMsgClose();">客户质疑上网流量使用太快</span></td></tr>
        <tr  style="height: 30px;" ><td><input type="radio"  id="notre_cause4"  name="notre_cause" value="4"/>&nbsp;&nbsp;<span onmouseover="showTishiMsg(this,4);" onmouseout="showTishiMsgClose();">客户不认可系统提供的应用名称及网站标识</span></td></tr>
         <tr  style="height: 30px;" ><td><input type="radio"  id="notre_cause5"  name="notre_cause" value="5"/>&nbsp;&nbsp;<span onmouseover="showTishiMsg(this,5);" onmouseout="showTishiMsgClose();">系统无法甄别，网站及应用无法显示</span></td></tr>
        <tr  style="height: 30px;" ><td><input type="radio"  id="notre_cause6"  name="notre_cause" value="6"/>&nbsp;&nbsp;<span onmouseover="showTishiMsg(this,6);" onmouseout="showTishiMsgClose();">客户质疑使用的WIFI，但产生了上网流量</span></td></tr>
         </table>
         
         <div style="margin-bottom:12px;margin-top:8px;">
         	<a href="javascript:selectTasCause();">
          	<img src="${ctx}/aibi_tas/assets/css/images/tas_ok.png">
          </a>
         	</div>
       
    </div>
  </div>
</div>
	</body>
</html>

<%}else{ 
	 System.out.println("传入的参数不正确(ailk_autoLogin_userId,charge_id,phoneNo,billNo,flow,startTime和endTime不能为空)!");
	 System.out.println("传入的参数:");
	 System.out.println("ailk_autoLogin_userId===="+user);
	 System.out.println("charge_id===="+charge_id);
	 System.out.println("phoneNo===="+phoneNo);
	 System.out.println("startTime===="+startTime);
   System.out.println("endTime===="+endTime);
    System.out.println("flow===="+flow);
	 System.out.println("billNo===="+billNo);
	 String errormsg = "";

	 	//if (charge_id==null){
	  // errormsg = "charge_id";
	// }
	 if (phoneNo==null){
	   if (errormsg.equals("")){
	     errormsg ="phoneNo";
	  }else{
	     errormsg =errormsg +  ",phoneNo";
	   }
	 }
	 if (startTime==null){
	  if (errormsg.equals("")){
	     errormsg ="startTime";
	  }else{
	     errormsg =errormsg +  ",startTime";
	   }
	 }
	 if (endTime==null){
	   if (errormsg.equals("")){
	     errormsg ="endTime";
	  }else{
	     errormsg =errormsg +  ",endTime";
	   }
	 }
	 	 if (flow==null){
	   if (errormsg.equals("")){
	     errormsg ="flow";
	  }else{
	     errormsg =errormsg +  ",flow";
	   }
	 }

	%>
	<html>
	<head>
 
	</head>
	<body>
			<div style="margin-top:50px;text-align:center;color:#00448b;font-size:12px;">
        传入的参数不正确(<%=errormsg%>不能为空)!
        <!--(ailk_autoLogin_userId,priv,phoneNo,startTime和onlineDur不能为空)-->
		</div>
	</body>
</html>
<%}%>
