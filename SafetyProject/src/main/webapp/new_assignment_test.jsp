<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Assign Inspection</title>
<!-- Link to Bootstrap CSS -->
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/inspection_navigation.css">
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/BigInteger.js"></script>
<script src="assets/js/BigInteger.min.js"></script>

<script>function preventBack() {
            history.pushState(null, null, location.href);
            window.onpopstate = function () {
                history.pushState(null, null, location.href);
            };
        }

        // Call the function on page load
        window.onload = preventBack;
    </script>
<%@page import="org.json.*,java.time.*,java.time.format.*"%>
</head>
<body>
	<!-- Navigation Bar -->
	<nav>
		<%@ include file="navbar.jsp"%>
	</nav>

	<!-- Main Content -->
	<div class="container">
		<div class="form-container">
			<h2 class="text-center mb-4">Assign Inspection</h2>
			<form>
				<!-- 				<div class="mb-3 row">
					<label class="col-sm-3 col-form-label">Hello, <strong>username</strong>
						(Office Code)
					</label>
					<div class="col-sm-9">
						<p class="form-control-static"></p>
					</div>
				</div> -->
				<!-- <div class="mb-3 row">
                    <label for="officeCode" class="col-sm-3 col-form-label">Your Office Code</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" id="officeCode" placeholder="Enter Office Code" required>
                    </div>
                </div> -->
				<div class="mb-3 row">
					<label for="teamMembers" class="col-sm-3 col-form-label">Number
						of Team Members</label>
					<div class="col-sm-9">
						<select class="form-control" id="teamMembers"
							onchange="updateERPFields()">
							<option disabled selected hidden=>Select Team Members</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
						</select>
					</div>
				</div>
				<div id="erpIdContainer"></div>
				<div class="mb-3 row">
					<label class="col-sm-3 col-form-label">Inspection Date</label>
					<div class="col-sm-4">
						<input type="date" class="form-control" id="inspectionDateStart"
							required>
					</div>
					<div class="col-sm-1 text-center">to</div>
					<div class="col-sm-4">
						<input type="date" class="form-control" id="inspectionDateEnd"
							required>
					</div>
				</div>
				<p id="dateError" class="error text-danger" aria-live="assertive"></p>
				<!-- Error message container with red text -->
				<div class="mb-3 row">
					<label for="officeName" class="col-sm-3 col-form-label">Office
						Name</label>
					<!-- <div class="col-sm-9">
                        <input type="text" class="form-control" id="officeName" placeholder="Enter Office Name" required>
                    </div> -->
					<div class="col-sm-9">
						<select class="form-control" id="officeName" name="officeName"
							required>
							<option value="">Select Office Name</option>
							<!-- Add options here dynamically or hardcode them -->
							<option value="3300000">BERHAMPORE ZONE (3300000)</option>
							<option value="3500000">BURDWAN ZONE (3500000)</option>
							<option value="3100000">KOLKATA ZONE (3100000)</option>
							<option value="3200000">MIDNAPORE ZONE (3200000)</option>
							<option value="3400000">SILIGURI ZONE (3400000)</option>
							<option value="3450000">ALIPURDUAR REGION (3450000)</option>
							<option value="3230000">BANKURA REGION (3230000)</option>
							<option value="3120000">BIDHANNAGAR REGION (3120000)</option>
							<option value="3520000">BIRBHUM REGION (3520000)</option>
							<option value="3510000">BURDWAN REGION (3510000)</option>
							<option value="3440000">COOCHBEHAR REGION (3440000)</option>
							<option value="3460000">DAKSHIN DINAJPUR (3460000)</option>
							<option value="3410000">DARJEELING REGION (3410000)</option>
							<option value="3530000">HOOGHLY REGION (3530000)</option>
							<option value="3130000">HOWRAH REGION (3130000)</option>
							<option value="3420000">JALPAIGURI REGION (3420000)</option>
							<option value="3250000">JHARGRAM REGION (3250000)</option>
							<option value="3470000">KALINGPONG REGION (3470000)</option>
							<option value="3340000">MALDA REGION (3340000)</option>
							<option value="3310000">MURSHIDABAD REGION (3310000)</option>
							<option value="3330000">NADIA REGION (3330000)</option>
							<option value="3150000">NORTH 24 PGS REGION (3150000)</option>
							<option value="3540000">PASCHIM BURDWAN REGION (3540000)</option>
							<option value="3210000">PASCHIM MIDNAPORE REGION
								(3210000)</option>
							<option value="3220000">PURBA MIDNAPORE REGION (3220000)</option>
							<option value="3240000">PURULIA REGION (3240000)</option>
							<option value="3430000">RAIGUNJ REGION (3430000)</option>
							<option value="3110000">SOUTH 24 PGS REGION (3110000)</option>
							<option value="3453000">ALIPURDUAR Division (3453000)</option>
							<option value="3533000">ARAMBAGH Division (3533000)</option>
							<option value="3541000">ASANSOL Division (3541000)</option>
							<option value="3158000">BADURIA Division (3158000)</option>
							<option value="3461000">BALURGHAT Division (3461000)</option>
							<option value="3232000">BANKURA Division (3232000)</option>
							<option value="3152000">BARACKPUR Division (3152000)</option>
							<option value="3153000">BARASAT Division (3153000)</option>
							<option value="3113000">BARUIPUR Division (3113000)</option>
							<option value="3156000">BASIRHAT Division (3156000)</option>
							<option value="3112000">BEHALA Division (3112000)</option>
							<option value="3216000">BELDA Division (3216000)</option>
							<option value="3314000">BERHAMPORE Division (3314000)</option>
							<option value="3124000">BHANGAR Division (3124000)</option>
							<option value="3122000">BIDHANNAGAR-I Division (3122000)</option>
							<option value="3123000">BIDHANNAGAR-II Division
								(3123000)</option>
							<option value="3233000">BISHNUPUR Division (3233000)</option>
							<option value="3523000">BOLPUR Division (3523000)</option>
							<option value="3157000">BONGAON Division (3157000)</option>
							<option value="3462000">BUNIADPUR Division (3462000)</option>
							<option value="3512000">BURDWAN (NORTH) Division
								(3512000)</option>
							<option value="3518000">BURDWAN (SOUTH) Division
								(3518000)</option>
							<option value="3119000">CANNING(D)DIV. Division
								(3119000)</option>
							<option value="3532000">CHANDANNAGAR Division (3532000)</option>
							<option value="3223000">CONTAI Division (3223000)</option>
							<option value="3444000">COOCHBEHAR Division (3444000)</option>
							<option value="3414000">DARJEELING Division (3414000)</option>
							<option value="3117000">DIAMOND HARBOUR Division
								(3117000)</option>
							<option value="3446000">DINHATA Division (3446000)</option>
							<option value="3317000">DOMKAL DIVISION Division
								(3317000)</option>
							<option value="3542000">DURGAPUR Division (3542000)</option>
							<option value="3225000">EGRA Division (3225000)</option>
							<option value="3115000">GARIA Division (3115000)</option>
							<option value="3213000">GHATAL Division (3213000)</option>
							<option value="3154000">HABRA Division (3154000)</option>
							<option value="3224000">HALDIA Division (3224000)</option>
							<option value="3132000">HOWRAH-I Division (3132000)</option>
							<option value="3135000">HOWRAH-II Division (3135000)</option>
							<option value="3434000">ISLAMPUR Division (3434000)</option>
							<option value="3422000">JALPAIGURI Division (3422000)</option>
							<option value="3251000">JHARGRAM Division (3251000)</option>
							<option value="3318000">JIAGANJ DIVISION Division
								(3318000)</option>
							<option value="3116000">JOYNAGAR Division (3116000)</option>
							<option value="3118000">KAKDWIP Division (3118000)</option>
							<option value="3471000">KALINGPONG Division (3471000)</option>
							<option value="3516000">KALNA Division (3516000)</option>
							<option value="3332000">KALYANI Division (3332000)</option>
							<option value="3316000">KANDI Division (3316000)</option>
							<option value="3515000">KATWA Division (3515000)</option>
							<option value="3212000">KHARAGPUR Division (3212000)</option>
							<option value="3234000">KHATRA Division (3234000)</option>
							<option value="3333000">KRISHNANAGAR Division (3333000)</option>
							<option value="3413000">KURSEONG Division (3413000)</option>
							<option value="3427000">MAL Division (3427000)</option>
							<option value="3445000">MATHABHANGA Division (3445000)</option>
							<option value="3517000">MEMARI Division (3517000)</option>
							<option value="3214000">MIDNAPUR Division (3214000)</option>
							<option value="3536000">MOGRA Division (3536000)</option>
							<option value="3155000">NAIHATI Division (3155000)</option>
							<option value="3336000">NAKASI PARA Division (3336000)</option>
							<option value="3125000">NEW-TOWN Division (3125000)</option>
							<option value="3343000">NORTH MALDA Division (3343000)</option>
							<option value="3242000">PURULIA Division (3242000)</option>
							<option value="3315000">RAGHUNATHGANJ Division (3315000)</option>
							<option value="3243000">RAGHUNATHPUR Division (3243000)</option>
							<option value="3522000">RAMPURHAT Division (3522000)</option>
							<option value="3335000">RANAGHAT Division (3335000)</option>
							<option value="3412000">SILIGURI Division (3412000)</option>
							<option value="3415000">SILIGURI SUB-URBAN Division
								(3415000)</option>
							<option value="3535000">SINGUR Division (3535000)</option>
							<option value="3342000">SOUTH MALDA Division (3342000)</option>
							<option value="3531000">SREERAMPUR Division (3531000)</option>
							<option value="3521000">SURI Division (3521000)</option>
							<option value="3222000">TAMLUK Division (3222000)</option>
							<option value="3534000">TARAKESWAR Division (3534000)</option>
							<option value="3334000">TEHATTA Division (3334000)</option>
							<option value="3133000">ULUBERIA Division (3133000)</option>
							<option value="3432000">UTTAR DINAJPUR Division
								(3432000)</option>
							<option value="3112102">BUDGE BUDGE CCC (3112102)</option>
							<option value="3112500">AMTALA CCC (3112500)</option>
							<option value="3112501">NODAKHALI CCC (3112501)</option>
							<option value="3112700">BAKRAHAT CCC (3112700)</option>
							<option value="3112800">PAILAN CCC (3112800)</option>
							<option value="3112900">USTHI CCC (3112900)</option>
							<option value="3113102">CHAMPAHATI CCC (3113102)</option>
							<option value="3113302">MAGRAHAT CCC (3113302)</option>
							<option value="3113400">BARUIPUR CCC (3113400)</option>
							<option value="3113401">RAMNAGAR CCC (3113401)</option>
							<option value="3113500">MAHINAGAR CCC (3113500)</option>
							<option value="3115300">BANSDRONI CCC (3115300)</option>
							<option value="3115400">GARIA CCC (3115400)</option>
							<option value="3115500">RAJPUR CCC (3115500)</option>
							<option value="3115600">SONARPUR CCC (3115600)</option>
							<option value="3115700">BOALIA CCC (3115700)</option>
							<option value="3117300">FALTA SEZ CCC (3117300)</option>
							<option value="3118201">KAKDWIP CCC (3118201)</option>
							<option value="3118202">NAMKHANA CCC (3118202)</option>
							<option value="3118203">RUDRANAGAR CCC (3118203)</option>
							<option value="3118204">PATHAR PRATIMA CCC (3118204)</option>
							<option value="3119101">CANNING CCC (3119101)</option>
							<option value="3119102">BASANTI CCC (3119102)</option>
							<option value="3119104">JIBANTALA CCC (3119104)</option>
							<option value="3119105">GOSABA CCC (3119105)</option>
							<option value="3122200">BIDHANNAGAR CCC-I (3122200)</option>
							<option value="3122300">BIDHANNAGAR CCC-II (3122300)</option>
							<option value="3122400">BIDHANNAGAR CCC-III (3122400)</option>
							<option value="3123101">NEW BARRACKPUR CCC (3123101)</option>
							<option value="3115800">BORAL CCC (3115800)</option>
							<option value="3116101">JOYNAGAR CCC (3116101)</option>
							<option value="3116102">DAKSHIN BARASAT CCC (3116102)</option>
							<option value="3116103">KULTALI CCC (3116103)</option>
							<option value="3116104">MATHURAPUR CCC (3116104)</option>
							<option value="3116105">LAXMIKANTAPUR CCC (3116105)</option>
							<option value="3117101">DIAMOND HARBOUR CCC (3117101)</option>
							<option value="3117102">SARISHA CCC (3117102)</option>
							<option value="3117103">FALTA CCC (3117103)</option>
							<option value="3117104">KULPI CCC (3117104)</option>
							<option value="3132700">JAGADISHPUR CCC (3132700)</option>
							<option value="3132800">DASNAGAR CCC (3132800)</option>
							<option value="3133101">ULUBERIA CCC (3133101)</option>
							<option value="3133102">BURIKHALI CCC (3133102)</option>
							<option value="3133109">BIRSHIBPUR CCC (3133109)</option>
							<option value="3133201">BAGNAN-I CCC (3133201)</option>
							<option value="3123102">BIRATI CCC (3123102)</option>
							<option value="3123200">BAGUIHATI CCC (3123200)</option>
							<option value="3123300">RAJARHAT CCC (3123300)</option>
							<option value="3123301">LAUHATI CCC (3123301)</option>
							<option value="3123500">KRISHNAPUR CCC (3123500)</option>
							<option value="3123600">TEGHORIA CCC (3123600)</option>
							<option value="3124100">KOLKATA LEATHER COMPLEX CCC
								(3124100)</option>
							<option value="3124101">BHANGAR CCC (3124101)</option>
							<option value="3124102">MINAKHAN CCC (3124102)</option>
							<option value="3124103">SARBERIA CCC (3124103)</option>
							<option value="3125100">NEWTOWN ACTION AREA I (3125100)</option>
							<option value="3125101">NEWTOWN ACTION AREA II (3125101)</option>
							<option value="3125102">NEWTOWN ACTION AREA III
								(3125102)</option>
							<option value="3132100">ANDUL-MOURI CCC (3132100)</option>
							<option value="3132101">JALDHULAGORI CCC (3132101)</option>
							<option value="3132400">BHATTANAGAR CCC (3132400)</option>
							<option value="3132500">SANTRAGACHI CCC (3132500)</option>
							<option value="3132600">BALLY CCC (3132600)</option>
							<option value="3133202">BAGNAN-II CCC (3133202)</option>
							<option value="3133203">AJODHYA CCC (3133203)</option>
							<option value="3133208">DEULGRAM CCC (3133208)</option>
							<option value="3133209">SHYAMPUR CCC (3133209)</option>
							<option value="3133500">PANCHLA CCC (3133500)</option>
							<option value="3133600">GARCHUMUK CCC (3133600)</option>
							<option value="3133700">MANSHATALA CCC (3133700)</option>
							<option value="3135200">SALAP CCC (3135200)</option>
							<option value="3135300">BARGACHIA CCC (3135300)</option>
							<option value="3135400">DOMJUR CCC (3135400)</option>
							<option value="3135500">MUNSHIRHAT CCC (3135500)</option>
							<option value="3135600">AMTA CCC (3135600)</option>
							<option value="3135700">AMRAGORAI CCC (3135700)</option>
							<option value="3135800">UDAYNARAYANPUR CCC (3135800)</option>
							<option value="3152101">RAHARA CCC (3152101)</option>
							<option value="3152201">SODEPUR CCC (3152201)</option>
							<option value="3152202">PANSILA CCC (3152202)</option>
							<option value="3152203">AGARPARA CCC (3152203)</option>
							<option value="3152206">MURAGACHA CCC (3152206)</option>
							<option value="3152301">ANANDAPURI SECTOR CCC(SAP)
								(3152301)</option>
							<option value="3152302">JAFARPUR CCC (3152302)</option>
							<option value="3152303">TALPUKUR CCC (3152303)</option>
							<option value="3152400">ARABINDA NAGAR CCC (3152400)</option>
							<option value="3152500">BARRACKPORE CCC (3152500)</option>
							<option value="3153103">GANGANAGAR CCC (3153103)</option>
							<option value="3153104">JEERAT CCC (3153104)</option>
							<option value="3153105">KADAMGACHI CCC (3153105)</option>
							<option value="3153401">BARASAT GR CCC (3153401)</option>
							<option value="3153402">NABAPALLY CCC (3153402)</option>
							<option value="3153403">MADHYAMGRAM CCC (3153403)</option>
							<option value="3153404">DUTTAPUKUR CCC (3153404)</option>
							<option value="3153500">NOAPARA CCC (3153500)</option>
							<option value="3153600">BARASAT-II CCC (3153600)</option>
							<option value="3153700">DEGANGA CCC (3153700)</option>
							<option value="3154102">HABRA CCC (3154102)</option>
							<option value="3154201">GOBARDANGA CCC (3154201)</option>
							<option value="3154202">GAIGHATA CCC (3154202)</option>
							<option value="3154400">ASHOKNAGAR CCC (3154400)</option>
							<option value="3154401">GUMA CCC (3154401)</option>
							<option value="3154600">BANIPUR CCC (3154600)</option>
							<option value="3155300">HALISAHAR CCC (3155300)</option>
							<option value="3155301">JETIA CCC (3155301)</option>
							<option value="3155401">BHATPARA CCC (3155401)</option>
							<option value="3155402">KANKINARA CCC (3155402)</option>
							<option value="3155403">SHYAMNAGAR CCC (3155403)</option>
							<option value="3155404">ATPUR CCC (3155404)</option>
							<option value="3155500">KANCHRAPARA CCC (3155500)</option>
							<option value="3153101">BERACHAMPA CCC (3153101)</option>
							<option value="3156105">HINGALGANJ CCC (3156105)</option>
							<option value="3158101">BADURIA CCC (3158101)</option>
							<option value="3158106">HAROA CCC (3158106)</option>
							<option value="3158102">KEOTSHA CCC (3158102)</option>
							<option value="3158105">KHOLAPATA CCC (3158105)</option>
							<option value="3156300">BASHIRHAT CCC (3156300)</option>
							<option value="3156301">MAITRABAGAN CCC (3156301)</option>
							<option value="3158104">KATIAHAT CCC (3158104)</option>
							<option value="3157101">BANGAON CCC (3157101)</option>
							<option value="3157102">GOPALNAGAR CCC (3157102)</option>
							<option value="3157103">BAGDA CCC (3157103)</option>
							<option value="3157104">GANRAPATA CCC (3157104)</option>
							<option value="3157105">THAKURNAGAR CCC (3157105)</option>
							<option value="3212101">MALANCHA CCC (3212101)</option>
							<option value="3212120">NIMPURA CCC (3212120)</option>
							<option value="3212200">KHARAGPUR CCC (3212200)</option>
							<option value="3155501">KAMPA CCC (3155501)</option>
							<option value="3155600">NAIHATI CCC (3155600)</option>
							<option value="3155601">DEULPARA CCC (3155601)</option>
							<option value="3156101">HASNABAD CCC (3156101)</option>
							<option value="3156102">BHEBIA CCC (3156102)</option>
							<option value="3158103">SWARUPNAGAR CCC (3158103)</option>
							<option value="3156104">SANDESHKHALI CCC (3156104)</option>
							<option value="3214205">B R Sector CCC (3214205)</option>
							<option value="3214206">Barua CCC (3214206)</option>
							<option value="3214207">Salboni CCC (3214207)</option>
							<option value="3214208">Anandapur CCC (3214208)</option>
							<option value="3214209">PIRAKATA CCC (3214209)</option>
							<option value="3214402">AMLAGOLA CCC (3214402)</option>
							<option value="3214503">CHANDRAKONA ROAD CCC (3214503)</option>
							<option value="3251101">Jhargram CCC (3251101)</option>
							<option value="3212501">BALICHAK CCC (3212501)</option>
							<option value="3212502">SABONG CCC (3212502)</option>
							<option value="3212503">PINGLA CCC (3212503)</option>
							<option value="3212506">LOWADA CCC (3212506)</option>
							<option value="3212507">CHANDKURI CCC (3212507)</option>
							<option value="3212703">MADPUR CCC (3212703)</option>
							<option value="3213401">DASPUR CCC (3213401)</option>
							<option value="3213402">SONAKHALI CCC (3213402)</option>
							<option value="3213403">GHATAL CCC (3213403)</option>
							<option value="3213404">BIRSINGHAPUR CCC (3213404)</option>
							<option value="3213405">RAMJIBANPUR CCC (3213405)</option>
							<option value="3213406">CK TOWN CCC (3213406)</option>
							<option value="3213407">UPPERKUAI CCC (3213407)</option>
							<option value="3214100">Midnapur CCC (3214100)</option>
							<option value="3251102">Manikpara CCC (3251102)</option>
							<option value="3251103">Jambonui CCC (3251103)</option>
							<option value="3251105">Gopiballavpur CCC (3251105)</option>
							<option value="3251104">Binpur CCC (3251104)</option>
							<option value="3251106">BELPAHARI CCC (3251106)</option>
							<option value="3216201">BELDA CCC (3216201)</option>
							<option value="3251107">NAYAGRAM CCC (3251107)</option>
							<option value="3251108">SANKRAIL CCC (3251108)</option>
							<option value="3216204">KESHIARY CCC (3216204)</option>
							<option value="3216205">NARAYANGARH CCC (3216205)</option>
							<option value="3216206">DANTAN CCC (3216206)</option>
							<option value="3216207">MOHANPUR CCC (3216207)</option>
							<option value="3216208">KHAKURDA CCC (3216208)</option>
							<option value="3222102">NANDAKUMAR CCC (3222102)</option>
							<option value="3222103">MOINA CCC (3222103)</option>
							<option value="3222104">GOURANGAPUR CCC (3222104)</option>
							<option value="3222301">KOLAGHAT CCC (3222301)</option>
							<option value="3222302">GOPALNAGAR CCC (3222302)</option>
							<option value="3222303">PANSHKURA CCC (3222303)</option>
							<option value="3222308">PRATAPPUR CCC (3222308)</option>
							<option value="3222500">TAMLUK CCC (3222500)</option>
							<option value="3222600">MATANGINI CCC (3222600)</option>
							<option value="3223101">CONTAI CCC (3223101)</option>
							<option value="3223102">DIGHA CCC (3223102)</option>
							<option value="3223109">Marisda CCC (3223109)</option>
							<option value="3223110">Pichaboni CCC (3223110)</option>
							<option value="3223114">MUKUNDAPUR CCC (3223114)</option>
							<option value="3223203">KHEJURI CCC (3223203)</option>
							<option value="3223206">MADHAKHALI CCC (3223206)</option>
							<option value="3224108">CHANDIPUR CCC (3224108)</option>
							<option value="3224109">MAHISADAL CCC (3224109)</option>
							<option value="3224110">NANDIGRAM CCC (3224110)</option>
							<option value="3224114">BRAJALALCHAK CCC (3224114)</option>
							<option value="3224201">CHAITANYAPUR CCC (3224201)</option>
							<option value="3224202">DURGACHAK CCC (3224202)</option>
							<option value="3225101">EGRA CCC (3225101)</option>
							<option value="3225102">BHAGABANPUR CCC (3225102)</option>
							<option value="3225103">PATASHPUR CCC (3225103)</option>
							<option value="3225104">CHOREPALIA CCC (3225104)</option>
							<option value="3225105">BALIGHAI CCC (3225105)</option>
							<option value="3225106">AMARSHI CCC (3225106)</option>
							<option value="3232202">BELIATORE CCC (3232202)</option>
							<option value="3232203">BARJORA CCC (3232203)</option>
							<option value="3232205">MAJIA CCC (3232205)</option>
							<option value="3232207">GANGAJALGHATI CCC (3232207)</option>
							<option value="3233101">BISHNUPUR CCC (3233101)</option>
							<option value="3233103">PATRASAYER CCC (3233103)</option>
							<option value="3233105">JOYPUR CCC (3233105)</option>
							<option value="3233107">KOTULPUR CCC (3233107)</option>
							<option value="3233109">ONDA CCC (3233109)</option>
							<option value="3233111">SONAMUKHI CCC (3233111)</option>
							<option value="3233113">INDUS CCC (3233113)</option>
							<option value="3233115">RADHANAGAR CCC (3233115)</option>
							<option value="3234100">KHATRA CCC (3234100)</option>
							<option value="3234101">INDPUR CCC (3234101)</option>
							<option value="3234102">RANIBANDH CCC (3234102)</option>
							<option value="3234103">SARENGA CCC (3234103)</option>
							<option value="3234104">SIMLAPAL CCC (3234104)</option>
							<option value="3234105">TALDANGRA CCC (3234105)</option>
							<option value="3234106">HIRBANDH CCC (3234106)</option>
							<option value="3234107">RAIPUR CCC (3234107)</option>
							<option value="3242102">TELKALPARA CCC (3242102)</option>
							<option value="3242201">JOYPUR CCC (3242201)</option>
							<option value="3242202">ARSHA CCC (3242202)</option>
							<option value="3232401">SALTORA CCC (3232401)</option>
							<option value="3232402">JHANTIPAHARI CCC (3232402)</option>
							<option value="3232403">CHHATNA CCC (3232403)</option>
							<option value="3232501">PATPUR SECTOR CCC (3232501)</option>
							<option value="3232503">SCHOOLDANGA SECTOR CCC (3232503)</option>
							<option value="3232504">LALBAZAR SECTOR CCC (3232504)</option>
							<option value="3243501">ADRA CCC (3243501)</option>
							<option value="3243502">ANARA CCC (3243502)</option>
							<option value="3243503">DUBRAPARA CCC (3243503)</option>
							<option value="3243504">KASHIPUR CCC (3243504)</option>
							<option value="3243701">MANBAZAR CCC (3243701)</option>
							<option value="3243702">PUNCHA CCC (3243702)</option>
							<option value="3314101">KHAGRA SECTOR CCC (3314101)</option>
							<option value="3314102">GORABAZAR SECTOR CCC (3314102)</option>
							<option value="3314103">COSSIMBAZAR SECTOR CCC (3314103)</option>
							<option value="3314104">BERHAMPORE CCC (3314104)</option>
							<option value="3314202">BEHARAN CCC (3314202)</option>
							<option value="3314203">BELDANGA CCC (3314203)</option>
							<option value="3314204">REJINAGAR CCC (3314204)</option>
							<option value="3242203">JHALDA CCC (3242203)</option>
							<option value="3242301">BALARAMPUR CCC (3242301)</option>
							<option value="3242302">BAGMUNDI CCC (3242302)</option>
							<option value="3242303">BARABAZAR CCC (3242303)</option>
							<option value="3242600">PURULIA CCC (3242600)</option>
							<option value="3242705">BUNDWAN CCC (3242705)</option>
							<option value="3243101">HURA CCC (3243101)</option>
							<option value="3243401">RAGHUNATHPUR CCC (3243401)</option>
							<option value="3243402">SALTORE CCC (3243402)</option>
							<option value="3243403">SANTURI CCC (3243403)</option>
							<option value="3243404">CHELIAMA CCC (3243404)</option>
							<option value="3317101">CHAKISLAMPUR CCC (3317101)</option>
							<option value="3317102">DAULATABAD CCC (3317102)</option>
							<option value="3317103">DOMKAL CCC (3317103)</option>
							<option value="3317104">RANINAGAR CCC (3317104)</option>
							<option value="3317105">JALANGI CCC (3317105)</option>
							<option value="3318101">AZIMGUNJ CCC (3318101)</option>
							<option value="3318102">BHAGABANGOLA CCC (3318102)</option>
							<option value="3314205">AMTALA CCC (3314205)</option>
							<option value="3314208">SARGACHHI CCC (3314208)</option>
							<option value="3315101">RAGHUTATHGANJ CCC (3315101)</option>
							<option value="3315102">JANGIPUR CCC (3315102)</option>
							<option value="3315103">AURANGABAD CCC (3315103)</option>
							<option value="3315104">DHULIAN CCC (3315104)</option>
							<option value="3315105">FARAKKA CCC (3315105)</option>
							<option value="3315114">AHIRAN CCC (3315114)</option>
							<option value="3315201">SAGARDIGHI CCC (3315201)</option>
							<option value="3316101">KANDI CCC (3316101)</option>
							<option value="3316102">BHARATPUR CCC (3316102)</option>
							<option value="3316103">SALAR CCC (3316103)</option>
							<option value="3316104">PANCHTHUPI CCC (3316104)</option>
							<option value="3316105">KHARGRAM CCC (3316105)</option>
							<option value="3316201">GOALJAN CCC (3316201)</option>
							<option value="3316202">SHAKTIPUR CCC (3316202)</option>
							<option value="3316203">GOKARNA CCC (3316203)</option>
							<option value="3334204">TEHATTA CCC (3334204)</option>
							<option value="3318103">NABAGRAM CCC (3318103)</option>
							<option value="3318104">LALGOLA CCC (3318104)</option>
							<option value="3318105">MURSHIDABAD MUNICIPAL TOWN CCC
								(3318105)</option>
							<option value="3318106">JIAGANJ CCC (3318106)</option>
							<option value="3318112">MAYA CCC (3318112)</option>
							<option value="3332103">CHAKDAH(WEST) CCC (3332103)</option>
							<option value="3332201">SUBARNAPUR CCC (3332201)</option>
							<option value="3332202">MADANPUR CCC (3332202)</option>
							<option value="3332208">NAGARUKHRA CCC (3332208)</option>
							<option value="3332300">CHAKDA(E) CCC (3332300)</option>
							<option value="3332301">EAST BISHNUPUR CCC (3332301)</option>
							<option value="3332401">KALYANI SECTOR OFFICE CCC
								(3332401)</option>
							<option value="3332402">GAYESHPUR SECTOR OFFICE CCC
								(3332402)</option>
							<option value="3333101">KISHANGANJ CCC (3333101)</option>
							<option value="3333103">SWARUPGANJ CCC (3333103)</option>
							<option value="3333105">BAGULA CCC (3333105)</option>
							<option value="3333106">KRISHNAGAR ROAD STATION CCC
								(3333106)</option>
							<option value="3333502">CHITRASALI CCC (3333502)</option>
							<option value="3333503">KRISHNAGAR TOWN CCC (3333503)</option>
							<option value="3333600">NABADWEEP CCC (3333600)</option>
							<option value="3334201">PANCHADHARA ABHAYANAGAR CCC
								(3334201)</option>
							<option value="3334202">CHAPRA CCC (3334202)</option>
							<option value="3334203">KARIMPUR CCC (3334203)</option>
							<option value="3334208">NAZIRPUR CCC (3334208)</option>
							<option value="3335100">ARANGHATA CCC (3335100)</option>
							<option value="3335101">AISHTOLA SECTOR OFFICE CCC
								(3335101)</option>
							<option value="3335102">GANGNAPUR CCC (3335102)</option>
							<option value="3335103">RANAGHAT(E) CCC (3335103)</option>
							<option value="3335104">RANAGHAT(WEST) CCC (3335104)</option>
							<option value="3335105">ULABINNAGAR CCC (3335105)</option>
							<option value="3335106">BADKULLA CCC (3335106)</option>
							<option value="3335107">DIGNAGAR CCC (3335107)</option>
							<option value="3335108">FULIA CCC (3335108)</option>
							<option value="3335109">SANTIPUR CCC (3335109)</option>
							<option value="3335110">SUTRAGARH CCC (3335110)</option>
							<option value="3336101">BETHUADAHARI(NORTH)CCC (3336101)</option>
							<option value="3336102">DEBAGRAM CCC (3336102)</option>
							<option value="3336103">DHUBULIA CCC (3336103)</option>
							<option value="3336104">MOTIARY CCC (3336104)</option>
							<option value="3336110">MURAGACHA_DHARMADA CCC (3336110)</option>
							<option value="3336209">PALASSEY CCC (3336209)</option>
							<option value="3342101">OLD MALDA CCC (3342101)</option>
							<option value="3342102">MATHURAPUR CCC (3342102)</option>
							<option value="3342103">GOLAPGANJ CCC (3342103)</option>
							<option value="3342104">AIHO CCC (3342104)</option>
							<option value="3342109">BAISHNABNAGAR CCC (3342109)</option>
							<option value="3342301">KALIACHAK CCC (3342301)</option>
							<option value="3342302">MOTHABARI CCC (3342302)</option>
							<option value="3343102">SAMSI CCC (3343102)</option>
							<option value="3343103">PARANPUR CCC (3343103)</option>
							<option value="3343104">CHANCHAL CCC (3343104)</option>
							<option value="3343105">MALATIPUR CCC (3343105)</option>
							<option value="3343106">HARISHCHANDRAPUR CCC (3343106)</option>
							<option value="3343107">GAJOL CCC (3343107)</option>
							<option value="3343108">BAMONGOLA CCC (3343108)</option>
							<option value="3343119">KUSHIDA CCC (3343119)</option>
							<option value="3412400">MILANPALLY CCC (3412400)</option>
							<option value="3412401">NJP GATEBAZAR CCC (3412401)</option>
							<option value="3412501">SUBHASPALLY SECTOR CCC (3412501)</option>
							<option value="3412502">HAKIMPARA SECTOR CCC (3412502)</option>
							<option value="3412503">POWER HOUSE SECTOR CCC (3412503)</option>
							<option value="3412504">PRADHANNAGAR SECTOR CCC
								(3412504)</option>
							<option value="3412505">SILIGURI TOWN CCC (3412505)</option>
							<option value="3413101">SONADA CCC (3413101)</option>
							<option value="3413201">MIRIK CCC (3413201)</option>
							<option value="3413202">KURSEONG CCC (3413202)</option>
							<option value="3414101">SUKHIAPOKHRIA CCC (3414101)</option>
							<option value="3342304">SUJAPUR CCC (3342304)</option>
							<option value="3342601">RATHBARI CCC (3342601)</option>
							<option value="3342602">FULBARI CCC (3342602)</option>
							<option value="3342603">MOKDUMPUR CCC (3342603)</option>
							<option value="3343101">BHALUKA CCC (3343101)</option>
							<option value="3471102">TEESTA BAZAR CCC (3471102)</option>
							<option value="3471103">MONGPU CCC (3471103)</option>
							<option value="3471104">PEDONG CCC (3471104)</option>
							<option value="3471105">SINJEE CCC (3471105)</option>
							<option value="3422102">BELACOVA CCC (3422102)</option>
							<option value="3422108">FULBARIHAT CCC (3422108)</option>
							<option value="3422201">MOINAGURI CCC (3422201)</option>
							<option value="3422206">BHOTPATTY CCC (3422206)</option>
							<option value="3422301">DHUPGURI CCC (3422301)</option>
							<option value="3422401">PANDAPARA &NAYABASTI SECTOR CCC
								(3422401)</option>
							<option value="3422402">MASKALAIBARI &UKILPARA SECTOR
								CCC (3422402)</option>
							<option value="3414102">TAKDAH CCC (3414102)</option>
							<option value="3414201">BIJANBARI CCC (3414201)</option>
							<option value="3414204">LODHAMA CCC (3414204)</option>
							<option value="3414300">DARJEELING CCC (3414300)</option>
							<option value="3415101">NAXALBARI CCC (3415101)</option>
							<option value="3415102">PHANSIDEWA CCC (3415102)</option>
							<option value="3415103">KHARIBARI CCC (3415103)</option>
							<option value="3415200">BAGDOGRA CCC (3415200)</option>
							<option value="3415201">BIDHAN NAGAR CCC (3415201)</option>
							<option value="3415400">MATIGARA CCC (3415400)</option>
							<option value="3415600">SHIBMANDIR CCC (3415600)</option>
							<option value="3471101">KALINGPONG CCC (3471101)</option>
							<option value="3444302">NEW-TOWN SECTOR CCC (3444302)</option>
							<option value="3444303">PUNDIBARI CCC (3444303)</option>
							<option value="3444503">TUFANGANJ CCC (3444503)</option>
							<option value="3444506">BOXIRHAT CCC (3444506)</option>
							<option value="3427101">MAL CCC (3427101)</option>
							<option value="3427102">OODLABARI CCC (3427102)</option>
							<option value="3427103">METTELI CCC (3427103)</option>
							<option value="3427104">JHALUNGPAREN CCC (3427104)</option>
							<option value="3427105">NAGRAKATA CCC (3427105)</option>
							<option value="3427106">BANERHAT CCC (3427106)</option>
							<option value="3427108">KANTI CCC (3427108)</option>
							<option value="3432101">ITAHAR CCC (3432101)</option>
							<option value="3432102">HEMTABAD CCC (3432102)</option>
							<option value="3432301">KALIAGANJ CCC (3432301)</option>
							<option value="3432400">RAIGANJ CCC (3432400)</option>
							<option value="3432500">BIRNAGAR CCC (3432500)</option>
							<option value="3432800">KARANDIGHI CCC (3432800)</option>
							<option value="3434201">ISLAMPUR CCC (3434201)</option>
							<option value="3434202">CHOPRA CCC (3434202)</option>
							<option value="3434203">DALKHOLA CCC (3434203)</option>
							<option value="3434204">GOALPOKHAR CCC (3434204)</option>
							<option value="3434205">KANKI CCC (3434205)</option>
							<option value="3444300">COOCHBEHAR CCC (3444300)</option>
							<option value="3444301">KHAGRABARI SECTOR CCC (3444301)</option>

						</select>
					</div>
				</div>
				<div class="mb-3 row">
					<label for="remarks" class="col-sm-3 col-form-label">Remarks</label>
					<div class="col-sm-9">
						<textarea class="form-control" id="remarks" rows="3"
							placeholder="Enter remarks"></textarea>
					</div>
				</div>
				<div class="mb-3 row">
					<div class="col-sm-12 text-center">
						<button type="button" class="btn btn-primary" id="assgnSubmitbtn">Assign
							Inspection</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<!-- Footer -->
	<footer class="text-center mt-auto">
		<div class="text-center p-3">© 2024 IT&C Cell, WBSEDCL</div>
	</footer>

	<script>
	var name= "";
	var erp_id= "";
	var designation= "";
	var office= "";
	var userRole= "";
	var tkn= "";
	
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
	
	const getCurrentDate = () => {
		const date = new Date();
	    let year = String(date.getFullYear());
	    
	    let month = String(date.getMonth() + 1); // Add 1 to the month
	    month = month.length === 1 ? "0" + month : month;
	    let day = String(date.getDate());
	    day = day.length === 1 ? "0" + day : day;
	    
	    //return `${year}-${day}-${month}`;
	    return year+ "-"+ day+ "-"+ month;
	}
	
	function fetchERPIds() {
        // Simulate an async fetch from an ERP server via RFC
        return new Promise((resolve) => {
            setTimeout(() => {
                // Example ERP IDs
                const erpIds = ["90012775", "90009977", "90009981", "900012774", "90012776"];
                resolve(erpIds);
            }, 1000); // Simulates a 1-second delay
        });
    }
	
	document.addEventListener('DOMContentLoaded', () => {
		document.getElementById('inspectionDateStart').addEventListener('input', validateInspectionDates);
        document.getElementById('inspectionDateEnd').addEventListener('input', validateInspectionDates);

		var cookieData = JSON.parse(getCookie('empDtls'));
		//get different value based on key of cookieData json
		var name= cookieData.empDtls.EMNAMCL;
		var erp_id= cookieData.User;
		var designation= cookieData.empDtls.STEXTCL;
		var office= cookieData.empDtls.LTEXTCL;
		var userRole= cookieData.empDtls.STELLCL;
		var tkn= cookieData.tkn;
		
		$('#assgnSubmitbtn').on('click', function() {
			var jsonObject = {};
	    	jsonObject.assignedDate= getCurrentDate();
	    	jsonObject.inspectionFromDate= document.getElementById('inspectionDateStart').value;
	    	jsonObject.inspectionToDate= document.getElementById('inspectionDateEnd').value;
	    	jsonObject.inspectionId= "";
	    	
	    	// Collect all ERP IDs
	        var erpIds = [];
	        $('.erp-select').each(function() {
	            var erpId = $(this).val();
	            if (erpId !== 'Select ERP ID') {
	                erpIds.push(erpId);
	            }
	        });
	        
	    	//jsonObject.empAssignedTo= document.getElementById('erpId1').value;
	    	jsonObject.empAssignedTo= erpIds;
	    	jsonObject.empAssignedBy= erp_id;
	    	jsonObject.rectifiedBy= "";
	    	jsonObject.assignedFromOff= office;
	    	jsonObject.officeCodeToInspect= document.getElementById('officeName').value;
	    	jsonObject.status= "ASSIGNED";
	    	jsonObject.inspectedBy= "";
	    	jsonObject.tkn= tkn;
	    	jsonObject.pageNm= "DASH";
	    	jsonObject.ServType= 101;
        	$.ajax({
        		url: 'http://10.251.37.170:8080/testSafety/testSafety', // replace with above Servlet URL
        		type: 'POST',
        		data: JSON.stringify(jsonObject),
        		contentType: 'application/json', // Specify content type
        		success: function(response) {
        			if(response.ackMsgCode== '101'){
        				alert("assignment successful");
        				window.location.href = 'assign_inspection.jsp';
        			}
        			console.log("entered success function");
        			//alert(JSON.stringify(jsonObject));
					console.log("Data sent and session updated successfully.");
				},
				error: function(xhr, status, error) {
					//console.error("Error sending data:", status, error);
					console.error("xhr: " + JSON.stringify(xhr) + "\nstatus: " + status + "\nerror: " + error);
				}
        	});		
        });
		
		preventBack();
		document.getElementById("cookieDisplay").innerText = cookieData ?name+ ", "+ designation+" (ERP ID: "+ erp_id+ ") " : "Cookie not found.";
	});
	
	function updateERPFields() {
	    const number = document.getElementById('teamMembers').value;
	    const container = document.getElementById('erpIdContainer');
	    container.innerHTML = ''; // Clear previous fields

	    // Pre-defined list of ERP IDs
	    const erpIds = ["90012775", "90009977", "90009981", "90012774", "90012776"];

	    for (let i = 1; i <= number; i++) {
	        const div = document.createElement('div');
	        div.className = 'mb-3 row';

	        // Create label
	        const label = document.createElement('label');
	        label.setAttribute('for', 'erpId' + i);
	        label.className = 'col-sm-3 col-form-label';
	        label.textContent = 'ERP ID ' + i;

	        // Create select dropdown
	        const inputDiv = document.createElement('div');
	        inputDiv.className = 'col-sm-9';
	        const select = document.createElement('select');
	        select.className = 'form-control erp-select';
	        select.id = 'erpId' + i;
	        select.name = 'erpId' + i;

	        // Add a default disabled option
	        const defaultOption = document.createElement('option');
	        defaultOption.textContent = 'Select ERP ID';
	        defaultOption.disabled = true;
	        defaultOption.selected = true;
	        select.appendChild(defaultOption);

	        // Populate the select dropdown with ERP IDs
	        erpIds.forEach(function (erpId) {
	            const option = document.createElement('option');
	            option.value = erpId;
	            option.textContent = erpId;
	            select.appendChild(option);
	        });

	        // Append the select dropdown to the div
	        inputDiv.appendChild(select);
	        div.appendChild(label);
	        div.appendChild(inputDiv);
	        container.appendChild(div);
	    }
	    
	 // Add event listeners to all the dropdowns
	    $('.erp-select').on('change', function () {
	        filterDropdownOptions();
	    });
	}
	
	// Function to filter options in dropdowns
	function filterDropdownOptions() {
	    const allSelects = document.querySelectorAll('.erp-select');
	    const selectedValues = [];

	    // Get all selected values
	    allSelects.forEach(select => {
	        if (select.value !== 'Select ERP ID') {
	            selectedValues.push(select.value);
	        }
	    });

	    // Update options in each dropdown
	    allSelects.forEach(select => {
	        const currentSelection = select.value;
	        const options = select.querySelectorAll('option');

	        // Enable/disable options based on the selected values in other dropdowns
	        options.forEach(option => {
	            if (option.value !== 'Select ERP ID') {
	                if (selectedValues.includes(option.value) && option.value !== currentSelection) {
	                    //option.disabled = true;
	                    option.style.display = 'none';
	                } else {
	                    //option.disabled = false;
	                    option.style.display = 'block';
	                }
	            }
	        });
	    });
	}

        
        function validateInspectionDates() {
            const startDateInput = document.getElementById('inspectionDateStart');
            const endDateInput = document.getElementById('inspectionDateEnd');
            const errorDisplay = document.getElementById('dateError');
            const assgnSubmitbtn = document.getElementById('assgnSubmitbtn');
            
            const startDate = new Date(startDateInput.value);
            const endDate = new Date(endDateInput.value);
            const today = new Date();
            today.setHours(0, 0, 0, 0); // Reset time to midnight

            // Validate start date
            if (startDate < today) {
                errorDisplay.textContent = "Start date cannot be in the past.";
                startDateInput.classList.add('is-invalid'); // Add Bootstrap error styling
                errorDisplay.classList.add('text-danger'); // Show red error message
                assgnSubmitbtn.disabled = true;
            } else {
                startDateInput.classList.remove('is-invalid');
                assgnSubmitbtn.disabled = false;
            }

            // Validate end date only if it's entered
            if (endDateInput.value) {
                if (endDate < today) {
                    errorDisplay.textContent = "End date cannot be in the past.";
                    endDateInput.classList.add('is-invalid');
                    errorDisplay.classList.add('text-danger');
                    assgnSubmitbtn.disabled = true;
                } else if (endDate < startDate) {
                    errorDisplay.textContent = "End date cannot be before start date.";
                    endDateInput.classList.add('is-invalid');
                    errorDisplay.classList.add('text-danger');
                    assgnSubmitbtn.disabled = true;
                } else {
                    endDateInput.classList.remove('is-invalid');
                    assgnSubmitbtn.disabled = false;
                }
            }

            // If both start and end dates are valid, clear the error message
            if (startDate >= today && (!endDateInput.value || (endDate >= today && endDate >= startDate))) {
                errorDisplay.textContent = ""; // Clear error message
                errorDisplay.classList.remove('text-danger');
            }
        }
        
        
    </script>
	<!-- <script src="assets/js/login.js"></script> -->
</body>
</html>