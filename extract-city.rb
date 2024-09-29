require 'open-uri'
require 'zip'

# zipをダウンロードする
def download_zip(url, download_dir, zip_filename)
  zip_filepath = File.join(download_dir, zip_filename)
  Dir.mkdir(download_dir) unless Dir.exist?(download_dir)

  File.open(zip_filepath, "wb") do |saved_file|
    URI.open(url, "rb") do |read_file|
      saved_file.write(read_file.read)
    end
  end

  puts "Downloaded #{zip_filename} to #{zip_filepath}"
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
      puts "Extracted #{entry.name} to #{entry_path}"
    end
  end
end

def main
  # (1)zipをダウンロードする
  url = "https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip"
  download_dir = "./downloads"
  zip_filename = "ken_all.zip"
  zip_filepath = download_zip(url, download_dir, zip_filename)

  # (2)zipを解凍する
  extract_dir = "./extracted_files"
  extract_zip(zip_filepath, extract_dir)

  # (3)csvからデータを取得する

  # (4)csvのデータを加工する

  # (5)成功したメッセージを表示する
  puts "csv"
end

# main関数を実行する
main