require 'time'

class KeywordMap
  def keywords_with_exif(exif, types = [], keys = [])
    if exif && exif.exposure_time
      exposure = exif.exposure_time.to_f
      types << 'long_exposure' if exposure > 5
    end

    if exif && exif.date_time_original
      month = exif.date_time_original.strftime('%B').downcase
      keys << month
      types << 'summer' if %w{june july august}.include?(month)
      types << 'autumn' if %w{september october november}.include?(month)
      types << 'winter' if %w{december january february}.include?(month)
      types << 'spring' if %w{march april may}.include?(month)
    end

    keywords(types, keys)
  end

  def nouns_with_modifiers(nouns = [], modifiers = [])
    nouns + modifiers + nouns.product(modifiers).map{ |i| i.join('_')}
  end

  def keywords(types = [], keys = [])
    types.each do |type|
      begin
        keys.concat(self.send(type))
      rescue
        puts "Warning: No type “#{type}” found"
      end
    end

    keys.concat(paul_hayes)
    keys.map {|k| k.gsub('_', ' ') }.uniq
  end

  def bird
    birds
  end

  def birds
    %w{
      bird
      birds
      aves
      avian
      wings
      feathers
      flying
      birding
      bird_portrait
    } + wildlife
  end

  def starlings
    %w{
      starlings
      murmuration
      murmurating
      murmurating_starlings
      flock_of_birds
      flock
      sturnidae
      passerine
    } + birds
  end

  def wildlife
    %w{
      wildlife
      animal
      animals
      nature
      wildlife_photography
      natural
      nature
      fauna
      animal_portrait
    }
  end

  def landscape
    %w{
      landscape
      landscape_photography
      outdoors
      travel
      vista
      picturesque
    }
  end

  def land
    %w{
      land
      light_on_land
      adventure
    } + landscape
  end

  def overcast
    %w{
      moody
      overcast
      epic
      adventure
      heavy
      powerful
      stormy
      storm
      clouds
    }
  end

  def paul_hayes
    %w{
      paul_hayes
      paul_hayes_photography
    }
  end

  def black_and_white
    %w{
      black_and_white
      b&w
      b+w
      black_white
      tones
    }
  end

  def sheffield_park
    %w{
      sheffield_park
      national_trust
      gardens
      garden
      trees
      tree
    } + english
  end

  def forest
    %w{
      forest
      wood
      woods
      trees
      leaves
      tall
      nature
    }
  end

  def borneo
    %w{
      borneo
      malaysia
      jungle
      wild
    }
  end

  def uk
    %w{
      uk
      british
    }
  end

  def costa_rica
    %w{
      costa_rica
      central_america
      americas
      new_world
      pura_vida
    }
  end

  def england
    english
  end

  def english
    %w{
      english
      england
    } + uk
  end

  def lake_district
    %w{
      lake_district
      the_lakes
      lake
      lakes
      cumbria
      northwest_england
    } + land + england
  end

  def brighton
    %w{
      brighton
      south_coast
    } + sussex
  end

  def devils_dyke
    %w{
      devils_dyke
    } + south_downs
  end

  def south_downs
    %w{
      south_downs
      rolling_hills
      downs
      hills
      farm
      farmland
      slopes
      pasture
      pattern
    } + brighton + land
  end

  def sussex
    %w{
      sussex
      southern_england
    } + england
  end

  def west_pier
    %w{
      west_pier
      pier
      architecture
      deteriorate
      structure
      disappearing
      decay
    } + sea + brighton
  end

  def palace_pier
    %w{
      palace_pier
      brighton_pier
      pier
      architecture
      seaside_town
      seaside_attractions
      arcades
    } + sea + brighton
  end

  def pavilion
    %w{
      brighton_pavilion
      royal_pavilion
      architecture
      brighton_palace
      pavilion
    } + brighton
  end

  def sea
    %w{
      sea
      seaside
      beach
      sand
      coast
      water
      seascape
      waves
      ocean
      outdoors
      travel
    }
  end

  def mammal
    %w{
      mammal
      mammals
    } + wildlife
  end

  def fantasy
    %w{
      fantasy
      magical
      middle_earth
      beautiful
      mystical
      tolkien
    }
  end

  def fox
    %w{
      fox
      foxy
      red_fox
      british_fox
      british_wildlife
      fox_portrait
      fox_daylight
      fox_field
      european_fox
      fur
      red
      orange
      predator
      carnivore
      vulpes
    } + mammal
  end

  def portrait
    %w{
      close_up
      closeup
      portrait
      head
      face
    }
  end

  def long_exposure
    %w{
      long_exposure
      long
    }
  end

  def winter
    %w{
      cold
      winter
    }
  end

  def spring
    %w{
      spring
      springtime
    }
  end

  def summer
    %w{
      summer
      warm
    }
  end

  def autumn
    %w{
      autumn
      fall
      autumnal
      autumn_colours
    }
  end

  def frost
    %w{
      frost
      frosty
      frostbite
    } + winter
  end

  def big_cat
    %w{
      big_cat
      predator
      carnivore
      cat
      cats
      fauna
      panthera
      endangered
    } + wildlife + mammal
  end

  def flower
    flowers + macro
  end

  def flowers
    %w{
      flower
      flowers
      plant
      flora
      blossom
      bloom
    }
  end

  def bluebells
    %w{
      bluebell
      bluebells
      purple
      purple flowers
    } + flowers + uk
  end

  def macro
    %w{
      macro
      small
      detail
    }
  end

  def scotland
    %w{
      scotland
      scottish
    } + uk
  end

  def highlands
    %w{
      highlands
      mountain
      mountains
      snow
      snowy
    } + land + scotland
  end

  def lake
    %w{
      lake
      water
      reflection
      water_body
    }
  end

  def loch
    %w{
      loch
    } + lake + scotland
  end

  def blue_sky
    %w{
      blue_sky
      clear_sky
      azure
      fairweather
      nice_weather
    }
  end

  def calm
    %w{
      calm
      holiday
      tranquil
      peaceful
      quiet
      relaxing
      relax
      serene
      serenity
      halcyon
      idyllic
      blissful
      picturesque
    }
  end

  def night
    %w{
      night
      night_time
      nightscape
      dark
    }
  end

  def city
    %w{
      city
      city_lights
      cityscape
    }
  end

  def sci_fi
    %w{
      sci_fi
      scifi
      futuristic
    } + city
  end

  def astro
    %w{
      astro
      astrophotography
      star
      stars
      space
      universe
    } + night
  end

  def milky_way
    %w{
      milky_way
      milkyway
      galaxy
      our_galaxy
      stardust
      star_dust
    } + astro
  end

  def moon
    %w{
      moon
      luna
      the_moon
    }
  end

  def dawn
    %w{
      dawn
      sunrise
      morning
      morning_light
      start_of_the_day
    }
  end

  def sunset
    %w{
      sunset
      dusk
      evening
      evening_light
      end_of_the_day
    }
  end

  def twilight
    %w{
      twilight
      evening
      blue_hour
    } + night
  end

  def seychelles
    %w{
      seychelles
      north_island
      island
      remote
      remote_island
      holiday
    }
  end

  def mist
    %w{
      mist
      misty
      fog
      foggy
      low_cloud
    } + land
  end

  def abstract
    %w{
      abstract
      different
      alternative
    }
  end
end
