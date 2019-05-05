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

We need the data to be saved into 2 different tables:
`visits` and `pageviews`.  

Create models `Visit` and `Pageview`. `Visit` is as associated with `Pageview` with one to many relation.
API responce fields are different of table columns. You will need to map needed response field to appropriate column.
Skip all other response fields.

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

**Position column**

For `pageview` you will need to add the `position` field which indicates `pageview` position in data source array.
Please ensure that pages are unique, and there are no duplicates.  


###Requirements

*L1.*

  + Ruby MRI 2.5+
  + Rspec for tests (100% coverage)
  + Rubocop for linting ruby code
  + ActiveRecord for models (arguable)
  + MySQL for database
  + Docker + optionally docker-compose for containerization
  
*L2.*

  + Exactly lambci/lambda:build-ruby2.5 as source image
  + AWS Lambda for code execution
  + AWS RDS for MySQL database (use free tier)

  
###Deliverable

*L1.*

A project directory containing Docker file (optionally with docker-compose), that can be built,
and then executed with: 

```
docker build -t shastic_challenge .
docker run -it -v "$(pwd)"/:/target_path shastic_challenge
bash# bundle exec app.rb
```
  
  or with Docker compose
  
```
docker-compose build
docker-compose up -d    
docker-compose exec shastic_challenge bundle exec app.rb      
```

and create desired records in database
  
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
