# 宿題28-C
# FileManagerクラスのadd_fileメソッドを、
# すでに同じ名前のファイル名が登録されていたらFalseを返すように修正してください。
# 同じファイルを登録しないようにしてください。


class FileManager
    def initialize()
	    @file_name = []
    end

    def add_file(f)
        
        if @file_name.include?(f)
            return false
        else
            @file_name << f
            return true
        end
    end
    
    def kakunin # 配列の中身確認用
        p @file_name
    end

end

fm = FileManager.new()
 
p fm.add_file("bbb.txt")
p fm.add_file("aaa.txt")
p fm.add_file("aaa.txt")
p fm.add_file("aaa.txt")
p fm.add_file("ccc.txt")
 
fm.kakunin
