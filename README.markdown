JRails Tutorial Application
========================================

The purpose of this application is to serve as a tutorial for the JRails plugin, which
is a plugin that creates an interface between jQuery and Prototype style
'link_to_remote' and 'remote_form_for' tags, which can be used directly in Ruby code.

JRails simplifies ajax requests by keeping code within Ruby instead of using
javascript 'jQuery.load' in a separate file. Using the straight jQuery technique is fine, but
doesnt allow for clean and manageable code.

Also explored in this application are the will_paginate gem and sorting techniques.
Using will_paginate allows paging, which makes the interface beautiful and improves performance drastically.

Here is the summary of topics covered:
* link_to_remote
* remote_form_for
* will_paginate
* preservation of sort type/order while paging
* resetting of page when changing sort type/order

How to get the project?
-----------------------
`git clone git@github.com:nitindhar7/jrails-tut.git`

Overview
--------
This application uses a `store` model. Each store has two attributes: `name` and `city`
We want to be able to create new stores, edit existing stores,
view individual store information, delete store and view all stores.

While viewing all stores (index page), we wish to be able to sort the list by store name or store city using ajax
so that instead of the whole page reloading, only the part of it changes asynchronously.
As mentioned, jQuery.load function can be used in `application.js` via a click bind on a button, but
we want to use Ruby code to accomplish ajax.

Sorting
----------------------
Either using scaffolding or manually create a simple RESTful controller.
In the index action, draw a table (using css tables or nested div's) with
store name and city, as well as the links to show, edit and delete stores.
The title label of each column will be an interactive button in our example.

Create the label using the link_to_remote tag:

`<%= link_to_remote("Store Name", :update => "stores", :url => {:action => "sort"} %>`

The 'remote' in the above tag indicates that the request is sent to a remote location via AJAX. In this case
the text on the link is "Store Name", the div to update is "stores" and the action that will receive the request is "sort"

After building this basic tag, fancier things can be done:
`<%= link_to_remote("Store Name", :update => "stores", :url => {:action => "sort"}, :with => "'sort=name'", :complete => "color_rows()") %>`

Check the [documentation](http://api.rubyonrails.org/classes/ActionView/Helpers/PrototypeHelper.html#M002174) for
full explainations of each attribute.

When this link is clicked, an ajax call is made to the action "sort" of the current controller. The `:with` parameter sets the params
key that will be sent to action sort. Action sort will receive the parameters using the params hash:

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

The result of this is that if the order was already set and it was ASCENDING, the new order will become DESCENDING. If either the order
was not set previously or if the order was not ASCENDING, the order is changed to ASCENDING. Using the helper method `sort_order` is critical
because the sort order cannot be hard coded in. The sort method renders its view with the updated sort all under a second or two (depending on the
number of store records). When the result set increases explonentially, the performance increase shows its true form.

Pagination
----------
Pagination in rails requires the gem called `will_paginate`. This gem uses the same format as a regular ActiveRecord 'find' method, so the syntax
is very familiar. Setup for will paginate requires adding installing the gem, adding it to the environments file and restarting the server:

* `gem install will_paginate`
* In config/environments.rb, add `config.gem "will_paginate"` in the initializer block
* Stop server using 'ctrl+c'. Start it again `ruby script/server`

For full information about will_paginate, visit the [rdoc's](http://gitrdoc.com/mislav/will_paginate/tree/master).

First step is to retrieve records using will_paginate. In the index action, we retrive the record like so:

`@stores = Store.paginate(:page => params[:page] || 1, :per_page => 10)`

How will_paginate works is by counting the number of records in the total result set. Then using the 'per_page' attribute, 
it determines how many records to return for the page. When clicking on pages of the pager, the page parameter is set, which is
combined in the query using the SQL 'LIMIT' and 'OFFSET' clauses. The result is that as the user clicks on various pages, only
a small portion if the total set is returned making the interface feel much quicker. Imagine using the 
[Facebook photo's app](http://blog.facebook.com/blog.php?post=2406207130) without pagination. All those images would need to be loaded on the same page.
The effect is not just on the load times but usability. Its much harder for the human eye to follow along such a large grid.

