describe "LibExif Data" do

  let(:sample_image_path) { "spec/sample_images/exif_test.jpg" }

  specify "exif_data_new_from_file" do
    data = LibExif.exif_data_new_from_file sample_image_path
    data.null?.should_not eq true
    LibExif.exif_data_unref data
  end

end
