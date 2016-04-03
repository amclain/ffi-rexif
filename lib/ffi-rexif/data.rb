module LibExif
  # The entirety of EXIF data found in an image.
  module Data
    extend FFI::Library

    ffi_lib LibExif::FFI_LIBRARY_PATH

    attach_function :exif_data_new_from_file, [:string], :pointer, blocking: true
  end
end
