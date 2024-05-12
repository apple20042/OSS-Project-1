#!/bin/bash
echo "************OSS1 - Project1************"
echo "*        StudentID : 12211690         *"
echo "*        Name : Dongju Cho            *"
echo "***************************************"

get_son_data() {
	read -p "Do you want to get the Heung-Min Son's data? (y/n) :" choice
	if [ "$choice" == "y" ]; then 
		son_data=$(awk -F',' '$1=="Heung-Min Son" {print "Team:"$4", Appearance:"$6", Goal:"$7", Assist:"$8}' players.csv)
	       echo "$son_data"
       fi	       
}

get_team_data() {
	league_position=$1
	teams_csv="teams.csv"
	awk -F',' -v position="$league_position" '$6 == position { win_rate=($2)/($2+$3+$4); printf "%d %s %.6f\n", $6, $1, win_rate }' "$teams_csv"	
}



get_position_scorer() {
	teams_csv="teams.csv"
	players_csv="players.csv"
	if [ ! -f "$teams_csv" ]; then
		exit 1
	fi

	if [ ! -f "$players_csv" ]; then
		exit 1
	fi

	sort -t ',' -k 6n "$teams_csv" | while IFS=, read -r common_name wins draws losses points_per_game league_position cards_total shots fouls; do
		echo "$league_position $common_name"

		awk -F',' -v team="$common_name" 'NR > 1 && ($4 == team && $7 > max) { max=$7; player=$1 } END {printf "%s %s %d\n", player, team, max}' "$players_csv" | sed 's/?/\\?/'
		echo "$top_scorer" | sed 's/?/\\?/'
	done < "$teams_csv"
}

get_date_GMT() {
	if [ ! -f "matches.csv" ]; then
		exit 1
	fi
	awk -F',' 'NR > 1 {print $1}' matches.csv | head -n 10 | sed -E 's/([a-zA-Z]{3}) ([0-9]{2}) ([0-9]{4}) - ([0-9:]+)([ap]m)/\3\/\1\/\2 \4\5/'
}



while true; do
	echo -e "\n[MENU]"
	echo "1. Get the data of Heung-MIn Son's Current Club, Appearances, Goals, Assists in players.csv"
	echo "2. Get the team data to enter a league position in teams.csv"
	echo "3. Get the Top-3 Attendance matches in matches.csv"
	echo "4. Get the team's league position and team's top scorer in teams.csv & players.csv"
	echo "5. Get the modified format of data_GMT in matches.csv"
	echo "6. Get the data of the winning team by the largest difference on home stadium in teams.csv & matches.csv"
	echo "7. Exit"
	read -p "Enter your CHOICE (1~7) : " number
	case $number in
		1)
			get_son_data
			;;
		2)
			read -p "What do you want to get the team data of league_position[1~20] : " league_position
			get_team_data "$league_position"
			;;
		3)
			read -p "Do you want to know Top-3 attendance data and average attendance? (y/n) : " choice
			if [ "$choice" == "y" ]; then
				get_top3_attendance
			fi
			;;
		4)
			read -p "Do you want to get each team's ranking and the highest-scoring player? (y/n) : " choice
			if [ "$choice" == "y" ]; then
				get_position_scorer
			fi
			;;
		5)
			read -p "Do you want to midify the format of date? (y/n) : " choice
			if [ "$choice" == "y" ]; then
				get_date_GMT
			fi
			;;
		6)
			echo "1) Arsenal             11) Liverpool"
			echo "2) Tottenham Hotspur   12) Chelsea"
			echo "3) Manchester City     13) West Ham United"
			echo "4) Leicester City      14) Watford"
			echo "5) Crystal Palace      15) Newcastle United"
			echo "6) Everton             16) Cardiff City"
			echo "7) Burnley             17) Fulham"
			echo "8) Southampton         18) Brighton & Hove Albion"
			echo "9) AFC Bournemouth     19) Huddersfield Town"
			echo "10) Manchester United  20) Wolverhampton Wanderers"   
			read -p "Enter your team number : " team_number
			get_largest_difference "$team_number"
			;;
		7)
			echo -e "Bye!\n"
			exit
			;;
	esac
done
