class Tekcare::RgaController < ApplicationController
  
    before_action :set_rga, only: [:rgapack]
  def bol
  end
  
  
  def comminvoice
  end
  
  def rgadoc
  end
  
  def rgapack
    @rga=Hash.new
    @rga=JSON.parse(@rga_detail.body.to_json)
render text: @rga
  end
  
  private
  def set_rga
      dealer_code=session[:DealerCode]
      #@rga ||= Teknion::RGADetail.find('2668', dealer_code)
            @rga_detail ||= Tekcare::RGADetail.find(params[:rga_id], dealer_code)
    end
end
