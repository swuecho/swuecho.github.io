---
layout: page
title: Util 
permalink: /Util/
---

### Arabic Number to Written Number translator

 <fieldset>
  <legend> translator </legend>
  Number: <input id='number' type="number"><br>
  <button onclick="util_translate()"> translate </button>
 </fieldset>
 <p id="result"></p>

<script>
function util_translate() {
	var number = document.getElementById('number').value;
	document.getElementById("result").innerHTML = number + ' : <br/> '+ writtenNumber(number);
}
</script>

<script src="/assets/js/util.js"></script>
