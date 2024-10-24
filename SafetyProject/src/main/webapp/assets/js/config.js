//dev
//export const API_URL= "/testSafety/testSafety";
//var API_URL= "/testSafety/testSafety";

//prod
//export const var API_URL= "/prodSafety/prodSafety";
//var API_URL= "/prodSafety/prodSafety";


/*
var API_URL = "http://10.251.37.170:8080/testSafety/testSafety";
var BASE_URL = "http://10.251.37.170:8080/SafetyProject/";
*/
let jsonURLObj = {
	"dev": {
		"API_URL": "/testSafety/testSafety",
		"BASE_URL": "/SafetyProject"
	},
	"prod": {
		"API_URL": "/prodSafety/prodSafety",
		"BASE_URL": "/SafetyProject"
	},
	"local": {
		"API_URL": "http://10.251.37.170:8080/testSafety/testSafety",
		"BASE_URL": "/SafetyProject"
	},
}

//let choice= "dev";
//let choice= "prod";
let choice = "local";

const API_URL = jsonURLObj[choice]["API_URL"];
const BASE_URL = jsonURLObj[choice]["BASE_URL"];

