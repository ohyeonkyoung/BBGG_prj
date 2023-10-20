<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="ko">
<head>
 	<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=63c0f4f3e00e8d6c49088160aa0fdd64&libraries=services,clusterer,drawing"></script>
    <!-- 제이쿼리 -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    
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
		
		#items {
			height: 135px;
		}
		
		
		.email-text {
		    overflow: hidden;
		    text-overflow: ellipsis;
		    display: -webkit-box;
		    -webkit-line-clamp: 1; /* 최대 표시 줄 수 */
		    -webkit-box-orient: vertical;
		}
		
		/* 매물타입선택창 */
		.itemDiv {
	      display: none;
	      position: absolute;
	      background-color: #fff;
	      border: 1px solid #ccc;
	      padding: 10px;
	      z-index: 1;
	    }
	    .itemButton {
	    	border: none;
	    	background-color: white;
	    	width: 100%;
	    	text-align: left;
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
	        z-index: 0; /* 지도를 가장 뒤로 배치 */
	    }
	    
	    #map button {
            position: absolute;
            top: 50px;
            right: 20px;
            z-index: 50;
         	border: none;
         	padding: 0;
         	max-height: 30px;
         	max-width: 30px;
            display: flex;
		    align-items: center;
		    justify-content: center;
        }
        
        #map button img{
        	margin: 1px;
		    width: 100%; /* 이미지의 너비를 100%로 설정하여 버튼에 가득 차게 합니다 */
		    height: 100%; /* 이미지의 높이를 100%로 설정하여 버튼에 가득 차게 합니다 */
		    object-fit: contain; /* 이미지 비율 유지 */
        }
	    
	    /* 클릭한 링크에 대한 스타일 */
		.clicked {
		    background-color: #ffcccb; /* 클릭 시 변경할 배경색 */
		    color: #000; /* 클릭 시 변경할 텍스트 색상 */
		}
	    
	</style>
</head>
	<body>
		<!-- 지도 -->
	    <div id="map">
	    	<button id="currentLocationButton"><img alt="현재 위치 가져오기" src="/resources/comm/myXY.png"></button>
	    </div>
	   	
	   	<!-- 검색, 리스트 div -->
	   	<div class="container mt-5" id="search-list-container" >
		    <div class="email-search" id="search-container">
		        <div>
		        	<!-- 방종류 -->
		        	<div id="itemType" name="itemType">
		        		<button id="showDivButton" class="itemButton"></button>
		        		<div id="itemTypeDiv" class="itemDiv">
		        			<p>방 종류를 선택 해주세요.</p>
		        			<hr>
						    <label><input type="checkbox" value="O" name="itemType" id="O" checked>원룸</label>
						    <label><input type="checkbox" value="T" name="itemType" id="T" checked>투룸</label>
						    <label><input type="checkbox" value="H" name="itemType" id="H" checked>쓰리룸</label>
						    <label><input type="checkbox" value="F" name="itemType" id="F" checked>오피스텔</label>
		        		</div>
			        </div>
			        <br>
			        <!-- 월-전세 -->
				    <div id="leaseOrMonth" name="leaseOrMonth">
			        	<button id="showDivButton2" class="itemButton"></button>
			        	<div id=leaseOrMonthDiv class="itemDiv">
			        		<p>계약 조건을 선택 해주세요.</p>
			        		<hr>
							<label><input type="checkbox" value="month" name="leaseOrMonth" id="month" checked>월세</label>
							<label><input type="checkbox" value="lease" name="leaseOrMonth" id="lease" checked>전세</label>
			        	</div>
				    </div>
				</div>
				<script>
				    function initializeDropdown(buttonId, divId) {
						var showDivButton = document.getElementById(buttonId);
				    	var itemTypeDiv = document.getElementById(divId);
				
						// 초기 버튼 텍스트 업데이트
						updateButtonText();
				
						showDivButton.addEventListener("click", function(event) {
				        event.stopPropagation();
					        if (itemTypeDiv.style.display === "none" || itemTypeDiv.style.display === "") {
					          itemTypeDiv.style.display = "block";
					        } else {
					          itemTypeDiv.style.display = "none";
					        }
						});
						// 클릭 외의 영역을 클릭하면 드롭다운 닫기
						window.addEventListener("click", function() {
				        	itemTypeDiv.style.display = "none";
				      	});
				
				      	// 체크박스 상태 변경 시 텍스트 업데이트
				      	var checkboxes = document.querySelectorAll('#' + divId + ' input[type="checkbox"]');
				      	checkboxes.forEach(function(checkbox) {
				        	checkbox.addEventListener("change", function() {
				          	updateButtonText();
				        	});
				      	});
				
				      	function updateButtonText() {
					        var selectedItems = [];
					        var checkedCheckboxes = document.querySelectorAll('#' + divId + ' input[type="checkbox"]:checked');
					        checkedCheckboxes.forEach(function(checkbox) {
					          selectedItems.push(checkbox.parentElement.innerText);
					        });
					
					        showDivButton.textContent = selectedItems.length > 0 ? selectedItems.join(", ") : "선택한 항목이 없습니다.";
				      	}
				    }
				    // 방 종류 초기화
				    initializeDropdown("showDivButton", "itemTypeDiv");
				    // 월-전세 초기화
				    initializeDropdown("showDivButton2", "leaseOrMonthDiv");
				</script>
		        <br>
		        <div class="input-group">
		            
		            <img  src="../resources/comm/search.png" style="width: 24px; height: 24px; align-items: center; justify-content: center; margin-top: 8px; margin-bottom: 8px; ">
		            
		           	<!-- 매물 검색 -->
		            <input type="text" class="form-control" name="search" id="search" placeholder="도로명 또는 건물명을 입력하세요." required="" value="" style="border: none; align-items: center; justify-content: center;">
		        	
		        	<!-- 초기화 버튼 추가 -->
        			<button type="button" id="resetSearch" style="border: none; background: #fff"><img id="reset-btn" src="../resources/comm/reset.png" alt="Reset" /></button>
		        </div>
		    </div>
		    
		    <!-- 매물 리스트 -->
			<div class="emailapp-emails-list" id="list-container">
			    <div class="nicescroll-bar" id="property-list">
			    </div>
			</div>
		</div>
		<script>
		    var map; // 지도 객체를 저장할 변수
		    var clusterer; // 마커 클러스터러 객체
		    var filteredData; // 필터링된 데이터를 저장할 배열
		    var propertyList; // 매물 리스트 컨테이너
		    var marker; // 현재 매물에 대한 마커
		
		    // Kakao 지도 API 초기화 및 기타 설정
		    kakao.maps.load(function () {
		        var mapContainer = document.getElementById('map');
		        var mapOption = {
		            center: new kakao.maps.LatLng(36.3300693111, 127.4596995134),
		            level: 12,
		            maxLevel: 12
		        };
		
		        map = new kakao.maps.Map(mapContainer, mapOption);
		
		        // 마커 클러스터러 초기화
		        clusterer = new kakao.maps.MarkerClusterer({
		            map: map,
		            averageCenter: true,
		            minLevel: 2
		        });
		        
		     	// 처음 페이지가 열릴 때 모든 데이터를 가져오고 필터링
		        fetchDataAndFilter();
		
		     	// 검색어, 방 종류, 계약 조건이 변경될 때
		        $("#itemType, #leaseOrMonth, #search").on("input", function () {
		            fetchDataAndFilter();
		        });

		     	// 초기화 버튼 클릭 이벤트
		        $("#resetSearch").click(function () {
		        	resetFilters();
		            fetchDataAndFilter();
		            //updateMapZoom();
		        });

		        // 필터 초기화 함수
		        function resetFilters() {
		            // 선택된 방 종류 초기화
		            //$("#O, #T, #H, #F").prop("checked", true);
		            // 선택된 계약 조건 초기화
		            //$("#month, #lease").prop("checked", true);
		            // 검색어 필드 초기화
		            $("#search").val("");
		        }

		        // 서버에서 데이터를 가져오고 필터링하는 함수
		        function fetchDataAndFilter() {
		            var selectedItemTypes = getSelectedItemTypes();
		            var selectedLeaseOrMonth = getSelectedLeaseOrMonth();
		            var searchKeyword = $("#search").val();
		            
		         	// 매물 타입 체크한 값을 가져오는 함수
		            function getSelectedItemTypes() {
		                var selectedTypes = [];
		                
		                if ($("#O").prop("checked")) {
		                    selectedTypes.push("O");
		                }
		                if ($("#T").prop("checked")) {
		                    selectedTypes.push("T");
		                }
		                if ($("#H").prop("checked")) {
		                    selectedTypes.push("H");
		                }
		                if ($("#F").prop("checked")) {
		                    selectedTypes.push("F");
		                }
		                
		                return selectedTypes;
		            }
		            	
		            // 계약 조건 체크한 값을 가져오는 함수
		            function getSelectedLeaseOrMonth() {
		                var selectedLOM = [];
		                if ($("#month").prop("checked")) {
		                	selectedLOM.push("month");
		                }
		                if ($("#lease").prop("checked")) {
		                	selectedLOM.push("lease");
		                }
		                return selectedLOM;
		            }
		            
		            // 키워드 필터링 함수
		            function Keyword(item) {
		                if (searchKeyword.length >= 2) {
		                    return item.address.includes(searchKeyword) || item.address2.includes(searchKeyword);
		                } else {
		                    return true;
		                }
		            }
		            
		            $.get("/itemListAll", function (data) {
		                filteredData = data.filter(function (item) {
		                    return item.useAt === 'Y' &&
		                    	(selectedItemTypes.length === 0 || selectedItemTypes.includes(item.itemType)) &&
		                    	(selectedLeaseOrMonth.length === 0 || selectedLeaseOrMonth.includes(item.leaseOrMonth)) &&
			                    Keyword(item);
		                });

		                // 클러스터러에 마커 배열을 추가
		                clusterer.clear(); // 기존 마커 제거
		                var markers = filteredData.map(function (item) {
		                    var lat = item.lat;
		                    var lng = item.lng;
		                    var imageSize = new kakao.maps.Size(28, 35);

		                    return new kakao.maps.Marker({
		                        position: new kakao.maps.LatLng(lat, lng),
		                        image: new kakao.maps.MarkerImage("../resources/comm/marker.png", imageSize)
		                    });
		                });

		                clusterer.addMarkers(markers);
		                // 매물 리스트 컨테이너
		                propertyList = $("#property-list");
		                // 초기 매물 리스트 업데이트
		                updatePropertyList();
		                
		             	// 검색 결과가 있는 경우 지도를 해당 영역으로 이동
		                if (filteredData.length > 0 && searchKeyword.length >= 2) {
		                    var bounds = new kakao.maps.LatLngBounds();
		                    filteredData.forEach(function (item) {
		                        bounds.extend(new kakao.maps.LatLng(item.lat, item.lng));
		                    });
		                    map.setBounds(bounds);
		                }
		            });
		        }
		
		        // 이벤트 리스너 등록 (지도 이동 및 확대 축소 이벤트)
		        kakao.maps.event.addListener(map, 'dragend', updatePropertyList);
		        kakao.maps.event.addListener(map, 'zoom_changed', updatePropertyList);
		        
		     	// 현재 위치로 이동 버튼 클릭 이벤트
		        var currentLocationButton = document.getElementById('currentLocationButton');
		        currentLocationButton.addEventListener('click', function () {
		            // 위치 액세스 권한 동의 여부 확인
		            if ('geolocation' in navigator) {
		                navigator.geolocation.getCurrentPosition(function (position) {
		                    // 위치 정보를 얻은 후의 동작을 정의
		                    var latitude = position.coords.latitude;
		                    var longitude = position.coords.longitude;

		                    // 지도를 확대 및 중앙 위치로 이동
		                    var mapCenter = new kakao.maps.LatLng(latitude, longitude);
		                    map.setLevel(4); // 원하는 확대 레벨로 설정
		                    map.panTo(mapCenter); // 중앙으로 이동
		                    
		                 	// 위치를 가져온 후 매물 리스트를 업데이트
		                    updatePropertyList();

		                }, function (error) {
		                    // 위치 액세스 권한을 거부하거나 오류가 발생한 경우의 동작을 정의
		                    if (error.code === 1) {
		                        if (confirm('위치 액세스 권한을 허용하지 않았습니다. 위치 정보를 사용하려면 권한을 허용해야 합니다. 권한 설정을 확인하시겠습니까?')) {
		                            // 권한 설정 페이지로 이동
		                            window.location.href = '/'; // 적절한 설정 페이지 URL로 변경
		                        }
		                    } else {
		                        alert('위치 정보를 가져오는 동안 오류가 발생했습니다: ' + error.message);
		                    }
		                });
		            } else {
		                alert('브라우저에서 위치 정보 액세스를 지원하지 않습니다.');
		            }
		        });
		    });
		
		    // 지도 상태에 따라 매물 리스트 업데이트
		    function updatePropertyList() {
		        var bounds = map.getBounds();
		        var visibleItems = filteredData.filter(function (item) {
		            var latLng = new kakao.maps.LatLng(item.lat, item.lng);
		            return bounds.contain(latLng);
		        });
		
		        // 매물 리스트 초기화
		        propertyList.empty();
		
		        var imageSize = new kakao.maps.Size(28, 35);
		
		        // 보이는 매물 리스트 업데이트
		        visibleItems.forEach(function (item) {
		            var propertyItem = $("<a href='/itemDetail/" + item.itemNo + "' target='_blank' class='property-item' id='items' style='display: flex;'></a>");
		            var mediaImgWrap = $("<div class='media-img-wrap' style='position: relative;'>");
		            var propertyImage = $("<img alt='my-properties-3' class='img-fluid'>");
		            if (item.fileVO && item.fileVO.savedName) {
		                propertyImage.attr('src', '/upload/' + item.fileVO.savedName);
		            } else {
		                // 이미지가 없는 경우 처리
		                propertyImage.attr('src', '/resources/comm/itemimg/nonimg2.png'); // 대체 이미지 경로 또는 빈 이미지
		            }
		
		            mediaImgWrap.append(propertyImage);
		
		            var mediaBody = $("<div class='media-body'>");
		            var emailHead1 = $("<div class='email-head font-weight-700 font-lg-15'><h6>" + item.address + " <i class='lni-map-marker'></i></h5></div>");
		            var emailHead2 = $("<div class='email-head font-weight-700 font-lg-15'><h6>(" + item.address2 + ")</h6></div>");
		            var emailSubject1 = $("<div class='email-subject'><h5></h5></div>");
		            var emailSubject2 = $("<div class='email-subject'><h5></h5></div>");
		            var emailSubject3 = $("<div class='email-subject'><p></p></div>");
		            var emailSubject = $("<div class='email-subject'>#" + item.tag1 + " #" + item.tag2 + " #" + item.tag3 + "</div>");
		            var emailText = $("<div class='email-text' style='-webkit-line-clamp: 1;'><p>" + item.memoDetail + "</p></div>");
		            var hr = $("<hr>");
		
		            mediaBody.append(emailHead1);
		            mediaBody.append(emailHead2);
		
		            if (item.leaseOrMonth == 'lease') {
		                if (item.leasePrice < 10000) {
		                    emailSubject1.find('h5').text("전세 " + item.leasePrice);
		                } else if (item.leasePrice >= 10000 && item.leasePrice % 10000 == 0) {
		                    emailSubject1.find('h5').text("전세 " + item.leaseBillion + "억");
		                } else {
		                    emailSubject1.find('h5').text("전세 " + item.leaseBillion + "억 " + item.leaseTenMillion);
		                }
		            } else if (item.leaseOrMonth == 'month') {
		            	if (item.depositFee < 10000) {
		                	emailSubject2.find('h5').text("월세 " + item.depositFee + " / " + item.monthPrice);
		            	} else if (item.depositFee >= 10000 && item.depositFee % 10000 ==0) {
		            		emailSubject2.find('h5').text("월세 " + item.depositFeeBillion + "억" + " / " + item.monthPrice);
		            	} else {
		            		emailSubject2.find('h5').text("월세 " + item.depositFeeBillion + "억" + item.depositFeeTenMillion + " / " + item.monthPrice);
		            	}
		            }
		
		            if (item.itemType == 'O') {
		                emailSubject3.find('p').text("원룸   " + item.itemSize + "평 / " + item.itemSize * 3.3 + "㎡   " + item.itemFloor + "층 / " + item.buildingFloor + "층");
		            } else if (item.itemType == 'T') {
		                emailSubject3.find('p').text("투룸   " + item.itemSize + "평 / " + item.itemSize * 3.3 + "㎡   " + item.itemFloor + "층 / " + item.buildingFloor + "층");
		            } else if (item.itemType == 'H') {
		                emailSubject3.find('p').text("쓰리룸   " + item.itemSize + "평 / " + item.itemSize * 3.3 + "㎡   " + item.itemFloor + "층 / " + item.buildingFloor + "층");
		            } else if (item.itemType == 'F') {
		                emailSubject3.find('p').text("오피스텔   " + item.itemSize + "평 / " + item.itemSize * 3.3 + "㎡   " + item.itemFloor + "층 / " + item.buildingFloor + "층");
		            }
		
		            mediaBody.append(emailSubject1);
		            mediaBody.append(emailSubject2);
		            mediaBody.append(emailSubject3);
		            mediaBody.append(emailSubject);
		            mediaBody.append(emailText);
		
		            propertyItem.append(mediaImgWrap);
		            propertyItem.append(mediaBody);
		
		            // 매물 리스트 항목에 마우스 오버 이벤트 리스너 등록
		            propertyItem.mouseover(function () {
		                // 새로운 마커 생성
		                var latLng = new kakao.maps.LatLng(item.lat, item.lng);
		                marker = new kakao.maps.Marker({
		                    position: latLng,
		                    image: new kakao.maps.MarkerImage("../resources/comm/marker2.png", imageSize)
		                });
		
		                // 생성된 마커를 지도에 추가
		                marker.setMap(map);
		            });
		
		            // 매물 리스트 항목에 마우스 아웃 이벤트 리스너 등록
		            propertyItem.mouseout(function () {
		                // 마우스 아웃 시 마커 숨기기
		                if (marker) {
		                    marker.setMap(null); // 마커 제거
		                }
		            });
		
		            propertyList.append(propertyItem);
		            propertyList.append(hr);
		        });
		    }
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
		
	    <!-- 매물 봤다면 봤다는 표시 -->
	    <script>
		 	// JavaScript 코드
		    document.addEventListener('DOMContentLoaded', function() {
			    // 모든 매물 항목을 가져옵니다.
			    var propertyItems = document.querySelectorAll('.property-item');
			
			    // 클릭한 매물의 상태를 localStorage에서 가져와 배경색을 설정합니다.
			    propertyItems.forEach(function(item) {
			        var isClicked = localStorage.getItem('clicked_' + item.id);
			        if (isClicked === 'true') {
			            item.classList.add('clicked');
			        }
			
			        // 클릭 이벤트를 처리합니다.
			        item.addEventListener('click', function() {
			            // 클릭한 매물 항목에 'clicked' 클래스를 추가합니다.
			            item.classList.add('clicked');
			
			            // 클릭한 매물의 상태를 localStorage에 저장합니다.
			            localStorage.setItem('clicked_' + item.id, 'true');
			        });
			    });
			});
		</script>
	    
    </body>
</html>