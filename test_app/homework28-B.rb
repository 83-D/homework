# 宿題28-B
# FileManagerクラスのadd_fileメソッドを、なんらかの拡張子があればTrueを返し、
# なければFalseを返す（メンバ変数に登録もしない）、ように修正してください。

class FileManager
    def initialize()
	    @file_name = []
    end

    def add_file(f)
        if f.match(/(.*)(?:\.([^.]+$))/)
            @file_name << f
            return true
        else
            return false
        end
    end

    def kakunin # 配列の中身確認用
        p @file_name
    end
    
end

fm = FileManager.new()
 
p fm.add_file("bbb.txt")
p fm.add_file("aaa.jpg")
p fm.add_file("aaa")
 
fm.kakunin