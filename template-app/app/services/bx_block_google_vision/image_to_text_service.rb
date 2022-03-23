require "google/cloud/vision"
module BxBlockGoogleVision 
  class ImageToTextService
    attr_accessor :image_annotator, :file_name
    def initialize(file_name)
      @image_annotator = Google::Cloud::Vision::ImageAnnotator.new
      @file_name = file_name
    end

    def convert
      response = image_annotator.document_text_detection image: file_name
      
      text = ""
      response.responses.each do |res|
        res.text_annotations.each do |annotation|
          text << annotation.description
        end
      end

      text
    end
  end
end