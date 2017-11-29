# 宿題28-C
# FileManagerクラスのadd_fileメソッドを、
# すでに同じ名前のファイル名が登録されていたらFalseを返すように修正してください。


class FileManager
    def initialize()
	    @file_name = []
    end

    def add_file(f)
        aaa = @file_name.include?(f)
        @file_name << f
        return !(aaa)
    end

end

fm = FileManager.new()
 
p fm.add_file("bbb.txt")
p fm.add_file("aaa.txt")
p fm.add_file("aaa.txt")
 

