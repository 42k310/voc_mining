require 'csv'
require 'date'
require 'natto'

# 定数
TAKE_COUNT = 100 # 形態素解析後に上位何位までをCSVに出力するか

# 前処理
p '解析するファイル名を入力してください:'
file = gets.chomp.to_s
csv = 'result_scraping/' + file

nm = Natto::MeCab.new('--node-format=%f[0]')
word_counts = Hash.new(0)

# 本処理
CSV.foreach(csv, headers: true) do |row|
  content = row['Content']

  # 形態素解析を実行して単語の出現回数をカウント
  nm.parse(content) do |n|
    word = n.surface
    feature = n.feature

    if feature.start_with?('名詞')
      word_counts[word] += 1
    end
  end
end

top_words = word_counts.sort_by { |_word, count| -count }.take(TAKE_COUNT)

# CSV出力
now = DateTime.now.strftime('%Y%m%d%H%M%S')
output_file = 'result_text_mining/word_counts_' + file
CSV.open(output_file, 'w') do |csv|
  csv << ['Word', 'Count']
  top_words.each do |word, count|
    csv << [word, count]
  end
end
