# ControllerSupport [![Build Status](https://travis-ci.org/yonbergman/controller_support.png?branch=master)](https://travis-ci.org/yonbergman/controller_support)

Controller Supports are controller oriented mixins (modules) for Rails that can help you extract behaviour from controllers into shared resources.

## Why?
Controller Supports lets you extract common behaviour or non-core controller knowledge into it's seperate resource which makes it easier to test and maintain.
Some example of ControllerSupports:

* **UserSupport** - Authentication and current_user
* **ErrorSupport** - Global error methods and a before filter to catch uncaught exceptions
* **EventSupport** - Used to load the event resource based on the `params[:id]`
* **LocalizationSupport** - Helper methods to build hashes that will be passed to I18n
* **MobileSupport** - Check if in a mobile session and change the layout

ControllerSupports are just an extension of `ActiveSupport::Concern` so they supply all of the behaviours that you'd get from `ActiveSupport::Concern`.  
What Controller Supports adds on top of ActiveSupport::Concern is an easier way to define methods as `helper_methods` and `before_filters`. It does so in such a way that will enable you to `include` the support in controllers but also into other objects like test stubs or Mailers.

If you don't know `ActiveSupport::Concern` there are several links to reading material in the bottom of this README.
 
 
## Installation
 Just add the `controller_support` gem to your Gemfile
 
 ```ruby
 	gem 'controller_support'
 ```
 
## Usage

To define a module as a controller support you just need to extend it with `ControllerSupport::Base` it can then act as a mixin which you can `include` into Controllers or any other object.

```ruby
module UserSupport
	extend ControllerSupport::Base
	
	helper_method :current_user, :user_signed_in
	before_filter :must_be_signed_in
	# ControllerSupport also support after_filter and around_filter
	
	def current_user
		User.find(session[:user_id])
	end
	
	def user_signed_in?
		current_user.present?
	end
	
	def must_be_signed_in
		redirect_to sign_up_path unless user_signed_in?
	end
	
end
```

To use the support just `include` it in the controller of your choice

```ruby
class ItemController < ApplicationController
	include UserSupport
	
	skip_before_filter :must_be_signed_in, :only => :new

	def new
		render :inline => "this is just an example"
	end	
	
	def show
		current_user.item.find(params[:id])
	end
end
```
## ActiveSupport::Concern reading material

If you don't know about ActiveSupport::Concern and why it's an awesome thing you should read these stuff

* [The offical documentation](http://api.rubyonrails.org/classes/ActiveSupport/Concern.html)
* [Concerning yourself with ActiveSupport::Concern](http://www.fakingfantastic.com/2010/09/20/concerning-yourself-with-active-support-concern/) - This blog post covers everything you need to know
* [Concerning ActiveSupport::Concern](http://opensoul.org/blog/archives/2011/02/07/concerning-activesupportconcern/)
* [Extending ActiveModel via ActiveSupport::Concern](http://chris-schmitz.com/extending-activemodel-via-activesupportconcern/)
* [Trimming the fat from your controllers](http://notninjas.com/2012/12/03/trimming-the-fat-from-your-controllers/) - A blog post I wrote that led to the creation of this gem.

 
## License

This project rocks and uses MIT-LICENSE.
