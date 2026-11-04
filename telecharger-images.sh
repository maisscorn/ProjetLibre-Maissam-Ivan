#!/bin/bash
# Télécharge les images des sports depuis Wikimedia Commons dans public/img/
# À lancer depuis la racine du projet : bash telecharger-images.sh
set -u
mkdir -p public/img
UA="SportsNiches-ProjetHEIG/1.0"
ok=0; ko=0
dl() {
  # $1 = nom du fichier Commons (déjà encodé pour l'URL), $2 = nom de destination
  if [ -s "public/img/$2" ]; then echo "déjà là : $2"; ok=$((ok+1)); return; fi
  if curl -fsSL -A "$UA" "https://commons.wikimedia.org/wiki/Special:FilePath/$1?width=1200" -o "public/img/$2"; then
    echo "OK : $2"; ok=$((ok+1))
  else
    echo "ÉCHEC : $2"; rm -f "public/img/$2"; ko=$((ko+1))
  fi
  sleep 1
}

dl '2015_King%27s_Cup_Quidditch_Tournament,_Syracuse,_NY-01.JPG' 'quidditch-1.jpg'
dl 'Quidditch_match_in_Hyde_Park.jpg' 'quidditch-2.jpg'
dl '14548-Bubble_Soccer-9146_(15789509140).jpg' 'bubble-football-1.jpg'
dl 'Chess_Boxing_2007_(1).jpg' 'chessboxing-1.jpg'
dl 'Schachboxen1.jpg' 'chessboxing-2.jpg'
dl 'Esteit%C3%A4keppihevosella2020.jpg' 'hobby-horsing-1.jpg'
dl 'Sheaf_toss_001.jpg' 'lancer-botte-de-paille-1.jpg'
dl 'Caber_Toss.jpg' 'caber-toss-1.jpg'
dl 'Highland_games_caber_toss_2.JPG' 'caber-toss-2.jpg'
dl 'Wellie_Wanging._One_handed_forward_throw_method.JPG' 'lancer-de-bottes-1.jpg'
dl 'Pelote_basque.jpg' 'pelote-basque-main-nue-1.jpg'
dl 'Esteren%C3%A7uby_Pelote.JPG' 'pelote-basque-main-nue-2.jpg'
dl 'Man_highlining_in_Yosemite_National_Park_with_El_Capitan_in_the_background.JPG' 'slackline-1.jpg'
dl 'Lost_Arrow_Spire_Slackline.jpeg' 'slackline-2.jpg'
dl 'Parkour.jpg' 'parkour-1.jpg'
dl 'Parkour_Frankfurt.jpg' 'parkour-2.jpg'
dl 'Balaruc-les-Bains_jeu_de_boules.JPG' 'petanque-en-bateau-1.jpg'
dl 'Extermeironingrivelin.jpg' 'extreme-ironing-1.jpg'
dl 'UW-rugby_match_1.jpg' 'rugby-subaquatique-1.jpg'
dl 'Underwater_rugby_banner.jpg' 'rugby-subaquatique-2.jpg'
dl 'CheeseRolling.jpg' 'cheese-rolling-1.jpg'
dl 'CheeseRollingRace.jpg' 'cheese-rolling-2.jpg'
dl 'SoapboxRace.jpg' 'course-de-cuvettes-1.jpg'
dl 'Wood_chopping_competition,_jill-and-jill_sawing,_Ekka,_Brisbane,_2015.jpg' 'timbersports-1.jpg'
dl 'Dragon_boat_racing.jpg' 'dragon-boat-1.jpg'
dl 'Three_Dragon_Boats_in_Last_Race_of_the_Day.jpg' 'dragon-boat-2.jpg'
dl 'Flying_Disc_-_Ultimate_Frisbee_-_World_Games_2005_(1).jpg' 'ultimate-frisbee-1.jpg'
dl 'Ultimate_Frisbee,_Jul_2009_-_17.jpg' 'ultimate-frisbee-2.jpg'
dl 'Bossaball-wiki-2.jpg' 'bossaball-1.jpg'
dl 'Bossaball_in_%22El_Camp%C3%ADn%22.jpg' 'bossaball-2.jpg'
dl 'Sepak_takraw.jpg' 'sepak-takraw-1.jpg'
dl 'Sepak_Takraw_Bangkok.jpg' 'sepak-takraw-2.jpg'
dl '20e_journ%C3%A9e_du_championnat_de_france_2013-2014_de_Kin-Ball_097.jpg' 'kin-ball-1.jpg'
dl 'KIN_4519.JPG' 'kin-ball-2.jpg'
dl 'Jorky.jpg' 'jorkyball-1.jpg'

echo
echo "Terminé : $ok image(s) OK, $ko échec(s)."
echo
echo "À télécharger à la main (choisir une image dans la catégorie, ou reprendre la maquette) :"
echo "  public/img/bubble-football-2.jpg  ->  https://commons.wikimedia.org/wiki/Category:Bubble_football"
echo "  public/img/hobby-horsing-2.jpg  ->  https://commons.wikimedia.org/wiki/Category:Hobbyhorsing"
echo "  public/img/lancer-botte-de-paille-2.jpg  ->  https://commons.wikimedia.org/wiki/Category:Highland_games"
echo "  public/img/lancer-de-bottes-2.jpg  ->  https://commons.wikimedia.org/wiki/Category:Shoe_tossing"
echo "  public/img/petanque-en-bateau-2.jpg  ->  https://commons.wikimedia.org/wiki/Category:P%C3%A9tanque"
echo "  public/img/extreme-ironing-2.jpg  ->  https://commons.wikimedia.org/wiki/Category:Extreme_ironing"
echo "  public/img/course-de-lits-1.jpg  ->  photo de la maquette Canva"
echo "  public/img/course-de-lits-2.jpg  ->  photo de la maquette Canva"
echo "  public/img/course-de-cuvettes-2.jpg  ->  https://commons.wikimedia.org/wiki/Category:Red_Bull_Soapbox_Races"
echo "  public/img/timbersports-2.jpg  ->  https://commons.wikimedia.org/wiki/Category:Stihl_Timbersports_Series"
echo "  public/img/jorkyball-2.jpg  ->  https://commons.wikimedia.org/wiki/Category:Jorkyball"
echo "  public/img/hero.jpg  ->  photo de course de lits de la maquette Canva"
