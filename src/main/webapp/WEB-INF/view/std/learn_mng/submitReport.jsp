 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>과제 제출</title>
<jsp:include page="/WEB-INF/view/common/common_include.jsp"></jsp:include>
<style type="text/css">
.cursor{
	cursor: pointer;
}
</style>
<script type="text/javascript">
//과제목록페이지
var pageSize = 5;
var pageBlockSize = 5;
/** OnLoad event */
$(document).ready(function() {
	// 강의목록 조회
	$("#homework").hide();
	freportList(); // jquery
	//버튼이벤트
	fRegisterButtonClickEvent()
});

/** 버튼 이벤트 등록 */
function fRegisterButtonClickEvent() {
	$('a[name=btn]').click(function(e) {
		e.preventDefault();

		var btnId = $(this).attr('id');

		switch (btnId) {
			case 'btnSaveHwk' :
				fSaveHwk();
				break;
			case 'btnUpdateHwk' :
				fSaveHwk();
				break;
			case 'btnDeleteHwk' :
				fDeleteHwk();
				break;
			case 'btnClose' :
				gfCloseModal();
				break;
		}
	});
}

//강의 목록 조회 ajax --jquery
function freportList(currentPage){
		
	currentPage = currentPage || 1;
	var param = {
			currentPage : currentPage,
			pageSize : pageSize
		}
	
	
	var resultCallback = function(data) {
	
		freportList_result(data, currentPage);
	};
	//Ajax실행 방식
	//callAjax("Url",type,return,async or sync방식,넘겨준거,값,Callback함수 이름)
	callAjax("/std/selReportList.do", "post", "text", true, param, resultCallback);
}
//ajax 콜백 함수 --jquery
function freportList_result(data, currentPage){
	//console.log("jquery : " + data);
	//console.log("학생 제출 과제 여부 "+ data.hwk_id_sub);
	// 기존 목록 삭제 후 생성
 	$('#selReportList').empty().append(data);
	// totalCount 값 가져오기
	var totalCount = $("#totalCount").val();
	
	// 페이지 네비게이션 생성
	var paginationHtml = getPaginationHtml(currentPage, totalCount, pageSize, pageBlockSize, 'freportList');
	$("#Pagination_hwk").empty().append( paginationHtml );
}

/* row클릭 시 이벤트 발생 -- 입력div 보이기*/
function fshowSubModal(task_id, lec_no) {
    console.log("과제 NO : " + task_id);
//     console.log("유저 NO : " + user_no);
    var param = {
        task_id: task_id,
        lec_no: lec_no
    };
    var resultCallback = function(data) {
        fhwkreportList_modal(data);
    };
	callAjax("/std/choiceReportList.do", "post", "json", true, param, resultCallback);
	
}
//모달 callback함수
function fhwkreportList_modal(data){
	console.log(JSON.stringify(data));
	gfModalPop("#homework"); //모달 열기
	document.getElementById("sub_content").value = null; //입력값 비우기

		frealPopModal(data);  
	
}
//(모달) 과제 입력 - 수정 
function frealPopModal(object){
		var choiceReportList = object.choiceHwkList;
		 $("#task_id").val(choiceReportList.task_id);
		 if(choiceReportList.sub_content =="" || choiceReportList.sub_content == null || choiceReportList.sub_content == undefined){
			 $("#action").val("I");
			 $("#lec_no").text(choiceReportList.lec_nm);
			 $("#tutor_name").text(choiceReportList.tutor_name);
		     $("#user_no").text(choiceReportList.user_no); //
			 $("#task_name").text(choiceReportList.task_name);
			 $("#task_content").text(choiceReportList.task_content);
			 $("#sub_content").text("");
			 $("#file_name").val("");
// 			 $("#user_no").text(choiceReportList.user_no);
			
			 $("#btnDeleteHwk").hide(); // 삭제버튼 숨기기
			 $("#btnUpdateHwk").hide();
			 $("#btnSaveHwk").show();
		 }else{
			 $("#action").val("U");
			 $("#lec_no").text(choiceReportList.lec_nm);
			 $("#tutor_name").text(choiceReportList.tutor_name);
		     $("#user_no").text(choiceReportList.user_no); //
			 $("#task_name").text(choiceReportList.task_name);
			 $("#task_content").text(choiceReportList.task_content);
			 $("#sub_content").val(choiceReportList.sub_content);
			 $("#file_name").val(choiceReportList.sub_filename);
// 			 $("#user_no").text(choiceReportList.user_no);
			 
			 $("#btnDeleteHwk").show(); // 삭제버튼 보이기
			 $("#btnUpdateHwk").show(); 
			 $("#btnSaveHwk").hide();	
		 }
}
//최종 진행 전 확인
function fsaveinfo(){
	//submit_con 유무로 저장/수정 판단하기
	if($("#action").val() == 'I'){
		if(confirm('저장 하시겠습니까?') == false){
			return false;
		} else {
			return true;
		}
	}else if($("#action").val() == 'U'){
		if(confirm('내용을 수정 하시겠습니까?') == false){
			return false;
		} else {
			return true;
		}
	}
}

function fSaveHwk(){
	if(fsaveinfo(true)) {
		ffileuplaod();
	}
}

//파일 업로드
function ffileuplaod(){
	var frm = document.getElementById("modalForm");
	frm.enctype = 'multipart/form-data';
	var fileData = new FormData(frm);
	var resultCallback = function(data) {
		fSaveDataResult(data);
	};
	callAjaxFileUploadSetFormData("/std/saveReport.do", "post", "json", true, fileData, resultCallback);
}
/** 데이터 저장 콜백 함수 */
function fSaveDataResult(data) {
	if (data.result == "SUCCESS") {
		$("#bbs_files_1").val("");	// 첨부파일
		gfCloseModal();
		freportList();
	} else {
		// 오류 응답 메시지 출력
		alert(data.resultMsg);
	}
}
//업로드시 input 태그 이름생성
$(document).ready(function(){
	  var fileTarget = $('.filebox .upload-hidden');

	    fileTarget.on('change', function(){
	        if(window.FileReader){
	            var filename = $(this)[0].files[0].name;
	        } else {
	            var filename = $(this).val().split('/').pop().split('\\').pop();
	        }
	        $(this).siblings('.upload-name').val(filename);
	    });
	}); 
/* 파일 업로드 end */

/** 게시글 삭제 */
function fDeleteHwk(id) {
	id = id || $('#task_id').val();
	var param = { task_id : id};
	
	var resultCallback = function(data) {
		fDeleteDataResult(data);
	};
	
	callAjax("/std/deleteHwk.do", "post", "json", true, param, resultCallback);
}

function fDeleteDataResult(data){
	//var currentPage = $("#currentPageTarget").val();
	if (data.result == "SUCCESS") {
		// 응답 메시지 출력
		alert(data.resultMsg);
		// 목록 조회
		gfCloseModal();
		freportList();
	} else {
		alert(data.resultMsg);
	}	
}

function ffiledownload(task_id,lec_no){
	
	
    $("#task_id").val(task_id);

	
	
        var params = "<input type='hidden' name='task_id' value='"+ task_id +"' />";
        params += "<input type='hidden' name='lec_no' value='"+ lec_no +"' />";
        $("<form action='downloadHwk.do' method='post' id='fileDownload'>" + params + "</form>").appendTo('body').submit().remove();
        alert("다운로드 했습니다.");
        }

</script>
</head>
<body>
<form id="myForm" action=""  method="">
<input type="hidden" id="currentPage" value="1">
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
							<a href="" class="btn_set home">메인으로</a> <a href=""
								class="btn_nav">학습 관리</a> <span class="btn_nav bold">과제 제출</span><a href="" class="btn_set refresh">새로고침</a>
						</p>
						<p class="conTitle">
							<span>과제 제출</span>
						</p>
						<div class="div_reportlist" id="div_reportlist">
							<table class="col" id="reportlist">
								<caption>caption</caption>
									<colgroup>
										<col width="5%">
									    <col width="15%">
										<col width="20%">
										<col width="10%">
										<col width="15%">
										<col width="5%">
									</colgroup>
								<thead>
									<tr>
									    <th scope="col">번호</th>
									    <th scope="col">강의명</th>
									    <th scope="col">과제명</th>
										<th scope="col">강사</th>
										<th scope="col">기간</th>
										<th scope="col">첨부파일</th>										
									</tr>
								</thead>
								<tbody id="selReportList">
								</tbody>
							</table>
							<div class="paging_area" id="Pagination_hwk"></div>
						</div>

					</div> <!--// content -->
						<h3 class="hidden">풋터 영역</h3>
						<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>
				</li>
			</ul>		
		</div>
	</div>
</form>
  <!-- 모달팝업 -->
 <form id="modalForm">
  <div id="homework" class="layerPop layerType2" style="width: 1000px;">
     <input type="hidden" name="task_id"  id="task_id" > <!-- 수정시 필요한 hwk_id 값을 넘김  -->
   	<input type="hidden" name="action" id="action" value="">
   	<input type="hidden" name="user_no" id="user_no" >
     <dl>
     	<dt>
			<strong>과제</strong>
		</dt>
        <dd class="content">
           <!-- s : 여기에 내용입력 -->
           <table class="row">
              <caption>caption</caption>
	         <tbody style=“overflow-X:hidden”>    
	             <tr>
	             	<th scope="row">과목명 </th>
					<td colspan="3" id="lec_no"></td>
	             	<th scope="row">강사명 </th>
					<td colspan="3" id="tutor_name" ></td>
				</tr>
				<tr>
	             	<th scope="row">과제명 </th>
					<td colspan="6" id="task_name">
					</td>
				</tr>
				<tr>
	             	<th scope="row">과제내용 </th>
					<td colspan="6">
						<textarea class="inputTxt p100" name="task_content" id="task_content" style="width:100%; border:0; resize:none;" readonly></textarea>
					</td>
				</tr>
				<tr>
	             	<th scope="row">내용 </th>
					<td colspan="6">
						<textarea class="inputTxt p100" name="sub_content" id="sub_content" placeholder="내용을 입력하세요" style="resize: none;"></textarea>
					</td>
				</tr>
	          	<tr>
					<th scope="row">첨부파일</th>
					<td colspan="6">
						<div class="filebox bs3-primary">
						<input class="upload-name" id="file_name" name="file_name" style="height:20px;"> 
						<input type="file"  name="bbs_files_1" id="bbs_files_1" class="upload-name">
						</div>
					</td>
				</tr>
       		</tbody> 
          </table>
           <!-- e : 여기에 내용입력 -->
           <div class="btn_areaC mt30">
              <a href="javascript:fsaveinfo();" class="btnType blue" id="btnSaveHwk" name="btn"><span>저장</span></a> 
              <a href="" class="btnType blue" id="btnUpdateHwk" name="btn" style="display:none"><span>수정</span></a> 
              <a href="" class="btnType blue" id="btnDeleteHwk" name="btn"><span>삭제</span></a> 
              <a href="" class="btnType gray" id="btnClose" 	name="btn"><span>닫기</span></a>
           </div>
        </dd>
     </dl>
     <a href="" class="closePop"><span class="hidden">닫기</span></a>
  </div>
  </form> 
</body>
</html> 