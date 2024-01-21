import scrapy
import pandas as pd
from selenium import webdriver
from scrapy.crawler import CrawlerProcess
from scrapy.http import Request
import json
import os
import requests

c=0    
class GRSpider(scrapy.Spider):
    c=0
    name = 'GRspider'
    allowed_domains = ['goodreads.com']
    start_urls = ['https://www.goodreads.com/list/show/1.Best_Books_Ever']
    user_agent = "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1"

    def start_requests(self):
        global book_df
        book_df = pd.DataFrame(columns=['index','name', 'author','rating', 'description', 'genres','price'])
        yield scrapy.Request(url=self.start_urls[0], callback=self.parse)

    def parse(self, response):
        for href in response.css(".bookTitle::attr(href)").getall():
            # print(href)
            yield response.follow(url=href, callback=self.parse_book)
    
    def parse_book(self, response):
        global book_df
        global c
        try:
            book_name = response.xpath('//*[@id="__next"]/div[2]/main/div[1]/div[2]/div[1]/div[1]/div[1]/h1/text()').get()
        except:
            book_name="couldn't crawl"
        c+=1

        try:
            book_author = response.xpath('//*[@id="__next"]/div[2]/main/div[1]/div[2]/div[1]/div[2]/div[1]/h3/div/span[1]/a/span/text()').get()
        except:
            book_author="couldn't crawl"

        try:
            book_rating = float(response.xpath('//*[@id="__next"]/div[2]/main/div[1]/div[2]/div[1]/div[2]/div[2]/a/div[1]/div/text()').get())
        except:
            book_rating="couldn't crawl"

        try:
            book_desc = ','.join(response.xpath('//*[@id="__next"]/div[2]/main/div[1]/div[2]/div[1]/div[2]/div[4]/div/div[1]/div/div/span/text()').getall())
        except:
            book_desc="couldn't crawl"
        try:
            book_genres = ','.join(response.xpath('//*[@id="__next"]/div[2]/main/div[1]/div[2]/div[1]/div[2]/div[5]/ul/span[1]/span/a/span/text()').getall())
        except:
            book_genres ="couldn't crawl"
        try:
            book_price = response.xpath('//*[@id="__next"]/div[2]/main/div[1]/div[2]/div[1]/div[2]/div[2]/a/div[2]/div/span[2]/text()[1]').get()
        except:
            book_price="couldn't crawl"
        book_df = book_df.append({'index':c,'name': book_name, 'author': book_author, 'rating' : book_rating, 'description' : book_desc, 'genres' : book_genres,'price':book_price}, ignore_index=True)
        print(book_df.shape)
        book_df.to_json('books.json',orient='records')


        try:
            image_url = response.css(".ResponsiveImage::attr(src)").get()
            if image_url:
                save_directory = 'images'
                os.makedirs(save_directory, exist_ok=True)

                image_name = os.path.join(save_directory, book_name+'.jpg')

                response = requests.get(image_url)
                if response.status_code == 200:
                    with open(image_name, 'wb') as f:
                        f.write(response.content)
                    print(f"Image downloaded and saved as {image_name}")
                else:
                    print(f"Failed to download the image. Status code: {response.status_code}")
            else:
                print("No image URL found.")
        except Exception as e:
            print(f"Error processing image request: {str(e)}")
        

process = CrawlerProcess()
process.crawl(GRSpider)
process.start()

