class WidgetsController < ApplicationController
  before_action :set_widget, only: [:destroy]

  def new
    @widget = Widget.new(category: params[:category])
  end

  def create
    @widget = Widget.new(widget_params)
    @widget.dashboard = default_dashboard
    @widget.assign_attributes(config_params_for(@widget))

    if @widget.save
      return redirect_to ENV['WEB_HOST'], notice: 'Widget was successfully created.'
    else
      return render :new
    end
  end

  def destroy
    if @widget.destroy!
      notice = 'Widget was successfully deleted.'
    else
      notice = 'Widget could not be deleted.'
    end

    redirect_to ENV['WEB_HOST'], notice: notice
  end

  private

  def set_widget
    @widget = Widget.find(params[:id])
  end

  def widget_params
    params.require(:widget).permit(:title, :category, :height, :width)
  end

  def config_params_for(widget)
    params.require(:widget).permit(*widget.category.fields.keys)
  end
end
