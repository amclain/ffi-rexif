require 'ffi-rexif/content'
require 'ffi-rexif/data'

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

  ExifTag = enum :exif_tag, [
    :EXIF_TAG_INTEROPERABILITY_INDEX, 0x0001,
    :EXIF_TAG_INTEROPERABILITY_VERSION, 0x0002,
    :EXIF_TAG_NEW_SUBFILE_TYPE, 0x00fe,
    :EXIF_TAG_IMAGE_WIDTH, 0x0100,
    :EXIF_TAG_IMAGE_LENGTH, 0x0101,
    :EXIF_TAG_BITS_PER_SAMPLE, 0x0102,
    :EXIF_TAG_COMPRESSION, 0x0103,
    :EXIF_TAG_PHOTOMETRIC_INTERPRETATION, 0x0106,
    :EXIF_TAG_FILL_ORDER, 0x010a,
    :EXIF_TAG_DOCUMENT_NAME, 0x010d,
    :EXIF_TAG_IMAGE_DESCRIPTION, 0x010e,
    :EXIF_TAG_MAKE, 0x010f,
    :EXIF_TAG_MODEL, 0x0110,
    :EXIF_TAG_STRIP_OFFSETS, 0x0111,
    :EXIF_TAG_ORIENTATION, 0x0112,
    :EXIF_TAG_SAMPLES_PER_PIXEL, 0x0115,
    :EXIF_TAG_ROWS_PER_STRIP, 0x0116,
    :EXIF_TAG_STRIP_BYTE_COUNTS, 0x0117,
    :EXIF_TAG_X_RESOLUTION, 0x011a,
    :EXIF_TAG_Y_RESOLUTION, 0x011b,
    :EXIF_TAG_PLANAR_CONFIGURATION, 0x011c,
    :EXIF_TAG_RESOLUTION_UNIT, 0x0128,
    :EXIF_TAG_TRANSFER_FUNCTION, 0x012d,
    :EXIF_TAG_SOFTWARE, 0x0131,
    :EXIF_TAG_DATE_TIME, 0x0132,
    :EXIF_TAG_ARTIST, 0x013b,
    :EXIF_TAG_WHITE_POINT, 0x013e,
    :EXIF_TAG_PRIMARY_CHROMATICITIES, 0x013f,
    :EXIF_TAG_SUB_IFDS, 0x014a,
    :EXIF_TAG_TRANSFER_RANGE, 0x0156,
    :EXIF_TAG_JPEG_PROC, 0x0200,
    :EXIF_TAG_JPEG_INTERCHANGE_FORMAT, 0x0201,
    :EXIF_TAG_JPEG_INTERCHANGE_FORMAT_LENGTH, 0x0202,
    :EXIF_TAG_YCBCR_COEFFICIENTS, 0x0211,
    :EXIF_TAG_YCBCR_SUB_SAMPLING, 0x0212,
    :EXIF_TAG_YCBCR_POSITIONING, 0x0213,
    :EXIF_TAG_REFERENCE_BLACK_WHITE, 0x0214,
    :EXIF_TAG_XML_PACKET, 0x02bc,
    :EXIF_TAG_RELATED_IMAGE_FILE_FORMAT, 0x1000,
    :EXIF_TAG_RELATED_IMAGE_WIDTH, 0x1001,
    :EXIF_TAG_RELATED_IMAGE_LENGTH, 0x1002,
    :EXIF_TAG_CFA_REPEAT_PATTERN_DIM, 0x828d,
    :EXIF_TAG_CFA_PATTERN, 0x828e,
    :EXIF_TAG_BATTERY_LEVEL, 0x828f,
    :EXIF_TAG_COPYRIGHT, 0x8298,
    :EXIF_TAG_EXPOSURE_TIME, 0x829a,
    :EXIF_TAG_FNUMBER, 0x829d,
    :EXIF_TAG_IPTC_NAA, 0x83bb,
    :EXIF_TAG_IMAGE_RESOURCES, 0x8649,
    :EXIF_TAG_EXIF_IFD_POINTER, 0x8769,
    :EXIF_TAG_INTER_COLOR_PROFILE, 0x8773,
    :EXIF_TAG_EXPOSURE_PROGRAM, 0x8822,
    :EXIF_TAG_SPECTRAL_SENSITIVITY, 0x8824,
    :EXIF_TAG_GPS_INFO_IFD_POINTER, 0x8825,
    :EXIF_TAG_ISO_SPEED_RATINGS, 0x8827,
    :EXIF_TAG_OECF, 0x8828,
    :EXIF_TAG_TIME_ZONE_OFFSET, 0x882a,
    :EXIF_TAG_EXIF_VERSION, 0x9000,
    :EXIF_TAG_DATE_TIME_ORIGINAL, 0x9003,
    :EXIF_TAG_DATE_TIME_DIGITIZED, 0x9004,
    :EXIF_TAG_COMPONENTS_CONFIGURATION, 0x9101,
    :EXIF_TAG_COMPRESSED_BITS_PER_PIXEL, 0x9102,
    :EXIF_TAG_SHUTTER_SPEED_VALUE, 0x9201,
    :EXIF_TAG_APERTURE_VALUE, 0x9202,
    :EXIF_TAG_BRIGHTNESS_VALUE, 0x9203,
    :EXIF_TAG_EXPOSURE_BIAS_VALUE, 0x9204,
    :EXIF_TAG_MAX_APERTURE_VALUE, 0x9205,
    :EXIF_TAG_SUBJECT_DISTANCE, 0x9206,
    :EXIF_TAG_METERING_MODE, 0x9207,
    :EXIF_TAG_LIGHT_SOURCE, 0x9208,
    :EXIF_TAG_FLASH, 0x9209,
    :EXIF_TAG_FOCAL_LENGTH, 0x920a,
    :EXIF_TAG_SUBJECT_AREA, 0x9214,
    :EXIF_TAG_TIFF_EP_STANDARD_ID, 0x9216,
    :EXIF_TAG_MAKER_NOTE, 0x927c,
    :EXIF_TAG_USER_COMMENT, 0x9286,
    :EXIF_TAG_SUB_SEC_TIME, 0x9290,
    :EXIF_TAG_SUB_SEC_TIME_ORIGINAL, 0x9291,
    :EXIF_TAG_SUB_SEC_TIME_DIGITIZED, 0x9292,
    :EXIF_TAG_XP_TITLE, 0x9c9b,
    :EXIF_TAG_XP_COMMENT, 0x9c9c,
    :EXIF_TAG_XP_AUTHOR, 0x9c9d,
    :EXIF_TAG_XP_KEYWORDS, 0x9c9e,
    :EXIF_TAG_XP_SUBJECT, 0x9c9f,
    :EXIF_TAG_FLASH_PIX_VERSION, 0xa000,
    :EXIF_TAG_COLOR_SPACE, 0xa001,
    :EXIF_TAG_PIXEL_X_DIMENSION, 0xa002,
    :EXIF_TAG_PIXEL_Y_DIMENSION, 0xa003,
    :EXIF_TAG_RELATED_SOUND_FILE, 0xa004,
    :EXIF_TAG_INTEROPERABILITY_IFD_POINTER, 0xa005,
    :EXIF_TAG_FLASH_ENERGY, 0xa20b,
    :EXIF_TAG_SPATIAL_FREQUENCY_RESPONSE, 0xa20c,
    :EXIF_TAG_FOCAL_PLANE_X_RESOLUTION, 0xa20e,
    :EXIF_TAG_FOCAL_PLANE_Y_RESOLUTION, 0xa20f,
    :EXIF_TAG_FOCAL_PLANE_RESOLUTION_UNIT, 0xa210,
    :EXIF_TAG_SUBJECT_LOCATION, 0xa214,
    :EXIF_TAG_EXPOSURE_INDEX, 0xa215,
    :EXIF_TAG_SENSING_METHOD, 0xa217,
    :EXIF_TAG_FILE_SOURCE, 0xa300,
    :EXIF_TAG_SCENE_TYPE, 0xa301,
    :EXIF_TAG_NEW_CFA_PATTERN, 0xa302,
    :EXIF_TAG_CUSTOM_RENDERED, 0xa401,
    :EXIF_TAG_EXPOSURE_MODE, 0xa402,
    :EXIF_TAG_WHITE_BALANCE, 0xa403,
    :EXIF_TAG_DIGITAL_ZOOM_RATIO, 0xa404,
    :EXIF_TAG_FOCAL_LENGTH_IN_35MM_FILM, 0xa405,
    :EXIF_TAG_SCENE_CAPTURE_TYPE, 0xa406,
    :EXIF_TAG_GAIN_CONTROL, 0xa407,
    :EXIF_TAG_CONTRAST, 0xa408,
    :EXIF_TAG_SATURATION, 0xa409,
    :EXIF_TAG_SHARPNESS, 0xa40a,
    :EXIF_TAG_DEVICE_SETTING_DESCRIPTION, 0xa40b,
    :EXIF_TAG_SUBJECT_DISTANCE_RANGE, 0xa40c,
    :EXIF_TAG_IMAGE_UNIQUE_ID, 0xa420,
    :EXIF_TAG_GAMMA, 0xa500,
    :EXIF_TAG_PRINT_IMAGE_MATCHING, 0xc4a5,
    :EXIF_TAG_PADDING, 0xea1c,
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
  attach_function :exif_entry_initialize, [:pointer, :exif_tag], :void
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
