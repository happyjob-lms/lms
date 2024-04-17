<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<c:if test="${totalCnt_lec eq 0 }">
	<tr>
		<td colspan="9">데이터가 존재하지 않습니다.</td>
	</tr>
</c:if>

<c:if test="${totalCnt_lec > 0 }">
	<c:set var="nRow" value="${pageSize*(currentPage-1)}" />
	<c:forEach items="${lecAdList}" var="list">
		<tr>
	<td>${list.lec_no}</td>
	<td><strong><a href="javascript:flist_advice(1, '${list.lec_no}')">${list.lec_nm}</a></strong></td>
			<td>${list.lec_start}~${list.lec_end}</td>
		</tr>
		<c:set var="nRow" value="${nRow + 1}" />
	</c:forEach>
</c:if>

<input type="hidden" id="totalCnt_lec" name="totalCnt_lec"
	value="${totalCnt_lec}" />