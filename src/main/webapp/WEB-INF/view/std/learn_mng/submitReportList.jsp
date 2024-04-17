 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
					

							<c:if test="${totalCount eq 0 }">
								<tr>
									<td colspan="7">데이터가 존재하지 않습니다.</td>
								</tr>
							</c:if>
							
							<c:if test="${totalCount > 0 }">
								<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
								<c:forEach items="${selReportList}" var="list" >

									<tr id = "reportListdata" >
										<td>${nRow + 1}</td>
										<td>${list.lec_nm}</td>
										<c:if test="${list.task_id eq list.task_id_sub}">
<%-- 										<c:if test="${list.task_id eq list.task_id}"> --%>
											<td onClick="fshowSubModal('${list.task_id}', '${list.lec_no}' , '${list.user_no}', '${list.name}')" class="cursor"><strong style="color:black;">${list.task_name} (제출완료)</strong></td>
										</c:if>
										<c:if test="${list.task_id ne list.task_id_sub}">
<%-- 										<c:if test="${list.task_id ne list.task_id}"> --%>
											<td onClick="fshowSubModal('${list.task_id}', '${list.lec_no}', '${list.user_no}', '${list.name}')" class="cursor"><strong style="color:black;">${list.task_name}</strong></td>
										</c:if>
										<td>${list.tutor_name}</td>
										<td>${list.task_start} ~ ${list.task_end}</td> 
										<td>
<%-- 											<c:if test="${not empty list.task_path}"> --%>
<%-- 												<input type="button" value="다운로드" onclick="ffiledownload('${list.task_path}','${list.task_id}');" /> --%>
                        			 			<a href="javascript:ffiledownload('${list.task_id}','${list.lec_no}')" class="btnType blue" name="btn"><span>다운로드</span></a> 
<%--                         			 		</c:if> --%>
                       			 		</td>
									</tr>
								<c:set var="nRow" value="${nRow + 1}" />
								
								</c:forEach>
							</c:if>
							
							<input type="hidden" id="totalCount" name="totalCount" value="${totalCount}"/>
