---
layout: post
title:  html5 canvas
date:   2015-08-19 14:11 
categories: tech 
---

HTML5 canvas example

<canvas id="mycanvas"> </canvas>

```{javascript}
        var mycanvas = document.getElementById("mycanvas");
        var mycontext = mycanvas.getContext("2d");

        mycontext.beginPath();
        mycontext.moveTo(10, 10);
        mycontext.lineTo(35, 35);
        mycontext.strokeStyle = "#000";
        mycontext.stroke();

        mycontext.beginPath();
        mycontext.arc(35, 25, 10, 0, Math.PI * 2, true);
        mycontext.fillStyle = "#f00";
        mycontext.fill();

    # code from html5 cookbook

```
    
<script>
        var mycanvas = document.getElementById("mycanvas");
        var mycontext = mycanvas.getContext("2d");

        mycontext.beginPath();
        mycontext.moveTo(10, 10);
        mycontext.lineTo(35, 35);
        mycontext.strokeStyle = "#000";
        mycontext.stroke();

        mycontext.beginPath();
        mycontext.arc(35, 25, 10, 0, Math.PI * 2, true);
        mycontext.fillStyle = "#f00";
        mycontext.fill();
 </script>

