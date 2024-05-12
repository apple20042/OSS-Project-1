# OSS-Project-1

1. Get the data of Heung-Min Son's Current Club, Appearances, Goals, Assists in players.csv

read -p "Do you want to get the Heung-Min Son's data? (y/n) :" choice 
사용자로부터 손흥민의 데이터를 가져올지 입력을 받고 $choice 변수에 저장된다.

if [ "$choice" == "y" ]; then
son_data=$(awk -F',' '$1=="Heung-Min Son" {print "Team:"$4", Appearance:"$6", Goal:"$7", Assist:"$8}' players.csv)
echo "$son_data"
y를 입력하면 awk 명령어를 통해 players.csv에서 손흥민의 데이터를 찾는다. -F‘,’를 통해 구분 기호 쉼표를 사용한다. 첫 번째 인자가 손흥민인 행을 찾고 조건에 맞는 열의 값을 출력한다. 그 값을 son_data에 저장하고 출력한다.


2. Get the team data to enter a league position in teams.csv

league_position=$1 
teams_csv="teams.csv" 
awk -F',' -v position="$league_position" '$6 == position { win_rate=($2)/($2+$3+$4); printf "%d %s %.6f\n", $6, $1, win_rate }' "$teams_csv
league_position 변수에 함수로 전달된 매개변수를 할당한다. -v를 사용해서 position 변수를 awk 스크립트로 전달하고 6번째 열의 값과 일치하는지 확인한다. 일치하면 승률을 계산해주고 소수점은 6자리로 설정해주었다.


5. Get the modified format of date_GMT in matches.csv

awk -F',' 'NR >1 {print $1}' matches.csv | head -n 10 | sed -E 's/([a-zA-Z]{3}) ([0-9]{2}) ([0-9]{4}) - ([0-9:]+)([ap]m)/\3\/\1\/\2 \4\5/'
NR > 1을 통해 첫 번째 행(date_GMT)를 건너뛰고 두 번째 행부터 10개를 출력한다. sed를 사용하여 날짜 형식을 수정한다.



7. Exit

echo –e “Bye!\n”
exit
;;
\n가 적용되도록 –e를 사용하고 exit 해준다.





 
