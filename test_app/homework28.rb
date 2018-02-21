# 宿題28
# 以下のプログラムを考えてください。1,2全てが出力されるように、FileManagerクラスを実装してください。

class FileManager
    def initialize()
	    @file_name = []
    end

    def add_file(f)
        @file_name << f
    end

    def filename_include?(s)
    	@file_name.each do |str|
    		unless str.include?(s)
    			return  false
    		end
    	end
        return true
    end
end

fm = FileManager.new()
 
fm.add_file("bbb.txt")
fm.add_file("aaa.txt")
 
if fm.filename_include?(".txt") then
	puts "1. Include!"
end
 
unless fm.filename_include?("aaa") then
	puts "2. Not include..."
end
