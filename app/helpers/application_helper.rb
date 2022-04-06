module ApplicationHelper
  def title_content(page_title)
    base_title = 'Speaking Checker'

    page_title.present? ? "#{page_title} | #{base_title}" : base_title
  end

  def default_meta_tags
    {
      site: 'Speaking Checker',
      title: 'あなたの英語の発音、確認してみませんか？',
      reverse: true,
      charset: 'utf-8',
      description: 'あなたの英語の発音精度を分析できるアプリケーション「Speaking Checker」です。',
      keywords: '英語,発音',
      canonical: request.original_url,
      separator: '|',
      icon: [
        { href: image_url('favicon.png') },
        { href: image_url('icon-256x256.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
      ],
      og: {
        site_name: 'Speaking Checker', # もしくは site_name: :site
        title: 'あなたの英語の発音、確認してみませんか？', # もしくは title: :title
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('twitter_card.png'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@yoshitaka12_2',
        title: 'あなたの英語の発音、確認してみませんか？', # もしくは title: :title
        image: image_url('twitter_card.png'),
      }
    }
  end
end
