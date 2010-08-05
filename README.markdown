JRails Tutorial Application
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

Details & Explanations
----------------------
Either using scaffolding or manually create a simple RESTful controller.
In the index method, draw a table (using css tables or nested div's) with
store name and city, as well as the links to show, edit and delete stores.
The title label of each column will interactive button in our example.

Create the label using the link_to_remote tag:
`<%= link_to_remote("Store Name", :update => "stores", :url => {:action => "sort"} %>`

* Argument 1: `Store Name` is the text on the link
* Argument 2: `:update => "stores"` indicates that the response from the ajax request will populate html tag with id = stores
* Argument 3: `:url => {:action => "sort"}` sets the action that will handle the ajax request

After building this basic tag, fancier things can be done:
`<%= link_to_remote("Store Name", :update => "stores", :url => {:action => "sort"}, :with => "'sort=name'", :complete => "color_rows()") %>`

Check [documenatation](http://api.rubyonrails.org/classes/ActionView/Helpers/PrototypeHelper.html#M002174) for full explainations of each attribute

When this link is clicked, an ajax call is made to the action "sort" of the current controller. The `:with` parameter sets the params key that will
be sent to action sort. Action sort will receive the parameter using the params hash:

`@sort  = params[:sort]`

Later, we add another param to :with called "order":

`@order = params[:order]`
    
Once the store controller receives these parameters it can set the conditions for the find call:

`@stores = Store.find(:all, :order => "#{@sort} #{@order}")`

Now, @stores contains store information on all stores sorted by whichever link was clicked (name or city).
We need a way to change the sort order when the links are clicked again. Add:

`&order=#{sort_order(@order)}`

to the ':with' parameter for the link_to_remote tag. This will pass the @order variable (retrieved from the controller action)
to a custom helper method called `sort_order`. Sort order checks if order was previously set (`!order.blank?`) and if order is ascending

`def sort_order(order)`
`  if !order.blank? && order == 'ASC'`
`    'DESC'`
`  else`
`    'ASC'`
`  end`
`end`

The result of this is that of the order was already set and it was ASCENDING, the new order will become DESCENDING. If either the order
was not set previously or if the order was not ASCENDING, the order is changed to ASCENDING. Using the helper method `sort_order` is critical
because the sort order cannot be hard coded in.

The sort method renders its view with the updated sort all under a second or two (depending on the number of store records).
