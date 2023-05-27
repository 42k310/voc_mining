import pandas as pd
from wordcloud import WordCloud
import matplotlib.pyplot as plt
import os
import glob

font = 'NotoSansJP-Bold.ttf'

# CSVファイルからテキストを読み取る
dir = 'result_text_mining/'
files = sorted(glob.glob(dir + '*'))
n = 1

for file in files:
    if os.path.isfile(file):
        data = pd.read_csv(file)
        text = ' '.join(data['Word'])

        # ワードクラウドを生成する
        stop_words = ['契約', '締結', '書', 'こと', 'の', 'ため', '電子', '機能', '点', 'よう']
        wc = WordCloud(
            width = 800,
            height = 400,
            font_path = font,
            background_color = 'white',
            prefer_horizontal = 1, # 縦書きをなしにする
            colormap = 'tab20', # テキストのカラーテーマ
            stopwords = stop_words,
            max_words = 100 # 表示する最大単語数
            ).generate(text)

        output_name = str(n) + '.png'
        plt.figure(figsize=(10, 5))
        plt.imshow(wc, interpolation='bilinear')
        plt.axis('off')
        plt.savefig('result_wordcloud/' + output_name)
        # plt.show()
        print('DONE: ' + file + ' / file_name: ' + output_name)
        n += 1
