simple search
==
가장 간단한 search 기능 구현

## 1. 더미 데이터 작성(실제 사용 시 적용 X)
* bash - scaffold 작업
```bash
rails g scaffold post title content:text
```
* Gemfile - 가상 데이터 작업 1
```ruby
gem 'faker' #가상 text 생성 gem
```
* db/seeds.rb - 가상 데이터 작업 2
```ruby
# post를 가상의 문장으로 50개 생성하기
50.times do 
   Post.create(title: Faker::Lorem.word,content: Faker::Lorem.sentence) 
end
```
* bash - migrate 및 가상 데이터 생성
```bash
rake db:migrate
rake db:seed
```
* config/route.rb - route 작업
```ruby
root 'posts#index'
```
## 2. search 기능 구현
* app/views/posts/index.html.erb - index에서 검색 창 구현
```html
[...]
<form action='posts' method="GET">
  <label>검색</label>
  <input type="text" name="search">
  <input type="submit">
</form>
[...]
```
여기서 action인 'posts'는 index 액션을 뜻함(.all이 보여지는 page)
* app/models/post.rb - 검색 기능 구현 1(search 메소드 구현)
```ruby
[...]
# Post.search(검색할 쿼리)
def self.search(query)
    self.where("title || content LIKE ?","%#{query}%")
end
[...]
```
title이나 content중 query를 포함한 것(["%%"sql 와일드카드](https://www.w3schools.com/sql/sql_wildcards.asp))을 출력
* app/controllers/posts_controller.rb - 검색 기능 구현 2(컨트롤러 세팅)
```ruby
def index
    if params[:search]
      @posts = Post.search(params[:search])
    else
      @posts = Post.all
    end
end
```
만약 url에 search쿼리가 있다면(index에서 form을 사용했다면) Post.search를 통해 검색하고 아니라면 Post.all해라

완성!!!
## Refernece Post
[simple search post](http://www.korenlc.com/creating-a-simple-search-in-rails-4/)<br>
[sql wild card](https://www.w3schools.com/sql/sql_wildcards.asp)<br>
[faker gem](https://github.com/stympy/faker)