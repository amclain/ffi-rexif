module LibExif
  # Holds all EXIF tags in a single IFD.
  class Content < FFI::Struct
    layout \
      :entries, :pointer,
      :count, :uint,
      :parent, :pointer,
      :priv, :pointer
  end
end
