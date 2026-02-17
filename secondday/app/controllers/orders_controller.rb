class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    # raise @order.save.inspect

    # hard coding for active job support later have to change
    @order.product_id = 14
    # raise @order.save.inspect
    @order.customer_id = 14
    # raise @order.save.inspect

    if @order.save
      redirect_to @order

    else
      render :new
    end
  end

  def edit
  @order = Order.find(params[:id])
end

def update
  @order = Order.find(params[:id])
  if @order.update(order_params)
    redirect_to orders_path
  else
    render :edit
  end
end


  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:details, :count,:product_id,:customer_id)
  end

end
