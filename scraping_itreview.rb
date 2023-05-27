require 'nokogiri'
require 'open-uri'
require 'date'
require 'csv'

# 定数
# TODO: 動的に変えられるようにする
PAGE_NUM = 25

# 前処理
p 'ITreviewのURLを入力してください:'
base_url = gets.chomp.to_s

p '取得するレビュータイプを選択してください（p / n / s）'
type = gets.chomp.to_s
csv_file = 'reviews_' + type + '_' + DateTime.now.strftime('%Y%m%d%H%M%S') + '.csv'


# 本処理
CSV.open(csv_file, 'w') do |csv|
  csv << ['Month', 'Title', 'Content']

  # ページごとにループ
  (1..NUM_PAGE).each do |page|
    puts url = "#{base_url}?page=#{page}"

    html = open(url)
    doc = Nokogiri::HTML(html)
    reviews = doc.css('.row')

    reviews.each do |review|
      date_str = review.css('.product-review-time').text
      unless date_str == "" # 謎に改行が入ってしまうため暫定措置
        date = Date.strptime(date_str.slice(4..11), '%Y年%m月')
      end
      title = review.css('.product-review-title').text
      case type
        when 'p' then
          content = review.css('.product-review-answer')[0] # 良いポイント
        when 'n' then
          content = review.css('.product-review-answer')[1] # 改善してほしいポイント
        when 's' then
          content = review.css('.product-review-answer')[2] # どのような課題解決に貢献しましたか？どのようなメリットが得られましたか？
      end

      unless title == "" # 謎に改行が入ってしまうため暫定措置
        csv << [date, title, content]
      end
    end
  end
end

puts "CSVファイルに結果を書き出しました: #{csv_file}"
