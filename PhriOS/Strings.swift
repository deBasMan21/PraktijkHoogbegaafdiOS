//
//  Strings.swift
//  PhriOS
//
//  Created by Bas Buijsen on 10/04/2022.
//

import Foundation

//TEXTS FOR DISPLAY
//      GRAPHVIEW
let SHARE_STRING_ADULT = "Klik op delen en dan wordt er een mail klaargezet die alleen nog verzonden moet worden."
let SHARE_STRING_PARENT = "Kies hieronder wat je wilt delen met je begeleider. \n\nEr wordt een mail klaargezet die alleen nog verzonden moet worden."
let SHARE_STRING_NO_PHR_PARENT = "Kies hieronder wat je op wil slaan. \n\nNa een moment wachten worden de deelopties geopend."
let SHARE_STRING_NO_PHR_ADULT = "Klik op delen en dan krijg je opties om de pdf te delen."
let SHARE_STRING_WITH_PHR_OPTIONS = "Kies op welke manier je de grafieken wilt delen met je behandelaar."

//      ONBOARDINGVIEW
let ONBOARDING_NOTIFICATIONS = "Als je bij het instellen toestemming hebt gegeven om notificaties te ontvangen krijg je standaard elke dag om 10.00, 16.00 en 20.00 een melding als herrinering om je intensiteiten in te vullen. De tijden kan je aanpassen in de instellingen van de app. Die zijn te vinden onder in het menu bij het tandwiel icoontje."
let ONBOARDING_SCORES = "Elke dag kan je tot maximaal 3 keer je intensiteiten invullen. Je krijgt hier dan per intensiteit een slider om aan te geven hoe sterk deze aanwezig is. De ingevulde waardes kan je in de grafiek zien. Deze is te vinden bij het grafiek icoontje in het menu. Hier kun je ook een andere datum kiezen of er voor kiezen om een specifieke intensiteit te bekijken."
let ONBOARDING_SHARE = "Op de grafiek pagina kun je ook de grafiek delen. Dit kan door op de delen knop te drukken. In het geval dat je de app gebruikt met een behandelaar van Praktijk Hoogbegaafd wordt er direct een email klaar gezet om de grafieken te delen met je behandelaar. Anders krijg je een menu om de gemaakte pdf op te slaan op je device."
let ONBOARDING_CONSENT = """
Om de app te kunnen gebruiken vragen we je om je toestemming om de data die ingevuld wordt op je eigen device op te slaan.

Het opslaan van deze data is nodig om de app te kunnen gebruiken dus zonder toestemming kan de app ook niet gebruikt worden.

De data wordt alleen op je eigen device opgeslagen. Het blijft bewaard zolang de app geïnstalleerd is of de app gereset wordt via de instellingen. Dit kan je zelf op elk moment doen door 5 keer op het versie nummer te klikken.

Deze data wordt niet gedeeld met derde partijen. De data wordt alleen gedeeld met je begeleidster op het moment dat je daar zelf voor kiest door op de delen knop te klikken.

Bij vragen kan je altijd contact opnemen met je begeleidster of kun je contact zoeken via de [website](https://www.praktijkhoogbegaafd.nl).

Om deze keuze terug te draaien kun je op elk moment de app verwijderen of resetten om alle data te verwijderen.
"""

//      HOMEVIEW
let START_INTENSITEITEN_ADULT = "Vul je intensiteiten in"
let START_INTENSITEITEN_PARENT = "Vul de intensiteiten van je kind in"

//      SETTINGSVIEW
let RESET_MESSAGE = "Weet je zeker dat je de app wil resetten?"

//      NEWUSERVIEW
let DISCLAIMER_MESSAGE = "Hallo en leuk dat je deze app gaat gebruiken! Dit is een beta versie van de app en deze kan nog problemen bevatten. Mocht er een fout voordoen geef dit dan aan bij je begeleidster. \n\nAlle data die opgeslagen wordt is alleen op je eigen device opgeslagen en zal op geen enkele manier openbaar kunnen worden."
let WELCOME_MESSAGE = "Vul de velden hieronder in en klik op beginnen om aan de slag te gaan met de app. \n\nVeel succes!"

//      BILLIEVIEW
let BILLIE_CHILD = "Hoeveel ...'s heb je?"
let BILLIE_PARENT = "Hoe sterk is de ... aanwezig bij je kind?"
let BILLIE_ADULT = "Hoe sterk is de ... aanwezig bij jezelf?"
let BILLIE_EMOTO = "De emotionele intensiteit kan het best worden omschreven als een versterkte beleving van emoties bij jezelf, maar ook het versterk waarnemen van emoties bij anderen. Dit zorgt voor het ervaren van diepte in emoties en een sterk empathisch vermogen. Je hebt meer behoefte aan diepe emotionele verbinding met anderen, toont compassie en sensitiviteit in relaties en bent sterker gehecht aan plekken, mensen, spullen of dieren."
let BILLIE_PSYMO = "De psychomotorische intensiteit kan het best omschreven worden door een constante psychomotorische activiteit, hoge energielevels, snel en veel praten, veel beweging nodig hebben en een drang naar actie. Dit kan naar voren komen in het niet goed stil kunnen zitten, het repetitief friemelen aan voorwerpen of last hebben van motorische of verbale impulsiviteit."
let BILLIE_SENZO = "De sensorische intensiteit kan het best omschreven worden als een versterkte beleving van sensorische input, zoals dingen die je hoort, ziet, voelt, proeft en ruikt als duidelijk prettig of onprettig ervaren worden. Dit kan er toe leiden dat je sterk wordt aangetrokken tot sommige zintuigelijke belevingen of juist een aversie ontwikkelt voor bepaalde zintuigelijke belevingen en daarom deze uit de weg gaat."
let BILLIE_INTELLECTO = "De intellectuele intensiteit kan het best omschreven worden als een drang naar het verkrijgen van informatie, het zoeken naar en begrijpen van de waarheid en het analyseren en synthetiseren van informatie om zo antwoord te krijgen op vragen. Kritisch nadenken, perfectionisme en een sterk rechtvaardigheidsgevoel zijn daarin tevens kenmerken die vaker naar voren komen. "
let BILLIE_FANTI = "De beeldende intensiteit kan het best omschreven worden als een versterkt vermogen tot verbeelding die naar voren kan komen als een sterke fantasie, het uit verband trekken van situaties, het hebben van intense dromen of nachtmerries en het bedenken van en het opgaan in levendige innerlijke werelden."
let BILLIES_DESCRIPTION : [Billie : String] = [.Emoto : BILLIE_EMOTO, .Fanti : BILLIE_FANTI, .Intellecto : BILLIE_INTELLECTO, .Psymo : BILLIE_PSYMO, .Senzo : BILLIE_SENZO]
let BILLIES_MAX_ENTERED = "Je hebt vandaag al 3 keer je intensiteiten ingevuld. Dit is het maximale aantal per dag. Morgen kan je weer invullen!"

//STATIC INFORMATION
let BEGELEIDSTERS : [String : String] = [
    "Eveline Eulderink" : "eveline@praktijkhoogbegaafd.nl",
    "Yvonne Duran" : "yvonne@praktijkhoogbegaafd.nl",
    "Sjarai Gelissen" : "sjarai@praktijkhoogbegaafd.nl",
    "Mirthe Zom" : "mirthe@praktijkhoogbegaafd.nl",
    "Lisanne Boerboom" : "lisanne@praktijkhoogbegaafd.nl",
    "Meghan Kalisvaart" : "meghan@praktijkhoogbegaafd.nl",
    "Tessa van Sluijs" : "tessa@praktijkhoogbegaafd.nl",
    "Eda Canikli" : "eda@praktijkhoogbegaafd.nl",
    "Milou van Beijsterveldt" : "milou@praktijkhoogbegaafd.nl",
    "Denise Janssen" : "denise_j@praktijkhoogbegaafd.nl",
    "Denise Damen" : "denise_d@praktijkhoogbegaafd.nl",
    "Claire Spoormakers" : "claire@praktijkhoogbegaafd.nl",
    "Chelsea Aarts" : "chelsea@praktijkhoogbegaafd.nl"
]
let VERSION: String = Bundle.main.infoDictionary?["AppVersion"] as? String ?? "onbekend"

//USER DEFAULT KEYS
let DEFS_ADULT_MODE = "adultMode"
let DEFS_BEGELEIDSTER = "begeleidster"
let DEFS_NAME = "name"
let DEFS_NOTIFICATIONS_ENABLED = "notsEnabled"
let DEFS_NOTIFICATIONS = "nots"
let DEFS_WITH_PHR = "withBegeleidster"
let DEFS_SHOW_CONSENT = "showConsent"

//TEXTS FOR EMAIL
let EMAIL_BODY = "In de bijlage zit het verslag van de intensiteiten. Dit is van .. tot en met ..."
let EMAIL_SUBJECT = "Verslag uit de app"
let EMAIL_DEFAULT_ADRESS = "info@praktijkhoogbegaafd.nl"

//COLORS
let PHR_PURPLE = "PhrPurple"
let PHR_ORANGE = "PhrOrange"

//NOTIFICATIONS
let NOTIFICATION_TITLE = "Vul je intensiteiten in!"
let NOTIFICATION_BODY = "Vergeet niet je intensiteiten in te vullen in de Praktijk Hoogbegaafd app"
