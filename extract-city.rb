require 'open-uri'
require 'zip'
require 'csv'

# zipをダウンロードする
def download_zip(url, download_dir, zip_filename)
  zip_filepath = File.join(download_dir, zip_filename)
  Dir.mkdir(download_dir) unless Dir.exist?(download_dir)

  File.open(zip_filepath, "wb") do |saved_file|
    URI.open(url, "rb") do |read_file|
      saved_file.write(read_file.read)
    end
  end

  puts "*********************************************"
  puts "*********************************************"
  puts "LOG::Downloaded #{zip_filename} to #{zip_filepath}"
  puts "*********************************************"
  puts "*********************************************"
  zip_filepath
end

# zipを解凍する
def extract_zip(zip_filepath, extract_dir)
  Dir.mkdir(extract_dir) unless Dir.exist?(extract_dir)

  Zip::File.open(zip_filepath) do |zip_file|
    zip_file.each do |entry|
      entry_path = File.join(extract_dir, entry.name)
      FileUtils.mkdir_p(File.dirname(entry_path))
      zip_file.extract(entry, entry_path) unless File.exist?(entry_path)
      puts "*********************************************"
      puts "*********************************************"
      puts "LOG::Extracted #{entry.name} to #{entry_path}"
      puts "*********************************************"
      puts "*********************************************"
    end
  end
end

# 全角スペースを半角スペースに変換
def replace_fullwidth_space(text)
  text.gsub('　', ' ')
end

# 郵便番号の整形：0が省略されている場合に付与
def format_postal_code(postal_code)
  postal_code.rjust(7, '0')  # 7桁に満たない場合、0を付ける
end

def process_csv(csv_file_path)
  concatenated_addresses = []

  CSV.foreach(csv_file_path, headers: false, col_sep: ",", quote_char: "\"", encoding: "Shift_JIS:UTF-8", liberal_parsing: true) do |row|
    kanji_address = concat_kanji_address(row)
    romaji_address = concat_romaji_address(row)
    concatenated_addresses << [kanji_address, romaji_address]
  end

  concatenated_addresses

end

def concat_kanji_address(row)
  "#{row[1]} #{row[2]} #{row[3]}".strip
end

def concat_romaji_address(row)
  "#{row[4]} #{row[5]} #{row[6]}".strip
end

def main
  # (1)zipをダウンロードする
  # url = "https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip"
  url = "https://www.post.japanpost.jp/zipcode/dl/roman/KEN_ALL_ROME.zip"
  download_dir = "./downloads"
  zip_filename = "ken_all.zip"
  zip_filepath = download_zip(url, download_dir, zip_filename)

  # (2)zipを解凍する
  extract_dir = "./extracted_files"
  extract_zip(zip_filepath, extract_dir)


  # (3)解凍されたCSVファイルのパスを指定する
  csv_file_path = File.join(extract_dir, 'KEN_ALL_ROME.csv') # 実際のファイル名に変更してください

  # (4)csvのデータを加工する
  processed_data = process_csv(csv_file_path)
  if processed_data.empty?
    return puts "processed_data is empty"
  end 

  # ログ
  puts "process_data$$$$$$$$$$$$$$$"
  p processed_data
  puts "process_data$$$$$$$$$$$$$$$"

  # (5)配列の中から指定した市区のローマ字を取得する

  # (5)成功したメッセージを表示する
  puts "process csv successly"
end

# main関数を実行する
main