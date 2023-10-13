<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="ko">
<head>
 	<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=63c0f4f3e00e8d6c49088160aa0fdd64&libraries=services,clusterer,drawing"></script>
    
    <jsp:include page="../head.jsp"></jsp:include>
    <jsp:include page="../nav.jsp"></jsp:include>
   
    <style>
    	body {
		    background-color: #DCDCDC; 
		}
    
    	#header-wrap {
	        position: fixed; /* 헤더를 화면 상단에 고정합니다 */
	        width: 100%; /* 너비를 100%로 설정하여 화면 가로폭에 맞게 헤더가 나타나도록 합니다 */
	        z-index: 1000; /* 다른 요소 위에 나타나도록 설정하세요 (필요에 따라 숫자 조정) */
	    }
    
    	/* 스타일을 추가하여 검색창과 리스트를 원하는 위치에 배치합니다. */
	    #search-list-container {
	        position: absolute;
	        top: 16%; /* 헤더 높이만큼 아래에 위치하도록 조정 */
	        right: 0px; /* 오른쪽에 위치하도록 조정 */
	        /* z-index: 1; */
	        display: flex; /* 컨테이너 내부의 요소를 가로로 배치하기 위해 flex 사용 */
	        flex-direction: column; /* 컨테이너 내부의 요소를 세로로 배치하기 위해 flex-direction 사용 */
	        /* max-height: 84%; */
	        max-height: calc(100vh - 16%); /* 화면 높이에서 헤더의 높이를 빼서 최대 높이로 설정 */
	        width: 30%;
	    }
    
	    /* 스타일을 추가하여 검색창을 원하는 위치에 배치합니다. */
	    #search-container {
	    position: absolute;
	        background-color: white;
	        padding: 10px;
	        border-radius: 5px;
	        box-shadow: 0px 0px 5px 0px rgba(0, 0, 0, 0.5);
	        margin-bottom: 10px; /* 검색 폼과 리스트 사이의 간격을 설정 */
	        position: relative; /* 부모 컨테이너 기준으로 배치 */
            z-index: 2; /* 검색창을 부가 메뉴보다 위로 올립니다. */
	    }
	
	    /* 리스트 창 스타일 설정 */
	    #list-container {
	        background-color: white;
	        padding: 10px;
	        border-radius: 5px;
	        box-shadow: 0px 0px 5px 0px rgba(0, 0, 0, 0.5);
	        overflow-y: auto;
	    }
	    
	    .property-item .media-img-wrap {
	    	margin: 5px;
		    width: 25%;
		    display: flex; 
		    justify-content: center; 
		    align-items: center;
		    /* 아래의 margin-right 속성은 요소 사이의 간격을 설정합니다. */
		}
		.img-fluid{
			margin: 2px;
			width: 100%;
			height: 100%;
			
		}
		
		.property-item .media-body {
			margin: 5px;
		    width: 75%;
		    display: inline-block;
		    vertical-align: middle;
		}
		
		/* 이미지 위에 번호를 겹치시키기 위한 스타일 */
		.image-number {
		    position: absolute;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    background-color: rgba(0, 0, 0, 0.7);
		    color: #fff;
		    padding: 5px 5px;
		    border-radius: 5px;
		    z-index: 1;
		    display: none; /* 초기에는 숨겨둠 */
		    text-align: center;
		}
		
		.email-text {
		    overflow: hidden;
		    text-overflow: ellipsis;
		    display: -webkit-box;
		    -webkit-line-clamp: 1; /* 최대 표시 줄 수 */
		    -webkit-box-orient: vertical;
		}
		
		#reset-btn {
			width: 15px; 
			height: 15px; 
			justify-content: center; 
			align-items: center; 
			border: none;
			margin-top: 5px; 
		}
		
	    /* 지도 스타일 설정 */
	    #map {
	        position: absolute;
	        top: 16%; /* 헤더 높이만큼 아래에 위치하도록 조정 */
	        left: 5px;
	        width: calc(100% - 30%); /* 검색창과 리스트 창의 너비를 제외한 나머지 공간을 지도가 차지하도록 조정 */
	        /* height: 84%; */
	        height: calc(100vh - 16%); /* 화면 높이에서 헤더의 높이를 빼서 최대 높이로 설정 */
	        z-index: 0; /* 지도를 가장 뒤로 배치 
	    }
	    
	    /* 클릭한 링크에 대한 스타일 */
		.property-item.clicked {
		    background-color: rgba(255, 255, 255, 0.5); /* 흰색 배경색을 반투명하게 설정합니다. */
		}
	    
	</style>
</head>
	
	<body>
	    <div id="map"></div>
	    <script>
		    var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
		        center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표
		        level : 8 // 지도의 확대 레벨
		    });
				
		    // 마커 클러스터러를 생성합니다
		    // 마커 클러스터러를 생성할 때 disableClickZoom 값을 true로 지정하지 않은 경우
		    // 클러스터 마커를 클릭했을 때 클러스터 객체가 포함하는 마커들이 모두 잘 보이도록 지도의 레벨과 영역을 변경합니다
		    // 이 예제에서는 disableClickZoom 값을 true로 설정하여 기본 클릭 동작을 막고
		    // 클러스터 마커를 클릭했을 때 클릭된 클러스터 마커의 위치를 기준으로 지도를 1레벨씩 확대합니다
		    var clusterer = new kakao.maps.MarkerClusterer({
		        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
		        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
		        minLevel: 10, // 클러스터 할 최소 지도 레벨
		        disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
		    });
	
		    // 데이터를 가져오기 위해 jQuery를 사용합니다
		    // 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
		    $.get("/itemListAll", function(data) {
			    var markers = data.map(function(item) {
			        return new kakao.maps.Marker({
			            position: new kakao.maps.LatLng(item.lat, item.lng)
			        });
			    });
			
			    // 클러스터러에 마커 배열을 추가합니다
			    clusterer.addMarkers(markers);
			});
	
		    // 마커 클러스터러에 클릭이벤트를 등록합니다
		    // 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우
		    // 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다
		    kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
	
		        // 현재 지도 레벨에서 1레벨 확대한 레벨
		        var level = map.getLevel()-1;
	
		        // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다
		        map.setLevel(level, {anchor: cluster.getCenter()});
		    });
	    </script>
	    
	    <div class="container mt-5" id="search-list-container" >
		    <form role="search" class="email-search" method="post" id="search-container">
		        <div>
		            <!-- 방종류 -->
		            <select id="itemType" name="itemType">
		                <option value="">방 타입 선택하기</option>
		                <option value="O">원룸</option>
		                <option value="T">투룸</option>
		                <option value="H">쓰리룸</option>
		                <option value="F">오피스텔</option>
		            </select>
		        </div>
		        <div>
		            <!-- 월-전세 -->
		            <select id="leaseOrMonth" name="leaseOrMonth">
		                <option value="">계약 조건 선택하기</option>
		                <option value="month">월세</option>
		                <option value="lease">전세</option>
		            </select>
		        </div>
		        <br>
		        <div class="input-group">
		            
		            <img  src="../resources/comm/search.png" style="width: 24px; height: 24px; align-items: center; justify-content: center; margin-top: 8px; margin-bottom: 8px; ">
		            <input type="text" class="form-control" name="search" id="search" placeholder="도로명 또는 건물명을 입력하세요." required="" value="" style="border: none; align-items: center; justify-content: center;">
		        	<!-- 초기화 버튼 추가 -->
        			<button type="button" id="resetSearch" style="border: none;"><img id="reset-btn" src="../resources/comm/reset.png" alt="Reset" /></button>
		        </div>
		    </form>
		    <script>
			 	// 초기화 버튼 클릭 시 검색어 필드 초기화
			    document.getElementById('resetSearch').addEventListener('click', function () {
			        document.getElementById('search').value = ''; // 검색어 필드를 빈 문자열로 설정
			        document.getElementById('itemType').value = ''; // 방종류 select 요소 초기화
			        document.getElementById('leaseOrMonth').value = ''; // 월-전세 select 요소 초기화
			    });
		    </script>
		    <script>
			 	// 검색 폼 엘리먼트 가져오기
			    var searchForm = document.getElementById('search-container');
	
			    // 검색 폼이 제출되면 세션 스토리지에 검색어 및 셀렉트 태그 값 저장
			    searchForm.addEventListener('submit', function() {
			        var searchInput = document.getElementById('search');
			        var searchValue = searchInput.value;
			        var itemTypeSelect = document.getElementById('itemType');
			        var leaseOrMonthSelect = document.getElementById('leaseOrMonth');
			        var itemTypeValue = itemTypeSelect.value;
			        var leaseOrMonthValue = leaseOrMonthSelect.value;
			        
			        sessionStorage.setItem('search', searchValue);
			        sessionStorage.setItem('itemType', itemTypeValue);
			        sessionStorage.setItem('leaseOrMonth', leaseOrMonthValue);
			    });
	
			    // 검색어 및 셀렉트 태그 값이 세션 스토리지에 저장된 경우 자동으로 설정
			    var searchInput = document.getElementById('search');
			    var itemTypeSelect = document.getElementById('itemType');
			    var leaseOrMonthSelect = document.getElementById('leaseOrMonth');
			    
			    var storedSearch = sessionStorage.getItem('search');
			    var storedItemType = sessionStorage.getItem('itemType');
			    var storedLeaseOrMonth = sessionStorage.getItem('leaseOrMonth');
			    
			    if (storedSearch) {
			        searchInput.value = storedSearch;
			    }
			    if (storedItemType) {
			        itemTypeSelect.value = storedItemType;
			    }
			    if (storedLeaseOrMonth) {
			        leaseOrMonthSelect.value = storedLeaseOrMonth;
			    }
			 	// 5분(300000 밀리초) 후에 세션 스토리지 초기화
			    setTimeout(function() {
			        sessionStorage.clear(); // 세션 스토리지 초기화
			    }, 6000);
		    </script>
		
		    <div class="emailapp-emails-list" id="list-container">
		        <div class="nicescroll-bar">
		            <c:forEach var="item" items="${list}">
			            <c:if test="${item.useAt == 'Y' }">
			                <a href="/itemDetail/${item.itemNo}" target="_blank" onclick="handleClick('${item.itemNo}')" class="property-item" id="property-${item.itemNo}" style="display: flex;">
			                    <div class="media-img-wrap" style="position: relative;">
			                    	<img alt="my-properties-3" src="/upload/${item.fileVO.savedName}" class="img-fluid"  onmouseover="showNumber('${item.itemNo}')" onmouseout="hideNumber('${item.itemNo}')">
			                    	<div class="image-number" id="number-${item.itemNo}">매물<br/>${item.itemNo}</div>
			                    </div>
			                    <div class="media-body">
			                        <div>
			                            <div class="email-head font-weight-700 font-lg-15"><h5>${item.address}　<i class="lni-map-marker"></i></h5></div>
			                            <div class="email-head font-weight-700 font-lg-15"><h6>(${item.address2})</h6></div>
			                            <c:choose>
			                            	<c:when test="${item.leaseOrMonth == 'lease' }">
			                            		<c:if test="${item.leasePrice < 10000 }">
			                            			<div class="email-subject"><h5>전세 ${item.leasePrice }</h5></div>
			                            		</c:if>
			                            		<c:if test="${item.leasePrice >= 10000 && item.leasePrice % 10000 == 0 }">
			                            			<div class="email-subject"><h5>전세 ${item.leaseBillion}억</h5></div>
			                            		</c:if>
			                            		<c:if test="${item.leasePrice >= 10000 && item.leasePrice % 10000 != 0 }">
			                            			<div class="email-subject"><h5>전세 ${item.leaseBillion}억 ${item.leaseTenMillion}</h5></div>
			                            		</c:if>
			                            	</c:when>
			                            	<c:when test="${item.leaseOrMonth == 'month' }">
			                            		<div class="email-subject"><h5>월세 ${item.depositFee} / ${item.monthPrice}</h5></div>
			                            	</c:when>
			                            </c:choose>
			                            <c:choose>
			                            	<c:when test="${item.itemType == 'O' }">
			                            		<div class="email-subject">원룸 &nbsp;&nbsp; ${item.itemSize}평/${item.itemSize * 3.3}㎡ &nbsp;&nbsp; ${item.itemFloor}층/${item.buildingFloor}층</div>
			                            	</c:when>
			                            	<c:when test="${item.itemType == 'T' }">
			                            		<div class="email-subject">투룸 &nbsp;&nbsp; ${item.itemSize}평/${item.itemSize * 3.3}㎡ &nbsp;&nbsp; ${item.itemFloor}층/${item.buildingFloor}층</div>
			                            	</c:when>
			                            	<c:when test="${item.itemType == 'H' }">
			                            		<div class="email-subject">쓰리룸 &nbsp;&nbsp; ${item.itemSize}평/${item.itemSize * 3.3}㎡ &nbsp;&nbsp; ${item.itemFloor}층/${item.buildingFloor}층</div>
			                            	</c:when>
			                            	<c:when test="${item.itemType == 'F' }">
			                            		<div class="email-subject">오피스텔 &nbsp;&nbsp; ${item.itemSize}평/${item.itemSize * 3.3}㎡ &nbsp;&nbsp; ${item.itemFloor}층/${item.buildingFloor}층</div>
			                            	</c:when>
			                            </c:choose>
			                            <div class="email-subject">${item.memoShort} </div>
			                            <div class="email-text">
			                                <p>${item.memoDetail}</p>
			                            </div>
			                        </div>
			                    </div>
			                </a>
			                <div class="email-hr-wrap">
			                    <hr>
			                </div>
			            </c:if>
		            </c:forEach>
		        </div>
		    </div>
		</div>
		
		<!-- 카테고리에 따른 마커 생성 -->
		<c:forEach var="item" items="${list}">
			<c:if test="${item.useAt == 'Y' }">
			    <script>
			        var positions = [
			            {
			                title: "${item.itemNo}",
			                latlng: new kakao.maps.LatLng(${item.lat}, ${item.lng})
			            }
			        ]
			
			        // 마커 이미지의 이미지 주소입니다
			        var imageSrc = "../resources/comm/marker.png";
			
			        for (var i = 0; i < positions.length; i++) {
			
			            // 마커 이미지의 이미지 크기 입니다
			            var imageSize = new kakao.maps.Size(28, 35);
			
			            // 마커 이미지를 생성합니다    
			            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
			
			            // 마커를 생성합니다
			            var marker = new kakao.maps.Marker({
			                map: map, // 마커를 표시할 지도
			                position: positions[i].latlng, // 마커를 표시할 위치
			                title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			                image : markerImage // 마커 이미지 
			            });
			            
			            // 마커에 클릭 이벤트를 등록합니다
			            kakao.maps.event.addListener(marker, 'click', function() {
			                // 클릭한 마커의 위치로 지도 중심 이동
			                map.setCenter(marker.getPosition());
			                
			             	// 클릭한 마커의 번호에 해당하는 페이지로 새 창으로 이동
			                var itemNo = this.getTitle(); // 클릭한 마커의 title 속성에 itemNo가 저장되어 있음
			                var url = "/itemDetail/" + itemNo; // 이동할 페이지의 URL을 생성
			                window.open(url, "_blank"); // 페이지를 새 창으로 열기
			            });
			        }
			        
			        // 검색 결과가 있을 때, 첫 번째 마커를 기준으로 지도 중심을 설정합니다
			        if (positions.length > 0) {
			            map.setCenter(positions[0].latlng);
			        }
			    </script>
			</c:if>
		</c:forEach>
		
		<!-- 검색 결과가 있을 때, 첫 번째 마커를 기준으로 지도 중심을 설정합니다 -->
		<script>
		    if (positions.length > 0) {
		        map.setCenter(positions[0].latlng);
		    }
		</script>
		
		<script>
		    // 이미지 위에 번호를 나타내는 함수
		    function showNumber(itemNo) {
		        var numberElement = document.getElementById('number-' + itemNo);
		        if (numberElement) {
		            numberElement.style.display = 'block';
		        }
		    }
		    // 이미지 위에 번호를 숨기는 함수
		    function hideNumber(itemNo) {
		        var numberElement = document.getElementById('number-' + itemNo);
		        if (numberElement) {
		            numberElement.style.display = 'none';
		        }
		    }
		</script>
	    
	    <!-- 매물 봤다면 봤다는 표시 -->
	    <script>
		 	// JavaScript 코드
		    document.addEventListener('DOMContentLoaded', function() {
		        // 모든 링크 요소를 가져옵니다.
		        var links = document.querySelectorAll('.property-item');
	
		        // 각 링크에 대한 클릭 이벤트를 처리합니다.
		        links.forEach(function(link) {
		            link.addEventListener('click', function() {
		                // 클릭한 링크에 'clicked' 클래스를 추가합니다.
		                link.classList.add('clicked');
		            });
		        });
		    });
		</script>
	    
    </body>
</html>