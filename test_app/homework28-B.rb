# 宿題28-B
# FileManagerクラスのadd_fileメソッドを、なんらかの拡張子があればTrueを返し、
# なければFalseを返す（メンバ変数に登録もしない）、ように修正してください。

class FileManager
    def initialize()
	   
    end

    def add_file(f)
        if f.match(/(.*)(?:\.([^.]+$))/)
            return true
        else
            return false
        end
    end

end

fm = FileManager.new()
 
p (fm.add_file("aaa.txt"))
p (fm.add_file("bbb"))
