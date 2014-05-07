<html>
<?
$irrigationCaddy = "192.168.1.60";

function runNowForm($zone) {
    global $irrigationCaddy;
?>
    <!--  <form method="POST" action="http://requestb.in/18anybe1"> -->
    <form method="POST" action="http://<?=$irrigationCaddy?>/program.htm">
        <b>Zone <?=$zone?>:</b>
        <? if ($zone == 1) echo '<input type="text"   name="z1durMin" value="1" width="3"/>'; else echo '<input type="hidden"   name="z1durMin" value="0"/>'; ?>
        <? if ($zone == 2) echo '<input type="text"   name="z2durMin" value="1" width="3"/>'; else echo '<input type="hidden"   name="z2durMin" value="0"/>'; ?>
        <? if ($zone == 3) echo '<input type="text"   name="z3durMin" value="1" width="3"/>'; else echo '<input type="hidden"   name="z3durMin" value="0"/>'; ?>
        <? if ($zone == 4) echo '<input type="text"   name="z4durMin" value="1" width="3"/>'; else echo '<input type="hidden"   name="z4durMin" value="0"/>'; ?>
        <? if ($zone == 5) echo '<input type="text"   name="z5durMin" value="1" width="3"/>'; else echo '<input type="hidden"   name="z5durMin" value="0"/>'; ?>
        <? if ($zone == 6) echo '<input type="text"   name="z6durMin" value="1" width="3"/>'; else echo '<input type="hidden"   name="z6durMin" value="0"/>'; ?>
        <? if ($zone == 7) echo '<input type="text"   name="z7durMin" value="1" width="3"/>'; else echo '<input type="hidden"   name="z7durMin" value="0"/>'; ?>
        <? if ($zone == 8) echo '<input type="text"   name="z8durMin" value="1" width="3"/>'; else echo '<input type="hidden"   name="z8durMin" value="0"/>'; ?>
        <? if ($zone == 9) echo '<input type="text"   name="z9durMin" value="1" width="3"/>'; else echo '<input type="hidden"   name="z9durMin" value="0"/>'; ?>
        <input type="submit" value="Run"/>
        <input type="hidden"   name="z1durHr" value="0"/>
        <input type="hidden"   name="z2durHr" value="0"/>
        <input type="hidden"   name="z3durHr" value="0"/>
        <input type="hidden"   name="z4durHr" value="0"/>
        <input type="hidden"   name="z5durHr" value="0"/>
        <input type="hidden"   name="z6durHr" value="0"/>
        <input type="hidden"   name="z7durHr" value="0"/>
        <input type="hidden"   name="z8durHr" value="0"/>
        <input type="hidden"   name="z9durHr" value="0"/>
        <input type="hidden"   name="doProgram" value="1"/>
        <input type="hidden"   name="runNow" value="1"/>
        <input type="hidden"   name="pgmNum" value="4"/>
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

