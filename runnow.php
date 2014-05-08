<html>
<?
$irrigationCaddy = "192.168.1.60";

function minSelect($zone) {
?>
<select name="<?="z${zone}durMin"?>">
  <option value="1">1</option>
  <option value="2">2</option>
  <option value="3">3</option>
  <option value="4">4</option>
  <option value="5">5</option>
  <option value="6">6</option>
  <option value="7">7</option>
  <option value="8">8</option>
  <option value="9">9</option>
  <option value="10">10</option>
</select>
<?
}

function runNowForm($zone) {
    global $irrigationCaddy;
?>
    <!-- <form method="POST" action="http://requestb.in/18anybe1">  -->
    <form method="POST" action="http://<?=$irrigationCaddy?>/program.htm">
        <b>Zone <?=$zone?>:</b>
        <?
        minSelect($zone);
        for ( $i=1; $i<=9; $i++ ) {
            if ($zone != $i)
                echo '<input type="hidden" name="z'.$i.'durMin" value="0"/>'."\n";
        }
        ?>
        <input type="hidden" name="z1durHr" value="0"/>
        <input type="hidden" name="z2durHr" value="0"/>
        <input type="hidden" name="z3durHr" value="0"/>
        <input type="hidden" name="z4durHr" value="0"/>
        <input type="hidden" name="z5durHr" value="0"/>
        <input type="hidden" name="z6durHr" value="0"/>
        <input type="hidden" name="z7durHr" value="0"/>
        <input type="hidden" name="z8durHr" value="0"/>
        <input type="hidden" name="z9durHr" value="0"/>
        <input type="hidden" name="doProgram" value="1"/>
        <input type="hidden" name="runNow" value="1"/>
        <input type="hidden" name="pgmNum" value="4"/>
        <input type="submit" value="Run"/>
    </form>
<? } ?>
<head>
</head>
<body>
    <form method="POST" action="http://<?=$irrigationCaddy?>/stopSprinklers.htm">
        <input type="submit" value="Stop Active Zone"/>
        <input type="hidden" name="stop" value="active"/>
    </form>
<?
runNowForm(1);
runNowForm(2);
runNowForm(3);
runNowForm(4);
runNowForm(5);
runNowForm(6);
runNowForm(7);
runNowForm(8);
runNowForm(9);
?>
</body>
</html>

