class StoreController < ApplicationController
  
  def index
    @stores = Store.paginate(:page => params[:page] || 1, :per_page => 10)
  end
  
  def new
    @store = Store.new
  end
  
  def create
    @store = Store.new(params[:store])
    
    if @store.save
      flash[:notice] = "Successfully created store"
      redirect_to :action => "show", :id => @store.id
    else
      flash[:error] = "Failed to created store"
      redirect_to :action => "new"
    end
  end
  
  def show
    @store = Store.find(params[:id])
  end
  
  def edit
    @store = Store.find(params[:id])
  end
  
  def update
    @store = Store.find(params[:id])
    @store.name = params[:store][:name]
    @store.city = params[:store][:city]
    
    if @store.save
      flash[:notice] = "Successfully updated store"
      redirect_to :action => "show", :id => @store.id
    else
      flash[:error] = "Failed to update store"
      redirect_to :action => "edit"
    end
  end
  
  def destroy
    if Store.delete(params[:id])
      flash[:notice] = "Successfully deleted store"
      redirect_to :action => "index"
    else
      flash[:error] = "Failed to delete store"
      redirect_to :action => "index"
    end
  end
  
  def sort
    @sort = params[:sort]
    @order = params[:order]
    
    debugger
    
    @stores = Store.paginate(:page => params[:page] || 1, :per_page => 10, :order => "#{@sort} #{@order}")
  end

end
