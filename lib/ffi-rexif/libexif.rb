# A low-level Ruby FFI wrapper for libexif.
# @see http://libexif.sourceforge.net/api/ libexif API documentation
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
  ExifTag = enum :exif_tag, [
    :EXIF_TAG_MODEL, 0x0110,
  ]

  # Loader
  attach_function :exif_data_new, [:void], :pointer
  attach_function :exif_loader_new_mem, [:pointer], :pointer
  attach_function :exif_loader_ref, [:pointer], :void
  attach_function :exif_loader_unref, [:pointer], :void
  attach_function :exif_loader_write_file, [:pointer, :string], :void, blocking: true
  attach_function :exif_loader_write, [:pointer, :uchar, :uint], :uchar
  attach_function :exif_loader_reset, [:pointer], :void
  attach_function :exif_loader_get_data, [:pointer], :pointer
  attach_function :exif_loader_get_buf, [:pointer, :pointer, :uint], :void
  attach_function :exif_loader_log, [:pointer, :pointer], :void

  # Data
  attach_function :exif_data_new, [:void], :pointer
  attach_function :exif_data_new_mem, [:pointer], :pointer
  attach_function :exif_data_new_from_file, [:string], :pointer, blocking: true
  attach_function :exif_data_new_from_data, [:pointer, :uint], :pointer
  attach_function :exif_data_load_data, [:pointer, :pointer, :uint], :void
  attach_function :exif_data_save_data, [:pointer, :pointer, :pointer], :void
  attach_function :exif_data_ref, [:pointer], :void
  attach_function :exif_data_unref, [:pointer], :void
  attach_function :exif_data_free, [:pointer], :void
  # attach_function :exif_data_get_byte_order, [:pointer], :exif_byte_order
  # attach_function :exif_data_set_byte_order, [:pointer, :exif_byte_order], :void
  attach_function :exif_data_get_mnote_data, [:pointer], :pointer
  attach_function :exif_data_fix, [:pointer], :void
  # attach_function :exif_data_foreach_content, [:pointer, ], :void
  # attach_function :exif_data_option_get_name, [:exif_data_option], :string
  # attach_function :exif_data_option_get_description, [:exif_data_option], :string
  # attach_function :exif_data_set_option, [:pointer, :exif_data_option], :void
  # attach_function :exif_data_unset_option, [:pointer, :exif_data_option], :void
  # attach_function :exif_data_set_data_type, [:pointer, :exif_data_type], :void
  # attach_function :exif_data_get_data_type, [:pointer], :exif_data_type
  attach_function :exif_data_dump, [:pointer], :void
  attach_function :exif_data_log, [:pointer, :pointer], :void

  # Content
  attach_function :exif_content_new, [:void], :pointer
  attach_function :exif_content_new_mem, [:pointer], :pointer
  attach_function :exif_content_ref, [:pointer], :void
  attach_function :exif_content_unref, [:pointer], :void
  attach_function :exif_content_free, [:pointer], :void
  attach_function :exif_content_add_entry, [:pointer, :pointer], :void
  attach_function :exif_content_remove_entry, [:pointer, :pointer], :void
  attach_function :exif_content_get_entry, [:pointer, :exif_tag], :pointer
  attach_function :exif_content_fix, [:pointer], :void
  # attach_function :exif_content_foreach_entry, [:pointer, ], :void
  # attach_function :exif_content_get_ifd, [:pointer], :exif_ifd
  attach_function :exif_content_dump, [:pointer, :uint], :void
  attach_function :exif_content_log, [:pointer, :pointer], :void

  # Entry
  attach_function :exif_entry_new, [:void], :pointer
  attach_function :exif_entry_new_mem, [:pointer], :pointer
  attach_function :exif_entry_ref, [:pointer], :void
  attach_function :exif_entry_unref, [:pointer], :void
  attach_function :exif_entry_free, [:pointer], :void
  # attach_function :exif_entry_initialize, [:pointer, :exif_tag], :void
  attach_function :exif_entry_fix, [:pointer], :void
  attach_function :exif_entry_get_value, [:pointer, :pointer, :uint], :string
  attach_function :exif_entry_dump, [:pointer, :uint], :void

  # Mnote Data
  attach_function :exif_mnote_data_ref, [:pointer], :void
  attach_function :exif_mnote_data_unref, [:pointer], :void
  attach_function :exif_mnote_data_load, [:pointer, :pointer, :uint], :void
  attach_function :exif_mnote_data_save, [:pointer, :pointer, :pointer], :void
  attach_function :exif_mnote_data_count, [:pointer], :uint
  attach_function :exif_mnote_data_get_id, [:pointer, :uint], :uint
  attach_function :exif_mnote_data_get_name, [:pointer, :uint], :string
  attach_function :exif_mnote_data_get_title, [:pointer, :uint], :string
  attach_function :exif_mnote_data_get_description, [:pointer, :uint], :string
  attach_function :exif_mnote_data_get_value, [:pointer, :uint, :pointer, :uint], :string
  attach_function :exif_mnote_data_log, [:pointer, :pointer], :void

  # Log
  attach_function :exif_log_new, [:void], :pointer
  attach_function :exif_log_new_mem, [:pointer], :pointer
  attach_function :exif_log_ref, [:pointer], :void
  attach_function :exif_log_unref, [:pointer], :void
  attach_function :exif_log_free, [:pointer], :void
  # attach_function :exif_log_code_get_title, [:exif_log_code], :string
  # attach_function :exif_log_code_get_message, [:exif_log_code], :string
  # attach_function :exif_log_set_func, [:pointer, :exif_log_func, :pointer], :void
  # attach_function :exif_log, [:pointer, :exif_log_code, :pointer, :pointer, ...], :void
  # attach_function :exif_logv, [:pointer, :exif_log_code, :pointer, :pointer, :args_list], :void
end
