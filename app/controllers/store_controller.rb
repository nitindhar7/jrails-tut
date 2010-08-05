class StoreController < ApplicationController
  
  def index
    @sort  = params[:sort]
    @order = params[:order]
    
    if @sort.blank?
      @stores = Store.find(:all)
    else
      @stores = Store.find(:all, :order => "#{@sort} #{@order}") 
    end
  end
  
  def new
    @store = Store.new
  end
  
  def create
    @store = Store.new()
    @store.name = params[:store][:name]
    @store.city = params[:store][:city]
    @store.created_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    @store.updated_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    
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
    @store.updated_at = Time.new.strftime("%Y-%m-%d %H:%M:%S")
    
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
    @sort  = params[:sort]
    @order = params[:order]
    
    if @sort.blank?
      @stores = Store.find(:all)
    else
      @stores = Store.find(:all, :order => "#{@sort} #{@order}") 
    end
  end

end
