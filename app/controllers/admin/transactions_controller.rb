class Admin::TransactionsController < Admin::ResourceController

  def cancel
    resource.cancel!
    flash[:notice] = "Transaction was canceled"
    redirect_to admin_transaction_path(resource)
  end

  private

    def collection
      unless @collection
        result = current_economy ? current_economy.transactions : Transaction.all
        @collection = result.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: 10)
      end
      @collection
    end

end