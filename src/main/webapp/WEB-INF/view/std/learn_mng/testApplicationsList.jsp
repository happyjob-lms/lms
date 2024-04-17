<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>학생수강목록</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<style type="text/css">

</style>
<script type="text/javascript">

//과제목록페이지
var pageSize = 9;
var pageBlockSize = 5;

$( function(){

	lecList();

});

//메인 리스트 callAjax
function lecList(currentPage){

		
		currentPage = currentPage || 1;
		
		var param = {
				currentPage : currentPage,
				pageSize : pageSize,
		}
		
		
		function listcallback(response){	
			//alert(response);
			console.log(response);
			
			$("#registerListBody").empty().append(response);
			
			var paginationHtml = getPaginationHtml(currentPage, $("#listcnt").val(), pageSize, pageBlockSize, "lecList");
			console.log("paginationHtml : " + paginationHtml);

			$("#registerListPagination").empty().append(paginationHtml);

			$("#currentPage").val(currentPage); 
		}
		
	
	callAjax("/std/testApplicationsListBody.do", "post", "text", false, param, listcallback)
}



//메인 리스트 callAjax
function testApplicationsList(lec_no, currentPage, searchStatus){
	
	currentPage = currentPage || 1;
	
	var param = {
			lec_no : lec_no,
			searchStatus : $("#searchStatus").val(),
			currentPage : currentPage,
			pageSize : pageSize,
	}
	
	function listcallback(response){	
		//alert(response);
		console.log(response);
		
		$("#testApplicationListBody").empty().append(response);
		
		var paginationHtml = getPaginationHtml(currentPage, $("#testListCnt").val(), pageSize, pageBlockSize, "testApplicationsList");
		console.log("paginationHtml : " + paginationHtml);

		$("#testApplicationsPagination").empty().append(paginationHtml);

		$("#currentPage").val(currentPage); 
	}
	
	callAjax("/std/testApplicationsDetail.do", "post", "text", false, param, listcallback);
}

function applyTest(test_no){
	//alert("시험 응시");
	$("#test_no").val(test_no);
	
	var param = {
			test_no : test_no,
	}
	
	function listcallback(response){	
		//alert(response);
		console.log(response);
		
		$("#testDetailBody").append(response);
		 
	}
	
	callAjax("/std/testApplicationsTestDetail.do", "post", "text", false, param, listcallback);
	
	gfModalPop("#test_modal");
}

//시험 제출하기
/* function btnSaveTestAnswer(){
	//alert(answerValidation());
	//alert(answerValidation() != false);
	if(answerValidation() == true){
		// 선택된 답안을 담을 배열
	    var selectedAnswers = [];
	    var selectedTestQueNo = [];
	    
	    
	    // 각 라디오 버튼을 순회하며 선택된 값을 수집
	    $('input[type="radio"]:checked').each(function() {
	        var answerValue = $(this).val(); // 선택된 답안의 값
	        //var questionIndex = $(this).attr('name').replace('test_ans[', '').replace(']', ''); // 질문의 인덱스
	        
	        // 선택된 답안과 질문의 인덱스를 객체로 만들어 배열에 추가
	        selectedAnswers.push(answerValue);
	    });
	    
	
	 	// 각 라디오 버튼을 순회하며 선택된 값을 수집
	    $('input[name="test_que_no"]').each(function() {
	        selectedTestQueNo.push($(this).val());
	    });
		
	 	//alert("test check ::"+ JSON.stringify(selectedTestQueNo));
	 	//alert("test selectedAnswers check ::"+ JSON.stringify(selectedAnswers));
	 	
	 	var selectedAnswersStr = JSON.stringify(selectedAnswers);
	 	var selectedTestQueNoStr = JSON.stringify(selectedTestQueNo);
	 	
	 	
		var param = {
				student_answer: selectedAnswersStr,
				test_no : $("#test_no").val(),
				test_que_no : selectedTestQueNoStr,
		}
		
		
		function resultCallback(response){
			//alert(JSON.stringify(response));
			gfModalClose("#test_modal")
		}
		
		callAjax("/std/testDetailUpdate.do", "post", "json", true, param, resultCallback);
	}
	
	
} */

function btnSaveTestAnswer(){
    if(answerValidation() == true){
        var selectedAnswers = [];
        var selectedTestQueNo = [];

        // 각 질문의 test_que_no와 선택된 답안을 수집
        $('input[type="hidden"][name="test_que_no"]').each(function() {
            var testQueNo = $(this).val(); // 현재 질문의 번호
            var $parentRow = $(this).closest('tr'); // 현재 숨겨진 입력란이 있는 행
            var $prevRows = $parentRow.prevAll(); // 현재 행 이전의 모든 행

            // 현재 질문에 대한 선택된 답안 찾기
            var selectedAnswer = null;
            $prevRows.each(function() {
                var $radio = $(this).find('input[type="radio"][name^="test_ans"]');
                if($radio.length > 0 && $radio.is(':checked')) {
                    selectedAnswer = $radio.val();
                    return false; // 선택된 답안을 찾았으므로 반복 중지
                }
            });

            if(selectedAnswer !== null) { // 선택된 답안이 있는 경우
                selectedAnswers.push(selectedAnswer);
                selectedTestQueNo.push(testQueNo);
            }
        });

        var param = {
            student_answer: JSON.stringify(selectedAnswers),
            test_que_no: JSON.stringify(selectedTestQueNo),
            test_no : $("#test_no").val(),
        }

        function resultCallback(response){
            gfModalClose("#test_modal")
        }

        callAjax("/std/testDetailUpdate.do", "post", "json", true, param, resultCallback);
    }
}

function answerValidation() {
    var allAnswersSelected = true; // 모든 답안이 선택되었는지 여부를 나타내는 변수
    var unansweredQuestions = []; // 답변이 선택되지 않은 질문 번호를 저장할 배열

    // 각 라디오 버튼을 순회하며 선택된 값을 확인
    $('input[type="radio"]').each(function() {
        var questionIndex = $(this).attr('name').replace('test_ans[', '').replace(']', ''); // 질문의 인덱스
        if (!$('input[name="test_ans[' + questionIndex + ']"]:checked').val()) {
            unansweredQuestions.push(parseInt(questionIndex) + 1); // 질문 번호 추가
            allAnswersSelected = false;
        }
    });

    // 답변이 선택되지 않은 질문이 있는 경우 alert 출력
    if (unansweredQuestions.length > 0) {
        alert("모든 질문에 대해 답안을 선택해주세요.");
    }

    // 모든 답변이 선택되었는지 여부 반환
    return allAnswersSelected;
}


</script>
</head>
<body>
<form id="myForm" action=""  method="">
	<input type="hidden" id="currentPage" value="1">
	<input type="hidden" id="test_no" value="">
	
	<!-- <input type="hidden" id="lec_id"> -->
	<!-- 모달 배경 -->
	<div id="mask"></div>
	<div id="wrap_area">
		<h2 class="hidden">header 영역</h2>
		<jsp:include page="/WEB-INF/view/common/header.jsp"></jsp:include>

		<h2 class="hidden">컨텐츠 영역</h2>
		<div id="container">
			<ul>
				<li class="lnb">
					<!-- lnb 영역 --> 
					<jsp:include page="/WEB-INF/view/common/lnbMenu.jsp"></jsp:include> 
					<!--// lnb 영역 -->
				</li>
				<li class="contents">
					<!-- contents -->
					<h3 class="hidden">contents 영역</h3> <!-- content -->
					<div class="content">
						<p class="Location">
							<a href="/dashboard/dashboard.do" class="btn_set home">메인으로</a> 
							<a href="javascript:void(0)" class="btn_nav">학습 관리</a> 
							<span class="btn_nav bold">시험 응시</span> 
							<a href="/std/testApplications.do" class="btn_set refresh">새로고침</a>
						</p>
						<br/>
						<div class="conTitle">
							
						</div>
						
						
						<div class="testApplicationList" id="registList">
							<table class="col" id="title">
								<caption>caption</caption>
								<colgroup>
								    <col width="30%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">과정명</th>
										<th scope="col">강사</th>
										<th scope="col">강의 기간</th>
										<th scope="col">강의실</th>										
									</tr>
								</thead>
							<tbody id="registerListBody"></tbody>
							</table>
							<div class="paging_area"  id="registerListPagination"></div>
							<br/><br/><br/>	
							
							<table class="col" id="titleDetail">
								<caption>caption</caption>
								<colgroup>
								    <col width="30%">
									<col width="20%">
									<col width="20%">
									<col width="10%">
								</colgroup>
	
								<thead>
									<tr>
									    <th scope="col">시험명</th>
										<th scope="col">시험명</th>
										<th scope="col">구분</th>
										<th scope="col">상태</th>
										<th scope="col">시험응시</th>
									</tr>
								</thead>
								<tbody id="testApplicationListBody"></tbody>				
								
							</table>
							<!-- <div class="paging_area"  id="testApplicationsPagination"></div> -->
							
							
						</div>
					</div>
				<h3 class="hidden">풋터 영역</h3>
					<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>		
		</div>
	</div>
</form>

<!-- 설문조사 모달팝업시작 -->
<form id="modalForm">
	<input type="hidden" id="currentPage" name="currentPage" value="1" />
	<input type="hidden" id="lec_no" name="lec_no" value="${lec_no}" />
	<input type="hidden" id="que_no" name="que_no" value="${que_no}" />
	<input type="hidden" id="user_no" name="user_no" value="${user_no}" />
  <div id="test_modal" class="layerPop layerType2" style="width: 800px; ">
     <dl>
     	<dt>
			<strong>시험응시</strong>
		</dt>
        <dd class="content" >
           <!-- s : 여기에 내용입력 -->
           <div class="sidescroll" style="height:700px; overflow: auto !important;">
           <table class="row" id="testQue">
           	<caption>caption</caption>
           
           	<tbody>
           		
           		<tr>
           			<th scope="row">시험명</th><td colspan="4">1주차 quiz</td>           			
           		</tr>
           		<tr>           	 	
           	 		<th scope="row">강의이름</th><td><span>자바</span></td>
           	 		<th scope="row">강사명</th><td><span>김강사</span></td>
           	 	</tr>
           		<tr>
           			<th scope="row" colspan="6">시험문제</td>
           		</tr>
           		
           		
           		</tbody>
            </table>
            <table>
            	<tbody id="testDetailBody"></tbody>
            </table>
          
		  </div>
          <!--  <div class="paging_area" id="Pagination_svy"></div> -->
           <!-- e : 여기에 내용입력 -->
           <div class="btn_areaC mt30">
              <a href="javascript:btnSaveTestAnswer()" class="btnType blue" id="btnSaveTestAnswer" name="btn"><span>답안 제출</span></a> 
              <a href="" class="btnType gray" id="btnClose" name="btn"><span>닫기</span></a>
           </div>
        </dd>
     </dl>
     <a href="" class="closePop"><span class="hidden">닫기</span></a>
  </div>
  </form> 
<!-- 모달팝업끝 -->

</body>
</html>