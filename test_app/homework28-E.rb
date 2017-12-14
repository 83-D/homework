# 宿題28-E
# ファイルの属性(Attribute)を管理するクラスFileAttrManagerを新たに定義します。
# ファイルの、サイズ、所有者、書き込みの許可、作成時刻、をメンバ変数に持ちます。
# コンストラクタでそれぞれのメンバ変数を適切な初期値で初期化してください。
# 作成時刻には、初期値としてコンストラクタが呼ばれた時点の現在時刻を設定してください。
require 'date'

class FileAttrManager
    def initialize() # ファイルのサイズ、所有者、書き込みの許可、作成時刻、をメンバ変数に持ちます。コンストラクタでそれぞれのメンバ変数を適切な初期値で初期化してください。
	    @f_size = 0
	    @f_owner = ""
	    @f_write = false
	    @f_create_at = Time.now
    end

end

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
fa = FileAttrManager.new()

fm.add_file("bbb.txtc")
fm.add_file("aaa.txtc")
fm.add_file("aaa")
fm.add_file("aaa.jpg")

p fm.is_same_ext
 
fm.kakunin