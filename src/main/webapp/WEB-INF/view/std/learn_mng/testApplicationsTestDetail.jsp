<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

									<c:if test="${testDetailCnt eq 0 }">
										<tr>
											<td colspan="6">데이터가 존재하지 않습니다.</td>
										</tr>
									</c:if>

									 <c:if test="${testDetailCnt > 0 }">
										<c:forEach items="${testdata}" var="list" varStatus="loop">
											<tr>
												<th scope="rows" colspan="6" style="background-color:#eee;">${list.test_que}</th>
											</tr>
											<tr>
												<td><input type="radio" value="1" name="test_ans[${loop.index}]" /><label>${list.que_ex1}</label></td>
											</tr>
											<tr>
												<td><input type="radio" value="2" name="test_ans[${loop.index}]" /><label>${list.que_ex2}</label></td>
											</tr>
											<tr>
												<td><input type="radio" value="3" name="test_ans[${loop.index}]" /><label>${list.que_ex3}</label></td>
											</tr>
											<tr>
												<td><input type="radio" value="4" name="test_ans[${loop.index}]" /><label>${list.que_ex4}</label></td>												
											</tr>
											<tr>
												<td><input type="hidden" name="test_que_no" value ="${list.test_que_no}"/></td>
											</tr>
											
										</c:forEach>
									</c:if>
									<input type="hidden" id="testDetailCnt" name="testDetailCnt" value ="${testDetailCnt}"/>
									<br/>
									