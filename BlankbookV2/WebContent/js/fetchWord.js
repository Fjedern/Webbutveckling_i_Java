
// URLs to APIs
const fetchWordUrl = "http://api.wordnik.com/v4/words.json/randomWords?hasDictionaryDef=true&minCorpusCount=0&minLength=5&maxLength=8&limit=1&api_key=a2a73e7b926c924fad7001ca3111acd55af2ffabf50eb4ae5";



fetch(fetchWordUrl).then(response => response.json()).then(data => useTheWordData(data));

// you can read more about it here
//https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch


;
// This is just a normal function that has an argument 
function useTheWordData(data) {
	// lets print the data we just sent here.
	console.log(data);

	// lets get that word
	let wordUrl = data[0].word;
	// print it to make sure its the right thing
	console.log(wordUrl);
	
	// now get a good spot for it and add a src into the html tag. 
	document.getElementById("wordPlace").innerHTML = wordUrl.toUpperCase();
}
