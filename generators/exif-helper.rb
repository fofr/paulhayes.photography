require 'time'

module ExifHelper
  def date(exif)
    exif.date_time_original.strftime('%Y-%m-%d %H:%M')
  end

  def camera(exif)
    exif.model
  end

  # Lens isn't available using EXIFR
  # Instead infer from focal length
  def lens(exif)
    focal_length = exif.focal_length.to_f

    if focal_length == 400
      lens = "Canon EF 400mm f/5.6L USM"
    elsif focal_length > 69
      lens = "Canon EF 70-200mm f/4L IS"
    elsif focal_length == 50
      lens = "Canon EF 50mm f/1.4 USM"
    elsif focal_length >= 17 && Time.parse('2015-01-01') < exif.date_time_original
      # Purchased start of 2015
      lens = "Canon EF 17-40mm f/4L USM"
    elsif focal_length >= 23
      lens = "Canon EF-S 17-55mm f/2.8 IS USM"
    elsif focal_length >= 18 && Time.parse('2013-01-01') > exif.date_time_original
      # Kits lens, stopped using circa 2013
      lens = "Canon EF-S 18-55mm f/3.5-5.6 IS"
    else
      lens = "Canon EF-S 10-22mm f/3.5-4.5 USM"
    end
  end

  def aperture(exif)
    "ƒ/#{exif.f_number.to_f.to_s.sub(/\.0$/, '')}"
  end

  # Readable shutter speeds
  # Use 0.X but not 1.X or 0.0X shutter speeds
  def shutter(exif)
    shutter = exif.exposure_time.to_f

    if exif.exposure_time && exif.exposure_time.numerator != 1 && shutter < 1
      return shutter
    end

    if shutter < 1
      return exif.exposure_time
    end

    shutter.to_s.sub(/\.0$/,'')
  end

  def iso(exif)
    exif.iso_speed_ratings
  end

  def focal(exif)
    "#{exif.focal_length.to_f}mm"
  end
end
