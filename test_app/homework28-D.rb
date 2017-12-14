# 宿題28-D
# FileManagerクラスに、登録された全てのファイル名が同じ拡張子を持っているかどうかを
# 判断して真偽値を返すメソッドis_same_extを実装して使ってみてください。

class FileManager
    def initialize()
	    @file_name = []
    end

    def add_file(f) #なんらかの拡張子があればTrueを返し、なければFalseを返す（メンバ変数に登録もしない）
        #if f.match(/(.*)(?:\.([^.]+$))/)
        if f.match(/.*\..+$/)
            @file_name << f
            return true
        else
            return false
        end
    end
    
    def is_same_ext #登録された全てのファイル名が同じ拡張子を持っているかどうかを判断して真偽値を返す
        ext_ary = []
        @file_name.each do |f| #拡張子をext_aryに格納
            f.match(/.*\.(.+$)/)
            ext_ary << $1 
        end
        
        count = Hash.new(0)
        ext_ary.each do |elem|
            count[elem] += 1
        end
        if count.count == 1 #ハッシュのカウントが2以上だったら複数の拡張子があるということ
            return true
        end
        return false
    end

    def kakunin # 配列の中身確認用
        p @file_name
    end
    
end

fm = FileManager.new()
 
fm.add_file("bbb.txtc")
fm.add_file("aaa.txtc")
fm.add_file("aaa")
fm.add_file("aaa.jpg")

p fm.is_same_ext
 
fm.kakunin