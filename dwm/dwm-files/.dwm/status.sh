#! /usr/bin/zsh


sb_ram() {
	mem=$(free -h | awk '/Mem:/ { print $3 }' | cut -f1 -d 'i')
	echo ≣  "$mem"
}

sb_cpu() {
	read -r cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read -r cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	echo   "$cpu"%
}

sb_clock() {
	dte=$(date +"%D")
	time=$(date +"%H:%M")

	echo "  $dte -   $time"
}

sb_batt(){
	per=$(upower -i $(upower -e | grep 'BAT') | grep -E "percentage")

	echo "󱊣 ${per: -4}";
}
xsetroot -name "|| $(sb_batt) | $(sb_ram) | $(sb_cpu) | $(sb_clock) || [daffyd] ||"
