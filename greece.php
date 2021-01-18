<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="author" content="Kostas Maistrelis">
  <meta name="keywords" content="statistics,covid">
  <link rel="stylesheet" href="style.css">
</head>

<body>

<style>
  p.desc {
      margin-top: 20px;
      margin-bottom: 8px;
  }
</style>

<div class="page_plots">
  <h1>COVID-19 Greece Statistics</h1>

  <p class="desc">
    confirmed Cases:  επιβεβαιωμένα κρούσματα
  </p>
  <a href="plots/covid_greece_confirmed.png" class="plots"><img  class="plots" src="plots/covid_greece_confirmed.png"/></a>
  <br/>
  <a href="plots/covid_greece_confirmed_w.png" class="plots"><img  class="plots" src="plots/covid_greece_confirmed_w.png"/></a>


  <p class="desc">
    Deaths:  επιβεβαιωμένοι θάνατοι από covid
  </p>
  <a href="plots/covid_greece_deaths.png" class="plots"><img  class="plots" src="plots/covid_greece_deaths.png"/></a>
  <br/>
  <a href="plots/covid_greece_deaths_w.png" class="plots"><img  class="plots" src="plots/covid_greece_deaths_w.png"/></a>


  <p class="desc">
    Fatality Rate: ο λόγος των θανάτων προς τα covid επιβεβαιωμένα κρούσματα εκφρασμένος ως ποσοστό επί τοις εκατό
  </p>
  <a href="plots/covid_greece_fatality.png" class="plots"><img  class="plots" src="plots/covid_greece_fatality.png"/></a>



</div>


<div class="return_link">
  <a  href="/content/covid-19">[επιστροφή]</a>
</div>

<script src="covid.js"></script>






</body>
</html>