describe "integration tests" do

  let(:tag_size) { 255 }
  let(:sample_image_path) { "spec/sample_images/exif_test.jpg" }

  it "reads exif data from a jpeg file" do
    exif_data = LibExif::Data.new LibExif.exif_data_new_from_file(sample_image_path)
    exif_content = LibExif::Content.new \
      exif_data[:ifd] + (LibExif::IFD[:EXIF_IFD_0] * LibExif::Content.size)

    entry = LibExif.exif_content_get_entry exif_content.to_ptr, :EXIF_TAG_MODEL
    model_tag_buf = FFI::MemoryPointer.new :char, tag_size
    model_tag = LibExif.exif_entry_get_value entry, model_tag_buf, tag_size

    model_tag.should eq "Test Model"
  end

end
