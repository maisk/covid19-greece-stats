<?php
  $static_path = '/_static/covid';
?>

<style>
    img.lplot {
        width:260px;
        border: 1px solid gray;
    }

    div.plots {
        margin-bottom: 25px;
    }

    div.covid h3 {
        margin-top: 24px;
        margin-bottom: 12px;
    }

</style>


<div class="covid">

<!--  <h2>COVID-19 Statistics</h2> -->


<p>
last data update: <?php  readfile('./data/covid/fetch.log');    ?>
</p>

<h3>Ελλάδα</h3>
<div class="plots">
  <a href="<?=$static_path?>/greece.html">Ελλάδα στατιστικά</a><br />
  <a href="<?=$static_path?>/greece.html"><img class="lplot" src="<?=$static_path?>/plots/covid_greece_confirmed_w.png" > </a>
  <a href="<?=$static_path?>/greece.html"><img class="lplot" src="<?=$static_path?>/plots/covid_greece_deaths_w.png" > </a>
  <a href="<?=$static_path?>/greece.html"><img class="lplot" src="<?=$static_path?>/plots/covid_greece_confirmed.png" > </a>
</div>

<h3>Σύγκριση Ελλάδας με άλλα κράτη</h3>
<div class="plots">
  <a href="<?=$static_path?>/confirmed.html">confirmed Cases: επιβεβαιωμένα κρούσματα</a><br />
  <a href="<?=$static_path?>/confirmed.html"><img class="lplot" src="<?=$static_path?>/plots/covid_confirmed_gsi.png" > </a>
  <a href="<?=$static_path?>/confirmed.html"><img class="lplot" src="<?=$static_path?>/plots/covid_confirmed_gcs.png" > </a>
  <a href="<?=$static_path?>/confirmed.html"><img class="lplot" src="<?=$static_path?>/plots/covid_confirmed_gbb.png" > </a>
</div>

<div class="plots">
  <a href="<?=$static_path?>/deaths.html">Deaths: επιβεβαιωμένoι θάνατοι από covid</a><br>
  <a href="<?=$static_path?>/deaths.html"><img class="lplot" src="<?=$static_path?>/plots/covid_deaths_gsi.png" > </a>
  <a href="<?=$static_path?>/deaths.html"><img class="lplot" src="<?=$static_path?>/plots/covid_deaths_gcs.png"  > </a>
  <a href="<?=$static_path?>/deaths.html"><img class="lplot" src="<?=$static_path?>/plots/covid_deaths_gbb.png"  > </a>
</div>

<div class="plots">
  <a href="<?=$static_path?>/fatality.html"> Fatality Rate: θάνατοι από covid προς επιβεβαιωμένα κρούσματα</a> <br>
  <a href="<?=$static_path?>/fatality.html"><img class="lplot" src="<?=$static_path?>/plots/covid_fatality_gsi.png" > </a>
  <a href="<?=$static_path?>/fatality.html"><img class="lplot" src="<?=$static_path?>/plots/covid_fatality_gcs.png" > </a>
  <a href="<?=$static_path?>/fatality.html"><img class="lplot" src="<?=$static_path?>/plots/covid_fatality_gbb.png" > </a>
</div>



<br/>
<ul>
  <li><a href="https://github.com/maisk/covid19-greece-stats"> source </a></li>
  <li><a href="https://github.com/CSSEGISandData"> data </a></li>

</ul>
</div>