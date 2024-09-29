require 'open-uri'
require 'zip'

# ダウンロードするzipファイルのURL
url = "https://www.post.japanpost.jp/zipcode/dl/kogaki/zip/ken_all.zip"

# 保存するファイル名とディレクトリ
download_dir = "./downloads"
zip_filename = "ken_all.zip"
zip_filepath = File.join(download_dir, zip_filename)

# 解凍先ディレクトリ
extract_dir = "./extracted_files"

# ダウンロード先ディレクトリが存在しない場合は作成
Dir.mkdir(download_dir) unless Dir.exist?(download_dir)

# zipファイルをダウンロードして保存
File.open(zip_filepath, "wb") do |saved_file|
  URI.open(url, "rb") do |read_file|
    saved_file.write(read_file.read)
  end
end

puts "Downloaded #{zip_filename} to #{zip_filepath}"

# 解凍先ディレクトリが存在しない場合は作成
Dir.mkdir(extract_dir) unless Dir.exist?(extract_dir)

# zipファイルを解凍
Zip::File.open(zip_filepath) do |zip_file|
  zip_file.each do |entry|
    entry_path = File.join(extract_dir, entry.name)
    FileUtils.mkdir_p(File.dirname(entry_path))
    zip_file.extract(entry, entry_path) unless File.exist?(entry_path)
    puts "Extracted #{entry.name} to #{entry_path}"
  end
end
