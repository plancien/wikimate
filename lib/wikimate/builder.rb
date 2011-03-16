module Wikimate
  class Builder
    def initialize(root,output_dir, options = {})
      @root = root
      @output_dir = output_dir
      @options = options
    end

    def run
      FileUtils.mkdir_p @output_dir
      interpreter = Interpreter.new(@root, @options)
      interpreter.pages.each do |page|
        File.open(File.join(@output_dir, page+".html"),"w") do |file|
          file.write interpreter.html_for_page(page)
        end
      end
      ['wikimate.css', 'wikimate.js'].each do |file_name|
        FileUtils.cp(File.join(LIB_DIR, file_name), File.join(@output_dir, file_name))
      end
    end

  end
end
