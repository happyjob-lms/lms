<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>설문조사</title>
<!-- sweet alert import -->
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<!-- sweet swal import -->

<script type="text/javascript">

	var pagesize = 5;
	var pageblocksize = 10;
   
	/** OnLoad event */ 
	$(function(){            
		surveyList();
	});
	
	function surveyList(cpage){
		
		cpage = cpage || 1;
		
		var param = {
				searchLectureName : $("#searchLectureName").val(),
				userNo : $("#userNo").val(),
				cpage : cpage,
				pagesize : pagesize
		}
		
		var listcallback = function(response){

			$("#lectureListBody").empty().append(response);
			
			var paginationHtml = getPaginationHtml(cpage, $("#listcnt").val(), pagesize, pageblocksize, 'surveyList');
			console.log("paginationHtml : " + paginationHtml);
			
			$("#lectureListPagination").empty().append(paginationHtml);
			
			$("#cpage").val(cpage);
		}
		
		callAjax("/tut/pfsLectureList.do", "post", "text" , false, param, listcallback);
		
	}
	
	function lectureStdList(lec_no, currentPage){
		
		currentPage = currentPage || 1;
		
		var param = {
				lec_no : lec_no,
				currentPage : currentPage,
				pagesize : pagesize
		}
		
		var listcallback = function(response){

			$("#lectureStdBody").empty().append(response);
			
			var paginationHtml = getPaginationHtml(currentPage, $("#listcnt").val(), pagesize, pageblocksize, 'lectureStdList');
			console.log("paginationHtml : " + paginationHtml);
	
			$("#lectureStdPagination").empty().append( paginationHtml );
			
			$("#lecno").val(lec_no);
		}	
		
		callAjax("/tut/lectureStdList.do", "post", "text" , false, param, listcallback);
	}
	
	function newreg() {
		
		alert($("#lecno").val());
		
		var param = {
			lecno : $("#lecno").val()				
		}
		
		var listcallback = function(response){
			console.log(JSON.stringify(response));
			
	        drawChart(response.listData);
	        
			gfModalPop("#layer1");
		}
		
		callAjax("/tut/statisticsList.do", "post", "json" , false, param, listcallback);
		
	}
	
</script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);

      function drawChart(response) {

       
        
        var chardata = [['Task', 'Hours per Day']];
        
        
        $.each(response, function(key, value){
        	
            console.log('select_num:' + value.select_num + ' / ' + 'value:' + value.cnt);
            var snum = value.select_num;
            var svalue = value.cnt;
            	
            chardata.push([snum.toString()+ '점',svalue]);
            
        });
        
        var makedata = google.visualization.arrayToDataTable(chardata);

        var options = {
          title: '차트?'
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

        chart.draw(makedata, options);
      }
</script>

</head>
<body>
	
	<input type="hidden"  id="userNo"  name="userNo"  value="${userNo}" />
	<input type="hidden"  id="lecno"  name="lecno"  value="" />
	
	<!-- 모달 배경 -->
	<div id="mask"></div>

	<div id="wrap_area">

		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> <jsp:include
						page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> <!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">

						<p class="Location">
							<a href="../dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<span class="btn_nav bold">커뮤니티</span> 
							<span class="btn_nav bold">설문조사관리</span>
								<a href="../adm/surveyControl.do" class="btn_set refresh">새로고침</a>
						</p>

						<p class="conTitle">
							<span>나의 강의</span>
							<span class="fr">
							<!-- <select id="areasel" name="areasel"></select> -->						
								강 의 명
								<input type="text" id="searchPfsName" name="searchLectureName" />
								<a class="btnType red" href="javascript:surveyList()" name="searchbtn"  id="searchbtn"><span>검색</span></a>
							</span>
						</p>
       
						<div class="divList">
							<table class="col">
								<caption>caption</caption>
								<colgroup>
									<col width="30%">
									<col width="20%">
									<col width="20%">
									<col width="30%">
								</colgroup>
	
								<thead>
									<tr>
										<th scope="col">강의명</th>								
										<th scope="col">강의 시작일</th>
										<th scope="col">강의 종료일</th>
										<th scope="col">수강인원 / 최대인원</th>
									</tr>
								</thead>
								<tbody id="lectureListBody"></tbody>
							</table>
						</div>
						
						<div class="paging_area"  id="lectureListPagination"> </div>
						
						<p class="conTitle mt10">
							<span>수강학생 목록</span>
							<a class="btnType blue" href="javascript:newreg();" name="modal"><span>설문조사 통계</span></a>
						</p>
						<div class="lectureList" id="lectureList">
							<table class="col">
									<caption>caption</caption>
									<colgroup>
										<col width="10%">
										<col width="40%">
										<col width="40%">
										<col width="10%">
									</colgroup>
								<thead>
									<tr>
										<th scope="col">학생번호</th>
										<th scope="col">학생명</th>
										<th scope="col">전화번호</th>
										<th scope="col">설문조사 여부</th>
									</tr>
								</thead>
								<tbody id="lectureStdBody">
									<tr>
										<td colspan="12">강의명을 선택해 주세요.</td>
									</tr>
								</tbody>
							</table>
							<div class="paging_area" id="lectureStdPagination"></div> 
						</div>
						
						
						
					</div> 
					
					 
					
				</li>
			</ul>
		</div>
	</div>
	
	<div id="layer1" class="layerPop layerType2" style="width: 600px;">
		<dl>
			<dt>
				<strong>설문조사 통계</strong>
			</dt>
			<dd class="content">
				<!-- s : 여기에 내용입력 -->
				<table class="row">
					<caption>caption</caption>
					<colgroup>
						<col width="120px">
						<col width="*">
						<col width="120px">
						<col width="*">
					</colgroup>

					<tbody>
						<div id="piechart" style="width: 900px; height: 500px;"></div>	
					</tbody>
				</table>

				<!-- e : 여기에 내용입력 -->

				<div class="btn_areaC mt30">
					<a href=""	class="btnType gray"  id="btnClose" name="btn"><span>닫기</span></a>
				</div>
			</dd>
		</dl>
		<a href="" class="closePop"><span class="hidden">닫기</span></a>
	</div>

	
</body>
</html>