# Praktijk Hoogbegaafd iOS

Dit project is een iOS variant van de [Praktijkhoogbegaafd repository](https://github.com/deBasMan21/PraktijkHoogbegaafd) (Android).
Dit project is in opdracht van [Praktijk Hoogbegaafd](https://www.praktijkhoogbegaafd.nl).

## Inhoud

- Project
- Techniek
- Veiligheid
- Deployment
- Project management

## Project

Het doel van de app is het bijhouden van intensiteiten. Er zijn 5 verschillende intensiteiten: Emotionele, Beeldende, Psychomotorische, Intellectuele en Sensorische intensiteit.
Deze intensiteiten moeten tot 3 keer per dag bijgehouden kunnen worden. Bij een volwassene is de waarde tussen de -2 en 2 en bij een kind is dit tussen de 0 en de 10.
De verzamelde gegevens van deze intensititeiten bij een persoon moeten getoond kunnen worden in een grafiek. Deze moet ook simpel gedeeld kunnen worden met de begeleidster.
Ook worden er statistieken berekend van de afgelopen periode. Deze periode kan je zelf kiezen. Dit is dezelfde periode als waar de grafiek van getoond wordt.
In het geval van een ouder en kind situatie wordt er verwacht dat de ouder invult wat hij/zij van de intensiteit bij het kind vindt.
Om mensen er aan te herinneren dat de intensiteiten ingevuld moeten worden kan je push notificaties krijgen. De tijd van deze kan je zelf instellen en ze zullen dagelijks herhalen.

## Techniek

De app is gemaakt door middel van Swift met als interfaces SwiftUI. Voor het programmeren in Swift is de MVVM architectuur aangehouden.
Elke view heeft zijn eigen viewmodel en deze viewmodel is verantwoordelijk voor alle functionaliteiten. De view is alleen verantwoordelijk voor het tonen van het scherm.
De models zijn de entiteiten die gebruikt zijn. De infrastructuur en logica zijn weer losgeschakeld van de viewmodels dus deze viewmodels roepen dan weer de infrastructuur en logica aan.
Hierdoor is het heel simpel om een van de onderdelen te vervangen door iets anders.

## Veiligheid

Er is voor deze app gekozen om geen backend te gebruiken. Alle data wordt lokaal opgeslagen op de device. Hierdoor is er ook geen veiligheidsrisico omdat alle data encrypted is op de device.
Voor het delen van de data wordt er telkens een screenshot gemaakt van de grafieken en deze worden in een pdf verwerkt.
Hierdoor is het enige wat naar buiten gaat een complete pdf en deze gaat direct naar de begeleidster.

## Deployment

Om de app te deployen naar de gebruikers wordt er in eerste instantie TestFlight van Apple gebruikt. Als er dan nog problemen voorkomen kunnen deze makkelijk terug gekoppeld worden.
Vervolgens zal de app naar de appstore gezet worden en kunnen mensen deze simpel downloaden.

## Project management

Deze app is alleen gemaakt door mijzelf (Bas Buijsen). Ik heb dus geen project management methodiek aangehouden. Als version control heb ik GitHub gebruikt.
