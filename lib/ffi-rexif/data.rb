module LibExif
  # The entirety of EXIF data found in an image.
  class Data < FFI::Struct
    layout \
      :ifd, :pointer,
      :data, :pointer,
      :size, :uint
  end
end
