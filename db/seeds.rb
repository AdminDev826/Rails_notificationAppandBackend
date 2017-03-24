
# !!! Need to download Seeds Folder to Users/$YOUR_USERNAME/Documents !!!
# Chemin pour les images
# path = "/Users/$YOUR_USERNAME/Documents/Seeds/"


# require 'net/ftp'

# ftp = Net::FTP.new('ftp.cluster007.hosting.ovh.net')
# ftp.login("cforgoodny", "Bethechange85")
# ftp.chdir("www/seed_img/")
# picture = ftp.getbinaryfile("sante.png")
# ftp.close

require 'cloudinary'
result = Cloudinary::Api.resources(type: :upload, prefix: "seed", max_results: 500)

images = []
urls = []

result["resources"].each do |resource|
  image = resource["url"].split('seed/')[1]
  images << image
  urls << resource["url"]
end

#----------------------------------------------------
# TABLES TECHNIQUES
#----------------------------------------------------

#----------------------------------------------------
# Création table BUSINESS_CATEGORIES
#----------------------------------------------------

BusinessCategory.destroy_all

puts "--------CREATE BUSINESS CATEGORIES--------"

personel = BusinessCategory.create!({
  name: "Développement personnel",
  remote_picture_url: urls.fetch(images.index("developpement.png")),
  color: "#36d3da",
  marker_symbol: "marker-developpement"
 })

fitness = BusinessCategory.create!({
  name: "Santé & Fitness",
  remote_picture_url: urls.fetch(images.index("fitness.png")),
  color: "#c386be",
  marker_symbol: "marker-forme"
 })

epicerie = BusinessCategory.create!({
  name: "Marchés & Epiceries",
  remote_picture_url: urls.fetch(images.index("market.png")),
  color: "#eeaa06",
  marker_symbol: "marker-epicerie"
 })

shopping = BusinessCategory.create!({
  name: "Shopping",
  remote_picture_url: urls.fetch(images.index("shopping.png")),
  color: "#f55b5b",
  marker_symbol: "marker-shopping"
 })

maison = BusinessCategory.create!({
  name: "Maison & Jardin",
  remote_picture_url: urls.fetch(images.index("maison.png")),
  color: "#adcb40",
  marker_symbol: "marker-maison"
 })

loisirs = BusinessCategory.create!({
  name: "Loisirs & Sorties",
  remote_picture_url: urls.fetch(images.index("loisirs.png")),
  color: "#1da1df",
  marker_symbol: "marker-loisirs"
 })

coffee = BusinessCategory.create!({
  name: "Cafés & Lieux de vie",
  remote_picture_url: urls.fetch(images.index("coffee.png")),
  color: "#7f5b0a",
  marker_symbol: "marker-coffee"
 })

beaute = BusinessCategory.create!({
  name: "Beauté & Bien Être",
  remote_picture_url: urls.fetch(images.index("beauty.png")),
  color: "#867486",
  marker_symbol: "marker-bienetre"
 })

bars = BusinessCategory.create!({
  name: "Bars & Restaurants",
  remote_picture_url: urls.fetch(images.index("restaurant.png")),
  color: "#db6f3a",
  marker_symbol: "marker-restaurant"
 })
puts "--------END BUSINESS CATEGORIES-----------"


#-------------------------------------------------
# Variables table BUSINESS_CATEGORIES
#-------------------------------------------------

# puts "--------READ BUSINESS CATEGORIES-----------"

# personel = BusinessCategory.find_by_name("Développement personnel")
# fitness = BusinessCategory.find_by_name("Santé & Fitness")
# epicerie = BusinessCategory.find_by_name("Marchés & Epiceries")
# shopping = BusinessCategory.find_by_name("Shopping")
# maison = BusinessCategory.find_by_name("Maison & Jardin")
# loisirs = BusinessCategory.find_by_name("Loisirs & Sorties")
# coffee = BusinessCategory.find_by_name("Cafés & Lieux de vie")
# beaute = BusinessCategory.find_by_name("Beauté & Bien Être")
# bars = BusinessCategory.find_by_name("Bars & Restaurants")

# puts "--------END READ BUSINESS CATEGORIES------"


#----------------------------------------------------
# Création table CAUSE_CATEGORIES
#----------------------------------------------------

CauseCategory.destroy_all

puts "--------CREATE CAUSE CATEGORIES--------"

humanitaire = CauseCategory.create!({
name: "Humanitaire",
remote_picture_url: urls.fetch(images.index("humanitaire.png")),
color: "#ff9e00"
})

culturel = CauseCategory.create!({
name: "Culturel",
remote_picture_url: urls.fetch(images.index("culture.png")),
color: "#8e513a)"
})

entreprenariat = CauseCategory.create!({
name: "Entrepreneuriat Social",
remote_picture_url: urls.fetch(images.index("social.png")),
color: "#2cc6ea"
})

agriculture = CauseCategory.create!({
name: "Agriculture",
remote_picture_url: urls.fetch(images.index("agriculture.png")),
color: "#ce801a"
})

insertion = CauseCategory.create!({
name: "Insertion/Précarité",
remote_picture_url: urls.fetch(images.index("insertion.png")),
color: "#bddb71"
})

education = CauseCategory.create!({
name: "Education",
remote_picture_url: urls.fetch(images.index("education.png")),
color: "#facf20"
})

environnement = CauseCategory.create!({
name: "Environnement",
remote_picture_url: urls.fetch(images.index("environment.png")),
color: "#db3142"
})

sante = CauseCategory.create!({
name: "Santé",
remote_picture_url: urls.fetch(images.index("sante.png")),
color: "#594887"
})

puts "--------END CAUSE CATEGORIES-----------"


#-------------------------------------------------
# Variables table CAUSE_CATEGORIES
#-------------------------------------------------

# puts "--------READ CAUSE CATEGORIES-----------"

# humanitaire = CauseCategory.find_by_name("Humanitaire")
# culturel = CauseCategory.find_by_name("Culturel")
# entreprenariat = CauseCategory.find_by_name("Entrepreneuriat Social")
# agriculture = CauseCategory.find_by_name("Agriculture")
# insertion = CauseCategory.find_by_name("Insertion/Précarité")
# education = CauseCategory.find_by_name("Education")
# environnement = CauseCategory.find_by_name("Environnement")
# sante = CauseCategory.find_by_name("Santé")

# puts "--------END READ CAUSE CATEGORIES------"

# ----------------------------------------------------
# Création table PERK_DETAIL
# ----------------------------------------------------

PerkDetail.destroy_all

puts "--------START PERK_DETAIL--------------"

online = PerkDetail.create!({
name: "online",
description: "Entrez le code promo CforGood (online)",
})

email = PerkDetail.create!({
name: "email",
description: "Envoyez-nous un email",
})

carte = PerkDetail.create!({
name: "carte",
description: "Présentez votre carte en magasin",
})

puts "--------END PERK_DETAIL----------------"


#-------------------------------------------------
# Variables table PERK_DETAIL
#-------------------------------------------------
# puts "--------READ BUSINESS CATEGORIES-----------"

# online = PerkDetail.find_by_name("online")
# email = PerkDetail.find_by_name("email")
# carte = PerkDetail.find_by_name("carte")

# puts "--------END READ BUSINESS CATEGORIES------"


# ----------------------------------------------------
# TABLES DONNEES
# ----------------------------------------------------

# ----------------------------------------------------
# Création table CAUSES
# ----------------------------------------------------

Use.destroy_all
User.destroy_all
Cause.destroy_all

puts "--------CREATE CAUSES--------------------"

cause_attributes = [
  {
    name: "CforGood",
    description: "CforGood est une plateforme web et mobile qui vous connecte aux acteurs positifs de votre territoire pour favoriser les comportements responsables ! Elle vous permet de localiser et de bénéficier de réductions chez les commerces responsables autour de vous, en échange d'une adhésion de 5€/mois destinée à soutenir l’association de votre choix. Enfin un moyen simple et valorisant de participer à l’émergence d’une société plus responsable et solidaire.",
    street: "44 rue des Chartrons",
    zipcode: "33000",
    city: "Bordeaux",
    url: "https://www.cforgood.com",
    email: "hello@cforgood.com",
    impact: "CforGood, l’évidence d’aller dans le bon sens.",
    remote_picture_url: urls.fetch(images.index("cover_cforgood.jpg")),
    cause_category_id: entreprenariat.id,
    facebook: "cforgood",
    twitter: "cforgood",
    representative_first_name: "Allan",
    representative_last_name: "Floury",
    remote_logo_url: urls.fetch(images.index("logo_cforgood.jpg"))
  },
  {
    name: "Etu-Récup",
    description: "La création d’une ressourcerie au cœur du Campus est née de la volonté de donner une seconde vie aux objets, souvent abandonnés en fin d'année par les étudiants quittant le campus, qui finiraient en déchèterie en les récupérant, les valorisant et en les proposant à bas coût / prix libre aux étudiants qui arrivent à la rentrée et ont besoin de s'équiper à peu de frais. Le souhait de créer des lieux de vie et d’échanges dans la mouvance du « Do It Yourself, Do it Together! » est aussi au cœur du projet, ainsi que la volonté d’ouvrir le Campus sur les territoires voisins. Si le Concept des Ressourceries / Recycleries a émergé depuis quelques années au cœur des villes, il n’avait jamais été mené à l’échelle d’un Campus : c’est une première en France ! Etu’Récup innove et expérimente : Étudiants de toutes filières, habitants, personnels du campus, riverains des villes voisines réinventent ensemble d’autres modes d’échanges et de consommation !",
    street: "11 avenue Pey Berland",
    zipcode: "33600",
    city: "Pessac",
    url: "http://eturecup.org",
    email: "hello@eturecup.org",
    telephone: "0951283415",
    impact: "50€ financent un atelier participatif autour du bois, du textile, des vélo ou encore des appareils électriques ou électroniques.",
    remote_picture_url: urls.fetch(images.index("12068966_822561957864796_8248249322430945852_o.jpg")),
    cause_category_id: environnement.id,
    facebook: "eturecup",
    twitter: "@EtuRecup",
    representative_first_name: "Disco",
    representative_last_name: "Soupe",
    remote_logo_url: urls.fetch(images.index("Rectangle_1___10333370_542988195822175_8954670466005362426_o.jpg"))
  },
  {
    name: "MakeSense",
    description: "MakeSense est une communauté internationale qui rassemble des citoyens dans 100 villes du monde pour résoudre les problèmes les plus urgents de la société : l'éducation, la santé, l'environnement, l'alimentation, etc. Comment ? En identifiant des projets à fort potentiel d'impact et en mobilisant des citoyens pour les aider à résoudre leurs problématiques et à changer d'échelle.",
    street: "26 rue boileau",
    zipcode: "75016",
    city: "Paris",
    url: "http://makesense.org/",
    email: "contact@makesense.org",
    telephone: "0663145359",
    impact: "100€ permettent de former 20 bénévoles pour aider des entrepreneurs sociaux dans le monde !",
    remote_picture_url: urls.fetch(images.index("00._Fulltime_team__2017-07-20.jpg")),
    cause_category_id: entreprenariat.id,
    facebook: "MakeSense",
    twitter: "@MakeSenseTwitts",
    instagram: "makesenseorg",
    representative_first_name: "Make",
    representative_last_name: "Sens",
    remote_logo_url: urls.fetch(images.index("Makesense.jpg"))
  },
  {
    name: "Osons Ici et Maintenant",
    description: "Osons Ici et Maintenant est une association fondée le 10 décembre 2014 en Gironde, à Bègles. Elle a une vocation nationale. Notre vision : Une société d’individus conscients des enjeux, capables de se parler, de se faire des propositions pour l’avenir et de coopérer pour relever les défis actuels. Notre mission : Proposer des parcours innovants pour les jeunes en quête de sens et les décideurs locaux visant à les informer sur les grands enjeux des territoires, à en débattre ensemble, à proposer des solutions et à passer à l’action. Nos objectifs Ici et maintenant : -Créer des espaces de rencontres et d’échanges sur les territoires entre les jeunes et les acteurs locaux pour caractériser les enjeux et entamer le dialogue ; -Organiser un événement déclic phare à l’échelle d’une région pour la jeunesse et les décideurs ; -Proposer des parcours en fonction des profils pour faire émerger des solutions nouvelles ; -Créer des parcours d’accompagnement pour les jeunes et les décideurs afin de passer de l’idée, à l’action -Partager en innovation ouverte, nos outils pour un développement sur d’autres territoires",
    street: "114 rue berthelot ",
    zipcode: "33130 ",
    city: "Bègles",
    url: "http://fabrikadeclik.strikingly.com",
    email: "fabrikadeclik@gmail.com",
    telephone: "0661512420",
    impact: "Révéler le potentiel des jeunes 18 - 30 ans",
    remote_picture_url: urls.fetch(images.index("thumbnail-osons.jpg")),
    cause_category_id: entreprenariat.id,
    facebook: "La-Fabrik-à-Déclik-645183675582256",
    representative_first_name: "Osons",
    representative_last_name: "Maintenant",
    remote_logo_url: urls.fetch(images.index("logo-osons.jpg"))
  },
  {
    name: "Keep A Breast Europe",
    description: "Créée en 2008, Keep A Breast Foundation Europe est une association à but non lucratif et reconnue d’intérêt général dont la mission est d'apporter aux jeunes du monde entier l'éducation indispensable à la bonne connaissance de l’impact de leur environnement sur leur santé en général et leur poitrine en particulier. Keep A Breast a été fondée par Shaney Jo Darden en 2000 aux Etats-Unis. Présente également au Japon, au Canada, au Chili, en Grande-Bretagne et en France, elle reste aujourd’hui la plus importante fondation de sensibilisation au cancer auprès des jeunes dans le monde. En 1998, Shaney Jo Darden (jeune designer dans l'industrie du skateboard) et son amie Mona Mukherjea-Gehrig organisaient des séries d'évènements regroupant des artistes de street art dont le succès dépassent les frontières de la Californie. Elles y ont vu un réel berceau créatif pour la sensibilisation et la communication. En 1999, Shaney et Mona apprirent qu'une de leur jeune amie venait de se faire diagnostiquer un cancer du sein. Shaney a immédiatement voulu sensibiliser les jeunes et soutenir son amie mais il existaient seulement des associations qui visaient des femmes plus âgées, touchées par le cancer du sein. Elles décident donc de garder l'énergie créative des artistes streets arts. Le résultat de cette réflexion fut Keep A Breast. L’expression est à double sens : « keep abreast » signifie « se tenir au courant et « keep a breast » signifie « sauver une poitrine ». Keep A Breast devint donc un concept artistique unique développé par Shaney et Mona pour identifier et communiquer sur les difficultés physiques et émotionnelles liées au cancer du sein. Shaney constitua un groupe de femmes volontaires et enveloppa leur poitrine avec des bandes de plâtre. Une fois les moulages durcis, ils étaient distribués à des artistes street art, pour être utilisés comme des toiles blanches. Toute une série de moulages customisés fut créée ainsi. En 2000, les premiers moulages de poitrines furent officialisés dans une exposition appelée Keep A Breast. Il comptait des moulages de femmes professionnelles de snowboard, peints par des artistes comme Shepard Fairey et Ed Templeton. Cet événement a vraiment marqué le tournant vers une organisation de sensibilisation au cancer du sein par l’art avec cet état d’esprit : Art, Education, Sensibilisation, Action. Aujourd'hui, Keep A Breast est la plus importante fondation de sensibilisation au cancer auprès des jeunes dans le monde.",
    street: "15, rue Francis Garnier",
    zipcode: " 33000 ",
    city: "Bordeaux",
    url: "http://www.keep-a-breast.fr",
    email: "europe@keep-a-breast.org",
    impact: "25€ permettent de financer un atelier éducatif, créatif et ludique pour sensibiliser les 5/11 ans",
    remote_picture_url: urls.fetch(images.index("keep_a_breast.jpg")),
    cause_category_id: sante.id,
    facebook: "KeepABreastFrance",
    twitter: "keepabreastEU",
    instagram: "keepabreasteu",
    description_impact: "Dans le cadre du programme de la Non Toxic Revolution, la fondation Keep A Breast Europe développe les ateliers éducatifs totem : cinq ateliers éducatifs, créatifs et ludiques à destination des 5/11 ans autour de 5 thèmes distincts : la maison, l’alimentation, le corps, le plastique et le bien-être. En partenariat avec l'OCCE 33, le projet a été présenté auprès de 850 écoles publiques élémentaires et maternelles à la rentrée 2015. L'objectif est : - Développer des connaissances dans le domaine de la santé. - Sensibiliser les jeunes à la toxicité potentielle de leur mode de vie et de leur environnement. - Faire acquérir des automatismes dès le plus jeune âge. - Apprendre à être respectueux des autres usagers et de son environnement. Keep A Breast a créé des kits complets comprenant tous les éléments nécessaires à la réalisation de ces 5 ateliers pour une classe de 20 enfants. Chaque kit coute 25 €. ",
    representative_first_name: "Keep",
    representative_last_name: "Breast",
    remote_logo_url: urls.fetch(images.index("52ee24cd4041-logo_keep_a_breast.jpg"))
  },
  {
    name: "Ecolo Info",
    description: "Ecolo Info est un média web spécialisé sur l'environnement, traitant de sujets de fond à travers le prisme et l’expérience de ses rédacteurs, toujours bénévoles. Outre les articles, l’équipe propose aussi une sélection thématique des meilleurs événements, sorties cinématographiques, sorties magazines, livres, vidéos, pétitions et tout coup de coeur en lien avec le développement durable. L'association propose aussi des événements pour sensibiliser le plus grand nombre à ces enjeux : apéros écolos, Place to B COP21...",
    url: "http://www.ecoloinfo.com",
    email: "sarah@ecoloinfo.com",
    telephone: "0646367273",
    impact: "Chaque tranche de 100€ permet de couvrir nos frais techniques durant 1 mois pour continuer à communiquer et sensibiliser sur l'environnement.",
    remote_picture_url: urls.fetch(images.index("1c205cf0f1c9-groupe_EN.jpg")),
    cause_category_id: environnement.id,
    facebook: "EcoloInfo",
    twitter: "ecoloinfo",
    description_impact: "Le site nous coûte 1500€ par an (hébergement et webdesign). Plus nous permettrait d'organiser davantage d'événements et d'agrandir notre équipe pour structurer une déclinaison partout en France.",
    representative_first_name: "Ecolo",
    representative_last_name: "Info",
    remote_logo_url: urls.fetch(images.index("logo-ecoloinfo.jpg"))
  },
  {
    name: "Disco Soupe",
    description: "Disco Soupe Bordeaux épluche dans la bonne humeur les fruits et légumes qui auraient du finir à la poubelle. Depuis 2 ans et demi, au moins une fois par mois, nous proposons ou nous invitons sur des événements pour sensibiliser au gaspillage alimentaire en musique en cuisinant de manière participative les rebuts de fruits et légumes. Déjà une trentaine d'événements et plusieurs tonnes de nourriture sauvées !",
    street: "16 rue de Cénac",
    zipcode: "33100",
    city: "Bordeaux",
    url: "http://discosoupe.org",
    email: "discosoupebordeaux@gmail.com",
    telephone: "0646367273",
    impact: "100€ financent une disco soupe",
    remote_picture_url: urls.fetch(images.index("137add8de6c3-_MG_8580.jpg")),
    cause_category_id: environnement.id,
    facebook: "Disco-Soupe-Bordeaux-558476744185476",
    twitter: "DiscoSoupeBx",
    description_impact: "Nous ne vivons que sur les dons, toute l'équipe est bénévole. Les sous nous permettront d'étoffer notre matériel (marmites, éco-cups, couverts, gants, gel hydro-alcoolique, condiments, plaque de cuisson, gaz, girafe...) pour proposer toujours plus d'événements dans de meilleures conditions !",
    representative_first_name: "Disco",
    representative_last_name: "Soupe",
    remote_logo_url: urls.fetch(images.index("logo-discosoup.jpg"))
  },
  {
    name: "Entr-Autres",
    description: "L'association Entr-Autres est à l'initiative du projet Réciprocité. C’est l’histoire d’un groupe de citoyen qui a décidé de se fédérer autour de sa jeunesse ! Persuadés que la société à les jeunes qu’elle mérite, nous avons décidé d’être fier de mériter notre jeunesse. Nous souhaiterions proposer aux jeunes une entrée en douceur dans le monde du travail, un temps pour penser ce qu’il pourrait faire et comment il pourrait le faire. C’est un projet à 3 volets : Insertion : Proposer une expérience d’emploi aux jeunes de 16-25 ans en situation d’insertion ou de décrochage scolaire en partenariat avec la Mission Locale de Bordeaux, l’EPID, le CALK, et l’UBAPS. Santé : Vente éthique de produits respectant le PNNS*, favorisant la consommation de fruits, de légumes et d’eau sur l’espace public à un prix abordable. *Programme National Nutrition et Santé (mangez-bougez) Écologie : Vente itinérante à vélo et utilisation de contenant écologique en production limité. Il s’agit d’éviter une surproduction venant interférer avec l’aspect écologique de l’éco-verre.",
    street: "67 Rue des Ayres",
    zipcode: "33000",
    city: "Bordeaux",
    url: "http://entr-autres.eu",
    email: "sabra@entr-autres.eu",
    impact: "200€ aide un jeune À se RÉINSÉRER",
    remote_picture_url: urls.fetch(images.index("b5944fd5c89c-Portrait_Epihanie_Enfant_.jpg")),
    cause_category_id: insertion.id,
    facebook: "entrautres",
    description_impact: "200€ nous permettent de faire vivre cette expérience à un jeune pour le réinsérer ensuite sur le marché du travail.",
    representative_first_name: "Entr",
    representative_last_name: "Autres",
    remote_logo_url: urls.fetch(images.index("logo-entrautres.jpg"))
  },
  {
    name: "Surfrider Foundation Europe",
    description: "Surfrider Foundation Europe est une association à but non lucratif (loi 1901), ayant « pour but la défense, la sauvegarde, la mise en valeur et la gestion durable de l'océan, du littoral, des vagues et de la population qui en jouit ».",
    street: "87 quai des queyries",
    zipcode: "33100",
    city: "Bordeaux",
    url: "http://www.surfrider.eu",
    email: "contact@surfriderfoundation.fr",
    telephone: "05 59 23 54 99",
    remote_picture_url: urls.fetch(images.index("thumbnail-surfriderfoundation.jpg")),
    cause_category_id: environnement.id,
    facebook: "surfriderfoundationeurope",
    twitter: "surfridereurope",
    instagram: "surfridereurope",
    representative_first_name: "Surfrider",
    representative_last_name: "Foundation",
    remote_logo_url: urls.fetch(images.index("logo-surfriderfoundation.jpg"))
  }
  ]

cause_attributes.each do |params|
  Cause.create(params)
end
puts "--------END CAUSES------------------------"


# ----------------------------------------------------
# Création table BUSINESS
# ----------------------------------------------------

Business.destroy_all
Perk.destroy_all

puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Sébastian Cantaut",
password: "123nuage",
street: "87 quai de queyries",
zipcode: "33000",
city: "bordeaux",
url: "http://bordeaux-hypnose.org",
telephone: "0669353667",
email: "contact@bordeaux-hypnose.org",
description: "Je suis Sébastian Cantaut Hypnothérapeute à Darwin. Si vous avez des problèmes d'estime de soi, de confiance en soi, de stress, d'angoisse. Envie de changer certains de vos comportements. Préparation concours, coaxhing sportif. Une phobie. Envie d'apprendre à lâcher prise, à vous relaxer. L'hypnose peut être une aide efficace.",
remote_picture_url: urls.fetch(images.index("10452927_808594772534200_6256437646451254378_o.jpg")),
business_category_id: personel.id,
facebook: "https://m.facebook.com/hypnotherapeuteDarwin/",
remote_leader_picture_url: urls.fetch(images.index("1959366_808286015898409_6482999773873997549_n.jpg")),
leader_first_name: "Sebastian ",
leader_last_name: "Cantaut",
leader_description: "Hypnothérapeute à Darwin je ferai en sorte de vous apporter mon aide afin que vous puissiez atteindre vos objectifs de la plus belle manière et avec vos propres ressources.",
active: true,
online: false,
leader_phone: "0669353667",
leader_email: "scantaut@gmail.com",
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "L'hypnose pour avancer",
business_id: business_id,
description: 'Une séance d\'hypnose à 60€ au lieu de 70€ "Les seules limites de nos réalisations de demain, ce sont nos doutes et nos hésitations d\'aujourd\'hui" Éléonore Roosevelt',
active: true,
perk_code: "UFMX5",
appel: true,
durable: false,
flash: false,
perk_detail_id: online.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
    Perk.create(params)
end
puts "--------END BUSINESS-----------"

puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "La pArtagerie",
password: "123nuage",
street: "5 rue Kléber",
zipcode: "33800",
city: "Bordeaux",
url: "http://www.partagerie.fr/",
email: "partagerie@gmail.com",
description: "La pArtagerie, ouverte depuis le 4 février 2015, est le nid de l'association pArt-âge, un lieu unique, innovant, solidaire & éco-responsable, convivial, familial se situant en plein cœur de Bordeaux. Vous y trouverez un salon de thé bio et végétalien, un coin d'éveil et de jeux, un showroom créateurs et un espace ateliers.",
remote_picture_url: urls.fetch(images.index("photo_couverture.jpg")),
business_category_id: coffee.id,
facebook: "https://www.facebook.com/partagerie/?fref=ts",
instagram: "partagerie",
remote_leader_picture_url: urls.fetch(images.index("LOGO_pArtage.jpg")),
leader_first_name: "Association pArt-âge",
leader_description: "pArt-âge est une association née en 2014 dont le but est de créer un lien bienveillant entre les individus, de motiver les échanges intergénérationnels, et de promouvoir l'artisanat local et éthique. Nous souhaitons aussi au travers de nos actions, sensibiliser aux bienfaits et aux possibilités de mener une vie saine et simple. ",
active: true,
online: false,
leader_phone: "09 53 11 78 23",
leader_email: "partagerie@gmail.com",
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "Une boisson offerte au salon de thé",
business_id: business_id,
description: "Venez dégustez une boisson chaude ou froide dans notre salon de thé bio et végétalien* . Venez découvrir la pArtagerie et tout ce qu'elle propose. Moments reposants et agréables garanties dans un cadre chaleureux. *L'adhésion annuelle à l'association pArt-âge est requise.",
active: true,
perk_code: "UZWG2",
appel: true,
durable: false,
flash: false,
remote_picture_url: urls.fetch(images.index("salon_de_th_.jpg")),
perk_detail_id: carte.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
    Perk.create(params)
end
puts "--------END BUSINESS-----------"

puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Nature et potager en ville",
password: "123nuage",
street: "87 Quai des Queyries",
zipcode: "33100",
city: "Bordeaux",
url: "http://www.natureetpotagerenville.fr/",
telephone: "0 609 725 765",
email: "contact@natureetpotagerenville.fr",
description: "Cultivez la biodiversité en ville en jardinant 100% éco-responsable ! Aménagements comestibles & Agriculture urbaine Mini-potagers - Semences bio - Arrosage économe&autonome - Vermicompost - Sac de culture en géotextile ",
remote_picture_url: urls.fetch(images.index("Marche-recadre.jpg")),
business_category_id: maison.id,
facebook: "https://www.facebook.com/natureetpotagerenville/?fref=ts",
remote_leader_picture_url: urls.fetch(images.index("Natureetpotagerenville_-_logo_-_RVB.jpg")),
leader_first_name: "Marie-Dominique",
leader_last_name: "Pivetaud",
active: true,
online: false,
leader_phone: "0 609 725 765",
leader_email: "contact@natureetpotagerenville.fr",
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: " 1 atelier pour 1 mini-potager :-)",
business_id: business_id,
description: "Parmi 4 formats on vous offre une réduction proportionnelle sur 1 atelier de jardinage de 50€: Format 12L - 20% de réduc, Format 19L -30% de réduc, Format 26L -40% de réduc et Format 41L -50% de réduc ",
active: true,
perk_code: "DYWI6",
appel: true,
durable: false,
flash: false,
remote_picture_url: urls.fetch(images.index("IMG_3506.jpg")),
perk_detail_id: email.id
},
{
name: "Qu'est ce qu'on S ' ÈME !",
business_id: business_id,
description: "Pour 5 paquets de semences achetés, un paquet offert ! Par exemple c'est le moment de semer du basilic, cerfeuil, claytone, cosmos, tomate et on vous offre le paquet de votre choix. ;-)",
times: 10,
start_date: "2016-03-15T00:00:00Z",
end_date: "2016-03-27T00:00:00Z",
active: true,
perk_code: "WPOS1",
appel: false,
durable: false,
flash: true,
remote_picture_url: urls.fetch(images.index("11091486_447553992063126_8599805154585597942_n.jpg")),
perk_detail_id: carte.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"

puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "INSPIRESELF",
password: "123nuage",
zipcode: "33300",
city: "Bordeaux",
url: "http://www.inspireself.org/",
telephone: "+33663075090",
email: "info@inspireself.com",
description: "Nous offrons des produits efficaces, réduisant considérablement les effets nocifs (chaleur, maux de têtes, migraines, baisse d'énergie, perte d'équilibre, manque d'ancrage, stress ) générés par les pollutions éléctromagnétiques des téléphones portables, ordinateurs, box wifi, tablettes, montres connectées, DECT, écoutes -bébés, tv en fait tous appareils émettant des ondes éléctromagnétiques de très hautes ou très basses fréquences....",
remote_picture_url: urls.fetch(images.index("Inspireself.jpg")),
business_category_id: fitness.id,
remote_leader_picture_url: urls.fetch(images.index("Inspire_Vectorialise_3D.jpg")),
leader_first_name: "Patrice",
leader_last_name: "Buyle",
active: true,
online: true,
leader_phone: "0663075090",
leader_email: "info@inspireself.com",
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "25% sur le premier produit acheté ",
business_id: business_id,
description: "Pour vous accueillir en tant que nouveau client, nous vous offrons 25% sur le premier produit acheté :-)",
active: true,
perk_code: "CFORGOOD",
appel: true,
durable: false,
flash: false,
remote_picture_url: urls.fetch(images.index("Inspireself.jpg")),
perk_detail_id: email.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"


puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "PALO ALTO ",
password: "123nuage",
street: "5 Quai de la Monnaie",
zipcode: "33800",
city: "Bordeaux",
telephone: "0982371550",
email: "paloalto.bx@gmail.com",
description: "Le Palo Alto a été conçu comme un lieu où il est possible de venir à n'importe quel moment de la journée.C'est un coffee shop où l'on vous propose petit déjeuner, pâtisseries maison, boissons chaudes et boissons fraiches maison (thés glacés, smoothies, citronnade, jus, etc).Arrivé midi, vous trouverez notre cuisine du marché. Nous nous attachons à travailler des produits de qualité, donc de saison. C'est pourquoi nous changeons notre carte régulièrement!La cerise sur le gâteau? Le patio! Notre petit havre de paix aux allures tropicales, au calme du tumulte de la ville, qui invite au voyage.",
remote_picture_url: urls.fetch(images.index("Palo-alto.jpg")),
business_category_id: coffee.id,
facebook: "paloaltocafeteria",
instagram: "@paloaltocafeteria",
leader_first_name: "Léa",
leader_last_name: "Nitaro",
active: true,
online: false,
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "Smile there is coffee !",
business_id: business_id,
description: "Un café offert (expresso ou allongé) pour toute pâtisserie achetée en semaine du lundi au vendredi à partir de 15h !",
active: true,
perk_code: "PALOALTO",
appel: false,
durable: true,
flash: false,
remote_picture_url: urls.fetch(images.index("2016-02-13_10.02.20.jpg")),
perk_detail_id: carte.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"


puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Origines Tea & Coffee",
password: "123nuage",
street: "11 rue sicard",
zipcode: "33000",
city: "Bordeaux",
url: "http://www.originesteaandcoffee.com/",
telephone: "0524617894",
email: "origines.sicard@gmail.com",
description: "Origines Tea & Coffee est une épicerie fine dans l'univers du petit déjeuner bio. Nous proposons du thé, du café, des tisanes, du sucre, du miel, du chocolat, des confitures, le tout bio et au plus proche des producteurs! Vous pouvez déguster nos produits sur place dans un cadre convivial, en terrasse ou dans le salon au coin du feu... :)",
remote_picture_url: urls.fetch(images.index("Origines_5.jpg")),
business_category_id: coffee.id,
facebook: "OriginesTeaandCoffee",
twitter: "@OriginesTea",
instagram: "originesteaandcoffee",
remote_leader_picture_url: urls.fetch(images.index("Origines_5.jpg")),
leader_first_name: "Léa",
leader_last_name: "Lanterne",
active: true,
online: false,
leader_phone: "0524617894",
leader_email: "origines.sicard@gmail.com",
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "Un Thé OFFERT",
business_id: business_id,
description: "Vous voulez découvrir nos produits bio ? Avec votre carte, on vous offre un thé à boire sur place. Thé blanc, thé vert, thé bleu, thé jaune...vous allez en boire de toutes les couleurs !",
active: true,
perk_code: "ONECUPOFTEA",
appel: true,
durable: false,
flash: false,
remote_picture_url: urls.fetch(images.index("10_thes_bio_pour_se_rechauffer_cet_hiver.jpg")),
perk_detail_id: carte.id
},
{
name: "-50% sur l'atelier de dégustation",
business_id: business_id,
description: 'Nous animons une fois par semaine des ateliers de dégustation. Nous dégusterons 6 thés aux vertus spécifiques ainsi qu\'un smoothie au thé vert matcha pour faire le plein d\'antioxydants et de vitamines!',
active: true,
perk_code: "VERTUS",
appel: true,
durable: false,
flash: false,
remote_picture_url: urls.fetch(images.index("teapot-516024_640.jpg")),
perk_detail_id: email.id
},
{
name: "Ramenez vos emballages !",
business_id: business_id,
description: "Chez Origines Tea & Coffee, les sachets de thé et de café sont réutilisables, ne les jetez plus! Si vous revenez pour les remplir à nouveau, le prix de l'emballage est déduit du prix total, soit 20 centimes d'économies.",
active: true,
perk_code: "RYOX3",
appel: false,
durable: true,
flash: false,
remote_picture_url: urls.fetch(images.index("Bikini_Tea_-_Accords_Originaux_DP.jpg")),
perk_detail_id: carte.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"

puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Maison Hegara",
password: "123nuage",
street: "14 cours Portal ",
zipcode: "33000 ",
city: "Bordeaux ",
url: "http://www.maisonhegara.com/",
telephone: "0623335080",
email: "maisonhegara@gmail.com",
description: "La Maison Hegara est une épicerie générale implantée aux chartrons. L'idée est de proposer une alimentation saine et de lutter contre le gaspillage, en proposant des produits bios et/ou locaux (légumes secs, pâtes, riz, huiles et vinaigres, thé..etc..)vendus au poids et sans emballage. Les fruits et légumes varient selon les saisons et les marchés où je me déplace chaque matin pour vous proposer des produits toujours frais.",
remote_picture_url: urls.fetch(images.index("MaisonHegara.jpg")),
business_category_id: epicerie.id,
facebook: "maisonhegara",
remote_leader_picture_url: urls.fetch(images.index("c03f92b7a206-IMG_4457_1.jpg")),
leader_first_name: "Hélène",
leader_last_name: "Galy-Ramounot ",
leader_description: "Bordelaise de 30 ans ne voulant plus manger des tomates d'Espagne en Hiver, ni descendre sa poubelle qui se remplit trop vite !",
active: true,
online: false,
leader_phone: "0623335080",
leader_email: "maisonhegara@gmail.com",
logo: urls.fetch(images.index("c03f92b7a206-IMG_4457_1.jpg")),
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name


perks_attributes = [{
name: "Deux contenants offerts ! ",
business_id: business_id,
description: 'Deux contenants offerts pour commencer vos courses en " vrac " : - une bouteille d\'huile de 25cl - un bocal en verre',
active: true,
perk_code: "ABUQ4",
appel: true,
durable: false,
flash: false,
perk_detail_id: carte.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"


puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Potager City",
password: "123nuage",
street: "Un peu partout !!",
city: "Bordeaux et alentours",
url: "http://www.potagercity.fr",
email: "benjamin@potagercity.fr",
description: "Potager City propose chaque semaine plusieurs assortiments de fruits et légumes frais bio et/ou fermiers avec les petits producteurs régionaux. Son objectif est de faire redécouvrir la saveur et la fraicheur des produits aux clients grâce à ses compositions originales, ainsi qu'au service d'accompagnement qui va avec !",
remote_picture_url: urls.fetch(images.index("Piece_jointe.jpg")),
business_category_id: epicerie.id,
facebook: "potagercity",
twitter: "potagercity",
remote_leader_picture_url: urls.fetch(images.index("17ec4edd58a7-potager_city_equipe.jpg")),
leader_first_name: "Benjamin ",
leader_last_name: "Gillot",
leader_description: "Tous les jours, dès l’aube, notre équipe accueille les producteurs et réceptionne les fruits, légumes et oeufs frais cueillis et ramassés la veille. Ensuite, toute l’équipe s’active pour livrer le jour même et faire que le chemin du jardin à l’assiette soit le plus court et le plus agréable possible :)",
active: true,
online: true,
leader_phone: "06 50 30 16 59",
leader_email: "benjamin@potagercity.fr",
logo: urls.fetch(images.index("17ec4edd58a7-potager_city_equipe.jpg")),
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "15% toutes les semaines !!",
business_id: business_id,
description: "Vous commandez pour 30€ ou plus ? Utilisez le code de réduction CFORGOOD15 et bénéficiez de 15% de réduction !",
active: true,
perk_code: "CFORGOOD15",
appel: false,
durable: true,
flash: false,
perk_detail_id: online.id
},
{
name: "30% de réduction",
business_id: business_id,
description: "30% sur votre première commande !",
active: true,
perk_code: "CFORGOOD",
appel: true,
durable: false,
flash: false,
remote_picture_url: urls.fetch(images.index("framboise2-copie.png")),
perk_detail_id: online.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"


puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Naturôme",
password: "123nuage",
street: "7 impasse Saint Jean",
zipcode: "33800 ",
city: "Bordeaux ",
url: "http://naturome.fr",
telephone: "0556782509",
email: "bonjour@naturome.fr",
description: "Naturôme est le 1er centre de naturopathie à Bordeaux. Son objectif est de regrouper et proposer l'ensemble des techniques naturelles au service de l'hygiène de vie et de la prévention santé. Sauna, massages, consultations, pratiques corporelles douces, thérapies complémentaires, esthétique bio...",
remote_picture_url: urls.fetch(images.index("Naturome.jpg")),
business_category_id: beaute.id,
facebook: "naturome",
twitter: "@CentreNaturome",
instagram: "Naturôme",
remote_leader_picture_url: urls.fetch(images.index("b5ea951e9691-20140409_092236.jpg")),
leader_first_name: "Elodie ",
leader_last_name: "Brillaud",
leader_description: "Naturôme est né de la rencontre de la naturopathie avec une volonté d'entreprendre de façon responsable, au service de la santé. L'espace a été créé de façon la plus écologique possible, comme un lieu d'échanges et de rencontres.",
active: true,
online: false,
logo: urls.fetch(images.index("b5ea951e9691-20140409_092236.jpg")),
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "50% de remise ",
business_id: business_id,
description: "50% de remise sur votre 1er sauna ! ( soit 11 € au lieu de 22 € ) ",
active: true,
perk_code: "ZMXO5",
appel: true,
durable: false,
flash: false,
remote_picture_url: urls.fetch(images.index("Sauna_Naturome.jpg")),
perk_detail_id: carte.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"


puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "La ruche des Chartrons",
password: "123nuage",
street: "22 rue Marsan",
zipcode: "33300 ",
city: "Bordeaux ",
url: "http://laruchequiditoui.fr",
telephone: "0644001321",
email: "ruchedeschartrons@gmail.com",
description: "Nous organisons la vente des produits d'agriculteurs locaux ( -de 250 Km) en circuit court, d'agriculture raisonnée ou bio, via le site laruchequiditoui.fr. Nous proposons 2 ventes par semaine et leurs distributions, des Ruche des Chartrons:-22Rue Marsan chaque vendredi de 18h à 19h30 -34Cours Balguerie mardi de 17h30 à 19h. ",
remote_picture_url: urls.fetch(images.index("ae2028d12c14-DSC_9523.jpg")),
business_category_id: epicerie.id,
facebook: "LaRucheDesChartrons",
instagram: "ruchedeschartrons",
leader_first_name: "Maud ",
leader_last_name: "Cazaux",
active: true,
online: false,
leader_phone: "0644001321",
leader_email: "maudcazaux@me.com",
logo: urls.fetch(images.index("ae2028d12c14-DSC_9523.jpg")),
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "Un cadeau de bienvenue ",
business_id: business_id,
description: "Pour chaque première commande, un cadeau de bienvenue offert ! ",
active: true,
perk_code: "ZESI7",
appel: true,
durable: false,
flash: false,
perk_detail_id: carte.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"


puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Épicerie ô merveilleux ",
password: "123nuage",
street: "49 Cours de la Martinique",
zipcode: "33300",
city: "Bordeaux ",
telephone: "0557895032",
email: "epicerieomerveilleux@gmail.com",
description: "Epicerie Fine produits nature et bio direct producteur Ariégeois",
remote_picture_url: urls.fetch(images.index("30f01a45614a-10906221_10205372821190399_6728216959958062098_n.jpg")),
business_category_id: epicerie.id,
facebook: "epicerieomerveilleuxbordeaux",
leader_first_name: "Julian ",
leader_last_name: "Saint-André",
leader_description: "Je suis un épicurien né à Paris et qui a grandi à la campagne dans le sud de la France. Je suis un amoureux du bon produit, tant que c'est naturel et sans cochonneries industrielle !!",
active: true,
online: false,
logo: urls.fetch(images.index("30f01a45614a-10906221_10205372821190399_6728216959958062098_n.jpg")),
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name


perks_attributes = [{
name: "10% de remise ",
business_id: business_id,
description: "10% sur votre addition dans notre épicerie !",
active: true,
perk_code: "YPCR0",
appel: false,
durable: true,
flash: false,
perk_detail_id: carte.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"

puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Ecoclicot",
password: "123nuage",
street: "66, rue abbé de l'épée",
zipcode: "33000",
city: "BORDEAUX",
url: "http://www.ecoclicot.com/",
telephone: "0535004030",
email: "info@ecoclicot.com",
description: "Nous développons en ligne une place de marché où se retrouve l'offre de produit eco-responsable ! ",
remote_picture_url: urls.fetch(images.index("b1f03b5cc443-Logo_Ecoclicot_HD.jpg")),
business_category_id: shopping.id,
facebook: "Ecoclicot",
twitter: "Ecoclicot",
instagram: "ecoclicot",
remote_leader_picture_url: urls.fetch(images.index("cedric_sauvy.jpg")),
leader_first_name: "Cédric",
leader_last_name: "Seauvy",
leader_description: "C'est histoire d'une rencontre de deux papas avec une vision commune, celle de promouvoir les fabricants, commerçants de produits plus respectueux de l'environnement et socialement plus responsable",
active: true,
online: true,
leader_phone: "0601747427",
leader_email: "cedric.seauvy@ecoclicot.com",
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "5% offert !",
business_id: business_id,
description: "Bénéficiez de 5% de remise sur votre première commande chez Ecoclicot, la place de marché Eco responsable !",
active: true,
perk_code: "CVKM0",
appel: true,
durable: false,
flash: false,
remote_picture_url: urls.fetch(images.index("Promo-5-Fb2.png")),
perk_detail_id: online.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"

puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Changer le monde en 2H",
password: "123nuage",
city: "Paris",
email: "en2heures@gmail.com",
description: "Changer le monde en 2 heures est un livre d'actions faciles et rapides pour avoir un impact social ou environnemental. L'objectif ? Aider 10.000 personnes à agir un peu plus pour les autres et la planète. Déjà 1500 en route. Vous nous rejoignez ?",
remote_picture_url: urls.fetch(images.index("logo_autocollant_en2heures_8x6_recto_-_rogne.jpg")),
business_category_id: personel.id,
facebook: "facebook.com/en2heures",
remote_leader_picture_url: urls.fetch(images.index("Lectrice_changer_le_monde_en_2_heures_piscine.jpg")),
leader_first_name: "Pierre",
leader_last_name: "Chevelle",
leader_description: "En 2015, Pierre Chevelle a été sélectionné par Ticket for Change parmi les 50 graines d’entrepreneurs les plus prometteurs pour monter leur projet au service de la société (avec Allan de CforGood !). À 25 ans, il a travaillé pour Sparknews et Ashoka, deux acteurs majeurs de l'innovation sociale.",
active: true,
online: true,
leader_email: "en2heures@gmail.com",
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "-10% + dédicace + envoi offert",
business_id: business_id,
description: "Changer le monde en 2 heures est un guide d'actions faciles et rapides pour agir un peu plus pour les autres et la planète. Extraits et livre disponibles sur www.en2heures.fr. ",
active: true,
perk_code: "CFORGOOD",
appel: true,
durable: false,
flash: false,
remote_picture_url: urls.fetch(images.index("Chien_en2heures_original.jpg")),
perk_detail_id: email.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"


puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Do you speak français ?",
password: "123nuage",
street: "93 rue Notre Dame",
zipcode: "33000",
city: "Bordeaux",
url: "http://dysfrancais.jimdo.com/",
telephone: "0624996412",
email: "bonjour@dysfrancais.fr",
description: "Do you speak français c'est un concept store et lieu de vie 100% Made in France où l'on trouve de la mode H/F/enfants, des cosmétiques, de la beauté, des accessoires, de la maroquinerie, des bijoux et plein d'autres choses faites par des gens près de chez vous !",
remote_picture_url: urls.fetch(images.index("DYSF.jpg")),
business_category_id: shopping.id,
facebook: "doyouspeakfrancais",
instagram: "doyouspeakfrancais",
remote_leader_picture_url: urls.fetch(images.index("image.jpg")),
leader_first_name: "Gaëlle",
leader_last_name: "Voisin",
active: true,
online: false,
leader_phone: "0624996412",
leader_email: "bonjour@dysfrancais.fr",
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name


perks_attributes = [{
name: "Un thé offert",
business_id: business_id,
description: "Un thé offert parmi notre sélection de thés, valable à votre première visite!",
times: 1,
active: true,
perk_code: "VEDL7",
appel: true,
durable: false,
flash: false,
perk_detail_id: carte.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"


puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Koken",
password: "123nuage",
street: "13 Place Puy Paulin",
zipcode: "33000",
city: "Bordeaux",
url: "http://www.boutique-koken.fr",
telephone: "0981463968",
email: "boutiquekoken@gmail.com",
description: "C'est une marque respectueuse de l'Homme, des valeurs de l'ouvrage et de l'environnement. Elle propose des articles de mode conçus par des créateurs et stylistes.",
remote_picture_url: urls.fetch(images.index("entete.jpg")),
business_category_id: shopping.id,
facebook: "Boutique-KOKEN-961622623877174",
remote_leader_picture_url: urls.fetch(images.index("9428a1fae6c6-Carole.jpg")),
leader_first_name: "Carole",
leader_last_name: "Girard",
leader_description: "Biographie!! Elle arrive!! Bientôt...",
active: true,
online: false,
logo: urls.fetch(images.index("9428a1fae6c6-Carole.jpg")),
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "Bienvenue! Un Kdo éthique offert...",
business_id: business_id,
description: "Offrez un vêtement éthique, nous vous offrons un carnet commerce équitable fait main de la marque People Tree. Valable pour tout achat dans la boutique hors bijoux et papeterie.",
active: true,
perk_code: "JVLA6",
appel: true,
durable: false,
flash: false,
remote_picture_url: urls.fetch(images.index("bonplanbienvenue.jpg")),
perk_detail_id: carte.id
},
{
name: "-25% sur les vêtements en laine",
business_id: business_id,
description: "Chez Koken les pulls, en plus d'être éthiques, sont intemporels et 100% laine. Profitez d'une remise de 25% sur tous les vêtements en laine pour l'hiver prochain! Les marques: L'Herbe Rouge, People Tree et Studio Jux",
times: 31,
start_date: "2016-03-11T00:00:00Z",
end_date: "2016-04-02T00:00:00Z",
active: true,
perk_code: "RJIV6",
appel: false,
durable: false,
flash: true,
remote_picture_url: urls.fetch(images.index("pullfrancesca2.jpg")),
perk_detail_id: carte.id
},
{
name: "-15% sur l'article de votre choix..",
business_id: business_id,
description: "Remise valable lors de votre premier achat sur l'ensemble de la boutique. Offre non cumulable avec les éventuelles promos en cours.",
times: 1,
active: true,
perk_code: "HWUG0",
appel: true,
durable: false,
flash: false,
remote_picture_url: urls.fetch(images.index("Topethnic.jpg")),
perk_detail_id: carte.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end

puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Animateur Culturel",
password: "123nuage",
street: "24 rue Roullet",
zipcode: "33800",
city: "Bordeaux",
telephone: "0671556756",
email: "anthony.benoitpro@gmail.com",
description: "« Jouer ce n’est pas tendre vers un but précis mais s’ouvrir à l’inattendu ». Ainsi je propose qu’à travers mes ateliers, le public vive une expérience ludique originale. Cela peut donc se faire sous deux formes : un atelier « Jeux de société » ou un atelier « Improvisation théâtrale ».",
remote_picture_url: urls.fetch(images.index("8ab0486e8197-16081_835643099866762_3198736444419260835_n.jpg")),
business_category_id: loisirs.id,
facebook: "Du-jeu-pour-tous-815636281867444",
remote_leader_picture_url: urls.fetch(images.index("63f6687e5218-199551_1949160535572_3889563_n.jpg")),
leader_first_name: "Anthony",
leader_last_name: "Benoît",
leader_description: "Ce projet d’auto-entreprise s’inscrit avant tout dans un projet personnel éducatif plus global. Mon parcours professionnel m’a permis de travailler avec de nombreux types de publics : de l’enfance à l’adolescence, des adultes, mais aussi les personnes en situation de handicap ou encore des personnes âgées.",
active: true,
online: false,
logo: urls.fetch(images.index("63f6687e5218-199551_1949160535572_3889563_n.jpg")),
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "- 20% sur mes prestations ",
business_id: business_id,
description: "20% de remise sur l'ensemble de mes prestations !",
active: true,
perk_code: "ANTHONYBENOIT",
appel: false,
durable: true,
flash: false,
perk_detail_id: email.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"


puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Decalez!",
password: "123nuage",
street: "66 rue Abbé de l'Epée ",
zipcode: "33000 ",
city: "Bordeaux",
url: "http://www.decalez.fr",
telephone: "0643584912",
email: "contact@decalez.fr",
description: "Décalez! est une structure de formation visant au développement des savoirs-être à partir des techniques d'improvisation théâtrale. Notre objectif ? Mettre le jeu au service de l'efficience et montrer que le développement des compétences est plus efficace lorsque l'on s'adresse à l'humain. Décalez! vous accompagne ainsi dans l'amélioration de vos compétences relationnelles, de communication, de prise de parole en public et de cohésion d'équipe... avec son regard décalé !",
remote_picture_url: urls.fetch(images.index("d835e13254ac-Chachou__58_sur_92_.jpg")),
business_category_id: personel.id,
facebook: "decalez",
twitter: "Decalez",
leader_first_name: "Charlotte",
leader_last_name: "Naymark",
active: true,
online: false,
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "1 formation offerte",
business_id: business_id,
description: "Une formation découverte achetée, une formation découverte offerte, alors venez accompagné ! :)",
times: 1,
active: true,
perk_code: "CFORGOOD",
appel: true,
durable: false,
flash: false,
perk_detail_id: email.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"


puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "TOUTNET ECO",
password: "123nuage",
street: "Rue Edouard Branly ",
zipcode: "33110",
city: "LE BOUSCAT",
url: "http://www.coopalpha.coop/entreprise/elisabeth-francois-produits-ecocitoyens-efpe",
telephone: "0637433552",
email: "elisabethfrancois.eco@gmail.com",
description: 'Éco-conçu en circuit court,TOUTNET ECO est un nettoyant écologique naturel très efficace sans pétrochimie. Son usage est très économique. Il sert également de "levier" responsable et solidaire pour le territoire.',
remote_picture_url: urls.fetch(images.index("1ac7d2180156-facebook3.jpg")),
business_category_id: epicerie.id,
facebook: "efproduitsecocitoyens",
remote_leader_picture_url: urls.fetch(images.index("portrait_la_teste.jpg")),
leader_first_name: "Elisabeth",
leader_last_name: "François",
leader_description: "« Sans utopie, aucune activité véritablement féconde n’est possible. »",
active: true,
online: false,
leader_phone: "0637433552",
leader_email: "elisabethfrancois6@gmail.com",
logo: urls.fetch(images.index("portrait_la_teste.jpg")),
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "20% de remise",
business_id: business_id,
description: "Un vaporisateur TOUTNET ECO de 750 ml et une recharge d'1 litre pour 20 € (au lieu de 24 €) !",
active: true,
perk_code: "AZBO5",
appel: true,
durable: false,
flash: false,
perk_detail_id: carte.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"


puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "w.a.n.",
password: "123nuage",
street: "1 rue des Lauriers",
zipcode: "33000",
city: "Bordeaux",
url: "http://www.wanweb.fr",
telephone: "0556481541",
email: "contact@wanweb.fr",
description: "Concept store créé en 2009 proposant exclusivement des articles fabriqués en France et pas trop loin avec des matériaux verts ou recyclés. Egalement fabricant de la marque de sacs et accessoires FANTOME, 100% made in France avec des chambres à air de vélo recyclées. Egalement galerie d'art au sous-sol, magnifique cave voûtée. A côté de belles marques françaises de type Le Slip Français, Oncle Pape, Le Baigneur, Maxence, Sabe Masson, Le Coq Français etc. un choix étonnant de lampes, sculptures et de petites et grandes choses étonnantes pour soi et vos meilleures amis. ",
remote_picture_url: urls.fetch(images.index("d7daa4cc9277-10250083_339433649567931_5022324882448988280_n.jpg")),
business_category_id: shopping.id,
facebook: "Wan-we-are-nothing-345718002111418/?ref=hl",
twitter: "wanbordeaux",
instagram: "wan_bordeaux",
remote_leader_picture_url: urls.fetch(images.index("249080_478365405513343_1625941968_npetit.jpg")),
leader_first_name: "Charles",
leader_last_name: "Burke",
leader_description: "Promis, suite à la réunion à la Ruche, je vais remplir ma bio!",
active: true,
online: false,
leader_phone: "+33556481541",
leader_email: "contact@wanweb.fr",
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "Bienvenue!",
business_id: business_id,
description: "pour tout achat dans notre boutique, nous vous offrons un Zap Book !",
active: true,
perk_code: "MKAN1",
appel: true,
durable: false,
flash: false,
remote_picture_url: urls.fetch(images.index("249080_478365405513343_1625941968_npetit.jpg")),
perk_detail_id: carte.id
},
{
name: "50 % SUR SOFTIN!",
business_id: business_id,
description: "Nous vous offrons 50% de remise sur la gamme des chaussons eco-responsables de la marque Softin!",
times: 21,
start_date: "2016-03-11T00:00:00Z",
end_date: "2016-03-31T00:00:00Z",
active: true,
perk_code: "FLJQ8",
appel: false,
durable: false,
flash: true,
remote_picture_url: urls.fetch(images.index("chausson_soft_in.jpg")),
perk_detail_id: carte.id
},
{
name: "10% de remise sur FANTOME",
business_id: business_id,
description: "10% de réduction sur l'ensemble de la gamme FANTOME présente en magasin.",
times: 1,
active: true,
perk_code: "VMLW1",
appel: false,
durable: true,
flash: false,
remote_picture_url: urls.fetch(images.index("logo_fantome5.jpg")),
perk_detail_id: carte.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
  Perk.create!(params)
end
puts "--------END BUSINESS-----------"


puts "--------NEW BUSINESS-----------"
business_attributes = {
name: "Label Terre",
password: "123nuage",
street: "2 Cours Alsace Lorraine ",
zipcode: "33000",
city: "Bordeaux",
telephone: "05 56 62 25 49",
email: "madeinlabel@gmail.com",
description: "Voilà le 1er concept Street Food locavore au coeur de Bordeaux ! Label Terre propose une cuisine de saison, rapide, savoureuse et locale avec des produits provenant de moins de 250km du restaurant. Profitez également de la salle à l'étage, du déjeuner au goûter !",
remote_picture_url: urls.fetch(images.index("label-terre_1.jpg")),
business_category_id: bars.id,
remote_leader_picture_url: urls.fetch(images.index("Label-terre-leader.jpg")),
leader_first_name: "Chris",
leader_last_name: "Madé",
active: true,
online: false,
shop: true,
itinerant: false
}

puts "--------CREATE BUSINESS----------"
b = Business.create(business_attributes)
business_id = b.id
puts b.name

perks_attributes = [{
name: "Un cookie offert",
business_id: business_id,
description: "Un cookie offert pour tout achat !",
active: true,
perk_code: "LABELTERRE",
appel: false,
durable: true,
flash: false,
perk_detail_id: carte.id
}]

puts "--------CREATE PERKS-----------"
perks_attributes.each do |params|
    Perk.create(params)
end
puts "--------END BUSINESS-----------"
