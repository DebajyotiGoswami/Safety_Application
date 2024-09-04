<!-- Navigation Bar -->
<%@page import="org.json.*"%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	<div class="container-fluid">
		<!-- Left side: Welcome message -->
		<div id="cookieDisplay"></div>
		<%-- <span class="navbar-text"><%= username %> (ERP ID: <%= erpId %>, <%= designation %>)
			</span> --%>
		<span class="navbar-text"><div id="cookieDisplay"></div> </span>
		<!-- Right side: Navigation links -->
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-end"
			id="navbarNav">
			<ul class="navbar-nav">
				<li class="nav-item"><a class="nav-link" href="dashboard.jsp">Home</a>
				</li>
				<li class="nav-item"><a class="nav-link" href="contacts.html">Contact</a>
				</li>
				<li class="nav-item">
					<!-- Logout form -->
					<form action="LogoutServlet" method="POST" style="display: inline;">
						<button type="submit" class="btn btn-outline-light ml-2">Logout</button>
					</form>
				</li>
			</ul>
		</div>
	</div>
</nav>


 <script>
        // Function to prevent back navigation
        function preventBack() {
            history.pushState(null, null, location.href);
            window.onpopstate = function () {
                history.go(1);
            };
        }
        
        /* function setCookie(name, value, minutes) {
        	let expires = "";
        	if (minutes) {
        		const date = new Date();
        		date.setTime(date.getTime() + (minutes * 60 * 1000));
        		expires = "; expires=" + date.toUTCString();
        	}
        	//document.cookie = name + "=" + (value || "") + expires + "; path=/";
        	document.cookie = JSON.stringify(value);
        	//debugger; 
        }
        
        function getCookie(name) {
        	/* const nameEQ = name + "=";
        	const ca = document.cookie.split(';');
        	for (let i = 0; i < ca.length; i++) {
        		let c = ca[i];
        		while (c.charAt(0) === ' ') c = c.substring(1, c.length);
        		if (c.indexOf(nameEQ) === 0) {
        			return c.substring(nameEQ.length, c.length);
        		}
        	}
        	return null; */
        	//var cookie= JSON.parse(document.cookie);
        	//return cookie;
        	
       // } 

        	function setCookie(name, value, minutes) {
        		let expires = "";
        		if (minutes) {
        			const date = new Date();
        			date.setTime(date.getTime() + (minutes * 60 * 1000));
        			expires = "; expires=" + date.toUTCString();
        		}
        		document.cookie = name + "=" + (value || "") + expires + "; path=/";
        		console.log(typeof(document.cookie));
        		console.log(document.cookie);        		
        	}

        	function getCookie(name) {
        		const nameEQ = name + "=";
        		const ca = document.cookie.split(';');
        		for (let i = 0; i < ca.length; i++) {
        			let c = ca[i];
        			while (c.charAt(0) === ' ') c = c.substring(1, c.length);
        			if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
        		}
        		return null;
        	} 
        	
        	 /* function getCookie(name) {
                let cookieArr = document.cookie.split(";");
                for(let i = 0; i < cookieArr.length; i++) {
                    let cookiePair = cookieArr[i].split("=");
                    if(name == cookiePair[0].trim()) {
                        return decodeURIComponent(cookiePair[1]);
                    }
                }
                return null;
            } */
        	
        function displayCookie() {
            const cookieName = "empDtls"; // Replace with your cookie name
            const cookieValue = getCookie(cookieName);
            var name= cookieValue.name;
            var erp_id= cookieValue.erp_id;
            var designation= cookieValue.designation;
            var office= cookieValue.office;
            debugger;
            //document.getElementById("cookieDisplay").innerText = cookieValue ? `Cookie Value: ${cookieValue}` : "Cookie not found.";
            document.getElementById("cookieDisplay").innerText = cookieValue ?name+ ", "+ designation+" (ERP ID: "+ erp_id+ ") " : "Cookie not found.";

        }
        
        /* function onPageLoad() {
        	empDtls= {
            		"name": "Debajyoti Goswami",
            		"erp_id": "90012775",
            		"designation": "DE(IT&C)",
            		"office": "IT&C Cell"
            	};
        	//console.log("before calling setCookie");
        	setCookie("empDtls", JSON.stringify(empDtls), 30);
            displayCookie();
            preventBack();
        } */
        
        document.addEventListener('DOMContentLoaded', () => {
        	const empDtls = {
                    "name": "Debajyoti",
                    "erp_id": "90012775",
                    "designation": "DE(IT&C)",
                    "office": "VB",
                    "userRole": "1"
                }; 
        	//setCookie('empDetails', JSON.stringify(empDtls), 30);
        	const cookieData = JSON.parse(getCookie('empDtls'));
        	//get different value based on key of cookieData json
        	console.log(cookieData);
        	const name= cookieData.empDtls.EMNAMCL;
        	const erp_id= cookieData.User;
        	const designation= cookieData.empDtls.STEXTCL;
        	const office= cookieData.empDtls.LTEXTCL;
        	const userRole= cookieData.empDtls.STELLCL;
        	
        	document.getElementById("cookieDisplay").innerText = cookieData ?name+ ", "+ designation+" (ERP ID: "+ erp_id+ ") " : "Cookie not found.";
        	
        	/* if (userRole === "1"){
        		//Disable "Inspection Assignment" section for role 1
        		$(".card-title:contains('Inspection Assignment')").closest(".card").addClass("disabled-card");
        	}
        	if (userRole === "2") {
                // Disable "Inspection Entry" section for role 2
                $(".card-title:contains('Inspection Entry')").closest(".card").addClass("disabled-card");
            } else if (userRole === "3") {
                // Disable "Rectification Entry" section for role 3
                $(".card-title:contains('Rectification Entry')").closest(".card").addClass("disabled-card");
            } else if (userRole === "4") {
                // Disable "Reports" section for role 4
                $(".card-title:contains('Reports')").closest(".card").addClass("disabled-card");
            } */
        });
     // Call the function on page load
        //window.onload = onPageLoad;
        
        //console.log("cookie details: "+ getCookie("empDtls"));
    </script>