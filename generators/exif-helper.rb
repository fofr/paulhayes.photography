module ExifHelper
  def date(exif)
    exif.date_time.strftime('%Y-%m-%d %H:%M')
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
    elsif focal_length > 16.9
      lens = "Canon EF 17-40mm f/4L USM"
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
    exposure_string = exif.exposure_time
    exposure_float = exposure_string.to_f

    if exposure_float < 1 && exposure_float > 0.09
      exposure_float
    else
      exposure_string
    end
  end

  def iso(exif)
    exif.iso_speed_ratings
  end

  def focal(exif)
    "#{exif.focal_length.to_f}mm"
  end
end
