require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'sqlite3'
require 'active_record'


def hash_sort_def(str)
  hash = {}
  str_ary = str.split(" ")
  str_ary.each do |key|
    if hash.has_key?(key) then
        hash[key] += 1
    else
        hash[key] = 1
    end
  end
  return hash.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }
end

get '/' do
  erb :index  
end

post '/add_to_database' do

  # データベースへの接続
  ActiveRecord::Base.establish_connection(
    adapter:   'sqlite3',
    database:  './test.db'
  )
  
  #UserAgentの情報を取得
  ua = request.env['HTTP_USER_AGENT']
  
  #ブラウザを判別
  browser = if ua.include? "MSIE"
    "ie"
  elsif ua.include? "Firefox"
    "firefox"
  elsif ua.include? "Chrome"
    "chrome"
  elsif ua.include? "Opera"
    "opera"
  elsif ua.include? "safari"
    "safari"
  else
    "others"
  end

  #テキストエリアの文章のスペース前後の記号を除去
  deleting_symbol_ary = []
  params[:foo].split(" ").each do |str|
    #deleting_symbol = str.gsub(/^[^0-9A-Za-z]|[^0-9A-Za-z]$/, "")
    #deleting_symbol = str.gsub(/^[^0-9A-Za-z]*|[^0-9A-Za-z]*$/, "")
    deleting_symbol = str.gsub(/^\W*|\W*$/, "")
    
    deleting_symbol_ary.push(deleting_symbol)
  end
  
  class Test < ActiveRecord::Base
  end
  
  #DBにブラウザと記号を消去した文字列を追加
  test = Test.new
  test.browser = browser
  test.text = deleting_symbol_ary.join(" ")
  test.save
  
  #ここまでうまく動作したことを確認するためにとりあえず返しているだけ。
  return browser
end

post '/post' do
  #テキストエリアの文字数をカウント
  params[:foo].length.to_s
end

post '/most' do
  input_value = params[:foo]
  
  most_many_char_count = 0
  input_value_char_count = 0
  input_value.chars { |ch|
    input_value_char_count = input_value.count(ch)
    if most_many_char_count < input_value_char_count then
      most_many_char_count = input_value_char_count
      content_type :text
      @data = ch
    end
  }
  return @data
end

post '/browser_graph' do

  # データベースへの接続
  ActiveRecord::Base.establish_connection(
    adapter:   'sqlite3',
    database:  './test.db'
  )

  browser_hash = Hash.new { |h,k| h[k] = {} }
  str_all = []
  
  class Test < ActiveRecord::Base
  end
  
  Test.all.each {|row|
    browser_name = row.browser
    row.text.split(" ").each do |str|
      unless str_all.include?(str) then #全ての単語の情報を配列に入れる
        str_all.push(str)
      end
      if browser_hash[browser_name].has_key?(str) then #各ブラウザの単語数をカウント
        browser_hash[browser_name][str] += 1
      else
        browser_hash[browser_name][str] = 1
      end 
    end  	
  }
  wak = "<caption>単語数ランキング</caption><thead><tr><td></td>"



  
  browser_hash.each do |key, value| #各ブラウザで単語の順番を揃える
    str_all.each do |str|
      unless browser_hash[key].has_key?(str) then
        browser_hash[key][str] = 0
      end  
    end    
    browser_hash[key] = browser_hash[key].sort
  end

  def add_elements(wak, tag, close_tag, hash_sort, num)
    hash_sort.each do |value|
      wak += tag
      wak += value[num].to_s
      wak += close_tag
    end
    return wak
  end

  wak = add_elements(wak, "<th>", "</th>", browser_hash["chrome"], 0)

  browser_hash.each do |key, value| #表の各行にブラウザ名と単語数を反映させる
    wak += "</tr></thead><tbody><tr><th>#{key}</th>\n"
    wak = add_elements(wak, "<td>", "</td>", browser_hash[key], 1)
  end
  
  wak += "</tr></tbody>\n";
  return wak
  #trの中を繰り返す
  
end


post '/bar_graph' do

  hash_sort = hash_sort_def(params[:foo])
  
  wak = "<caption>単語数ランキング</caption><thead><tr><td></td>"


  def add_elements(wak, tag, close_tag, hash_sort, num)
    hash_sort.each do |value|
      wak += tag
      wak += value[num].to_s
      wak += close_tag
    end
    return wak
  end

  wak = add_elements(wak, "<th>", "</th>", hash_sort, 0)
  wak += "</tr></thead><tbody><tr><th>単語数</th>\n"
  wak = add_elements(wak, "<td>", "</td>", hash_sort, 1)
  wak += "</tr></tbody>\n";

  return wak
end


post '/pie_chart' do
  hash_sort = hash_sort_def(params[:foo])
  
  wak = "<caption>単語数ランキング</caption><thead><tr><td></td><th>単語数</th></tr></thead><tbody>"
  
  hash_sort.each do |value|
    wak += "<tr><th>"
    wak += value[0].to_s
    wak += "</th>"
    wak += "<td>"
    wak += value[1].to_s
    wak += "</td></tr>"
  end 
  
  wak += "</tbody>"
  
  return wak
  
end




get '/mohan' do
content=<<'EOS'
<html> 
  <head> 
    <meta charset="utf-8"> 
    <title>test</title> 
    <script type=text/javascript> 
      function ajax(){ 
        var req = new XMLHttpRequest(); 
        req.onreadystatechange = function() { 
          console.log(this); 
          var res = document.getElementById("disp"); 
        if(this.readyState == 4){ 
          if(this.status == 200){ 
            res.innerHTML = this.responseText; 
          } 
        }else{ 
          res.innerHTML = "通信中..." + req.readyState; 
        } 
      } 
      req.open("POST",'/mohan', true); 
      req.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8'); 
      req.send('sentense='+encodeURIComponent(document.getElementById("sentense").value)); 
      //req.send(null); 
      } 
    </script> 
  </head> 
  <body> 
  <input type=textarea id="sentense"> 
  <input type=submit value="送信" onclick='ajax()'> 
  <div id="disp"></div> 
  </body> 
</html> 
EOS

end 

post '/mohan' do 
p params[:sentense] 
"<p>#{params[:sentense].split().size()}</p>" 
end