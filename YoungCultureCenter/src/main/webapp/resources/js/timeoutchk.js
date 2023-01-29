let iSecond; //초단위로 환산
let timerChecker = null;

//페이지가 열리면 시간 초기화, 타이머 작동
window.onload = function () {
    clearTimer();
    initTimer();
}

//타이머 초기화
function clearTimer() {
    //x분 * 60초
    iSecond = 15 * 60;
}

Lpad = function (str, len) {
    str = str + "";
    while (str.length < len) {
        str = "0" + str;
    }
    return str;
}

// 타이머 : "XX분:XX초" 형태로 텍스트 갱신, 1초마다 iSecond 감소
function initTimer () {
    let timer = document.getElementById("timer");
    rHour = parseInt(iSecond / 3600);
    rHour = rHour % 60;

    rMinute = parseInt(iSecond / 60);
    rMinute = rMinute % 60;

    rSecond = iSecond % 60;

    if (iSecond > 0) {
        timer.innerHTML = Lpad(rMinute, 2) + " : " + Lpad(rSecond, 2);
        iSecond--;
        timerChecker = setTimeout("initTimer()", 1000); // 1초 간격으로 체크
    } else {
        logoutUser();
    }
}

function logoutUser() {
    //setTImeout 해제
    clearTimeout(timerChecker);
    
    var xhr = initAjax();
    xhr.open("POST", "/ycc/logout", true);
    /**
     * metahead.jsp
     * const csrfHeader = "${_csrf.headerName}"
	 * const csrfToken = "${_csrf.token}"
     */
    xhr.setRequestHeader(csrfHeader, csrfToken)
    xhr.send();
    alert('세션이 만료되어 로그아웃 하였습니다.');
    location.reload();
}

// 브라우저에 따른 AjaxObject 인스턴스 분기 처리
function initAjax() {
    let xmlhttp;
    if (window.XMLHttpRequest) {				// 지원브라우저 : IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else {									// 구형브라우저 : IE6, IE5 => ActiveX
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return xmlhttp;
}

function refreshTimer() {
    //ajax로 임의 주소에 post method 보내서 세션 갱신
    var xhr = initAjax();
    xhr.open("GET", "/ycc/error/403", false);
    xhr.setRequestHeader(csrfHeader, csrfToken)
    xhr.send();
    clearTimer();
}