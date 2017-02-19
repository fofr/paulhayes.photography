#!/usr/bin/ruby
gem 'mini_exiftool', '2.8.0'
gem 'exifr', '1.2.3.1'
require 'optparse'
require 'mini_exiftool'
require 'exifr'
require "./#{File.dirname(__FILE__)}/keyword_map.rb"
keyword_map = KeywordMap.new

# Get list of all posts
path_to_images = "#{Dir.pwd}/../paulhayes.photography-photos/"
posts = Dir.glob("source/_posts/photos/*.md")

# posts.each do |post|
#   image = post.split('/').last.sub(/md$/, 'jpg')
#   puts "[\"#{image}\", %w{}, %w{}],"
# end

images = [
  ["amur-leopard-snarl.jpg", %w{big_cat portrait}, %w{parus orientalis panthera_pardus_orientalis amur amur_leopard leopard snarl angry danger hiss teeth jaw scare far_eastern_leopard critically_endangered}],
  ["amur-leopard.jpg", %w{big_cat portrait}, %w{parus orientalis panthera_pardus_orientalis amur amur_leopard leopard prowl walking far_eastern_leopard critically_endangered}],
  ["an-autumn-day.jpg", %w{land english fantasy}, %w{national_trust lord_of_the_rings wakehurst_place kew_gardens kew park leaves bench sussex wakehurst inviting path}],
  ["autumn-colours.jpg", %w{sheffield_park forest fantasy land}, %w{yellow}],
  ["autumn-light.jpg", %w{sheffield_park forest fantasy land}, %w{yellow}],
  ["azaleas.jpg", %w{sheffield_park flower macro}, %w{pink azalea azaleas rhododendron}],
  ["azure-clatteringshaws.jpg", %w{loch calm blue_sky land}, %w{clatteringshaws galloway dumfries national_park}],
  ["blackbrook-woods.jpg", %w{bluebells forest land}, %w{blackbrook}],
  ["blade-runner.jpg", %w{sci_fi moon astro}, %w{blade_runner}],
  ["bluebell-bloom.jpg",  %w{bluebells forest land}, %w{blackbrook}],
  ["brae-of-achnahaird.jpg", %w{highlands}, %w{beach frozen_beach sand}],
  ["brighton-beach-low-tide.jpg", %w{palace_pier dawn moon}, %w{low_tide}],
  ["brighton-pavilion-twilight.jpg", %w{pavilion twilight}, %w{purple}],
  ["brighton-pavilion.jpg", %w{pavilion twilight}, %w{blue}],
  ["brighton-pier-supermoon.jpg", %w{moon night palace_pier }, %w{supermoon super_moon big_moon}],
  ["brighton-starlings.jpg", %w{starlings twilight palace_pier}, %w{low_tide reflection}],
  ["brighton-west-pier.jpg", %w{west_pier sunset}, %w{}],
  ["cadaques.jpg", %w{calm blue_sky}, %w{architecture spain cadaques europe european spanish remote town small}],
  ["centre-of-our-galaxy.jpg", %w{milky_way seychelles}, %w{}],
  ["clatteringshaws-before-dawn.jpg",  %w{loch dawn mist}, %w{clatteringshaws galloway dumfries national_park}],
  ["clatteringshaws-dawn.jpg", %w{loch dawn mist}, %w{clatteringshaws galloway dumfries national_park}],
  ["clatteringshaws-mist-and-reflections.jpg", %w{loch dawn mist}, %w{clatteringshaws galloway dumfries national_park}],
  ["corsewall-on-the-rocks.jpg", %w{scotland land}, %w{corsewall lighthouse abstract upside_down different rocks interesting}],
  ["cowpaths.jpg", %w{devils_dyke}, %w{}],
  ["dawn-ascent.jpg", %w{dawn}, %w{balloons balloon_fiesta bristol silhouette}],
  ["devils-dyke-sunset.jpg", %w{devils_dyke sunset}, %w{}],
  ["elphin.jpg", %w{highlands frost calm}, %w{cul_mor elphin derelict abandoned remote grass house}],
  ["esthwaite.jpg", %w{mist dawn lake_district}, %w{esthwaite ambleside dragon}],
  ["first-dance.jpg", %w{black_and_white}, %w{wedding people dance dancing couple love first_dance}],
  ["fox-profile.jpg", %w{fox}, %w{}, %w{fox red_fox}, %w{prowling watching hunting}],
  ["fox.jpg", %w{fox}, %w{}, %w{fox red_fox}, %w{prowling watching hunting}],
  ["frosty-abstract-1.jpg", %w{frost land abstract}, %w{hoar_frost lindfield detail}],
  ["frosty-abstract-2.jpg", %w{frost land abstract}, %w{hoar_frost lindfield detail}],
  ["frosty-abstract-3.jpg", %w{frost land abstract}, %w{hoar_frost lindfield detail}],
  ["frosty-abstract-4.jpg", %w{frost land abstract}, %w{hoar_frost lindfield detail}],
  ["frosty-glow.jpg", %w{frost dawn land}, %w{hoar_frost lindfield detail}],
  ["frosty-lindfield.jpg", %w{frost land abstract}, %w{hoar_frost lindfield detail}],
  ["frozen-beach.jpg", %w{scotland frost land}, %w{frozen_beach beach sand}],
  ["great-argus.jpg", %w{bird borneo}, %w{great_argus argus danum_valley tropical}],
  ["great-langdale.jpg", %w{lake_district overcast}, %w{langdale great_langdale}],
  ["great-tit.jpg", %w{bird portrait england}, %w{parus_major parus paridae}, %w{great_tit}, %w{perching sitting watching waiting}],
  ["grey-wagtail.jpg", %w{bird portrait england}, %w{motacilla_cinerea}, %w{wagtail grey_wagtail}, %w{eating_bug holding_bug eating_insect catching_fly}],
  ["harvest-mouse-on-wheat.jpg", %w{mammal england}, %w{wheatear precarious}, %w{mouse harvest_mouse micromys}, %w{climbing balancing on_wheat}],
  ["harvest-mouse.jpg", %w{mammal england}, %w{wheatear precarious}, %w{mouse harvest_mouse micromys}, %w{climbing balancing on_wheat}],
  ["hong-kong.jpg", %w{city night sci_fi landscape}, %w{hong_kong china victoria skyscraper skyscrapers}],
  ["iguacu-falls.jpg", %w{land}, %w{brazil waterfall}],
  ["iguana.jpg", %w{wildlife costa_rica portrait}, %w{reptile lizard}, %w{lizard iguana}, %w{watching sitting staring portrait}],
  ["illuminating-the-milky-way.jpg", %w{milky_way scotland}, %w{lighthouse shining corsewall}],
  ["kielder-forest.jpg", %w{forest land abstract}, %w{}, %w{kielder northumberland}, %w{forest wood woods trees}],
  ["kielder-observatory.jpg", %w{astro}, %w{obsy}, %w{observatory kielder_observatory}, %w{under_stars beneath_stars at_night}],
  ["kota-kinabalu-sunset.jpg", %w{sunset landscape calm borneo sea}, %w{kota_kinabalu}],
  ["kuching.jpg", %w{calm city borneo}, %w{kuching}],
  ["langdale-light.jpg", %w{lake_district}, %w{ray_of_light shaft_of_light clouds_opening langdale}],
  ["lightning-brighton-station.jpg", %w{brighton night city overcast black_and_white}, %w{lightning}],
  ["lightning-brighton.jpg", %w{brighton night city overcast sea}, %w{}, %w{lightning}, %w{strike spark fork}],
  ["loch-assynt-panorama.jpg", %w{loch highlands dawn}, %w{assynt loch_assynt}],
  ["loch-assynt.jpg", %w{loch highlands dawn}, %w{assynt loch_assynt}],
  ["loch-skeen.jpg", %w{loch land}, %w{skeen hike trail walk}],
  ["longsheng-rice-terraces.jpg", %w{land calm}, %w{rice_terrace rice_terraces yellow china longsheng pingan}],
  ["marloes-sands.jpg", %w{sea landscape uk}, %w{wales pembrokeshire marloes}],
  ["mirror-lake-jiuzhaigou.jpg", %w{landscape lake calm}, %w{china jiuzhaigou}, %w{lake mirror_lake turquoise_lake}, %w{reflection serene}],
  ["our-galaxy.jpg", %w{milky_way england}, %w{beachy_head}],
  ["pheasant-portrait.jpg", %w{bird portrait}, %w{sheffield_park national_trust}, %w{pheasant}, %w{posing portrait closeup colours color}],
  ["pitstone-windmill.jpg", %w{land sunset}, %w{}, %w{windmill pitstone_windmill chilterns ivinghoe}, %w{with_clouds evening}],
  ["polecat.jpg", %w{mammal england flowers}, %w{sussex carnivora}, %w{polecat ferret}, %w{portrait closeup watching peeking staring smelling}],
  ["poppy-field.jpg", %w{flowers sunset brighton}, %w{}, %w{poppy red_poppy}, %w{field fields}],
  ["red-panda.jpg", %w{mammal}, %w{china chengdu}, %w{red_panda}, %w{looking watching sniffing staring}],
  ["resplendent-quetzal.jpg", %w{bird costa_rica portrait}, %w{}, %w{quetzal resplendent_quetzal}, %w{sitting perching}],
  ["seal-posing.jpg", %w{mammal scotland}, %w{stranraer}, %w{seal grey_seal}, %w{posing sitting waiting by_sea in_harbour}],
  ["seven-sisters-dawn.jpg", %w{sussex dawn sea}, %w{}, %w{seven_sisters}, %w{at_dawn morning sunlight}],
  ["sky-rise.jpg", %w{sci_fi city black_and_white abstract}, %w{london neo architecture}],
  ["sleepwalking.jpg", %w{seychelles night sea calm}, %w{sleepwalking}],
  ["snow-tree.jpg", %w{frost south_downs}, %w{snow tree}],
  ["south-downs-falmer.jpg", %w{south_downs}, %w{falmer green}],
  ["starlings.jpg", %w{starlings palace_pier sea}, %w{}],
  ["starry-arch.jpg", %w{seychelles astro milky_way}, %w{arch starry}],
  ["striped-blue-crow-butterfly.jpg", %w{wildlife}, %w{insect butterfly blue_crow_butterfly china longsheng pingan}],
  ["summer-poppies.jpg", %w{flowers sunset brighton}, %w{}, %w{poppy red_poppy}, %w{field fields}],
  ["sunbird.jpg", %w{bird borneo flower}, %w{kota_kinabalu}, %w{sunbird}, %w{perching sitting on_branch flower}],
  ["superbloodmoon-rottingdean.jpg", %w{moon astro sussex}, %w{rottingdean windmill composition supermoon superblood_moon superbloodmoon}],
  ["tawny-owl.jpg", %w{bird}, %w{strix aluco}, %w{owl tawny_owl}, %w{tree tree_trunk perching daylight sitting}],
  ["the-bandstand.jpg", %w{brighton night city sea}, %w{bandstand the_bandstand}],
  ["the-gloaming.jpg", %w{land abstract}, %w{purple chilterns ivinghoe}],
  ["thirlmere.jpg", %w{lake_district overcast}, %w{thirlmere}],
  ["tiger.jpg", %w{big_cat}, %w{bamboo}, %w{tiger bengal_tiger}, %w{staring prowling walking moving hunting}],
  ["tree-in-bluebells.jpg", %w{bluebells forest land sussex}, %w{blackbrook}],
  ["twilight-sands.jpg", %w{twilight sunset sea}, %w{marloes sands pembrokeshire}],
  ["two-trees.jpg", %w{}, %w{}],
  ["west-beach-sunset.jpg", %w{seychelles sunset sea calm}, %w{west_beach volunteering conservation}],
  ["west-beach.jpg", %w{seychelles sea calm blue_sky}, %w{west_beach volunteering conservation}],
  ["west-pier-blue.jpg", %w{west_pier}, %w{}],
  ["west-pier-dreamy.jpg", %w{west_pier sunset}, %w{dreamy colourful colours}],
  ["west-pier-halloween.jpg", %w{west_pier sunrise}, %w{halloween pink}],
  ["west-pier-hot-and-cold.jpg", %w{west_pier sunset}, %w{hot_and_cold hot cold}],
  ["west-pier-purple-murmuration.jpg", %w{west_pier starlings sunset}, %w{}],
  ["west-pier-rust.jpg", %w{west_pier birds abstract}, %w{rust}],
  ["west-pier-sunset.jpg", %w{west_pier sunset}, %w{silhouette sun}],
  ["wild-goat.jpg", %w{wildlife scotland}, %w{}, %w{goat wild_goat}, %w{chewing eating looking staring}],
]

images.each do |image|
  filename = image[0]
  keyword_types = image[1]
  keywords = image[2]
  keyword_nouns = image[3]
  keyword_modifiers = image[4]

  photo = MiniExiftool.new("#{path_to_images}#{filename}")
  exif = EXIFR::JPEG.new("#{path_to_images}#{filename}")

  existing_keywords = photo.keywords || []
  if keyword_nouns && keyword_modifiers
    modified_keywords = keyword_map.nouns_with_modifiers(keyword_nouns, keyword_modifiers)
    existing_keywords.concat(modified_keywords)
  end

  new_keywords = keyword_map.keywords_with_exif(exif, keyword_types, existing_keywords + keywords)
  puts "#{image[0]}: #{new_keywords.join(', ')} (#{new_keywords.size})\n\n"
  photo.keywords = new_keywords
  photo.save
end

exit
