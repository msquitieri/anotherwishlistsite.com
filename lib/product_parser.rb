require 'open-uri'

class ProductParser
  attr_reader :url, :title, :images

  MIN_IMAGE_WIDTH = 100

  USER_AGENT_STRINGS = [
    "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.72 Safari/537.36",
    "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:22.0) Gecko/20100101 Firefox/22.0",
    "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/536.30.1 (KHTML, like Gecko) Version/6.0.5 Safari/536.30.1",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.71 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36",
    "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.72 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:22.0) Gecko/20100101 Firefox/22.0",
    "Mozilla/5.0 (Windows NT 6.1; rv:22.0) Gecko/20100101 Firefox/22.0",
    "Mozilla/5.0 (Windows NT 5.1; rv:22.0) Gecko/20100101 Firefox/22.0",
    "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.72 Safari/537.36",
    "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.116 Safari/537.36",
    "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0) Gecko/20100101 Firefox/38.0",
    "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:21.0) Gecko/20100101 Firefox/21.0",
    "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.71 Safari/537.36"
  ]

  def initialize(url_to_parse)
    @url = url_to_parse
  end

  def parse!
    response = HTTParty.get(url, headers: default_headers)
    @doc     = Nokogiri::HTML(response.body)

    @title  = doc.xpath('//title').first.content.to_s
    @images = find_images

    self
  end

  def find_images
    # Select all images that have a width > MIN_IMAGE_WIDTH.
    # If the width is not present, take it anyway.
    all_images = doc.xpath('//img').select do |img|
      if img[:width].present?
        img[:width].to_i > MIN_IMAGE_WIDTH
      else
        true
      end
    end

    all_images.map { |img| decorate_image_url(url, img.attr('src')) }.compact
  end

  def decorate_image_url(base_url, image_url)
    return nil if image_url.nil?

    uri = URI.parse(base_url)

    # Case 1: '//s3.amazonaws.com/bucket' => 'https://s3.amazonaws.com/bucket'
    # Case 2: '/images/product-image.png' => 'https://amazon.com/images/product-image.png'
    if image_url.start_with?('//')
      "#{uri.scheme}:#{image_url}"
    elsif image_url.start_with?('/')
      "#{uri.scheme}://#{uri.host}#{image_url}"
    else
      image_url
    end

  end


  private

  def default_headers
    {
      'User-Agent'      => USER_AGENT_STRINGS.sample,
      'Referer'         => 'http://www.google.com',
      'Accept'          => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      'Accept-Language' => 'en-US,en;q=0.5',
      'Connection'      => 'keep-alive'
    }
  end

  attr_reader :doc
end