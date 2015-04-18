---
layout: page
title: Util 
permalink: /Util/
---

### Arabic Number to Written Number translator

<form>
 <fieldset>
  <legend> translator </legend>
  Number: <input id='number' type="number"><br>
  <button onclick="translate()"> translate </button>
 </fieldset>
</form>
  <p id="result"></p>

<script>
function translate() {
	var number = document.getElementById('number').value;
	document.getElementById("result").innerHTML = number + ' : <br/> '+ writtenNumber(number);
}
</script>

<script src="//code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="/assets/js/util.js"></script>
