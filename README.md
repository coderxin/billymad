# Billymad

![Build](https://github.com/coderxin/billymad/actions/workflows/master.yml/badge.svg)
[![GitHub version](https://badge.fury.io/gh/coderxin%2Fbillymad.svg)](http://badge.fury.io/gh/coderxin%2Fbillymad)
[![Coverage Status](https://coveralls.io/repos/coderxin/billymad/badge.png?branch=master)](https://coveralls.io/r/coderxin/billymad?branch=master)

API wrapper for Billomat online service written in Ruby.

###### This gem is in development.

See [Billomat API](http://www.billomat.com/en/api) documentation for detailed description of all resources.

## Installation

Add this line to your application's Gemfile:

    gem 'billymad'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install billymad

## Dependencies

The billymad gem depends on these other gems for installation and usage:

  - [rest-client](https://github.com/rest-client/rest-client)

## Configuration

To setup the gem you will need to provide `billomatID` of your Billomat account and `API key` of your user.

    Billymad.configure do |config|
      config.billomat_id = 'billomatID'
      config.api_key     = '1234567890abcde'
    end

Explicitly:

    Billymad.configuration.billomat_id = 'billomatID'
    Billymad.configuration.api_key     = '1234567890abcde'

In case of incorrect configuration, you will get exceptions:

    Billymad::User.logged_in

    # => Billymad::ConfigurationError: You must specify an Billomat ID
    # => Billymad::ConfigurationError: You must specify an API key

## Covered resources

Since Gem is in development, there are few resources (actually ###) covered in this API wrapper.

  - `Billymad::Account`
  - `Billymad::Client`
  	- `Billymad::ClientProperty`
    - `Billymad::ClientPropertyValue`
    - `Billymad::ClientTag`
    - `Billymad::Contact`
  - `Billymad::Article`
    - `Billymad::ArticleProperty`
    - `Billymad::ArticlePropertyValue`
    - `Billymad::ArticleTag`
  - `Billymad::Invoice`
    - `Billymad::InvoiceComment`
    - `Billymad::InvoicePayment`
    - `Billymad::InvoiceItem`
    - `Billymad::InvoiceTag`
  - `Billymad::Role`
  - `Billymad::Setting`
  - `Billymad::Unit`
  - `Billymad::User`
    - `Billymad::UserProperty`
    - `Billymad::UserPropertyValue`

## Usage

### Example: Client resource

List all clients:

    Billymad::Client.all

    # => [#<Billymad::Client:0x00000102283c70 @id=353026 ... >, #<Billymad::Client:0x00000102283c70 @id=353026 ... >]

Filtered with parameters:

    Billymad::Client.all(name: "Gmbh")

Show a specific client:

    Billymad::Client.find(353026)

Create a client:

    Billymad::Client.create(name: "Musterfirma", salutation: "Mr", first_name: "John", last_name: "Doe")

    # => #<Billymad::Client:0x00000102283c70 @id=353026, @created=2014-05-04 20:21:54 +0200,@name="Musterfirma", @salutation="Mr", @first_name="John", @last_name="Doe" ... >

Edit client:

    Billymad::Client.update(id: 353026, first_name: "Sam")

    client = Billymad::Client.find(353026)
    client.update(first_name: "Sam")

    # => #<Billymad::Client:0x00000102283c70 @id=353026, @created=2014-05-04 20:21:54 +0200,@name="Musterfirma", @salutation="Mr", @first_name="Sam", @last_name="Doe" ... >

Delete client:

    Billymad::Client.destroy(353026)

    client = Billymad::Client.find(353026)
    client.destroy

    # => true

Reload record from API:

    client = Billymad::Client.find(353026)
    client.reload!

    # => #<Billymad::Client:0x00000102283c70 @id=353026, @created=2014-05-04 20:21:54 +0200,@name="Musterfirma", @salutation="Mr", @first_name="Sam", @last_name="Doe" ... >

### Mandatory parameters

Some resources require mandatory parameters:

    Billymad::Contact.all

    # => Billymad::APIError: You must specify the mandatory parameter :client_id

For futher details, please check [API documentation](http://www.billomat.com/en/api).

### Method chaining

Methods currently available via association chain: `.all`, `.create`.


	client = Billymad::Client.all.last

	client.tags.create(name: "Books")
	client.tags.create(name: "Games")

	client.tags

	# => [
    	[0] #<Billymad::ClientTag:0x0102d87 @id=9092, @client_id="352837", @name="Books">,
    	[1] #<Billymad::ClientTag:0x0102d87 @id=9093, @client_id="352837", @name="Games">
	]

Same as `client.tags` but allows to pass extra parameters:

	client.tags.all(per_page: 1, page: 2)

### Pagination

To change default pagination settings you have to pass `page` attribute and `per_page`.

	Billymad::Client.all(per_page: 1, page: 2)

Default page size is `100` records.

### Sorting

To get sorted results from the API you can pass `order_by` attribute with the name of parameter and preferred sorting order.

	Billymad::ClientTag.all(order_by: "name ASC, id DESC")

## More to come

  - Authentication via App (since it allows higher limit for requests)
  - Pagination
  - Grouping
  - Resource relations (method chaining)
  - Multiple connections
  - Ideas?

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT



