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
</style>

<h2>COVID-19 Statistics</h2>

<div class="plots">
  <a href="<?=$static_path?>/confirmed.html">confirmed Cases: επιβεβαιωμένα κρούσματα</a><br />
  <a href="<?=$static_path?>/confirmed.html"><img class="lplot" src="<?=$static_path?>/plots/covid_confirmed_gsi.png" > </a>
  <a href="<?=$static_path?>/confirmed.html"><img class="lplot" src="<?=$static_path?>/plots/covid_confirmed_gcs.png" > </a>
  <a href="<?=$static_path?>/confirmed.html"><img class="lplot" src="<?=$static_path?>/plots/covid_confirmed_gbb.png" > </a>
</div>

<div class="plots">
  <a href="<?=$static_path?>/fatality.html"> Fatality Rate: θάνατοι από covid προς επιβεβαιωμένα κρούσματα</a> <br>
  <a href="<?=$static_path?>/fatality.html"><img class="lplot" src="<?=$static_path?>/plots/covid_fatality_gsi.png" > </a>
  <a href="<?=$static_path?>/fatality.html"><img class="lplot" src="<?=$static_path?>/plots/covid_fatality_gcs.png" > </a>
  <a href="<?=$static_path?>/fatality.html"><img class="lplot" src="<?=$static_path?>/plots/covid_fatality_gbb.png" > </a>
</div>

<div class="plots">
  <a href="<?=$static_path?>/deaths.html">Deaths: επιβεβαιωμένoι θάνατοι από covid</a><br>
  <a href="<?=$static_path?>/deaths.html"><img class="lplot" src="<?=$static_path?>/plots/covid_deaths_gsi.png" > </a>
  <a href="<?=$static_path?>/deaths.html"><img class="lplot" src="<?=$static_path?>/plots/covid_deaths_gcs.png"  > </a>
  <a href="<?=$static_path?>/deaths.html"><img class="lplot" src="<?=$static_path?>/plots/covid_deaths_gbb.png"  > </a>
</div>


<br/>
<ul>
  <li><a href="https://github.com/maisk/covid19-greece-stats"> source </a></li>
  <li><a href="https://github.com/CSSEGISandData"> data </a></li>
  <li>
    last data update: <?php  readfile('./data/covid/fetch.log');    ?>
  </li>

</ul>
