<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
   
<%--
	List<Purchase> list= (List<Purchase>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");
--%>  

<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script type="text/javascript" src="../javascript/jquery-2.1.4.js"></script>
<script type="text/javascript">
	function fncGetList(currentPage) {
		if(currentPage == null || currentPage == ""){
			currentPage = 1;
		}
		$("#currentPage").val(currentPage);
		$('form').attr('mehtod', 'POST').attr('action', "/purchase/listPurchase").submit();
	}
	$(function() {
		$('td[name="index"]').bind('click', function() {
			$('form').attr('method', 'POST').attr('action', '/purchase/getPurchase').submit();
		})

		$('td[name="userId"]').bind('click', function() {
			self.location="/user/getUser?userId=${purchase.buyer.userId}"
		})
		
		console.log($("input:hidden[name=tranCode]").val())

	})
	$(function() {
		if($("input:hidden[name=tranCode]").val() == '2  '){
			$('#dlvyState').append("물건도착").bind('click', function() {
				$('form').attr('method', 'POST').attr('action', '/purchase/updateTranCode').submit();
			})
		}
	})
		
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">전체  ${resultPage.totalCount } 건수, 현재  ${resultPage.currentPage} 페이지</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<%--
		for(int i=0; i<list.size(); i++) {
			Purchase purchase = list.get(i);
	--%>
	<c:set var="i" value="0" />
	<c:forEach var="purchase" items="${list}">
	<input type="hidden" name="tranNo" value="${purchase.tranNo}">
		<c:set var="i" value="${ i+1 }" />	
		<tr class="ct_list_pop">
			<td align="center" name="index">
				${ i }
			</td>
			<td></td>
			<td align="left" name="userId">
				${purchase.buyer.userId}
			</td>
			<td></td>
			<td align="left">${purchase.receiverName}</td>
			<td></td>
			<td align="left">${purchase.receiverPhone}</td>
			<td></td>
			<td align="left">
				<c:if test="${purchase.tranCode.trim()== '1'}">현재 구매완료 상태 입니다.</c:if>
				<c:if test="${purchase.tranCode.trim()== '2'}">현재 배송중 상태 입니다.</c:if>
				<c:if test="${purchase.tranCode.trim()== '3'}">현재 배송완료 상태 입니다.</c:if>
			</td>
			<td></td>
			<td align="left" id="dlvyState">
			<input type="hidden" name="tranCode" value="${purchase.tranCode}">
			</td>
		</tr>
		<tr>
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
	<%-- } --%>	
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<jsp:include page="../common/pageNavigator.jsp"/>
		</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>