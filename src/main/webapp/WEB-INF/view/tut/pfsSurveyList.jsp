<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>					
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<c:if test="${listcnt eq 0}">
		<tr>
			<td colspan="12">데이터가 존재하지 않습니다.</td>
		</tr>
	</c:if>
	<c:forEach items="${listData}" var="list">
		<tr>
			<td><a href="javascript:lectureStdList('${list.lec_no}', 1);">${list.lec_nm}</a></td>
			<td>${list.lec_start}</td>
			<td>${list.lec_end}</td>
			<td>
				<span>${list.lec_cnt}</span> <span> / ${list.lec_max_cnt}</span>
			</td>
		</tr>
	</c:forEach>
		
	<input type="hidden" id="listcnt" name="listcnt" value ="${listcnt}"/>