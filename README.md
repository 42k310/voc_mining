# 環境
- Ruby3系
- Python3系

# 概要
1. （Ruby）対象サイトをスクレイピングし、レビュー内容をCSVファイルとして吐き出す。`scraping_itreview.rb`
2. （Ruby）1のCSVファイルをインプットとして、`MeCab`を使って形態素解析をする。単語と出現回数がセットになったCSVファイルを吐き出す。`text_mining.rb`
3. （Python）2のCSVファイルをインプットとして、`wordcloud`を使ってワードクラウドを作成する。`generate_wordcloud.py`
