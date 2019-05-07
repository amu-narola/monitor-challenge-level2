###Goal

*L1.*

Create a small PORO application that will fetch sample data from API, 
convert it to given format and save to SQL. 
For testing - create a fake API server that will respond with API samples provided.

*L2.*

Create a Rake task for application deployment to AWS Lambda, using ruby AWS SDK 
Deploy application to AWS Lambda, and make sure it works.

**Estimated time for completion: 6 - 8 hours**

###Business Specification

As a customer i want to collect statistics of web site visits, that is provided by API server, 
and store it to MySQL database for later usage.

Sample API server response is located in `samples/api_response.json`

The API response is an array containing multiple elements, representing `visit`. Each `visit` contains nested array, 
called `actionDetails`, each element represents `pageview`.

**Models**

We need the data to be saved into 2 different tables:
`visits` and `pageviews`.  

Create migrations to create those tables.
Create models `Visit` and `Pageview`. `Visit` is as associated with `Pageview` with one to many relation.

API response field names are different from table column names. 
Please use mapping given below to assign source field values to target database columns.
Ignore source fields that are not listed in below mapping.

**Visits schema and mappings** 

```ruby
    t.string "evid"
    t.string "vendor_site_id"
    t.string "vendor_visit_id"
    t.string "visit_ip"
    t.string "vendor_visitor_id"
``` 

`visit element` => `visits table` field mapping:

```ruby
{
  'referrerName' => :evid,
  'idSite'       => :vendor_site_id,
  'idVisit'      => :vendor_visit_id,
  'visitIp'      => :visit_ip,
  'visitoriId'   => :vendor_visitor_id
}
```

**`evid` column validation**

Please clear up `referrerName` response field value before saving, it should validate with following regex:

`/\A[A-z0-9]{8}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{12}\z/` 

**Pageviews schema and mappings**

```ruby
    t.bigint "visit_id"
    t.string "title"
    t.string "position"
    t.text "url"
    t.string "time_spent"
    t.decimal "timestamp", precision: 14, scale: 3
```

`pageview element` => `pageviews table` field mapping:

```ruby
{
  'url'       => :url,
  'pagetitle' => :title,
  'timespent' => :time_spent,
  'timestamp' => :timestamp
}
```

**Pageviews order**

Pageviews should be sorted by `timestamp` field, in ascending order.

**Position column**

For `pageview` you will need to add the `position` field which indicates `pageview` position in data source array.
Please ensure that pages are unique, and there are no duplicates.  

**Fake API server**

You will need to create a simple Fake API server for handling responses. The server should accept get request,
ad respond with the json given in `samples/api_response.json`. We suggest to use Sinatra for creating small inline server,
but final solution is after you.

**Setup**

*L1.*

Please use included docker-compose.yml. It will spinup ready-for-work ruby-2.5.5 and mysql containers linking each other
Create Gemfile with required gems, before executing `docker-compose up`, as it will try to do `bundle install`

*L2.*

Change `docker/app/Dockerfile` image source to `lambci/lambda:build-ruby2.5` as it's 
the closest image to AWS Lambda. You will need to install `mysql-devel` package 
there and copy mysql shared library to `lib` folder, in order in order to make 
mysql client work on AWS Lambda.

###Requirements

*L1.*

  + Ruby MRI 2.5+
  + Rspec for tests (100% coverage)
  + Rubocop for linting ruby code
  + Simplecov for code coverage
  + ActiveRecord for models (arguable)
  + MySQL for database
  + Docker + docker-compose for containerization
  
*L2.*

  + Exactly lambci/lambda:build-ruby2.5 as source image
  + AWS Lambda for code execution
  + AWS RDS for MySQL database (use free tier)

  
###Deliverable

*L1.*

A project directory containing `app.rb` file, with the `call` method inside, that we can run inside Docker: 

```
docker build -t shastic_challenge .
docker run -it -v "$(pwd)"/:/app shastic_challenge
bash# bundle exec -r 'app.rb' -e 'call'
```
  
  or with Docker compose
  
```
docker-compose build
docker-compose up -d    
docker-compose exec shastic_challenge bundle exec -r 'app.rb' -e 'call'      
```

Executing above commands should create records in database according to specification.
  
*L2.*

A working AWS Lambda function that fetches from fake API server (inline) 
a sample responce and saves converted data to RDS

###Things this challenge evaluates

*L1.*

+ Application architecture (classes naming and placement, code split)
+ How candidate manages requirements of files
+ What gems candidate will choose
+ What patterns and best practices will be used (SRP, DRY, ServiceObject, Strategy, etc..)

*L2.*

+ AWS services knowledge
+ Dev Ops skills
+ Usage of environment variables
