class HomeController < ApplicationController
  before_action :must_be_logged_in ,except: [:login,:check_user]
  before_action :check_seller ,only: [:my_market,:purchase_history]
  before_action :check_buyer ,only: [:sale_history,:my_inventory,:top_seller,:addItem]
  def profile
    @user=User.where(id:session[:user_id]).first
    case @user.user_type
    when 0
      @type="Admin"
    when 1
      @type="Seller"
    when 2
      @type="Buyer"
    end
  end
  def verify_change_password
    @user=User.where(id:session[:user_id]).first
    if params["Re-enter password"]!=params[:Password] 
      redirect_to "/change_password", notice: "Re-enter password doesn't match"
    elsif @user.authenticate(params[:Password])
      redirect_to "/change_password", notice: "Don't use old password"
    else 
      @user.password=params[:Password]
      @user.save
      redirect_to "/login", notice: "Change password successfully"
    end 
  end
  def change_password
    
  end
  def login
    
  end
  def logout
    reset_session
    redirect_to '/login', notice: "Logout successfully"
  # endy_market
  end
  def check_user
    u=User.where(email: params[:login]).first
    if u&&u.authenticate(params[:password])
      redirect_to '/main'
      session[:logged_in]=true
      session[:user_id]=u.id
      session[:user_type]=u.user_type
    else
      redirect_to '/login', notice: "Incorrect email or password"
    end
  end
  def verify_buy
    market=Market.where(id:params[:market]).first
    if(market.stock<params[:quantity].to_i||market.stock==0)
      redirect_to '/my_market', notice: "Item out of stock"
    else
      market.stock-=params[:quantity].to_i
      market.save
      inventory=Inventory.new(user_id:session[:user_id],seller_id:market.user_id,item_id:market.item_id,price:market.price,qty:params[:quantity].to_i)
      inventory.save
      redirect_to '/my_market', notice: "Purchase Succesfully"
    end

  end
  def my_market 
    @db=Market.all
    @rows=[]
    @category=["All"]
    @selected="All"
    if params[:category]
      @selected=params[:category]
    end
    for info in @db
       item=Item.where(id:info.item_id).first
       user=User.where(id:info.user_id).first
       row2=[]
       if !item.isdeleted&&item.enable&&!@category.include?(item.category)
          @category.push(item.category)
       end
       if !item.isdeleted&&item.enable&&(!params[:category]||(params[:category]&&(params[:category]==item.category||params[:category]=="All")))
          row2.push(item.name)
          row2.push(info.stock)
          row2.push(user.name)
          row2.push(info.price)
          row2.push(item.category)
          row2.push(item)
          row2.push(info.id)
       end
       if row2.size !=0
        @rows.push(row2)
       end
    end
  end
  def purchase_history
    @db=Inventory.where(user_id:session[:user_id])
    @rows=[]
    for inventory in @db
       item=Item.where(id:inventory.item_id).first
       user=User.where(id:inventory.seller_id).first
       row2=[]
        row2.push(item.name)
        row2.push(item.category)
        row2.push(user.name)
        row2.push(inventory.price)
        row2.push(inventory.qty)
        row2.push(item)
        row2.push(inventory.created_at)
        @rows.push(row2)
    end
  end
  def my_inventory
    @db=Market.where(user_id:session[:user_id])
    @rows=[]
    for market in @db
       item=Item.where(id:market.item_id).first
        if(!item.isdeleted)
          row2=[]
          row2.push(item.name)
          row2.push(item.category)
          row2.push(market.stock)
          row2.push(market.price)
          row2.push(item)
          @rows.push(row2)
        end
    end
  end
  def addStock
    @item=Market.where(item_id:params[:item].to_i).first
  end
  def verify_add_stock
    item=Market.where(item_id:params[:item].to_i).first
    item.stock+=params[:addStock].to_i
    item.save
    redirect_to "/my_inventory", notice: "Add Stock Successfully"
  end
  def deleteItem
    item=Item.where(id:params[:item].to_i).first
    item.isdeleted=true
    item.save
    redirect_to "/my_inventory", notice: "Delete Succesfully"
  end
  def addItem
    
  end
  def verify_addItem
    item=Item.new()
    item.name=params[:item_name]
    item.category=params[:item_category].downcase
    item.isdeleted=false
    item.enable=false
    item.save
    if(!params.blank?)
      item.picture.attach(params[:picture])
    end
    market=Market.new()
    market.user_id=session[:user_id]
    market.item_id=Item.last.id.to_i
    market.price=params[:price].to_f
    market.stock=params[:stock]
    market.save
    redirect_to "/my_inventory", notice: "Add Item Succesfully"
  end
  def sale_history
    @db=Inventory.where(seller_id:session[:user_id])
    @rows=[]
    for inventory in @db
        item=Item.where(id:inventory.item_id).first
        user=User.where(id:inventory.user_id).first
        row2=[]
        row2.push(item.name)
        row2.push(item.category)
        row2.push(user.name)
        row2.push(inventory.price)
        row2.push(inventory.qty)
        row2.push(item)
        row2.push(inventory.created_at)
        @rows.push(row2)
    end
  end
  def verify_top_seller 
    if((!params[:from].blank?&&params[:to].blank?)||(!params[:to].blank?&&params[:from].blank?))
      redirect_to '/top_seller',notice: "Please Enter From and To Day"
    elsif(params[:from].to_date>params[:to].to_date)
      redirect_to '/top_seller',notice: "Do Not Select To Day Before From Day"
    else
      redirect_to '/top_seller' ,from: params[:from],to: params[:to]
    end
  end
  def top_seller
    @sort=["Quantity","Income"]
    @selected="Quantity"
    if params[:sort]
      @selected=params[:sort]
    end
    @from=""
    @to=""
    if flash[:from]
      @from=flash[:from]
    end
    if flash[:to]
      @to=flash[:to]
    end
    if(!params[:sort]||(params[:sort]&&params[:sort]=='Quantity'))
      inv=Inventory.group(:seller_id).order('sum_qty desc').sum('qty').to_a
      if(flash[:from]&&flash[:to]&&!flash[:from].blank?&&!flash[:to].blank?)
        inv=Inventory.group(:seller_id).where('created_at BETWEEN ? AND ?', flash[:from].to_date.beginning_of_day, flash[:to].to_date.end_of_day).order('sum_qty desc').sum('qty').to_a
      end
    elsif(params[:sort]&&params[:sort]=='Income')
      inv=Inventory.group(:seller_id).order('sum_qtyallprice desc').sum('qty*price').to_a
      if(flash[:from]&&flash[:to]&&!flash[:from].blank?&&!flash[:to].blank?)
        inv=Inventory.group(:seller_id).where('created_at BETWEEN ? AND ?', flash[:from].to_date.beginning_of_day, flash[:to].to_date.end_of_day).order('sum_qtyallprice desc').sum('qty*price').to_a
      end
    end
    @rows=[]
    for inventory in inv
      row2=[]
      row2.push(User.where(id:inventory[0]).first.name)
      row2.push(inventory[1])
      @rows.push(row2)
    end
  end
end
