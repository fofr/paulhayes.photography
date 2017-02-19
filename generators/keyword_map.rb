require 'time'

class KeywordMap
  def keywords_with_exif(exif, types = [], keys = [])
    exposure = exif.exposure_time.to_f
    types << 'long_exposure' if exposure > 5

    month = exif.date_time_original.strftime('%B').downcase
    keys << month
    types << 'summer' if %w{june july august}.include?(month)
    types << 'autumn' if %w{september october november}.include?(month)
    types << 'winter' if %w{december january february}.include?(month)
    types << 'spring' if %w{march april may}.include?(month)

    keywords(types, keys)
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

  def wildlife
    %w{
      wildlife
      wild
      animal
      animals
      nature
      wildlife_photography
      natural
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
      trees
      tree
    } + english
  end

  def uk
    %w{
      uk
      british
    }
  end

  def english
    %w{
      english
      england
    } + uk
  end

  def brighton
    %w{
      brighton
      sussex
      england
      south_coast
      southern_england
    } + english
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
      frost
      frosty
    }
  end

  def spring
    %w{
      spring
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
    }
  end
end
