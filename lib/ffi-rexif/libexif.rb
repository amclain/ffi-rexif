# A Ruby FFI wrapper for libexif.
module LibExif
  # @todo Search the common paths for the library.
  # Path to use for `ffi_lib`.
  FFI_LIBRARY_PATH = '/usr/lib/x86_64-linux-gnu/libexif.so.12'
end
