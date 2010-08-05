JRails Tutorial Application [jrails-tut]
========================================

The purpose of this application is to serve as a tutorial for the JRails plugin.
JRails is a plugin that creates an interface between jQuery and Prototype style
'link_to_remote' and 'remote_form_for' tags, which can be used directly in Ruby code.

JRails simplifies ajax requests by keeping code within Ruby instead of using
javascript 'jQuery.load' in a separate file. Even though using the straight jQuery technique is fine,
it may not come natural to Rails programmars.

Also explored in this application are the will_paginate gem and sorting techniques.
Using will_paginate allow paging, which makes the interface beautiful and more importantly
improves performance drastically.

Here is the summary of topics covered:
* link_to_remote
* remote_form_for
* will_paginate
* preservation of sort type/order while paging
* resetting of page when changing sort type/order

Installation and Setup
----------------------
1. Create a new rails application:
    `rails store`
2. Download and copy over jquery.js
3. Install JRails plugin
    `ruby script/plugin install git://github.com/aaronchi/jrails.git`
4. In `config/database.yml` update the configs to desired values
5. Delete `public/index.html`
6. Update `map.root :controller => "welcome"` in `config/routes.rb` to desired controller

Overview
--------
This application uses a `store` model. Each store has two attributes: `name` and `city`
We want to be able to take standard actions on each store: create new stores, edit existing stores,
view individual store information, delete store and view all stores.

While viewing all stores, we wish to be able to sort the list by store name or store city using ajax
so that instead of the whole page reloading, only the part that changes reloads asynchronously.
As mentioned, jQuery.load function can be used in `application.js` via a click bind on a button, but
we want to use Ruby code to accomplish ajax.
