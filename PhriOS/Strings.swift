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
let BILLIE_PARENT = "Hoe erg is de ... intensiteit aanwezig bij je kind?"
let BILLIE_ADULT = "Hoe erg is de ... intensiteit aanwezig bij jezelf?"

//STATIC INFORMATION
let BEGELEIDSTERS : [String : String] = [
    "Lisanne Boerboom" : "lisanne@praktijkhoogbegaafd.nl",
    "Yvonne Buijsen" : "Yvonne@praktijkhoobegaafd.nl",
    "Aukje Buijsen" : "Aukje@praktijkhoogbegaafd.nl",
    "TEST" : "bbuijsen@gmail.com"
]
let VERSION = "1.0.0"

//USER DEFAULT KEYS
let DEFS_ADULT_MODE = "adultMode"
let DEFS_BEGELEIDSTER = "begeleidster"
let DEFS_NAME = "name"
let DEFS_NOTIFICATIONS_ENABLED = "notsEnabled"
let DEFS_NOTIFICATIONS = "nots"

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
