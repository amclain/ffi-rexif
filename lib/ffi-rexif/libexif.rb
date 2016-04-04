# A Ruby FFI wrapper for libexif.
module LibExif
  extend FFI::Library

  # TODO: Search the common paths for the library.
  ffi_lib '/usr/lib/x86_64-linux-gnu/libexif.so.12'

  IFD = enum :ifd, [
    :EXIF_IFD_0, 0,
    :EXIF_IFD_1,
    :EXIF_IFD_EXIF,
    :EXIF_IFD_GPS,
    :EXIF_IFD_INTEROPERABILITY,
    :EXIF_IFD_COUNT,
  ]

  # TODO: Populate ####################################
  enum :exif_tag, [
    :EXIF_TAG_MODEL, 0x0110,
  ]

  # Loader

  # Data
  attach_function :exif_data_new_from_file, [:string], :pointer, blocking: true
  attach_function :exif_data_unref, [:pointer], :void

  # Content
  attach_function :exif_content_get_entry, [:pointer, :exif_tag], :pointer

  # Entry
  attach_function :exif_entry_get_value, [:pointer, :pointer, :uint], :string

  # Mnote Data

  # Log
end
